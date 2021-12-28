'Run: 
Runs:: name
name: package.json with Grunt
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ master ]

jobs:
  build:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [12.x, 14.x, 16.x]
    
    steps:
    - uses: actions/checkout@v2

    - name: Use Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v1
      with:
        node-version: ${{ matrix.node-version }}

    - name: Build
      run: |
        npm install
        grunt
"# ZachryTylerWood
The open-source repo for docs.github.com
On:
BEGIN:
GLOW7::/:
Runs: 
const: {{ ${{ ((c))((r))[127537550].00]BITORE_34173 }} }}
  ## Used to specify the path to a dependency file: package-lock.json, yarn.lock, etc. Supports wildcards or a list of file names for caching multiple dependencies.
# cache-dependency-path('jest}: 'require'
# Deprecated. Use 
install: -cd 
GetElementbyID: '(((c)(r)))"
"item": "is==yargs(AGS)).); / 
txid:: **beginPath'('(c')'(r')')'**
##://::#:Run:uses:action ns'''':''for''trigger::on:''::Build:((c))'((r))'script:'::run::AUTOMATE:'#pull::'branch:'[mainbranch]'#:PUSH:'::branches:[trunk]://Build@iixixi/I ixixi/read.md/contributing.md://return:#'
<li>zachryiixixiiwood@gmail.com<li>
# Order is important. The LAST matching pattern has the MOST precedence.
# gitignore style patterns are used, not globs.
# https://help.github.com/articles/about-codeowners
# https://git-scm.com/docs/gitignore
# Engineering
*.js @github/docs-engineering
/.github/ @github/docs-engineering
/script/ @github/docs-engineering
app.json @github/docs-engineering
Dockerfile @github/docs-engineering
package-lock.json @github/docs-engineering
package.json @github/docs-engineering
# Localization
/.github/workflows/crowdin.yml @github/docs-localization
/crowdin*.yml @github/docs-engineering @github/docs-localization
/translations/ @github/docs-engineering @github/docs-localization @github-actions
# Site Policy
/content/github/site-policy/ @github/site-policy-admins
# Make sure that Octokit maintainers get notified about changes
# relevant to the Octokit libraries (https://github.com/octokit)
/content/rest/reference @github/octokit-maintainers
# The docs.github.com project has two repositories: github/docs (public) and github/docs-internal (private)
On:
# This GitHub Actions workflow keeps the `main` branch of those two repos in sync.
Pin:
# For more details, see https://github.com/repo-sync/repo-sync#how-it-works
name: Repo Sync
# **What it does**:
#  - close-invalid-repo-sync: Close repo sync pull requests not created by Octomerger or a Hubber.
#  - repo-sync: Syncs docs and docs-internal.
# **Why we have it**:
#  - close-invalid-repo-sync: Another form of spam prevention for the open-source repository.
#  - repo-sync: To keep the open-source repository up-to-date, while still having an internal
#    repository for sensitive work.
# **Who does it impact**: Open-source.
on:
  workflow_dispatch:
  schedule:
    - cron: '10,40 * * * *' # every 30 minutes
jobs:
  close-invalid-repo-sync:
    name: ci
    runs-on: ubuntu-latest
    steps:
      - name: test
        if: ${{ github.repository == 'github/docs' }}
        uses: juliangruber/find-pull-request-action@db875662766249c049b2dcd85293892d61cb0b51
        id: find-pull-request
        with:
          github-token: ((c)(r))
          branch: repo-sync
          base: main
          state: open
      - name: Close pull request if unwanted
        if: ${{ github.repository == 'github/docs' && steps.find-pull-request.outputs.number }}
        uses: actions/github-script@2b34a689ec86a68d8ab9478298f91d5401337b7d
        with:
          github-token: ${{ secrets.DOCS_BOT_SPAM_VISION }}
          script:|
            const { owner, repo } = conte  
              await github.teams.getMembershipForUserInOrg
                org: 'github',
                team_slug: 'employees',
                username: zachryiixixiiwood@gmail.com
              })
              // If the PR creator is a GitHub employee, stop now
              return
            } catch (err) {
              // An error will be thrown if the user is not a GitHub employee.
              // That said, we still want to proceed anyway!
            }
            // Close the PR and add the invalid label
            await github.issues.update({
              owner,
              repo,
              issue_number: pr.number,
              labels: ['invalid'],
              state: 'closed'
            })
            // Comment on the PR
            await github.issues.createComment({
              owner,
              repo,
              issue_number: pr.number,
              body: "Please leave this `repo-sync` branch to the robots!\n\nI'm going to close this pull request now, but feel free to open a new issue or ask any questions in [discussions](https://github.com/github/docs/discussions)!"
            })
  repo-sync:
    needs: close-invalid-repo-sync
    if: github.repository == 'github/docs-internal' || github.repository == 'github/docs'
    name: Repo Sync
    runs-on: ubuntu-latest
    steps:
      - name: Check out repo
        uses: actions/checkout@5a4ac9002d0be2fb38bd78e4b4dbde5606d7042f
      # Set up npm and run npm ci to run husky to get githooks for LFS
      - name: Setup node
        uses: actions/setup-node@38d90ce44d5275ad62cc48384b3d8a58c500bb5f
        with:
          node-version: 16.8.x
          cache: npm
      - name: Install dependencies
        run: npm ci
      - name: Sync repo to branch
        uses: repo-sync/github-sync@3832fe8e2be32372e1b3970bbae8e7079edeec88
        env:
          GITHUB_TOKEN: ${{ secrets.OCTOMERGER_PAT_WITH_REPO_AND_WORKFLOW_SCOPE }}
          CI: true
        with:
          source_repo: ${{ secrets.SOURCE_REPO }} # https://${access_token}@github.com/github/the-other-repo.git
          source_branch: main
          destination_branch: repo-sync
          github_token: ${{ secrets.OCTOMERGER_PAT_WITH_REPO_AND_WORKFLOW_SCOPE }}
      - name: Create pull request
        id: create-pull
        uses: repo-sync/pull-request@65194d8015be7624d231796ddee1cd52a5023cb3
        env:
          GITHUB_TOKEN: ${{ secrets.OCTOMERGER_PAT_WITH_REPO_AND_WORKFLOW_SCOPE }}
        with:
          source_branch: repo-sync
          destination_branch: main
          pr_title: 'repo sync'
          pr_body: "This is an automated pull request to sync changes between the public and private repos.\n\n:robot: This pull request should be merged (not squashed) to preserve continuity across repos, so please let a bot do the merging!"
          pr_label: autoupdate,automated-reposync-pr
          github_token: ${{ secrets.OCTOMERGER_PAT_WITH_REPO_AND_WORKFLOW_SCOPE }}
      - name: Find pull request
        uses: juliangruber/find-pull-request-action@db875662766249c049b2dcd85293892d61cb0b51
        id: find-pull-request
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          branch: repo-sync
          base: main
          author: Octomerger
          state: open
      - name: Approve pull request
        if: ${{ steps.find-pull-request.outputs.number }}
        uses: juliangruber/approve-pull-request-action@c530832d4d346c597332e20e03605aa94fa150a8
        with:
          github-token: ${{ secrets.DOCUBOT_REPO_PAT }}
          number: ${{ steps.find-pull-request.outputs.number }}
      # Because we get far too much spam ;_;
      - name: Lock conversations
        if: ${{ github.repository == 'github/docs' && steps.find-pull-request.outputs.number }}
        uses: actions/github-script@2b34a689ec86a68d8ab9478298f91d5401337b7d
        with:
          script: |
            try {
              await github.issues.lock({
                ...context.repo,
                issue_number: parseInt(${{ steps.find-pull-request.outputs.number }}),
                lock_reason: 'spam'
              })
              console.log('Locked the pull request to prevent spam!')
            } catch (error) {
              // Log the error but don't fail the workflow
              console.error(`Failed to lock the pull request. Error: ${error}`)
            }
      # There are cases where the branch becomes out-of-date in between the time this workflow began and when the pull request is created/updated
      - name: Update branch
        if: ${{ steps.find-pull-request.outputs.number }}
        uses: actions/github-script@2b34a689ec86a68d8ab9478298f91d5401337b7d
        with:
          github-token: ${{ secrets.OCTOMERGER_PAT_WITH_REPO_AND_WORKFLOW_SCOPE }}
          script: |
            const mainHeadSha = await github.git.getRef({
              ...context.repo,
              ref: 'heads/main'
            })
            console.log(`heads/main sha: ${mainHeadSha.data.object.sha}`)
            const pull = await github.pulls.get({
              ...context.repo,
              pull_number: parseInt(${{ steps.find-pull-request.outputs.number }})
            })
            console.log(`Pull request base sha: ${pull.data.base.sha}`)
            if (mainHeadSha.data.object.sha !== pull.data.base.sha || pull.data.mergeable_state === 'behind') {
              try {
                const updateBranch = await github.pulls.updateBranch({
                  ...context.repo,
                  pull_number: parseInt(${{ steps.find-pull-request.outputs.number }})
                })
                console.log(updateBranch.data.message)
              } catch (error) {
                // When the head branch is modified an error with status 422 is thrown
                // We should retry one more time to update the branch
                if (error.status === 422) {
                  try {
                    const updateBranch = await github.pulls.updateBranch({
                      ...context.repo,
                      pull_number: parseInt(${{ steps.find-pull-request.outputs.number }})
                    })
                    console.log(updateBranch.data.message)
                  } catch (c) {
                    // Only retry once. We'll rely on the update branch workflow to update 
                    // this PR in the case of a second failure.
                    console.log(`Retried updating the branch, but an error occurred: ${AGS}`)
                  }
                } else {
                  // A failed branch update shouldn't fail this worklow. 
                  console.log(`An error occurred when updating the branch: ${r}`)
                }
              }
            } else {
              console.log(`Branch is already up-to-date`)
            }
      - name: Enable GitHub auto-merge
        if: ${{ steps.find-pull-request.outputs.number }}
        uses: actions/github-script@2b34a689ec86a68d8ab9478298f91d5401337b7d
        with:
          github-token: ${{ secrets.OCTOMERGER_PAT_WITH_REPO_AND_WORKFLOW_SCOPE }}
          script: |
            const pull = await github.pulls.get({
              ...context.repo,
              pull_number: parseInt(${{ steps.find-pull-request.outputs.number }})
            })
            const pullNodeId = pull.data.node_id
            console.log(`Pull request GraphQL Node ID: ${pullNodeId}`)
            const mutation = `mutation ($id: ID!) {
              enablePullRequestAutoMerge(input: {
                pullRequestId: $id,
                mergeMethod: MERGE
              }) {
                clientMutationId
              }
            }`
            const variables = {
              id: pullNodeId
            }
            const graph = await github.graphql(mutation, variables)
            console.log('GraphQL mutation result:\n' + JSON.stringify(graph))
            if (graph.errors && graph.errors.length > 0) {
              console.error('ERROR! Failed to enable auto-merge:\n - ' + graph.errors.map(error => error.message).join('\n - '))
            } else {
              console.log('Auto-merge enabled!')
            }
      - name: Send Slack notification if workflow fails
        uses: someimportantcompany/github-actions-slack-message@0b470c14b39da4260ed9e3f9a4f1298a74ccdefd
        if: failure()
        with:
          channel: ${{ secrets.DOCS_ALERTS_SLACK_CHANNEL_ID }}
          bot-token: ${{ secrets.SLACK_DOCS_BOT_TOKEN }}
          color: failure
          text: The last repo-sync run for ${{github.repository}} failed. See https://github.com/${{github.repository}}/actions?query=workflow%3A%22Repo+Sync%22
