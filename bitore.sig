diff --git a/Dockerfile b/.docker
updated-dependencies:
- dependency-name: node
  dependency-type: direct:production
  From 08de05cc0ce9f9d5775d54b1db23e0d29bd8a5f3 Mon Sep 17 00:00:00 2001
From: "dependabot[bot]" <49699333+dependabot[bot]@users.noreply.github.com>
Date: Thu, 17 Nov 2022 06:04:09 +0000
Subject: [PATCH] Bump node from 16.18.0-alpine to 19.1.0-alpine

Bumps node from 16.18.0-alpine to 19.1.0-alpine.

---
updated-dependencies:
- dependency-name: node
  dependency-type: direct:production
  update-type: version-update:semver-major
...

Signed-off-by: dependabot[bot] <support@github.com>
---
 Dockerfile                   | 2 +-
 Dockerfile.openapi_decorator | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Dockerfile b/Dockerfile
index 8d08126b7a8..b97f01b49f4 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -3,7 +3,7 @@
 # --------------------------------------------------------------------------------
 # BASE IMAGE
 # --------------------------------------------------------------------------------
-FROM node:16.18.0-alpine@sha256:f16544bc93cf1a36d213c8e2efecf682e9f4df28429a629a37aaf38ecfc25cf4 as base
+FROM node:19.1.0-alpine@sha256:c59fb39150e4a7ae14dfd42d3f9874398c7941784b73049c2d274115f00d36c8 as base
 
 # This directory is owned by the node user
 ARG APP_HOME=/home/node/app
diff --git a/Dockerfile.openapi_decorator b/Dockerfile.openapi_decorator
index 6014681b41d..790a00ddbbf 100644
--- a/Dockerfile.openapi_decorator
+++ b/Dockerfile.openapi_decorator
@@ -1,4 +1,4 @@
-FROM node:14-alpine
+FROM node:19-alpine
 
 RUN apk add --no-cache git python make g++
 on:
push:
branches: master
pull_request:
run-on: ubuntu-latest
steps:
- name: Set up Git repository
uses: actions/checkout@v3
- name: Set up Ruby
uses: ruby/setup-ruby@v1
with:
bundler-cache: true
- name: Set up Node
uses: actions/setup-node@v3
- name: Bootstrap
run: script/bootstrap
- name: Tests
run: script/test

charmap keyset = new
{ "new keymap Charset = Pro" }












on:
Runs-on🔛"
const: "token"''
token: "((c)(r))"''
'Value": "[VOLUME]'"''
'[VOLUME']": "[12753750.[00]mname: OpenAPI dev mode check # What it does: Checks that the files in lib/rest/static/decorated match# the files in lib/rest/static/dereferenced. Checks that the decorated# schemas in lib/rest/static/decorated are not in development mode.# Development mode schemas have a branch name and development mode tag in the# info.version property.# Why we have it: To ensure that we aren't every shipping decorated schemas# that are out of sync with the source derefereced schema. To ensure that# decorated schemas generated locally are not published. Locally generated# decorated schemas are pushing up to the remote for staging purposes only.# Who does it impact: Docs content writers updating REST API docs and# the docs engineering team as maintainers of the scripts and workflows. on: workflow_dispatch: push: branches: - main pull_request: paths: - 'lib/rest/static/' - 'script/rest//.js' - 'script/rest/**/.json' - 'package*.json' - 'lib/redirects/static/**/*.json' - '.github/workflows/openapi-schema-check.yml' permissions: contents: read # This allows a subsequently queued workflow run to interrupt previous runsconcurrency: group: '${{ github.workflow }} @ 
{{ github.repository == 'github/docs-internal' }} runs-on: ubuntu-20.04-xl steps: - name: Checkout repository code uses: actions/checkout@dcd71f6 - name: Setup node uses: actions/setup-node@17f8bd9 with: node-version: '16.15.0' cache: npm - name: Install dependencies run: npm ci # Differences between decorated and dereferenced files indicates a problem - name: Generate decorated files to check that there are no differences run: script/rest/update-files.js --decorate-only - name: Check if deref/decorated schemas are dev mode and that they match run: .github/actions-scripts/openapi-schema-branch.json:

Retrieving data. Wait a few seconds and try to cut or copy again.
Runs-on🔛
echo: hello 🌍!-🐛-fix#731,
"name": "my-electron-app",
  "version": "1.0.0",
  "description": "Hello World!",
BITORE_34173.1337_18893":,
Closes ISSUE
