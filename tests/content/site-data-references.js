import fs from 'fs/promises'
import { fileURLToPath } from 'url'
import path from 'path'

import { isEqual, uniqWith } from 'lodash-es'
import { jest } from '@jest/globals'

import { loadPages } from '../../lib/page-data.js'
import getDataReferences from '../../lib/get-liquid-data-references.js'
import frontmatter from '../../lib/read-frontmatter.js'
import { getDataByLanguage, getDeepDataByLanguage } from '../../lib/get-data.js'

const __dirname = path.dirname(fileURLToPath(import.meta.url))

const pages = (await loadPages()).filter((page) => page.languageCode === 'en')

describe('data references', () => {
  jest.setTimeout(60 * 1000)

  test('every data reference found in English content files is defined and has a value', () => {
    let errors = []
    expect(pages.length).toBeGreaterThan(0)

    pages.forEach((page) => {
      const file = path.join('content', page.relativePath)
      const pageRefs = getDataReferences(page.markdown)
      pageRefs.forEach((key) => {
        const value = getDataByLanguage(key.replace('site.data.', ''), 'en')
        if (typeof value !== 'string') errors.push({ key, value, file })
      })
    })

    errors = uniqWith(errors, isEqual) // remove duplicates
    expect(errors.length, JSON.stringify(errors, null, 2)).toBe(0)
  })

  test('every data reference found in metadata of English content files is defined and has a value', async () => {
    let errors = []
    expect(pages.length).toBeGreaterThan(0)

    await Promise.all(
      pages.map(async (page) => {
        const metadataFile = path.join('content', page.relativePath)
        const fileContents = await fs.readFile(path.join(__dirname, '../..', metadataFile))
        const { data: metadata } = frontmatter(fileContents, { filepath: page.fullPath })
        const metadataRefs = getDataReferences(JSON.stringify(metadata))
        metadataRefs.forEach((key) => {
          const value = getDataByLanguage(key.replace('site.data.', ''), 'en')
          if (typeof value !== 'string') errors.push({ key, value, metadataFile })
        })
      })
    )

    errors = uniqWith(errors, isEqual) // remove duplicates
    expect(errors.length, JSON.stringify(errors, null, 2)).toBe(0)
  })

  test('every data reference found in English reusable files is defined and has a value', async () => {
    let errors = []
    const allReusables = getDeepDataByLanguage('reusables', 'en')
    const reusables = Object.values(allReusables)
    expect(reusables.length).toBeGreaterThan(0)

    await Promise.all(
      reusables.map(async (reusablesPerFile) => {
        let reusableFile = path.join(
          __dirname,
          '../../data/reusables/',
          getFilenameByValue(allReusables, reusablesPerFile)
        )
        reusableFile = await getFilepath(reusableFile)

        const reusableRefs = getDataReferences(JSON.stringify(reusablesPerFile))

        reusableRefs.forEach((key) => {
          const value = getDataByLanguage(key.replace('site.data.', ''), 'en')
          if (typeof value !== 'string') errors.push({ key, value, reusableFile })
        })
      })
    )

    errors = uniqWith(errors, isEqual) // remove duplicates
    expect(errors.length, JSON.stringify(errors, null, 2)).toBe(0)
  })

  test('every data reference found in English variable files is defined and has a value', async () => {
    let errors = []
    const allVariables = getDeepDataByLanguage('variables', 'en')
    const variables = Object.values(allVariables)
    expect(variables.length).toBeGreaterThan(0)

    await Promise.all(
      variables.map(async (variablesPerFile) => {
        let variableFile = path.join(
          __dirname,
          '../../data/variables/',
          getFilenameByValue(allVariables, variablesPerFile)
        )
        variableFile = await getFilepath(variableFile)

        const variableRefs = getDataReferences(JSON.stringify(variablesPerFile))

        variableRefs.forEach((key) => {
          const value = getDataByLanguage(key.replace('site.data.', ''), 'en')
          if (typeof value !== 'string') errors.push({ key, value, variableFile })
        })
      })
    )

    errors = uniqWith(errors, isEqual) // remove duplicates
    expect(errors.length, JSON.stringify(errors, null, 2)).toBe(0)
  })
})

function getFilenameByValue(object, value) {
  return Object.keys(object).find((key) => object[key] === value)
}

// if path exists, assume it's a directory; otherwise, assume a YML extension
async function getFilepath(filepath) {
  try {
    await fs.stat(filepath)
    filepath = filepath + '/'
  } catch (_) {
    filepath = filepath + '.yml'
  }

  // we only need the relative path
  return filepath.replace(path.join(__dirname, '../../'), '')
}
