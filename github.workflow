name: 'Link Checker: All English'

# **What it does**: Renders the content of every page and check all internal links.
# **Why we have it**: To make sure all links connect correctly.
# **Who does it impact**: Docs content.

on:
  workflow_dispatch:
  push:
    branches:
      - main
  pull_request:

permissions:
  contents: read
  # Needed for the 'trilom/file-changes-action' action
  pull-requests: read

# This allows a subsequently queued workflow run to interrupt previous runs
concurrency:
  group: '${{ github.workflow }} @ ${{ github.event.pull_request.head.label || github.head_ref || github.ref }}'
  cancel-in-progress: true

jobs:
  check-links:
    runs-on: ${{ fromJSON('["ubuntu-latest", "self-hosted"]')[github.repository == 'github/docs-internal'] }}
    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Setup node
        uses: actions/setup-node@v3
        with:
          node-version: 16.13.x
          cache: npm

      - name: Install
        run: npm ci

      # Creates file "$/files.json", among others
      - name: Gather files changed
        uses: trilom/file-changes-action@a6ca26c14274c33b15e6499323aac178af06ad4b
        with:
          fileOutput: 'json'

      # For verification
      - name: Show files changed
        run: cat $HOME/files.json

      - name: Link check (warnings, changed files)
        run: |
          ./script/rendered-content-link-checker.mjs \
            --language en \
            --max 100 \
            --check-anchors \
            --check-images \
            --verbose \
            --list $HOME/files.json

      - name: Link check (critical, all files)
        run: |
          ./script/rendered-content-link-checker.mjs \
            --language en \
            --exit \
            --verbose \
            --check-images \
            --level critical