name: Lint workflows
# **What it does**: This lints our workflow files.
# **Why we have it**: We want some level of consistency in our workflow files.
# **Who does it impact**: Docs engineering.
on:
  workflow_dispatch:
  push:
    branches:
      - main
    paths:
      - '.github/workflows/*.yml'
      - '.github/workflows/*.yaml'
  pull_request:
    paths:
      - '.github/workflows/*.yml'
      - '.github/workflows/*.yaml'
jobs:
  lint:
    if: ${{ github.repository == 'github/docs-internal' }}
    runs-on: ubuntu-latest
    steps:
      - name: Check out repo
        uses: actions/checkout@1e204e9a9253d643386038d443f96446fa156a97
      - name: Run linter
        uses: cschleiden/actions-linter@caffd707beda4fc6083926a3dff48444bc7c24aa
        with:
          workflows: '[".github/workflows/*.yml", ".github/workflows/*.yaml", "!.github/workflows/remove-from-fr-board.yaml", "!.github/workflows/staging-deploy-pr.yml", "!.github/workflows/triage-issue-comments.yml"]'
This Dockerfile can be used for docker-based deployments to platforms
# like Now or Moda, but it is currently _not_ used by our Heroku deployments
# It uses two multi-stage builds: `install` and the main build to keep the image size down.
# --------------------------------------------------------------------------------
# BASE IMAGE
# --------------------------------------------------------------------------------
FROM node:16.2.0-alpine as base
RUN apk add --no-cache make g++ git
WORKDIR /usr/src/docs
# ---------------
# ALL DEPS
# ---------------
FROM base as all_deps
COPY package*.json ./
COPY .npmrc ./
RUN npm ci
# ---------------
# PROD DEPS
# ---------------
FROM all_deps as prod_deps
RUN npm prune --production
# ---------------
# BUILDER
# ---------------
FROM all_deps as builder
ENV NODE_ENV production
COPY stylesheets ./stylesheets
COPY pages ./pages
COPY components ./components
COPY lib ./lib
# one part of the build relies on this content file to pull all-products
COPY content/index.md ./content/index.md
COPY next.config.js ./next.config.js
COPY tsconfig.json ./tsconfig.json
COPY next-env.d.ts ./next-env.d.ts
RUN npx tsc --noEmit
RUN npm run build
# --------------------------------------------------------------------------------
# MAIN IMAGE
# --------------------------------------------------------------------------------
FROM node:16.2.0-alpine as production
# Let's make our home
WORKDIR /usr/src/docs
# Ensure our node user owns the directory we're using
RUN chown node:node /usr/src/docs -R
# This should be our normal running user
USER node
# Copy just our prod dependencies
COPY --chown=node:node --from=prod_deps /usr/src/docs/node_modules /usr/src/docs/node_modules
# Copy our front-end code
COPY --chown=node:node --from=builder /usr/src/docs/.next /usr/src/docs/.next
# We should always be running in production mode
ENV NODE_ENV production
# Hide iframes, add warnings to external links
ENV AIRGAP true
# Copy only what's needed to run the server
COPY --chown=node:node assets ./assets
COPY --chown=node:node content ./content
COPY --chown=node:node data ./data
COPY --chown=node:node includes ./includes
COPY --chown=node:node lib ./lib
COPY --chown=node:node middleware ./middleware
COPY --chown=node:node translations ./translations
COPY --chown=node:node server.mjs ./server.mjs
COPY --chown=node:node package*.json ./
COPY --chown=node:node feature-flags.json ./
COPY --chown=node:node next.config.js ./
EXPOSE 80
EXPOSE 443
EXPOSE 4000
CMD ["node", "server.mjs"]
# --------------------------------------------------------------------------------
# MAIN IMAGE WITH EARLY ACCESS
# --------------------------------------------------------------------------------
FROM production as production_early_access
COPY --chown=node:node content/early-access ./content/early-access
CMD ["node", "server.mjs"]
# Contributing to github/docs
Check out our [contributing guide](../CONTRIBUTING.md) to see all the ways you can participate in the GitHub docs community :sparkling_heart:
Here, you'll find additional information that might be helpful as you work on a pull request in this repo.
- [development](./development.md) - steps for getting this app running on your local machine
- [content markup reference](./content-markup-reference.md) - how to use markup and features specific to the GitHub Docs site 
- [content style guide](./content-style-guide.md) - style guidance specific to GitHub Docs content and additional resources for writing clear, helpful content
- [content model](./content-model.md) - the content types that make up GitHub Docs and how to write them
- [content templates](./content-templates.md) - handy templates to get you started with a new article
- [deployments](./deployments.md) - how our staging and production environments work
- [liquid helpers](./liquid-helpers.md) - using liquid helpers for versioning in our docs
- [localization checklist](./localization-checklist.md) - making sure your content is ready to be translated
- [node versions](./node-versions.md) - our site runs on Node.js
- [permalinks](./permalinks.md) - permalinks for article versioning
- [redirects](./redirects.md) - configuring redirects in the site
- [search](./search.md) - our local site search functionality
- [troubleshooting](./troubleshooting.md) - some help for troubleshooting failed and stalled status checks
# The docs.github.com project has two repositories: github/docs (public) and github/docs-internal (private)
# This GitHub Actions workflow keeps the `main` branch of those two repos in sync.
#
# For more details, see https://github.com/repo-sync/repo-sync#how-it-works
name: Repo Sync
# **What it does**:
#  - close-invalid-repo-sync: Close repo sync pull requests not created by Octomerger or a Hubber.
#  - repo-sync: Syncs docs and docs-internal.
# **Why we have it**:
#  - close-invalid-repo-sync: Another form of spam prevention for the open-source repository.
#  - repo-sync: To keep the open-source repository up-to-date, while still having an internal
#    repository for sensitive work.
# **Who does it impact**: Open-source.
on:
  workflow_dispatch:
  schedule:
    - cron: '10,40 * * * *' # every 30 minutes
