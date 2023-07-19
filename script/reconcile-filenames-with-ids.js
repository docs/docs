#!/usr/bin/env node

// [start-readme]
//
// An automated test checks for discrepancies between filenames and [autogenerated heading IDs](https://www.npmjs.com/package/remark-autolink-headings).
// If the test fails, a human needs to run this script to update the filenames.
//
// **This script is not currently supported on Windows.**
//
// [end-readme]

import fs from 'fs'
import path from 'path'
import walk from 'walk-sync'
import GithubSlugger from 'github-slugger'
import { decode } from 'html-entities'
import frontmatter from '../lib/read-frontmatter.js'
import { execSync } from 'child_process'
import addRedirectToFrontmatter from '../src/redirects/scripts/helpers/add-redirect-to-frontmatter.js'

const slugger = new GithubSlugger()

const contentDir = path.join(process.cwd(), 'content')

const contentFiles = walk(contentDir, { includeBasePath: true, directories: false }).filter(
  (file) => {
    return file.endsWith('.md') && !file.endsWith('index.md') && !file.includes('README')
  },
)

// TODO fix path separators in the redirect
if (process.platform.startsWith('win')) {
  console.log('This script cannot be run on Windows at this time! Exiting...')
  process.exit()
}

contentFiles.forEach((oldFullPath) => {
  const { data, content } = frontmatter(fs.readFileSync(oldFullPath, 'utf8'))

  // skip pages with frontmatter flag
  if (data.allowTitleToDifferFromFilename) return

  // slugify the title of each article
  // where title = Foo bar
  // and slug = foo-bar
  slugger.reset()
  const slug = slugger.slug(decode(data.title))

  // get the basename of each file
  // where file = content/foo-bar.md
  // and basename = foo-bar
  const basename = path.basename(oldFullPath, '.md')

  // if slug and basename match, return early
  if (basename === slug) return

  // otherwise rename the file using the slug
  const newFullPath = oldFullPath.replace(basename, slug)

  const oldContentPath = path.relative(process.cwd(), oldFullPath)
  const newContentPath = path.relative(process.cwd(), newFullPath)

  const gitStatusOfFile = execSync(`git status --porcelain ${oldContentPath}`).toString()

  // if file is untracked, do a regular mv; otherwise do a git mv
  if (gitStatusOfFile.includes('??')) {
    execSync(`mv ${oldContentPath} ${newContentPath}`)
  } else {
    execSync(`git mv ${oldContentPath} ${newContentPath}`)
  }

  // then add the old path to the redirect_from frontmatter
  // TODO fix path separators on Windows (e.g. \github\extending-github\about-webhooks)
  const redirect = path.join('/', path.relative(contentDir, oldFullPath).replace(/.md$/, ''))
  data.redirect_from = addRedirectToFrontmatter(data.redirect_from, redirect)

  // update the file
  fs.writeFileSync(newFullPath, frontmatter.stringify(content, data))
})
