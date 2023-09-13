import { addError } from 'markdownlint-rule-helpers'

// Adds an error object with details conditionally via the onError callback
export function addFixErrorDetail(onError, lineNumber, expected, actual, range, fixInfo) {
  addError(onError, lineNumber, `Expected: ${expected}`, ` Actual: ${actual}`, range, fixInfo)
}

export function getRange(line, content) {
  const startColumnIndex = line.indexOf(content)
  return startColumnIndex !== -1 ? [startColumnIndex + 1, content.length] : null
}

export function isStringQuoted(text) {
  // String starts with either a single or double quote
  // ends with either a single or double quote
  // and optionally ends with a question mark or exclamation point
  // because that punctuation can exist outside of the quoted string
  const regex = /^['"].*['"][?!]?$/
  return text.match(regex)
}
