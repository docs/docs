import { expect } from '@jest/globals'
import { tmpdir } from 'os'
import { mkdirp } from 'mkdirp'
import { cp, rm, readFile } from 'fs/promises'
import { existsSync } from 'fs'
import path from 'path'
import matter from 'gray-matter'

import { updateContentDirectory } from '../lib/update-markdown.js'

const versions = {
  fpt: '*',
  ghec: '*',
  ghes: '*',
}
const newContentData = {
  'actions/secrets.md': {
    data: {
      title: 'Secrets',
      versions,
      autogenerated: 'rest',
    },
    content: 'New content',
  },
  'actions/workflows.md': {
    data: {
      title: 'Workflows',
      versions,
      autogenerated: 'rest',
    },
    content: 'New content',
  },
  'code-scanning/alerts.md': {
    data: {
      title: 'Alerts',
      versions,
      autogenerated: 'rest',
    },
    content: 'New content',
  },
}

const tempDirectory = `${tmpdir()}/update-content-directory-test`
const tempContentDirectory = `${tempDirectory}/content`
const targetDirectory = path.join(tempContentDirectory, 'rest')
const indexOrder = {
  'content/rest/index.md': {
    startsWith: ['overview', 'guides'],
  },
}

describe('automated content directory updates', () => {
  // Before all tests, copy the content directory fixture
  // to the operating systems temp directory. We'll be modifying
  // that temp directory during the tests and comparing the directory
  // structure and contents after running updateContentDirectory.
  beforeAll(async () => {
    process.env.TEST_OS_ROOT_DIR = tempDirectory
    mkdirp.sync(`${tempContentDirectory}`)
    await cp('src/automated-pipelines/tests/fixtures/content', tempContentDirectory, {
      recursive: true,
    })

    // The updateContentDirectory uses relative paths to the content directory
    // because outside of testing it only runs in the docs-internal repo.
    // Because of that, we need to update the content paths to use the
    // full file path.
    const contentDataFullPath = {}
    Object.keys(newContentData).forEach(
      (key) => (contentDataFullPath[path.join(targetDirectory, key)] = newContentData[key]),
    )

    // Rewrites the content directory in the operating system's
    // temp directory.
    await updateContentDirectory({
      targetDirectory,
      sourceContent: contentDataFullPath,
      frontmatter: {
        autogenerated: 'rest',
      },
      indexOrder,
    })
  })

  afterAll(async () => {
    await rm(tempDirectory, { recursive: true, force: true })
    delete process.env.TEST_OS_ROOT_DIR
  })

  test('expected files and directories are removed', async () => {
    const artifactsFileExists = existsSync(`${tempContentDirectory}/rest/actions/artifacts.md`)
    expect(artifactsFileExists).toBe(false)

    const checksDirectoryExists = existsSync(`${tempContentDirectory}/rest/checks`)
    expect(checksDirectoryExists).toBe(false)
  })

  test('expected files and directories are added', async () => {
    const codeScanningDirectoryExists = existsSync(`${tempContentDirectory}/rest/code-scanning`)
    expect(codeScanningDirectoryExists).toBe(true)

    const alertsFileExists = existsSync(`${tempDirectory}/content/rest/code-scanning/alerts.md`)
    expect(alertsFileExists).toBe(true)

    const codeScanningIndexFileExists = existsSync(
      `${tempDirectory}/content/rest/code-scanning/index.md`,
    )
    expect(codeScanningIndexFileExists).toBe(true)
  })

  test('rest/actions index file is updated as expected', async () => {
    // workflows added and artifacts removed
    const actionsIndex = matter(
      await readFile(`${tempDirectory}/content/rest/actions/index.md`, 'utf8'),
    )
    expect(actionsIndex.data.children).toEqual(['/secrets', '/workflows'])
  })

  test('non-target directory index files did not get changed', async () => {
    const overviewIndex = matter(
      await readFile(`${tempDirectory}/content/rest/overview/index.md`, 'utf8'),
    )
    expect(overviewIndex.data.children).toEqual(['/apis'])

    const articleIndex = matter(
      await readFile(`${tempDirectory}/content/articles/index.md`, 'utf8'),
    )
    expect(articleIndex.data.children).toEqual(['/article'])
  })

  test('new directory gets correct index file and parent index file updated', async () => {
    const codeScanningIndex = matter(
      await readFile(`${tempDirectory}/content/rest/code-scanning/index.md`, 'utf8'),
    )
    expect(codeScanningIndex.data.children).toEqual(['/alerts'])

    const restIndex = matter(await readFile(`${tempDirectory}/content/rest/index.md`, 'utf8'))
    expect(restIndex.data.children).toEqual(['/overview', '/guides', '/actions', '/code-scanning'])
  })
  test('target directory index file gets update correctly', async () => {
    const contentIndex = matter(await readFile(`${tempDirectory}/content/index.md`, 'utf8'))
    expect(contentIndex.data.children).toEqual(['articles', 'rest'])
  })
})
