import markdownlint from 'markdownlint'

import { testOptions } from './default-markdownlint-options.js'

export async function runRule(module, { strings, files } = {}) {
  if ((!strings && !files) || (strings && files))
    throw new Error('Must provide either Markdown strings or files to run a rule')

  const options = testOptions(module.names[0], module, { strings, files })
  return await markdownlint.promises.markdownlint(options)
}