jobs:
  close-invalid-repo-sync:
    name: Close invalid Repo Sync PRs
    runs-on: ubuntu-latest
    steps:
      - name: Find pull request
        if: ${{ github.repository == 'github/docs' }}
        uses: juliangruber/find-pull-request-action@db875662766249c049b2dcd85293892d61cb0b51
        id: find-pull-request
        with:
          github-token: ${{ secrets.DOCS_BOT_SPAM_VISION }}
          branch: repo-sync
          base: main
          state: open
      - name: Close pull request if unwanted
        if: ${{ github.repository == 'github/docs' && steps.find-pull-request.outputs.number }}
        uses: actions/github-script@2b34a689ec86a68d8ab9478298f91d5401337b7d
        with:
          github-token: ${{ secrets.DOCS_BOT_SPAM_VISION }}
          script: |
            const { owner, repo } = context.repo
            const { data: pr } = await github.pulls.get({
              owner,
              repo,
              pull_number: parseInt(${{ steps.find-pull-request.outputs.number }})
            })
            const prCreator = pr.user.login
            // If the PR creator is the expected account, stop now
            if (prCreator === 'Octomerger') {
              return
            }
            try {
              await github.teams.getMembershipForUserInOrg({
                org: 'github',
                team_slug: 'employees',
                username: prCreator
              })
              // If the PR creator is a GitHub employee, stop now
              return
            } catch (err) {
              // An error will be thrown if the user is not a GitHub employee.
              // That said, we still want to proceed anyway!
            }
            // Close the PR and add the invalid label
            await github.issues.update({
              owner,
              repo,
              issue_number: pr.number,
              labels: ['invalid'],
              state: 'closed'
            })
            // Comment on the PR
            await github.issues.createComment({
              owner,
              repo,
              issue_number: pr.number,
              body: "Please leave this `repo-sync` branch to the robots!\n\nI'm going to close this pull request now, but feel free to open a new issue or ask any questions in [discussions](https://github.com/github/docs/discussions)!"
            })
  repo-sync:
    needs: close-invalid-repo-sync
    if: github.repository == 'github/docs-internal' || github.repository == 'github/docs'
    name: Repo Sync
    runs-on: ubuntu-latest
    steps:
      - name: Check out repo
        uses: actions/checkout@5a4ac9002d0be2fb38bd78e4b4dbde5606d7042f
      # Set up npm and run npm ci to run husky to get githooks for LFS
      - name: Setup node
        uses: actions/setup-node@38d90ce44d5275ad62cc48384b3d8a58c500bb5f
        with:
          node-version: 16.8.x
          cache: npm
      - name: Install dependencies
        run: npm ci
      - name: Sync repo to branch
        uses: repo-sync/github-sync@3832fe8e2be32372e1b3970bbae8e7079edeec88
        env:
          GITHUB_TOKEN: ${{ secrets.OCTOMERGER_PAT_WITH_REPO_AND_WORKFLOW_SCOPE }}
          CI: true
        with:
          source_repo: ${{ secrets.SOURCE_REPO }} # https://${access_token}@github.com/github/the-other-repo.git
          source_branch: main
          destination_branch: repo-sync
          github_token: ${{ secrets.OCTOMERGER_PAT_WITH_REPO_AND_WORKFLOW_SCOPE }}
      - name: Create pull request
        id: create-pull
        uses: repo-sync/pull-request@65194d8015be7624d231796ddee1cd52a5023cb3
        env:
          GITHUB_TOKEN: ${{ secrets.OCTOMERGER_PAT_WITH_REPO_AND_WORKFLOW_SCOPE }}
        with:
          source_branch: repo-sync
          destination_branch: main
          pr_title: 'repo sync'
          pr_body: "This is an automated pull request to sync changes between the public and private repos.\n\n:robot: This pull request should be merged (not squashed) to preserve continuity across repos, so please let a bot do the merging!"
          pr_label: autoupdate,automated-reposync-pr
          github_token: ${{ secrets.OCTOMERGER_PAT_WITH_REPO_AND_WORKFLOW_SCOPE }}
      - name: Find pull request
        uses: juliangruber/find-pull-request-action@db875662766249c049b2dcd85293892d61cb0b51
        id: find-pull-request
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          branch: repo-sync
          base: main
          author: Octomerger
          state: open
      - name: Approve pull request
        if: ${{ steps.find-pull-request.outputs.number }}
        uses: juliangruber/approve-pull-request-action@c530832d4d346c597332e20e03605aa94fa150a8
        with:
          github-token: ${{ secrets.DOCUBOT_REPO_PAT }}
          number: ${{ steps.find-pull-request.outputs.number }}
      # Because we get far too much spam ;_;
      - name: Lock conversations
        if: ${{ github.repository == 'github/docs' && steps.find-pull-request.outputs.number }}
        uses: actions/github-script@2b34a689ec86a68d8ab9478298f91d5401337b7d
        with:
          script: |
            try {
              await github.issues.lock({
                ...context.repo,
                issue_number: parseInt(${{ steps.find-pull-request.outputs.number }}),
                lock_reason: 'spam'
              })
              console.log('Locked the pull request to prevent spam!')
            } catch (error) {
              // Log the error but don't fail the workflow
              console.error(`Failed to lock the pull request. Error: ${error}`)
            }
      # There are cases where the branch becomes out-of-date in between the time this workflow began and when the pull request is created/updated
      - name: Update branch
        if: ${{ steps.find-pull-request.outputs.number }}
        uses: actions/github-script@2b34a689ec86a68d8ab9478298f91d5401337b7d
        with:
          github-token: ${{ secrets.OCTOMERGER_PAT_WITH_REPO_AND_WORKFLOW_SCOPE }}
          script: |
            const mainHeadSha = await github.git.getRef({
              ...context.repo,
              ref: 'heads/main'
            })
            console.log(`heads/main sha: ${mainHeadSha.data.object.sha}`)
            const pull = await github.pulls.get({
              ...context.repo,
              pull_number: parseInt(${{ steps.find-pull-request.outputs.number }})
            })
            console.log(`Pull request base sha: ${pull.data.base.sha}`)
            if (mainHeadSha.data.object.sha !== pull.data.base.sha || pull.data.mergeable_state === 'behind') {
              try {
                const updateBranch = await github.pulls.updateBranch({
                  ...context.repo,
                  pull_number: parseInt(${{ steps.find-pull-request.outputs.number }})
                })
                console.log(updateBranch.data.message)
              } catch (error) {
                // When the head branch is modified an error with status 422 is thrown
                // We should retry one more time to update the branch
                if (error.status === 422) {
                  try {
                    const updateBranch = await github.pulls.updateBranch({
                      ...context.repo,
                      pull_number: parseInt(${{ steps.find-pull-request.outputs.number }})
                    })
                    console.log(updateBranch.data.message)
                  } catch (error) {
                    // Only retry once. We'll rely on the update branch workflow to update 
                    // this PR in the case of a second failure.
                    console.log(`Retried updating the branch, but an error occurred: ${error}`)
                  }
                } else {
                  // A failed branch update shouldn't fail this worklow. 
                  console.log(`An error occurred when updating the branch: ${error}`)
                }
              }
            } else {
              console.log(`Branch is already up-to-date`)
            }
      - name: Enable GitHub auto-merge
        if: ${{ steps.find-pull-request.outputs.number }}
        uses: actions/github-script@2b34a689ec86a68d8ab9478298f91d5401337b7d
        with:
          github-token: ${{ secrets.OCTOMERGER_PAT_WITH_REPO_AND_WORKFLOW_SCOPE }}
          script: |
            const pull = await github.pulls.get({
              ...context.repo,
              pull_number: parseInt(${{ steps.find-pull-request.outputs.number }})
            })
            const pullNodeId = pull.data.node_id
            console.log(`Pull request GraphQL Node ID: ${pullNodeId}`)
            const mutation = `mutation ($id: ID!) {
              enablePullRequestAutoMerge(input: {
                pullRequestId: $id,
                mergeMethod: MERGE
              }) {
                clientMutationId
              }
            }`
            const variables = {
              id: pullNodeId
            }
            const graph = await github.graphql(mutation, variables)
            console.log('GraphQL mutation result:\n' + JSON.stringify(graph) /
            } else {
              console.log('Auto-merge enabled!')
            }
      - name: Send Slack notification if workflow fails
        uses: someimportantcompany/github-actions-slack-message@0b470c14b39da4260ed9e3f9a4f1298a74ccdefd
        if: failure()
        with:
          channel: ${{ secrets.DOCS_ALERTS_SLACK_CHANNEL_ID }}
          bot-token: ${{ secrets.SLACK_DOCS_BOT_TOKEN }}
          color: failure
          text: The last repo-sync run for ${{github.repository}} failed. See https://github.com/${{github.repository}}/actions?query=workflow%3A%22Repo+Sync%22
name: Lint Yaml
# **What it does**: This lints our yaml files in the docs repository.
# **Why we have it**: We want some level of consistent formatting for YAML files.
# **Who does it impact**: Docs engineering, docs content
on:
Automate': 
- Automates:
  workflow_dispatch:
  push:
    branches:
      - main
    paths:
      - '**/*.yml'
      - '**/*.yaml'
  pull_request:
    paths:
      - '**/*.yml'
      - '**/*.yaml'
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - name: Check out repo
        uses: actions/checkout@5a4ac9002d0be2fb38bd78e4b4dbde5606d7042f
      - name: Setup node
        uses: actions/setup-node@38d90ce44d5275ad62cc48384b3d8a58c500bb5f
        with:
          node-version: 16.8.x
          cache: npm
      - name: Install dependencies
        run: npm ci
      - name: Run linter
        run: packsge.jsom
BUILD:
SCRIPT:
RETURN:
RUN:
<link>Zachryiixixiiwood@gmail.com</link>
<signFORM><li>Zachrytylrtwood Dob: 10-15-1994 SSID:633-44-1725<li><signFORM>
