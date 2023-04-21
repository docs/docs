import { jest, test } from '@jest/globals'

import { loadPages } from '../../../lib/page-data.js'
import { get } from '../../../tests/helpers/e2etest.js'

describe('autogenerated docs render', () => {
  jest.setTimeout(3 * 60 * 1000)

  test('all automated pages return a 200 success code', async () => {
    // Get a list of the autogenerated pages
    const pageList = await loadPages(undefined, ['en'])
    const autogeneratedPages = pageList.filter((page) => page.autogenerated)

    expect.assertions(autogeneratedPages.length)

    const statusCodes = await Promise.all(
      autogeneratedPages.map(async (page) => {
        const url = page.permalinks[0].href
        // Some autogenerated pages can be very slow and might fail.
        // So we allow a few retries to avoid false positives.
        const res = await get(url, { retries: 3 })
        return [url, res.statusCode]
      })
    )

    for (const [url, status] of statusCodes) {
      expect(status, url).toBe(200)
    }
  })
})
