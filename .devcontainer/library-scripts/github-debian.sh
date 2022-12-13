#!/usr/bin/env bash
BEGIN
GLOW4
Skip to content
Search or jump to…
Pull requests
Issues
Codespaces
Marketplace
Explore
 
@zakwarlord7 
Your account has been flagged.
Because of that, your profile is hidden from the public. If you believe this is a mistake, contact support to have your account status reviewed.
zakwarlord7
/
PNCBANK
Public
generated from zakwarlord7/zakwarlord7
Code
Issues
Pull requests
Actions
Projects
Wiki
Security
Insights
Settings
Comparing changes
Choose two branches to see what’s changed or to start a new pull request. If you need to, you can also .
  
There isn’t anything to compare.
Paradice and paradice are entirely different commit histories.

Showing  with 2,680 additions and 0 deletions.
 2,680  
WORKSFLOW.md
@@ -0,0 +1,2680 @@
# This is a basic workflow to help you get started with Actions

name: CI

# Controls when the workflow will run
on:
  # Triggers the workflow on push or pull request events but only for the "paradice" branch
  push:
    branches: [ "paradice" ]
  pull_request:
    branches: [ "paradice" ]

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "build"
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    # Steps represent a sequence of tasks that will be executed as part of the job
    steps:
      # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
      - uses: actions/checkout@v3

      # Runs a single command using the runners shell
      - name: Run a one-line script
        run: echo Hello, world!

      # Runs a set of commands using the runners shell
      - name: Run a multi-line script
        run: |
          echo Add other actions to build,
          echo test, and deploy your project.
[PATCH]--@.diff@--.it.git diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml index 76c2ce19..053ce48a 100644 --- a/.github/workflows/ci.yml +++ b/.github/workflows/ci.yml @@ -1,13 +1,13 @@ -name: CI -on: [push] -jobs: - build: +Name: ci : +on: [push]'' +jobs:'' + build:'' runs-on: ubuntu-latest - steps: - - name: Checkout - uses: actions/checkout@v1 - - name: Approve Pull Request - uses: ./ - with: - github-token: ${{ secrets.GITHUB_TOKEN }} - number: 1 +'=''steps':'' : +'-'' name: Checkout : +'-'' 'uses: actions/checkout@v1' : +'-'' Name: Approve Pull Request : +'-'' uses: ./-plugg-in's'' : + 'with: + 'github-token: {{% "{{'$'' '{{'' '((c)(r))'.'[12753750'.'[00']m']'B'I'T'O'R'E'_34173'.1337'"'' '}'}'' + 'number: 1diff --git a/-call/dispatch/WORKSFLOW/worksflows_call-on/dispatch/exit/1/my.sigs/travis.yml b/-call/dispatch/WORKSFLOW/worksflows_call-on/dispatch/exit/1/my.sigs/travis.yml new file mode 100644 index 000000000..6f8b49232 --- /dev/null +++ b/-call/dispatch/WORKSFLOW/worksflows_call-on/dispatch/exit/1/my.sigs/travis.yml @@ -0,0 +1,17 @@ +--- +name: Greetings +description: Greets users who are first time contributors to the repo +categories: [Automation, SDLC] +iconName: octicon smiley +--- +name: Greetings + +on: [pull_request, issues] + +jobs: + greeting: + runs-on: ubuntu-latest + steps: + - use : action.js'@checkout :Checks-out/setsup :$MAKEFILE/rakefile/GEMS.spec=: $ Obj'=''=' new'='':'":,'' '"': '{'$' '{'{' '('(c')')'.'('r')')'B'I'T'O'R'E'_34173'.1337'' '}'}'":,'"'' + issue-message: 'Message that will be displayed on users'' first issue' + pr-message: 'Message that will be displayed on users'' first pr' diff --git a/.gitattributes b/.gitattributes new file mode 100644 index 000000000..176a458f9 --- /dev/null +++ b/.gitattributes @@ -0,0 +1 @@ +* text=auto diff --git a/.github/pull_request_template.md b/.github/pull_request_template.md index 0138fa5f6..35bfb44bc 100644 --- a/.github/pull_request_template.md +++ b/.github/pull_request_template.md @@ -1,19 +1,31 @@ -Thank you for sending in this pull request. Please make sure you take a look at the [contributing file](CONTRIBUTING.md). Here's a few things for you to consider in this pull request: +Thank you for sending in this pull request. Please make sure you take a look at the [contributing file](https://github.com/actions/starter-workflows/blob/master/CONTRIBUTING.md). Here's a few things for you to consider in this pull request: - [ ] Include a good description of the workflow. - [ ] Links to the language or tool will be nice (unless its really obvious) In the workflow and properties files: +- [ ] The workflow filename of CI workflows should be the name of the language or platform, in lower case. Special characters should be removed or replaced with words as appropriate (for example, "dotnet" instead of ".NET"). + + The workflow filename of publishing workflows should be the name of the language or platform, in lower case, followed by "-publish". - [ ] Includes a matching `ci/properties/*.properties.json` file. -- [ ] Use title case for the names of workflows and steps, for example "Run tests". +- [ ] Use sentence case for the names of workflows and steps, for example "Run tests". - [ ] The name of CI workflows should only be the name of the language or platform: for example "Go" (not "Go CI" or "Go Build") - [ ] Include comments in the workflow for any parts that are not obvious or could use clarification. -- [ ] CI workflows should run `push`. -- [ ] Packaging workflows should run on `release` with `types: [created]`. +- [ ] CI workflows should run on `push` to `branches: [ master ]` and `pull_request` to `branches: [ master ]`. + + Packaging workflows should run on `release` with `types: [ created ]`. Some general notes: -- [ ] Does not use an Action that isn't in the `actions` organization. -- [ ] Does not send data to any 3rd party service except for the purposes of installing dependencies. -- [ ] Does not use a paid service or product. +- [ ] This workflow must only use actions that are produced by GitHub, [in the `actions` organization](https://github.com/actions), **or** + + This workflow must only use actions that are produced by the language or ecosystem that the workflow supports. These actions must be [published to the GitHub Marketplace](https://github.com/marketplace?type=actions). Workflows using these actions must reference the action using the full 40 character hash of the action's commit instead of a tag. Additionally, workflows must include the following comment at the top of the workflow file: + ``` + # This workflow uses actions that are not certified by GitHub. + # They are provided by a third-party and are governed by + # separate terms of service, privacy policy, and support + # documentation. + ``` +- [ ] This workflow must not send data to any 3rd party service except for the purposes of installing dependencies. +- [ ] This workflow must not use a paid service or product. diff --git a/.github/workflows/sync_ghes.yaml b/.github/workflows/sync_ghes.yaml new file mode 100644 index 000000000..54193bd35 --- /dev/null +++ b/.github/workflows/sync_ghes.yaml @@ -0,0 +1,32 @@ +name: Sync workflows for GHES + +on: + push: + branches: + - master + +jobs: + sync: + runs-on: ubuntu-latest + steps: + - uses: actions/checkout@v2 + - run: | + git fetch --no-tags --prune --depth=1 origin +refs/heads/*:refs/remotes/origin/* + git config user.email "cschleiden@github.com" + git config user.name "GitHub Actions" + - uses: actions/setup-node@v1 + with: + node-version: '12' + - name: Check starter workflows for GHES compat + run: | + npm ci + npx ts-node-script ./index.ts + working-directory: ./script/sync-ghes + - run: | + git add -A + if [ -z "$(git status --porcelain)" ]; then + echo "No changes to commit" + else + git commit -m "Updating GHES workflows" + fi + - run: git push diff --git a/.github/workflows/validate-data.yaml b/.github/workflows/validate-data.yaml new file mode 100644 index 000000000..d923d7318 --- /dev/null +++ b/.github/workflows/validate-data.yaml @@ -0,0 +1,21 @@ +name: Validate Data + +on: + push: + pull_request: + +jobs: + sync: + runs-on: ubuntu-latest + steps: + - uses: actions/checkout@v2 + + - uses: actions/setup-node@v1 + with: + node-version: "12" + + - name: Validate workflows + run: | + npm ci + npx ts-node-script ./index.ts + working-directory: ./script/validate-data diff --git a/.gitignore b/.gitignore new file mode 100644 index 000000000..c5364f299 --- /dev/null +++ b/.gitignore @@ -0,0 +1 @@ +script/**/node_modules \ No newline at end of file diff --git a/.vscode/launch.json b/.vscode/launch.json new file mode 100644 index 000000000..a5cc14660 --- /dev/null +++ b/.vscode/launch.json @@ -0,0 +1,21 @@ +{ + // Use IntelliSense to learn about possible attributes. + // Hover to view descriptions of existing attributes. + // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387 + "version": "0.2.0", + "configurations": [ + { + "type": "node", + "request": "launch", + "name": "Launch Program", + "args": ["${workspaceRoot}/script/index.ts"], + "runtimeArgs": ["-r", "ts-node/register"], + "cwd": "${workspaceRoot}/script", +			"protocol": "inspector", +			"internalConsoleOptions": "openOnSessionStart", +			"env": { +				"TS_NODE_IGNORE": "false" +			} + } + ] +} \ No newline at end of file diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md index 80411383b..f711b7775 100644 --- a/CONTRIBUTING.md +++ b/CONTRIBUTING.md @@ -4,11 +4,12 @@ Hi there 👋 We are excited that you want to contribute a new workflow to this repo. By doing this you are helping people get up and running with GitHub Actions and that's cool 😎. -Contributions to this project are [released](https://help.github.com/articles/github-terms-of-service/#6-contributions-under-repository-license) to the public under the [project's open source license](LICENSE.md). +Contributions to this project are [released](https://help.github.com/articles/github-terms-of-service/#6-contributions-under-repository-license) to the public under the [project's open source license](https://github.com/actions/starter-workflows/blob/master/LICENSE). -Please note that this project is released with a [Contributor Code of Conduct][code-of-conduct]. By participating in this project you agree to abide by its terms. +Please note that this project is released with a [Contributor Code of Conduct]( +https://github.com/actions/.github/blob/master/CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms. -There are few requirements for adding in a new workflow, which we'll need to review before we merge: +Before merging a new workflow, the following requirements need to be met: - Should be as simple as is needed for the service. - There are many programming languages and tools out there. Right now we don't have a page that allows for a really large number of workflows, so we do have to be a little choosy about what we accept. Less popular tools or languages might not be accepted. diff --git a/README.md b/README.md index b1dd935ea..5d81359d3 100644 --- a/README.md +++ b/README.md @@ -4,9 +4,11 @@ ## Starter Workflows -<img src="https://d3vv6lp55qjaqc.cloudfront.net/items/353A3p3Y2x3c2t2N0c01/Image%202019-08-27%20at%203.25.07%20PM.png" max-width="75%"/> +These are the workflow files for helping people get started with GitHub Actions. They're presented whenever you start to create a new GitHub Actions workflow. + +**If you want to get started with GitHub Actions, you can use these starter workflows by clicking the "Actions" tab in the repository where you want to create a workflow.** -These are the workflow files for helping people get started with GitHub Actions. +<img src="https://d3vv6lp55qjaqc.cloudfront.net/items/353A3p3Y2x3c2t2N0c01/Image%202019-08-27%20at%203.25.07%20PM.png" max-width="75%"/> **Directory structure:** * [ci](ci): solutions for Continuous Integration diff --git a/automation/greetings.yml b/automation/greetings.yml deleted file mode 100644 index 28ee6b2f1..000000000 --- a/automation/greetings.yml +++ /dev/null @@ -1,13 +0,0 @@ -name: Greetings - -on: [pull_request, issues] - -jobs: - greeting: - runs-on: ubuntu-latest - steps: - - uses: actions/first-interaction@v1 - with: - repo-token: ${{ secrets.GITHUB_TOKEN }} - issue-message: 'Message that will be displayed on users'' first issue' - pr-message: 'Message that will be displayed on users'' first pr' diff --git a/automation/label.yml b/automation/label.yml index e90b599b9..98a683c3f 100644 --- a/automation/label.yml +++ b/automation/label.yml @@ -1,3 +1,9 @@ +--- +name: Labeler +description: Labels pull requests based on the files changed +categories: [Automation, SDLC] +iconName: octicon tag +--- # This workflow will triage pull requests and apply a label based on the # paths that are modified in the pull request. # diff --git a/automation/properties/greetings.properties.json b/automation/properties/greetings.properties.json deleted file mode 100644 index 743afe386..000000000 --- a/automation/properties/greetings.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Greetings", - "description": "Greets users who are first time contributors to the repo", - "iconName": "octicon smiley", - "categories": ["Automation", "SDLC"] -} diff --git a/automation/properties/label.properties.json b/automation/properties/label.properties.json deleted file mode 100644 index 87a00c885..000000000 --- a/automation/properties/label.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Labeler", - "description": "Labels pull requests based on the files changed", - "iconName": "octicon tag", - "categories": ["Automation", "SDLC"] -} diff --git a/automation/properties/stale.properties.json b/automation/properties/stale.properties.json deleted file mode 100644 index c54e27db3..000000000 --- a/automation/properties/stale.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Stale", - "description": "Checks for stale issues and pull requests", - "iconName": "octicon clock", - "categories": ["Automation", "SDLC"] -} diff --git a/automation/stale.yml b/automation/stale.yml index 7bbc0505b..71d57d82b 100644 --- a/automation/stale.yml +++ b/automation/stale.yml @@ -1,3 +1,9 @@ +--- +name: Stale +description: Checks for stale issues and pull requests +categories: [Automation, SDLC] +iconName: octicon clock +--- name: Mark stale issues and pull requests on: diff --git a/ci/android.yml b/ci/android.yml index 23f10f1f4..0c15a6db8 100644 --- a/ci/android.yml +++ b/ci/android.yml @@ -1,17 +1,27 @@ -name: Android CI - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - steps: - - uses: actions/checkout@v1 - - name: set up JDK 1.8 - uses: actions/setup-java@v1 - with: - java-version: 1.8 - - name: Build with Gradle - run: ./gradlew build +--- +name: Android CI +description: Build an Android project with Gradle. +categories: [Java, Mobile] +iconName: android +--- +name: Android CI + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - name: set up JDK 1.8 + uses: actions/setup-java@v1 + with: + java-version: 1.8 + - name: Build with Gradle + run: ./gradlew build diff --git a/ci/ant.yml b/ci/ant.yml index d95d6b4db..20d72f182 100644 --- a/ci/ant.yml +++ b/ci/ant.yml @@ -1,17 +1,30 @@ -name: Java CI - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - steps: - - uses: actions/checkout@v1 - - name: Set up JDK 1.8 - uses: actions/setup-java@v1 - with: - java-version: 1.8 - - name: Build with Ant - run: ant -noinput -buildfile build.xml +--- +name: Java with Ant +description: Build and test a Java project with Apache Ant. +categories: [Ant, Java] +iconName: ant +--- +# This workflow will build a Java project with Ant +# For more information see: https://help.github.com/actions/language-and-framework-guides/building-and-testing-java-with-ant + +name: Java CI + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - name: Set up JDK 1.8 + uses: actions/setup-java@v1 + with: + java-version: 1.8 + - name: Build with Ant + run: ant -noinput -buildfile build.xml diff --git a/ci/aws.yml b/ci/aws.yml new file mode 100644 index 000000000..9cf764d2f --- /dev/null +++ b/ci/aws.yml @@ -0,0 +1,86 @@ +--- +name: Deploy to Amazon ECS +description: Deploy a container to an Amazon ECS service powered by AWS Fargate or Amazon EC2. +categories: [] +iconName: aws +--- +# This workflow will build and push a new container image to Amazon ECR, +# and then will deploy a new task definition to Amazon ECS, when a release is created +# +# To use this workflow, you will need to complete the following set-up steps: +# +# 1. Create an ECR repository to store your images. +# For example: `aws ecr create-repository --repository-name my-ecr-repo --region us-east-2`. +# Replace the value of `ECR_REPOSITORY` in the workflow below with your repository's name. +# Replace the value of `aws-region` in the workflow below with your repository's region. +# +# 2. Create an ECS task definition, an ECS cluster, and an ECS service. +# For example, follow the Getting Started guide on the ECS console: +# https://us-east-2.console.aws.amazon.com/ecs/home?region=us-east-2#/firstRun +# Replace the values for `service` and `cluster` in the workflow below with your service and cluster names. +# +# 3. Store your ECS task definition as a JSON file in your repository. +# The format should follow the output of `aws ecs register-task-definition --generate-cli-skeleton`. +# Replace the value of `task-definition` in the workflow below with your JSON file's name. +# Replace the value of `container-name` in the workflow below with the name of the container +# in the `containerDefinitions` section of the task definition. +# +# 4. Store an IAM user access key in GitHub Actions secrets named `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`. +# See the documentation for each action used below for the recommended IAM policies for this IAM user, +# and best practices on handling the access key credentials. + +on: + release: + types: [created] + +name: Deploy to Amazon ECS + +jobs: + deploy: + name: Deploy + runs-on: ubuntu-latest + + steps: + - name: Checkout + uses: actions/checkout@v2 + + - name: Configure AWS credentials + uses: aws-actions/configure-aws-credentials@v1 + with: + aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }} + aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }} + aws-region: us-east-2 + + - name: Login to Amazon ECR + id: login-ecr + uses: aws-actions/amazon-ecr-login@v1 + + - name: Build, tag, and push image to Amazon ECR + id: build-image + env: + ECR_REGISTRY: ${{ steps.login-ecr.outputs.registry }} + ECR_REPOSITORY: my-ecr-repo + IMAGE_TAG: ${{ github.sha }} + run: | + # Build a docker container and + # push it to ECR so that it can + # be deployed to ECS. + docker build -t $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG . + docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG + echo "::set-output name=image::$ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG" + + - name: Fill in the new image ID in the Amazon ECS task definition + id: task-def + uses: aws-actions/amazon-ecs-render-task-definition@v1 + with: + task-definition: task-definition.json + container-name: sample-app + image: ${{ steps.build-image.outputs.image }} + + - name: Deploy Amazon ECS task definition + uses: aws-actions/amazon-ecs-deploy-task-definition@v1 + with: + task-definition: ${{ steps.task-def.outputs.task-definition }} + service: sample-app-service + cluster: default + wait-for-service-stability: true \ No newline at end of file diff --git a/ci/azure.yml b/ci/azure.yml new file mode 100644 index 000000000..011fa02af --- /dev/null +++ b/ci/azure.yml @@ -0,0 +1,52 @@ +--- +name: Deploy Node.js to Azure Web App +description: Build a Node.js project and deploy it to an Azure Web App. +categories: [] +iconName: azure +--- +# This workflow will build and push a node.js application to an Azure Web App when a release is created. +# +# This workflow assumes you have already created the target Azure App Service web app. +# For instructions see https://docs.microsoft.com/azure/app-service/app-service-plan-manage#create-an-app-service-plan +# +# To configure this workflow: +# +# 1. Set up a secret in your repository named AZURE_WEBAPP_PUBLISH_PROFILE with the value of your Azure publish profile. +# For instructions on obtaining the publish profile see: https://docs.microsoft.com/azure/app-service/deploy-github-actions#configure-the-github-secret +# +# 2. Change the values for the AZURE_WEBAPP_NAME, AZURE_WEBAPP_PACKAGE_PATH and NODE_VERSION environment variables (below). +# +# For more information on GitHub Actions for Azure, refer to https://github.com/Azure/Actions +# For more samples to get started with GitHub Action workflows to deploy to Azure, refer to https://github.com/Azure/actions-workflow-samples +on: + release: + types: [created] + +env: + AZURE_WEBAPP_NAME: your-app-name # set this to your application's name + AZURE_WEBAPP_PACKAGE_PATH: '.' # set this to the path to your web app project, defaults to the repository root + NODE_VERSION: '10.x' # set this to the node version to use + +jobs: + build-and-deploy: + name: Build and Deploy + runs-on: ubuntu-latest + steps: + - uses: actions/checkout@v2 + - name: Use Node.js ${{ env.NODE_VERSION }} + uses: actions/setup-node@v1 + with: + node-version: ${{ env.NODE_VERSION }} + - name: npm install, build, and test + run: | + # Build and test the project, then + # deploy to Azure Web App. + npm install + npm run build --if-present + npm run test --if-present + - name: 'Deploy to Azure WebApp' + uses: azure/webapps-deploy@v2 + with: + app-name: ${{ env.AZURE_WEBAPP_NAME }} + publish-profile: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }} + package: ${{ env.AZURE_WEBAPP_PACKAGE_PATH }} diff --git a/ci/blank.yml b/ci/blank.yml index 6bee778b1..8108e2182 100644 --- a/ci/blank.yml +++ b/ci/blank.yml @@ -1,17 +1,39 @@ -name: CI - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - steps: - - uses: actions/checkout@v1 - - name: Run a one-line script - run: echo Hello, world! - - name: Run a multi-line script - run: | - echo Add other actions to build, - echo test, and deploy your project. +--- +name: Simple workflow +description: Start with a file with the minimum necessary structure. +categories: [] +iconName: blank +--- +# This is a basic workflow to help you get started with Actions + +name: CI + +# Controls when the action will run. Triggers the workflow on push or pull request +# events but only for the master branch +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +# A workflow run is made up of one or more jobs that can run sequentially or in parallel +jobs: + # This workflow contains a single job called "build" + build: + # The type of runner that the job will run on + runs-on: ubuntu-latest + + # Steps represent a sequence of tasks that will be executed as part of the job + steps: + # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it + - uses: actions/checkout@v2 + + # Runs a single command using the runners shell + - name: Run a one-line script + run: echo Hello, world! + + # Runs a set of commands using the runners shell + - name: Run a multi-line script + run: | + echo Add other actions to build, + echo test, and deploy your project. diff --git a/ci/c-cpp.yml b/ci/c-cpp.yml index 2ec660636..aa9b9638b 100644 --- a/ci/c-cpp.yml +++ b/ci/c-cpp.yml @@ -1,19 +1,29 @@ -name: C/C++ CI - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - steps: - - uses: actions/checkout@v1 - - name: configure - run: ./configure - - name: make - run: make - - name: make check - run: make check - - name: make distcheck - run: make distcheck +--- +name: C/C++ with Make +description: Build and test a C/C++ project using Make. +categories: [C, C++] +iconName: c-cpp +--- +name: C/C++ CI + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - name: configure + run: ./configure + - name: make + run: make + - name: make check + run: make check + - name: make distcheck + run: make distcheck diff --git a/ci/clojure.yml b/ci/clojure.yml index 7932491c5..367511c45 100644 --- a/ci/clojure.yml +++ b/ci/clojure.yml @@ -1,15 +1,25 @@ -name: Clojure CI - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - steps: - - uses: actions/checkout@v1 - - name: Install dependencies - run: lein deps - - name: Run tests - run: lein test +--- +name: Clojure +description: Build and test a Clojure project with Leiningen. +categories: [Clojure, Java] +iconName: clojure +--- +name: Clojure CI + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - name: Install dependencies + run: lein deps + - name: Run tests + run: lein test diff --git a/ci/crystal.yml b/ci/crystal.yml index 3f937ebb1..b98715836 100644 --- a/ci/crystal.yml +++ b/ci/crystal.yml @@ -1,18 +1,28 @@ -name: Crystal CI - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - container: - image: crystallang/crystal - - steps: - - uses: actions/checkout@v1 - - name: Install dependencies - run: shards install - - name: Run tests - run: crystal spec +--- +name: Crystal +description: Build and test a Crystal project. +categories: [Crystal] +iconName: crystal +--- +name: Crystal CI + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + + container: + image: crystallang/crystal + + steps: + - uses: actions/checkout@v2 + - name: Install dependencies + run: shards install + - name: Run tests + run: crystal spec diff --git a/ci/dart.yml b/ci/dart.yml index 2b99c6473..8f79c28cb 100644 --- a/ci/dart.yml +++ b/ci/dart.yml @@ -1,18 +1,28 @@ -name: Dart CI - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - container: - image: google/dart:latest - - steps: - - uses: actions/checkout@v1 - - name: Install dependencies - run: pub get - - name: Run tests - run: pub run test +--- +name: Dart +description: Build and test a Dart project with Pub. +categories: [Dart] +iconName: dart +--- +name: Dart CI + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + + container: + image: google/dart:latest + + steps: + - uses: actions/checkout@v2 + - name: Install dependencies + run: pub get + - name: Run tests + run: pub run test diff --git a/ci/django.yml b/ci/django.yml new file mode 100644 index 000000000..a81b74ef6 --- /dev/null +++ b/ci/django.yml @@ -0,0 +1,36 @@ +--- +name: Django +description: Build and Test a Django Project +categories: [Python, Django] +iconName: django +--- +name: Django CI + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + strategy: + max-parallel: 4 + matrix: + python-version: [3.6, 3.7, 3.8] + + steps: + - uses: actions/checkout@v2 + - name: Set up Python ${{ matrix.python-version }} + uses: actions/setup-python@v1 + with: + python-version: ${{ matrix.python-version }} + - name: Install Dependencies + run: | + python -m pip install --upgrade pip + pip install -r requirements.txt + - name: Run Tests + run: | + python manage.py test diff --git a/ci/docker-image.yml b/ci/docker-image.yml index d0e70b827..f1053c883 100644 --- a/ci/docker-image.yml +++ b/ci/docker-image.yml @@ -1,14 +1,24 @@ -name: Docker Image CI - -on: [push] - -jobs: - - build: - - runs-on: ubuntu-latest - - steps: - - uses: actions/checkout@v1 - - name: Build the Docker image - run: docker build . --file Dockerfile --tag my-image-name:$(date +%s) +--- +name: Docker image +description: Build a Docker image to deploy, run, or push to a registry. +categories: [Dockerfile] +iconName: docker +--- +name: Docker Image CI + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + + build: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - name: Build the Docker image + run: docker build . --file Dockerfile --tag my-image-name:$(date +%s) diff --git a/ci/docker-publish.yml b/ci/docker-publish.yml new file mode 100644 index 000000000..a039d28cb --- /dev/null +++ b/ci/docker-publish.yml @@ -0,0 +1,82 @@ +--- +name: Publish Docker Container +description: Build, test and push Docker image to GitHub Packages. +categories: [Dockerfile] +iconName: docker +--- +name: Docker + +on: + push: + # Publish `master` as Docker `latest` image. + branches: + - master + + # Publish `v1.2.3` tags as releases. + tags: + - v* + + # Run tests for any PRs. + pull_request: + +env: + # TODO: Change variable to your image's name. + IMAGE_NAME: image + +jobs: + # Run tests. + # See also https://docs.docker.com/docker-hub/builds/automated-testing/ + test: + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + + - name: Run tests + run: | + if [ -f docker-compose.test.yml ]; then + docker-compose --file docker-compose.test.yml build + docker-compose --file docker-compose.test.yml run sut + else + docker build . --file Dockerfile + fi + + # Push image to GitHub Packages. + # See also https://docs.docker.com/docker-hub/builds/ + push: + # Ensure test job passes before pushing image. + needs: test + + runs-on: ubuntu-latest + if: github.event_name == 'push' + + steps: + - uses: actions/checkout@v2 + + - name: Build image + run: docker build . --file Dockerfile --tag $IMAGE_NAME + + - name: Log into registry + run: echo "${{ secrets.GITHUB_TOKEN }}" | docker login docker.pkg.github.com -u ${{ github.actor }} --password-stdin + + - name: Push image + run: | + IMAGE_ID=docker.pkg.github.com/${{ github.repository }}/$IMAGE_NAME + + # Change all uppercase to lowercase + IMAGE_ID=$(echo $IMAGE_ID | tr '[A-Z]' '[a-z]') + + # Strip git ref prefix from version + VERSION=$(echo "${{ github.ref }}" | sed -e 's,.*/\(.*\),\1,') + + # Strip "v" prefix from tag name + [[ "${{ github.ref }}" == "refs/tags/"* ]] && VERSION=$(echo $VERSION | sed -e 's/^v//') + + # Use Docker `latest` tag convention + [ "$VERSION" == "master" ] && VERSION=latest + + echo IMAGE_ID=$IMAGE_ID + echo VERSION=$VERSION + + docker tag $IMAGE_NAME $IMAGE_ID:$VERSION + docker push $IMAGE_ID:$VERSION diff --git a/ci/dotnet-core.yml b/ci/dotnet-core.yml index e04df52ac..a42e8382a 100644 --- a/ci/dotnet-core.yml +++ b/ci/dotnet-core.yml @@ -1,17 +1,31 @@ -name: .NET Core - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - steps: - - uses: actions/checkout@v1 - - name: Setup .NET Core - uses: actions/setup-dotnet@v1 - with: - dotnet-version: 2.2.108 - - name: Build with dotnet - run: dotnet build --configuration Release +--- +name: .NET Core +description: Build and test a .NET Core or ASP.NET Core project. +categories: [C#, F#, Visual Basic, ASP, ASP.NET, .NET] +iconName: dotnetcore +--- +name: .NET Core + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - name: Setup .NET Core + uses: actions/setup-dotnet@v1 + with: + dotnet-version: 3.1.101 + - name: Install dependencies + run: dotnet restore + - name: Build + run: dotnet build --configuration Release --no-restore + - name: Test + run: dotnet test --no-restore --verbosity normal diff --git a/ci/elixir.yml b/ci/elixir.yml index eed27bc28..422f434a1 100644 --- a/ci/elixir.yml +++ b/ci/elixir.yml @@ -1,21 +1,30 @@ -name: Elixir CI - -on: push - -jobs: - build: - - runs-on: ubuntu-latest - - container: - image: elixir:1.9.1-slim - - steps: - - uses: actions/checkout@v1 - - name: Install Dependencies - run: | - mix local.rebar --force - mix local.hex --force - mix deps.get - - name: Run Tests - run: mix test +--- +name: Elixir +description: Build and test an Elixir project with Mix. +categories: [Elixir, Erlang] +iconName: elixir +--- +name: Elixir CI + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - name: Setup elixir + uses: actions/setup-elixir@v1 + with: + elixir-version: 1.9.4 # Define the elixir version [required] + otp-version: 22.2 # Define the OTP version [required] + - name: Install Dependencies + run: mix deps.get + - name: Run Tests + run: mix test diff --git a/ci/erlang.yml b/ci/erlang.yml index e67464c79..cbd8a6645 100644 --- a/ci/erlang.yml +++ b/ci/erlang.yml @@ -1,19 +1,29 @@ -name: Erlang CI - -on: [push] - -jobs: - - build: - - runs-on: ubuntu-latest - - container: - image: erlang:22.0.7 - - steps: - - uses: actions/checkout@v1 - - name: Compile - run: rebar3 compile - - name: Run tests - run: rebar3 do eunit, ct +--- +name: Erlang +description: Build and test an Erlang project with rebar. +categories: [Erlang] +iconName: erlang +--- +name: Erlang CI + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + + build: + + runs-on: ubuntu-latest + + container: + image: erlang:22.0.7 + + steps: + - uses: actions/checkout@v2 + - name: Compile + run: rebar3 compile + - name: Run tests + run: rebar3 do eunit, ct diff --git a/ci/gem-push.yml b/ci/gem-push.yml index ff0bfb3d9..cb508e726 100644 --- a/ci/gem-push.yml +++ b/ci/gem-push.yml @@ -1,12 +1,16 @@ +--- +name: Ruby Gem +description: Pushes a Ruby Gem to RubyGems and GitHub Package Registry. +categories: [Ruby, SDLC] +iconName: ruby-gems +--- name: Ruby Gem on: - pull_request: - branches: - - master push: - branches: - - master + branches: [ master ] + pull_request: + branches: [ master ] jobs: build: @@ -14,7 +18,7 @@ jobs: runs-on: ubuntu-latest steps: - - uses: actions/checkout@master + - uses: actions/checkout@v2 - name: Set up Ruby 2.6 uses: actions/setup-ruby@v1 with: diff --git a/ci/go.yml b/ci/go.yml index 169022ba3..0d2366368 100644 --- a/ci/go.yml +++ b/ci/go.yml @@ -1,28 +1,43 @@ -name: Go -on: [push] -jobs: - - build: - name: Build - runs-on: ubuntu-latest - steps: - - - name: Set up Go 1.13 - uses: actions/setup-go@v1 - with: - go-version: 1.13 - id: go - - - name: Check out code into the Go module directory - uses: actions/checkout@v1 - - - name: Get dependencies - run: | - go get -v -t -d ./... - if [ -f Gopkg.toml ]; then - curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh - dep ensure - fi - - - name: Build - run: go build -v . +--- +name: Go +description: Build a Go project. +categories: [Go] +iconName: go +--- +name: Go + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + + build: + name: Build + runs-on: ubuntu-latest + steps: + + - name: Set up Go 1.x + uses: actions/setup-go@v2 + with: + go-version: ^1.13 + id: go + + - name: Check out code into the Go module directory + uses: actions/checkout@v2 + + - name: Get dependencies + run: | + go get -v -t -d ./... + if [ -f Gopkg.toml ]; then + curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh + dep ensure + fi + + - name: Build + run: go build -v . + + - name: Test + run: go test -v . diff --git a/ci/google.yml b/ci/google.yml new file mode 100644 index 000000000..29ae3bbe0 --- /dev/null +++ b/ci/google.yml @@ -0,0 +1,81 @@ +--- +name: Build and Deploy to GKE +description: Build a docker container, publish it to Google Container Registry, and deploy to GKE. +categories: [] +iconName: googlegke +--- +# This workflow will build a docker container, publish it to Google Container Registry, and deploy it to GKE when a release is created +# +# To configure this workflow: +# +# 1. Ensure that your repository contains the necessary configuration for your Google Kubernetes Engine cluster, including deployment.yml, kustomization.yml, service.yml, etc. +# +# 2. Set up secrets in your workspace: GKE_PROJECT with the name of the project, GKE_EMAIL with the service account email, GKE_KEY with the Base64 encoded JSON service account key (https://github.com/GoogleCloudPlatform/github-actions/tree/docs/service-account-key/setup-gcloud#inputs). +# +# 3. Change the values for the GKE_ZONE, GKE_CLUSTER, IMAGE, REGISTRY_HOSTNAME and DEPLOYMENT_NAME environment variables (below). + +name: Build and Deploy to GKE + +on: + release: + types: [created] + +# Environment variables available to all jobs and steps in this workflow +env: + GKE_PROJECT: ${{ secrets.GKE_PROJECT }} + GKE_EMAIL: ${{ secrets.GKE_EMAIL }} + GITHUB_SHA: ${{ github.sha }} + GKE_ZONE: us-west1-a + GKE_CLUSTER: example-gke-cluster + IMAGE: gke-test + REGISTRY_HOSTNAME: gcr.io + DEPLOYMENT_NAME: gke-test + +jobs: + setup-build-publish-deploy: + name: Setup, Build, Publish, and Deploy + runs-on: ubuntu-latest + steps: + + - name: Checkout + uses: actions/checkout@v2 + + # Setup gcloud CLI + - uses: GoogleCloudPlatform/github-actions/setup-gcloud@master + with: + version: '270.0.0' + service_account_email: ${{ secrets.GKE_EMAIL }} + service_account_key: ${{ secrets.GKE_KEY }} + + # Configure docker to use the gcloud command-line tool as a credential helper + - run: | + # Set up docker to authenticate + # via gcloud command-line tool. + gcloud auth configure-docker + + # Build the Docker image + - name: Build + run: | + docker build -t "$REGISTRY_HOSTNAME"/"$GKE_PROJECT"/"$IMAGE":"$GITHUB_SHA" \ + --build-arg GITHUB_SHA="$GITHUB_SHA" \ + --build-arg GITHUB_REF="$GITHUB_REF" . + + # Push the Docker image to Google Container Registry + - name: Publish + run: | + docker push $REGISTRY_HOSTNAME/$GKE_PROJECT/$IMAGE:$GITHUB_SHA + + # Set up kustomize + - name: Set up Kustomize + run: | + curl -o kustomize --location https://github.com/kubernetes-sigs/kustomize/releases/download/v3.1.0/kustomize_3.1.0_linux_amd64 + chmod u+x ./kustomize + + # Deploy the Docker image to the GKE cluster + - name: Deploy + run: | + gcloud container clusters get-credentials $GKE_CLUSTER --zone $GKE_ZONE --project $GKE_PROJECT + ./kustomize edit set image $REGISTRY_HOSTNAME/$GKE_PROJECT/$IMAGE:${GITHUB_SHA} + ./kustomize build . | kubectl apply -f - + kubectl rollout status deployment/$DEPLOYMENT_NAME + kubectl get services -o wide diff --git a/ci/gradle-publish.yml b/ci/gradle-publish.yml new file mode 100644 index 000000000..12977088d --- /dev/null +++ b/ci/gradle-publish.yml @@ -0,0 +1,39 @@ +--- +name: Publish Java Package with Gradle +description: Build a Java Package using Gradle and publish to GitHub Packages. +categories: [Java, Gradle] +iconName: gradle +--- +# This workflow will build a package using Gradle and then publish it to GitHub packages when a release is created +# For more information see: https://github.com/actions/setup-java#publishing-using-gradle + +name: Gradle Package + +on: + release: + types: [created] + +jobs: + build: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - name: Set up JDK 1.8 + uses: actions/setup-java@v1 + with: + java-version: 1.8 + server-id: github # Value of the distributionManagement/repository/id field of the pom.xml + settings-path: ${{ github.workspace }} # location for the settings.xml file + + - name: Build with Gradle + run: gradle build + + # The USERNAME and TOKEN need to correspond to the credentials environment variables used in + # the publishing section of your build.gradle + - name: Publish to GitHub Packages + run: gradle publish + env: + USERNAME: ${{ github.actor }} + TOKEN: ${{ secrets.GITHUB_TOKEN }} diff --git a/ci/gradle.yml b/ci/gradle.yml index 8e4dc5ea3..b0d16c919 100644 --- a/ci/gradle.yml +++ b/ci/gradle.yml @@ -1,17 +1,32 @@ -name: Java CI - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - steps: - - uses: actions/checkout@v1 - - name: Set up JDK 1.8 - uses: actions/setup-java@v1 - with: - java-version: 1.8 - - name: Build with Gradle - run: ./gradlew build +--- +name: Java with Gradle +description: Build and test a Java project using a Gradle wrapper script. +categories: [Java, Gradle] +iconName: gradle +--- +# This workflow will build a Java project with Gradle +# For more information see: https://help.github.com/actions/language-and-framework-guides/building-and-testing-java-with-gradle + +name: Java CI with Gradle + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - name: Set up JDK 1.8 + uses: actions/setup-java@v1 + with: + java-version: 1.8 + - name: Grant execute permission for gradlew + run: chmod +x gradlew + - name: Build with Gradle + run: ./gradlew build diff --git a/ci/haskell.yml b/ci/haskell.yml index 2f9a0d1dc..3354cb66e 100644 --- a/ci/haskell.yml +++ b/ci/haskell.yml @@ -1,25 +1,46 @@ -name: Haskell CI - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - steps: - - uses: actions/checkout@v1 - - uses: actions/setup-haskell@v1 - with: - ghc-version: '8.6.5' - cabal-version: '3.0' - - name: Install dependencies - run: | - cabal update - cabal install --only-dependencies --enable-tests - - name: Build - run: | - cabal configure --enable-tests - cabal build - - name: Run tests - run: cabal test +--- +name: Haskell +description: Build and test a Haskell project with Cabal. +categories: [Haskell] +iconName: haskell +--- +name: Haskell CI + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - uses: actions/setup-haskell@v1 + with: + ghc-version: '8.8.2' + cabal-version: '3.0' + + - name: Cache + uses: actions/cache@v1 + env: + cache-name: cache-cabal + with: + path: ~/.cabal + key: ${{ runner.os }}-build-${{ env.cache-name }}-${{ hashFiles('**/*.cabal') }}-${{ hashFiles('**/cabal.project') }} + restore-keys: | + ${{ runner.os }}-build-${{ env.cache-name }}- + ${{ runner.os }}-build- + ${{ runner.os }}- + + - name: Install dependencies + run: | + cabal update + cabal build --only-dependencies --enable-tests --enable-benchmarks + - name: Build + run: cabal build --enable-tests --enable-benchmarks all + - name: Run tests + run: cabal test all diff --git a/ci/ibm.yml b/ci/ibm.yml new file mode 100644 index 000000000..d239dcc75 --- /dev/null +++ b/ci/ibm.yml @@ -0,0 +1,80 @@ +--- +name: Build and Deploy to IKS +description: Build a docker container, publish it to IBM Container Registry, and deploy to IKS. +categories: [] +iconName: ibm +--- +# This workflow will build a docker container, publish it to IBM Container Registry, and deploy it to IKS when a release is created +# +# To configure this workflow: +# +# 1. Ensure that your repository contains a Dockerfile +# 2. Setup secrets in your repository by going to settings: Create ICR_NAMESPACE and IBM_CLOUD_API_KEY +# 3. Change the values for the IBM_CLOUD_REGION, REGISTRY_HOSTNAME, IMAGE_NAME, IKS_CLUSTER, DEPLOYMENT_NAME, and PORT + +name: Build and Deploy to IKS + +on: + release: + types: [created] + +# Environment variables available to all jobs and steps in this workflow +env: + GITHUB_SHA: ${{ github.sha }} + IBM_CLOUD_API_KEY: ${{ secrets.IBM_CLOUD_API_KEY }} + IBM_CLOUD_REGION: us-south + ICR_NAMESPACE: ${{ secrets.ICR_NAMESPACE }} + REGISTRY_HOSTNAME: us.icr.io + IMAGE_NAME: iks-test + IKS_CLUSTER: example-iks-cluster-name-or-id + DEPLOYMENT_NAME: iks-test + PORT: 5001 + +jobs: + setup-build-publish-deploy: + name: Setup, Build, Publish, and Deploy + runs-on: ubuntu-latest + steps: + + - name: Checkout + uses: actions/checkout@v2 + + # Download and Install IBM Cloud CLI + - name: Install IBM Cloud CLI + run: | + curl -fsSL https://clis.cloud.ibm.com/install/linux | sh + ibmcloud --version + ibmcloud config --check-version=false + ibmcloud plugin install -f kubernetes-service + ibmcloud plugin install -f container-registry + + # Authenticate with IBM Cloud CLI + - name: Authenticate with IBM Cloud CLI + run: | + ibmcloud login --apikey "${IBM_CLOUD_API_KEY}" -r "${IBM_CLOUD_REGION}" -g default + ibmcloud cr region-set "${IBM_CLOUD_REGION}" + ibmcloud cr login + + # Build the Docker image + - name: Build with Docker + run: | + docker build -t "$REGISTRY_HOSTNAME"/"$ICR_NAMESPACE"/"$IMAGE_NAME":"$GITHUB_SHA" \ + --build-arg GITHUB_SHA="$GITHUB_SHA" \ + --build-arg GITHUB_REF="$GITHUB_REF" . + + # Push the image to IBM Container Registry + - name: Push the image to ICR + run: | + docker push $REGISTRY_HOSTNAME/$ICR_NAMESPACE/$IMAGE_NAME:$GITHUB_SHA + + # Deploy the Docker image to the IKS cluster + - name: Deploy to IKS + run: | + ibmcloud ks cluster config --cluster $IKS_CLUSTER + kubectl config current-context + kubectl create deployment $DEPLOYMENT_NAME --image=$REGISTRY_HOSTNAME/$ICR_NAMESPACE/$IMAGE_NAME:$GITHUB_SHA --dry-run -o yaml > deployment.yaml + kubectl apply -f deployment.yaml + kubectl rollout status deployment/$DEPLOYMENT_NAME + kubectl create service loadbalancer $DEPLOYMENT_NAME --tcp=80:$PORT --dry-run -o yaml > service.yaml + kubectl apply -f service.yaml + kubectl get services -o wide diff --git a/ci/jekyll.yml b/ci/jekyll.yml index 782095829..7e695309c 100644 --- a/ci/jekyll.yml +++ b/ci/jekyll.yml @@ -1,16 +1,26 @@ -name: Jekyll site CI - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - steps: - - uses: actions/checkout@v1 - - name: Build the site in the jekyll/builder container - run: | - docker run \ - -v ${{ github.workspace }}:/srv/jekyll -v ${{ github.workspace }}/_site:/srv/jekyll/_site \ - jekyll/builder:latest /bin/bash -c "chmod 777 /srv/jekyll && jekyll build --future" +--- +name: Jekyll +description: Package a Jekyll site using the jekyll/builder Docker image. +categories: [HTML] +iconName: jekyll +--- +name: Jekyll site CI + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - name: Build the site in the jekyll/builder container + run: | + docker run \ + -v ${{ github.workspace }}:/srv/jekyll -v ${{ github.workspace }}/_site:/srv/jekyll/_site \ + jekyll/builder:latest /bin/bash -c "chmod 777 /srv/jekyll && jekyll build --future" diff --git a/ci/laravel.yml b/ci/laravel.yml index c3841eb52..b7d4e7a6c 100644 --- a/ci/laravel.yml +++ b/ci/laravel.yml @@ -1,18 +1,32 @@ +--- +name: Laravel +description: Test a Laravel project. +categories: [PHP, Laravel] +iconName: php +--- name: Laravel -on: [push] +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] jobs: laravel-tests: + runs-on: ubuntu-latest + steps: - - uses: actions/checkout@v1 + - uses: actions/checkout@v2 - name: Copy .env run: php -r "file_exists('.env') || copy('.env.example', '.env');" - name: Install Dependencies run: composer install -q --no-ansi --no-interaction --no-scripts --no-suggest --no-progress --prefer-dist - name: Generate key run: php artisan key:generate + - name: Directory Permissions + run: chmod -R 777 storage bootstrap/cache - name: Create Database run: | mkdir -p database diff --git a/ci/maven-publish.yml b/ci/maven-publish.yml new file mode 100644 index 000000000..2621d4211 --- /dev/null +++ b/ci/maven-publish.yml @@ -0,0 +1,36 @@ +--- +name: Publish Java Package with Maven +description: Build a Java Package using Maven and publish to GitHub Packages. +categories: [Java, Maven] +iconName: maven +--- +# This workflow will build a package using Maven and then publish it to GitHub packages when a release is created +# For more information see: https://github.com/actions/setup-java#apache-maven-with-a-settings-path + +name: Maven Package + +on: + release: + types: [created] + +jobs: + build: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - name: Set up JDK 1.8 + uses: actions/setup-java@v1 + with: + java-version: 1.8 + server-id: github # Value of the distributionManagement/repository/id field of the pom.xml + settings-path: ${{ github.workspace }} # location for the settings.xml file + + - name: Build with Maven + run: mvn -B package --file pom.xml + + - name: Publish to GitHub Packages Apache Maven + run: mvn deploy -s $GITHUB_WORKSPACE/settings.xml + env: + GITHUB_TOKEN: ${{ github.token }} \ No newline at end of file diff --git a/ci/maven.yml b/ci/maven.yml index dbc347f9c..98f00c08f 100644 --- a/ci/maven.yml +++ b/ci/maven.yml @@ -1,17 +1,30 @@ -name: Java CI - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - steps: - - uses: actions/checkout@v1 - - name: Set up JDK 1.8 - uses: actions/setup-java@v1 - with: - java-version: 1.8 - - name: Build with Maven - run: mvn -B package --file pom.xml +--- +name: Java with Maven +description: Build and test a Java project with Apache Maven. +categories: [Java, Maven] +iconName: maven +--- +# This workflow will build a Java project with Maven +# For more information see: https://help.github.com/actions/language-and-framework-guides/building-and-testing-java-with-maven + +name: Java CI with Maven + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - name: Set up JDK 1.8 + uses: actions/setup-java@v1 + with: + java-version: 1.8 + - name: Build with Maven + run: mvn -B package --file pom.xml diff --git a/ci/node.js.yml b/ci/node.js.yml index 94face118..ec556747a 100644 --- a/ci/node.js.yml +++ b/ci/node.js.yml @@ -1,26 +1,35 @@ -name: Node CI - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - strategy: - matrix: - node-version: [8.x, 10.x, 12.x] - - steps: - - uses: actions/checkout@v1 - - name: Use Node.js ${{ matrix.node-version }} - uses: actions/setup-node@v1 - with: - node-version: ${{ matrix.node-version }} - - name: npm install, build, and test - run: | - npm ci - npm run build --if-present - npm test - env: - CI: true +--- +name: Node.js +description: Build and test a Node.js project with npm. +categories: [JavaScript, Node, Npm] +iconName: nodejs +--- +# This workflow will do a clean install of node dependencies, build the source code and run tests across different versions of node +# For more information see: https://help.github.com/actions/language-and-framework-guides/using-nodejs-with-github-actions + +name: Node.js CI + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + + strategy: + matrix: + node-version: [10.x, 12.x] + + steps: + - uses: actions/checkout@v2 + - name: Use Node.js ${{ matrix.node-version }} + uses: actions/setup-node@v1 + with: + node-version: ${{ matrix.node-version }} + - run: npm ci + - run: npm run build --if-present + - run: npm test diff --git a/ci/npm-publish.yml b/ci/npm-publish.yml index ed81431b5..0f0c5ba47 100644 --- a/ci/npm-publish.yml +++ b/ci/npm-publish.yml @@ -1,3 +1,12 @@ +--- +name: Publish Node.js Package +description: Publishes a Node.js package to npm and GitHub Packages. +categories: [JavaScript, SDLC] +iconName: node-package-transparent +--- +# This workflow will run tests using node and then publish a package to GitHub Packages when a release is created +# For more information see: https://help.github.com/actions/language-and-framework-guides/publishing-nodejs-packages + name: Node.js Package on: @@ -8,7 +17,7 @@ jobs: build: runs-on: ubuntu-latest steps: - - uses: actions/checkout@v1 + - uses: actions/checkout@v2 - uses: actions/setup-node@v1 with: node-version: 12 @@ -19,7 +28,7 @@ jobs: needs: build runs-on: ubuntu-latest steps: - - uses: actions/checkout@v1 + - uses: actions/checkout@v2 - uses: actions/setup-node@v1 with: node-version: 12 @@ -33,12 +42,11 @@ jobs: needs: build runs-on: ubuntu-latest steps: - - uses: actions/checkout@v1 + - uses: actions/checkout@v2 - uses: actions/setup-node@v1 with: node-version: 12 registry-url: https://npm.pkg.github.com/ - scope: '@your-github-username' - run: npm ci - run: npm publish env: diff --git a/ci/php.yml b/ci/php.yml index 8e856b81f..90a731065 100644 --- a/ci/php.yml +++ b/ci/php.yml @@ -1,6 +1,16 @@ +--- +name: PHP +description: Build and test a PHP application using Composer +categories: [PHP, Composer] +iconName: php +--- name: PHP Composer -on: [push] +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] jobs: build: @@ -8,13 +18,13 @@ jobs: runs-on: ubuntu-latest steps: - - uses: actions/checkout@v1 + - uses: actions/checkout@v2 - name: Validate composer.json and composer.lock run: composer validate - name: Install dependencies - run: composer install --prefer-dist --no-progress --no-suggest + run: composer install --prefer-dist --no-progress # Add a test script to composer.json, for instance: "test": "vendor/bin/phpunit" # Docs: https://getcomposer.org/doc/articles/scripts.md diff --git a/ci/properties/android.properties.json b/ci/properties/android.properties.json deleted file mode 100644 index a557fd9a7..000000000 --- a/ci/properties/android.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Android CI", - "description": "Build an Android project with Gradle.", - "iconName": "android", - "categories": ["Java", "Mobile"] -} \ No newline at end of file diff --git a/ci/properties/ant.properties.json b/ci/properties/ant.properties.json deleted file mode 100644 index 4139b6726..000000000 --- a/ci/properties/ant.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Java with Ant", - "description": "Build and test a Java project with Apache Ant.", - "iconName": "ant", - "categories": ["Ant", "Java"] -} \ No newline at end of file diff --git a/ci/properties/blank.properties.json b/ci/properties/blank.properties.json deleted file mode 100644 index 927085bc5..000000000 --- a/ci/properties/blank.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Simple workflow", - "description": "Start with a file with the minimum necessary structure.", - "iconName": "blank", - "categories": null -} \ No newline at end of file diff --git a/ci/properties/c-cpp.properties.json b/ci/properties/c-cpp.properties.json deleted file mode 100644 index 605cd8902..000000000 --- a/ci/properties/c-cpp.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "C/C++ with Make", - "description": "Build and test a C/C++ project using Make.", - "iconName": "c-cpp", - "categories": ["C", "C++"] -} \ No newline at end of file diff --git a/ci/properties/clojure.properties.json b/ci/properties/clojure.properties.json deleted file mode 100644 index 9d1777266..000000000 --- a/ci/properties/clojure.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Clojure", - "description": "Build and test a Clojure project with Leiningen.", - "iconName": "clojure", - "categories": ["Clojure", "Java"] -} \ No newline at end of file diff --git a/ci/properties/crystal.properties.json b/ci/properties/crystal.properties.json deleted file mode 100644 index f5edf7ded..000000000 --- a/ci/properties/crystal.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Crystal", - "description": "Build and test a Crystal project.", - "iconName": "crystal", - "categories": ["Crystal"] -} \ No newline at end of file diff --git a/ci/properties/dart.properties.json b/ci/properties/dart.properties.json deleted file mode 100644 index a0aad8c02..000000000 --- a/ci/properties/dart.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Dart", - "description": "Build and test a Dart project with Pub.", - "iconName": "dart", - "categories": ["Dart"] -} \ No newline at end of file diff --git a/ci/properties/docker-image.properties.json b/ci/properties/docker-image.properties.json deleted file mode 100644 index 2db2368a7..000000000 --- a/ci/properties/docker-image.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Docker image", - "description": "Build a Docker image to deploy, run, or push to a registry.", - "iconName": "docker", - "categories": ["Dockerfile"] -} \ No newline at end of file diff --git a/ci/properties/dotnet-core.properties.json b/ci/properties/dotnet-core.properties.json deleted file mode 100644 index d5dc23a86..000000000 --- a/ci/properties/dotnet-core.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": ".NET Core", - "description": "Build and test a .NET Core or ASP.NET Core project.", - "iconName": "dotnetcore", - "categories": ["C#", "F#", "Visual Basic", "ASP", "ASP.NET", ".NET"] -} diff --git a/ci/properties/elixir.properties.json b/ci/properties/elixir.properties.json deleted file mode 100644 index 4b082d71e..000000000 --- a/ci/properties/elixir.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Elixir", - "description": "Build and test an Elixir project with Mix.", - "iconName": "elixir", - "categories": ["Elixir", "Erlang"] -} \ No newline at end of file diff --git a/ci/properties/erlang.properties.json b/ci/properties/erlang.properties.json deleted file mode 100644 index c728ac241..000000000 --- a/ci/properties/erlang.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Erlang", - "description": "Build and test an Erlang project with rebar.", - "iconName": "erlang", - "categories": ["Erlang"] -} \ No newline at end of file diff --git a/ci/properties/gem-push.properties.json b/ci/properties/gem-push.properties.json deleted file mode 100644 index c54e7b57d..000000000 --- a/ci/properties/gem-push.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Ruby Gem", - "description": "Pushes a Ruby Gem to RubyGems and GitHub Package Registry.", - "iconName": "ruby-gems", - "categories": ["Ruby", "SDLC"] -} diff --git a/ci/properties/go.properties.json b/ci/properties/go.properties.json deleted file mode 100644 index 339124515..000000000 --- a/ci/properties/go.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Go", - "description": "Build a Go project.", - "iconName": "go", - "categories": ["Go"] -} \ No newline at end of file diff --git a/ci/properties/gradle.properties.json b/ci/properties/gradle.properties.json deleted file mode 100644 index c58d68ab0..000000000 --- a/ci/properties/gradle.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Gradle", - "description": "Build and test a Java project using a Gradle wrapper script.", - "iconName": "gradle", - "categories": ["Java", "Gradle"] -} \ No newline at end of file diff --git a/ci/properties/haskell.properties.json b/ci/properties/haskell.properties.json deleted file mode 100644 index ae71a60df..000000000 --- a/ci/properties/haskell.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Haskell", - "description": "Build and test a Haskell project with Cabal.", - "iconName": "haskell", - "categories": ["Haskell"] -} \ No newline at end of file diff --git a/ci/properties/jekyll.properties.json b/ci/properties/jekyll.properties.json deleted file mode 100644 index c97835a4b..000000000 --- a/ci/properties/jekyll.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Jekyll", - "description": "Package a Jekyll site using the jekyll/builder Docker image.", - "iconName": "jekyll", - "categories": ["HTML"] -} \ No newline at end of file diff --git a/ci/properties/laravel.properties.json b/ci/properties/laravel.properties.json deleted file mode 100644 index f10a4623a..000000000 --- a/ci/properties/laravel.properties.json +++ /dev/null @@ -1,9 +0,0 @@ -{ - "name": "Laravel", - "description": "Test a Laravel project.", - "iconName": "php", - "categories": [ - "PHP", - "Laravel" - ] -} \ No newline at end of file diff --git a/ci/properties/maven.properties.json b/ci/properties/maven.properties.json deleted file mode 100644 index 1875bdcdc..000000000 --- a/ci/properties/maven.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Maven", - "description": "Build and test a Java project with Apache Maven.", - "iconName": "maven", - "categories": ["Java", "Maven"] -} \ No newline at end of file diff --git a/ci/properties/node.js.properties.json b/ci/properties/node.js.properties.json deleted file mode 100644 index 99a79bcb8..000000000 --- a/ci/properties/node.js.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Node.js", - "description": "Build and test a Node.js project with npm.", - "iconName": "nodejs", - "categories": ["JavaScript", "Node", "Npm"] -} \ No newline at end of file diff --git a/ci/properties/npm-publish.properties.json b/ci/properties/npm-publish.properties.json deleted file mode 100644 index 989c262c9..000000000 --- a/ci/properties/npm-publish.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Node.js Package", - "description": "Publishes a Node.js package to npm and GitHub Package Registry.", - "iconName": "node-package-transparent", - "categories": ["JavaScript", "SDLC"] -} diff --git a/ci/properties/php.properties.json b/ci/properties/php.properties.json deleted file mode 100644 index 641e536f2..000000000 --- a/ci/properties/php.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "PHP", - "description": "Build and test a PHP application using Composer", - "iconName": "php", - "categories": ["PHP", "Composer"] -} \ No newline at end of file diff --git a/ci/properties/python-app.properties.json b/ci/properties/python-app.properties.json deleted file mode 100644 index cdf0330d0..000000000 --- a/ci/properties/python-app.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Python application", - "description": "Create and test a Python application.", - "iconName": "python", - "categories": ["Python"] -} \ No newline at end of file diff --git a/ci/properties/python-package.properties.json b/ci/properties/python-package.properties.json deleted file mode 100644 index 4b3a8da1f..000000000 --- a/ci/properties/python-package.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Python package", - "description": "Create and test a Python package on multiple Python versions.", - "iconName": "python", - "categories": ["Python"] -} \ No newline at end of file diff --git a/ci/properties/python-publish.properties.json b/ci/properties/python-publish.properties.json deleted file mode 100644 index 4fd9eceb6..000000000 --- a/ci/properties/python-publish.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Publish Python Package", - "description": "Publish a Python Package to PyPI on release.", - "iconName": "python", - "categories": ["Python"] -} diff --git a/ci/properties/ruby.properties.json b/ci/properties/ruby.properties.json deleted file mode 100644 index df7493126..000000000 --- a/ci/properties/ruby.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Ruby", - "description": "Build and test a Ruby project with Rake.", - "iconName": "ruby", - "categories": ["Ruby"] -} \ No newline at end of file diff --git a/ci/properties/rust.properties.json b/ci/properties/rust.properties.json deleted file mode 100644 index 6f4f96736..000000000 --- a/ci/properties/rust.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Rust", - "description": "Build and test a Rust project with Cargo.", - "iconName": "rust", - "categories": ["Rust"] -} \ No newline at end of file diff --git a/ci/properties/scala.properties.json b/ci/properties/scala.properties.json deleted file mode 100644 index d44e8678d..000000000 --- a/ci/properties/scala.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Scala", - "description": "Build and test a Scala project with SBT.", - "iconName": "blank", - "categories": ["Scala", "Java"] -} diff --git a/ci/properties/swift.properties.json b/ci/properties/swift.properties.json deleted file mode 100644 index 9efd64515..000000000 --- a/ci/properties/swift.properties.json +++ /dev/null @@ -1,6 +0,0 @@ -{ - "name": "Swift", - "description": "Build and test a Swift Package.", - "iconName": "swift", - "categories": ["Swift"] -} diff --git a/ci/python-app.yml b/ci/python-app.yml index 81d1ef640..9779cc2a6 100644 --- a/ci/python-app.yml +++ b/ci/python-app.yml @@ -1,30 +1,42 @@ -name: Python application - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - steps: - - uses: actions/checkout@v1 - - name: Set up Python 3.7 - uses: actions/setup-python@v1 - with: - python-version: 3.7 - - name: Install dependencies - run: | - python -m pip install --upgrade pip - pip install -r requirements.txt - - name: Lint with flake8 - run: | - pip install flake8 - # stop the build if there are Python syntax errors or undefined names - flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics - # exit-zero treats all errors as warnings. The GitHub editor is 127 chars wide - flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics - - name: Test with pytest - run: | - pip install pytest - pytest +--- +name: Python application +description: Create and test a Python application. +categories: [Python] +iconName: python +--- +# This workflow will install Python dependencies, run tests and lint with a single version of Python +# For more information see: https://help.github.com/actions/language-and-framework-guides/using-python-with-github-actions + +name: Python application + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - name: Set up Python 3.8 + uses: actions/setup-python@v2 + with: + python-version: 3.8 + - name: Install dependencies + run: | + python -m pip install --upgrade pip + pip install flake8 pytest + if [ -f requirements.txt ]; then pip install -r requirements.txt; fi + - name: Lint with flake8 + run: | + # stop the build if there are Python syntax errors or undefined names + flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics + # exit-zero treats all errors as warnings. The GitHub editor is 127 chars wide + flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics + - name: Test with pytest + run: | + pytest diff --git a/ci/python-package.yml b/ci/python-package.yml index 24f36a85b..ed9c48567 100644 --- a/ci/python-package.yml +++ b/ci/python-package.yml @@ -1,34 +1,45 @@ -name: Python package - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - strategy: - max-parallel: 4 - matrix: - python-version: [2.7, 3.5, 3.6, 3.7] - - steps: - - uses: actions/checkout@v1 - - name: Set up Python ${{ matrix.python-version }} - uses: actions/setup-python@v1 - with: - python-version: ${{ matrix.python-version }} - - name: Install dependencies - run: | - python -m pip install --upgrade pip - pip install -r requirements.txt - - name: Lint with flake8 - run: | - pip install flake8 - # stop the build if there are Python syntax errors or undefined names - flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics - # exit-zero treats all errors as warnings. The GitHub editor is 127 chars wide - flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics - - name: Test with pytest - run: | - pip install pytest - pytest +--- +name: Python package +description: Create and test a Python package on multiple Python versions. +categories: [Python] +iconName: python +--- +# This workflow will install Python dependencies, run tests and lint with a variety of Python versions +# For more information see: https://help.github.com/actions/language-and-framework-guides/using-python-with-github-actions + +name: Python package + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + strategy: + matrix: + python-version: [3.5, 3.6, 3.7, 3.8] + + steps: + - uses: actions/checkout@v2 + - name: Set up Python ${{ matrix.python-version }} + uses: actions/setup-python@v2 + with: + python-version: ${{ matrix.python-version }} + - name: Install dependencies + run: | + python -m pip install --upgrade pip + pip install flake8 pytest + if [ -f requirements.txt ]; then pip install -r requirements.txt; fi + - name: Lint with flake8 + run: | + # stop the build if there are Python syntax errors or undefined names + flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics + # exit-zero treats all errors as warnings. The GitHub editor is 127 chars wide + flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics + - name: Test with pytest + run: | + pytest diff --git a/ci/python-publish.yml b/ci/python-publish.yml index 21f2f01de..acf66cdbd 100644 --- a/ci/python-publish.yml +++ b/ci/python-publish.yml @@ -1,3 +1,12 @@ +--- +name: Publish Python Package +description: Publish a Python Package to PyPI on release. +categories: [Python] +iconName: python +--- +# This workflows will upload a Python Package using Twine when a release is created +# For more information see: https://help.github.com/en/actions/language-and-framework-guides/using-python-with-github-actions#publishing-to-package-registries + name: Upload Python Package on: @@ -6,11 +15,13 @@ on: jobs: deploy: + runs-on: ubuntu-latest + steps: - - uses: actions/checkout@v1 + - uses: actions/checkout@v2 - name: Set up Python - uses: actions/setup-python@v1 + uses: actions/setup-python@v2 with: python-version: '3.x' - name: Install dependencies diff --git a/ci/ruby.yml b/ci/ruby.yml index 7258d723c..aadf82c49 100644 --- a/ci/ruby.yml +++ b/ci/ruby.yml @@ -1,20 +1,39 @@ -name: Ruby - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - steps: - - uses: actions/checkout@v1 - - name: Set up Ruby 2.6 - uses: actions/setup-ruby@v1 - with: - ruby-version: 2.6.x - - name: Build and test with Rake - run: | - gem install bundler - bundle install --jobs 4 --retry 3 - bundle exec rake +--- +name: Ruby +description: Build and test a Ruby project with Rake. +categories: [Ruby] +iconName: ruby +--- +# This workflow uses actions that are not certified by GitHub. +# They are provided by a third-party and are governed by +# separate terms of service, privacy policy, and support +# documentation. +# This workflow will download a prebuilt Ruby version, install dependencies and run tests with Rake +# For more information see: https://github.com/marketplace/actions/setup-ruby-jruby-and-truffleruby + +name: Ruby + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + test: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - name: Set up Ruby + # To automatically get bug fixes and new Ruby versions for ruby/setup-ruby, + # change this to (see https://github.com/ruby/setup-ruby#versioning): + # uses: ruby/setup-ruby@v1 + uses: ruby/setup-ruby@ec106b438a1ff6ff109590de34ddc62c540232e0 + with: + ruby-version: 2.6 + - name: Install dependencies + run: bundle install + - name: Run tests + run: bundle exec rake diff --git a/ci/rust.yml b/ci/rust.yml index 9ca641ba1..68bc6a308 100644 --- a/ci/rust.yml +++ b/ci/rust.yml @@ -1,15 +1,25 @@ -name: Rust - -on: [push] - -jobs: - build: - - runs-on: ubuntu-latest - - steps: - - uses: actions/checkout@v1 - - name: Build - run: cargo build --verbose - - name: Run tests - run: cargo test --verbose +--- +name: Rust +description: Build and test a Rust project with Cargo. +categories: [Rust] +iconName: rust +--- +name: Rust + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + build: + + runs-on: ubuntu-latest + + steps: + - uses: actions/checkout@v2 + - name: Build + run: cargo build --verbose + - name: Run tests + run: cargo test --verbose diff --git a/ci/scala.yml b/ci/scala.yml index fbeee571c..ef5c55d37 100644 --- a/ci/scala.yml +++ b/ci/scala.yml @@ -1,6 +1,16 @@ +--- +name: Scala +description: Build and test a Scala project with SBT. +categories: [Scala, Java] +iconName: scala +--- name: Scala CI -on: [push] +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] jobs: build: @@ -8,7 +18,7 @@ jobs: runs-on: ubuntu-latest steps: - - uses: actions/checkout@v1 + - uses: actions/checkout@v2 - name: Set up JDK 1.8 uses: actions/setup-java@v1 with: diff --git a/ci/swift.yml b/ci/swift.yml index 2e766326a..2d9f4a6bf 100644 --- a/ci/swift.yml +++ b/ci/swift.yml @@ -1,14 +1,24 @@ +--- +name: Swift +description: Build and test a Swift Package. +categories: [Swift] +iconName: swift +--- name: Swift -on: [push] +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] jobs: build: - runs-on: macOS-latest + runs-on: macos-latest steps: - - uses: actions/checkout@v1 + - uses: actions/checkout@v2 - name: Build run: swift build -v - name: Run tests diff --git a/ci/tencent.yml b/ci/tencent.yml new file mode 100644 index 000000000..338238065 --- /dev/null +++ b/ci/tencent.yml @@ -0,0 +1,81 @@ +--- +name: Tencent Kubernetes Engine +description: This workflow will build a docker container, publish and deploy it to Tencent Kubernetes Engine (TKE). +categories: [] +iconName: tencentcloud +--- +# This workflow will build a docker container, publish and deploy it to Tencent Kubernetes Engine (TKE). +# +# To configure this workflow: +# +# 1. Ensure that your repository contains the necessary configuration for your Tencent Kubernetes Engine cluster, +# including deployment.yml, kustomization.yml, service.yml, etc. +# +# 2. Set up secrets in your workspace: +# - TENCENT_CLOUD_SECRET_ID with Tencent Cloud secret id +# - TENCENT_CLOUD_SECRET_KEY with Tencent Cloud secret key +# - TENCENT_CLOUD_ACCOUNT_ID with Tencent Cloud account id +# - TKE_REGISTRY_PASSWORD with TKE registry password +# +# 3. Change the values for the TKE_IMAGE_URL, TKE_REGION, TKE_CLUSTER_ID and DEPLOYMENT_NAME environment variables (below). + +name: Tencent Kubernetes Engine + +on: + release: + types: [created] + +# Environment variables available to all jobs and steps in this workflow +env: + TKE_IMAGE_URL: ccr.ccs.tencentyun.com/demo/mywebapp + TKE_REGION: ap-guangzhou + TKE_CLUSTER_ID: cls-mywebapp + DEPLOYMENT_NAME: tke-test + +jobs: + setup-build-publish-deploy: + name: Setup, Build, Publish, and Deploy + runs-on: ubuntu-latest + steps: + + - name: Checkout + uses: actions/checkout@v2 + + # Build + - name: Build Docker image + run: | + docker build -t ${TKE_IMAGE_URL}:${GITHUB_SHA} . + + - name: Login TKE Registry + run: | + docker login -u ${{ secrets.TENCENT_CLOUD_ACCOUNT_ID }} -p ${{ secrets.TKE_REGISTRY_PASSWORD }} ${TKE_IMAGE_URL} + + # Push the Docker image to TKE Registry + - name: Publish + run: | + docker push ${TKE_IMAGE_URL}:${GITHUB_SHA} + + - name: Set up Kustomize + run: | + curl -o kustomize --location https://github.com/kubernetes-sigs/kustomize/releases/download/v3.1.0/kustomize_3.1.0_linux_amd64 + chmod u+x ./kustomize + + - name: Set up ~/.kube/config for connecting TKE cluster + uses: TencentCloud/tke-cluster-credential-action@v1 + with: + secret_id: ${{ secrets.TENCENT_CLOUD_SECRET_ID }} + secret_key: ${{ secrets.TENCENT_CLOUD_SECRET_KEY }} + tke_region: ${{ env.TKE_REGION }} + cluster_id: ${{ env.TKE_CLUSTER_ID }} + + - name: Switch to TKE context + run: | + kubectl config use-context ${TKE_CLUSTER_ID}-context-default + + # Deploy the Docker image to the TKE cluster + - name: Deploy + run: | + ./kustomize edit set image ${TKE_IMAGE_URL}:${GITHUB_SHA} + ./kustomize build . | kubectl apply -f - + kubectl rollout status deployment/${DEPLOYMENT_NAME} + kubectl get services -o wide \ No newline at end of file diff --git a/ci/terraform.yml b/ci/terraform.yml new file mode 100644 index 000000000..63e1a3952 --- /dev/null +++ b/ci/terraform.yml @@ -0,0 +1,96 @@ +--- +name: Terraform +description: Set up Terraform CLI in your GitHub Actions workflow. +categories: [] +iconName: terraform +--- +# This workflow installs the latest version of Terraform CLI and configures the Terraform CLI configuration file +# with an API token for Terraform Cloud (app.terraform.io). On pull request events, this workflow will run +# `terraform init`, `terraform fmt`, and `terraform plan` (speculative plan via Terraform Cloud). On push events +# to the master branch, `terraform apply` will be executed. +# +# Documentation for `hashicorp/setup-terraform` is located here: https://github.com/hashicorp/setup-terraform +# +# To use this workflow, you will need to complete the following setup steps. +# +# 1. Create a `main.tf` file in the root of this repository with the `remote` backend and one or more resources defined. +# Example `main.tf`: +# # The configuration for the `remote` backend. +# terraform { +# backend "remote" { +# # The name of your Terraform Cloud organization. +# organization = "example-organization" +# +# # The name of the Terraform Cloud workspace to store Terraform state files in. +# workspaces { +# name = "example-workspace" +# } +# } +# } +# +# # An example resource that does nothing. +# resource "null_resource" "example" { +# triggers = { +# value = "A example resource that does nothing!" +# } +# } +# +# +# 2. Generate a Terraform Cloud user API token and store it as a GitHub secret (e.g. TF_API_TOKEN) on this repository. +# Documentation: +# - https://www.terraform.io/docs/cloud/users-teams-organizations/api-tokens.html +# - https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets +# +# 3. Reference the GitHub secret in step using the `hashicorp/setup-terraform` GitHub Action. +# Example: +# - name: Setup Terraform +# uses: hashicorp/setup-terraform@v1 +# with: +# cli_config_credentials_token: ${{ secrets.TF_API_TOKEN }} + +name: 'Terraform' + +on: + push: + branches: + - master + pull_request: + +jobs: + terraform: + name: 'Terraform' + runs-on: ubuntu-latest + + # Use the Bash shell regardless whether the GitHub Actions runner is ubuntu-latest, macos-latest, or windows-latest + defaults: + run: + shell: bash + + # Checkout the repository to the GitHub Actions runner + steps: + - name: Checkout + uses: actions/checkout@v2 + + # Install the latest version of Terraform CLI and configure the Terraform CLI configuration file with a Terraform Cloud user API token + - name: Setup Terraform + uses: hashicorp/setup-terraform@v1 + with: + cli_config_credentials_token: ${{ secrets.TF_API_TOKEN }} + + # Initialize a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, etc. + - name: Terraform Init + run: terraform init + + # Checks that all Terraform configuration files adhere to a canonical format + - name: Terraform Format + run: terraform fmt -check + + # Generates an execution plan for Terraform + - name: Terraform Plan + run: terraform plan + + # On push to master, build or change infrastructure according to Terraform configuration files + # Note: It is recommended to set up a required "strict" status check in your repository for "Terraform Cloud". See the documentation on "strict" required status checks for more information: https://help.github.com/en/github/administering-a-repository/types-of-required-status-checks + - name: Terraform Apply + if: github.ref == 'refs/heads/master' && github.event_name == 'push' + run: terraform apply -auto-approve diff --git a/ci/wpf-dotnet-core.yml b/ci/wpf-dotnet-core.yml new file mode 100644 index 000000000..34a1fba0c --- /dev/null +++ b/ci/wpf-dotnet-core.yml @@ -0,0 +1,121 @@ +--- +name: WPF .NET Core +description: Build, test and publish a Wpf application built on .NET Core. +categories: [C#, Visual Basic, WPF, .NET] +iconName: dotnetcore +--- +# This workflow uses actions that are not certified by GitHub. +# They are provided by a third-party and are governed by +# separate terms of service, privacy policy, and support +# documentation. + +# This workflow will build, test and package a WPF desktop application +# built on .NET Core. +# To learn how to migrate your existing WPF application to .NET Core, +# refer to https://docs.microsoft.com/en-us/dotnet/desktop-wpf/migration/convert-project-from-net-framework +# +# To configure this workflow: +# +# 1. Configure environment variables +# GitHub sets default environment variables for every workflow run. +# Replace the variables relative to your project in the "env" section below. +# +# 2. Signing +# Generate a signing certificate in the Windows Application +# Packaging Project or add an existing signing certificate to the project. +# Next, use PowerShell to encode the .pfx file using Base64 encoding +# by running the following Powershell script to generate the output string: +# +# $pfx_cert = Get-Content '.\SigningCertificate.pfx' -Encoding Byte +# [System.Convert]::ToBase64String($pfx_cert) | Out-File 'SigningCertificate_Encoded.txt' +# +# Open the output file, SigningCertificate_Encoded.txt, and copy the +# string inside. Then, add the string to the repo as a GitHub secret +# and name it "Base64_Encoded_Pfx." +# For more information on how to configure your signing certificate for +# this workflow, refer to https://github.com/microsoft/github-actions-for-desktop-apps#signing +# +# Finally, add the signing certificate password to the repo as a secret and name it "Pfx_Key". +# See "Build the Windows Application Packaging project" below to see how the secret is used. +# +# For more information on GitHub Actions, refer to https://github.com/features/actions +# For a complete CI/CD sample to get started with GitHub Action workflows for Desktop Applications, +# refer to https://github.com/microsoft/github-actions-for-desktop-apps + +name: WPF .NET Core + +on: + push: + branches: [ master ] + pull_request: + branches: [ master ] + +jobs: + + build: + + strategy: + matrix: + configuration: [Debug, Release] + + runs-on: windows-latest # For a list of available runner types, refer to + # https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idruns-on + + env: + Solution_Name: your-solution-name # Replace with your solution name, i.e. MyWpfApp.sln. + Test_Project_Path: your-test-project-path # Replace with the path to your test project, i.e. MyWpfApp.Tests\MyWpfApp.Tests.csproj. + Wap_Project_Directory: your-wap-project-directory-name # Replace with the Wap project directory relative to the solution, i.e. MyWpfApp.Package. + Wap_Project_Path: your-wap-project-path # Replace with the path to your Wap project, i.e. MyWpf.App.Package\MyWpfApp.Package.wapproj. + + steps: + - name: Checkout + uses: actions/checkout@v2 + with: + fetch-depth: 0 + + # Install the .NET Core workload + - name: Install .NET Core + uses: actions/setup-dotnet@v1 + with: + dotnet-version: 3.1.101 + + # Add MSBuild to the PATH: https://github.com/microsoft/setup-msbuild + - name: Setup MSBuild.exe + uses: microsoft/setup-msbuild@2008f912f56e61277eefaac6d1888b750582aa16 + + # Execute all unit tests in the solution + - name: Execute unit tests + run: dotnet test + + # Restore the WPF application to populate the obj folder with RuntimeIdentifiers + - name: Restore the WPF application + run: msbuild $env:Solution_Name /t:Restore /p:Configuration=$env:Configuration + env: + Configuration: ${{ matrix.configuration }} + + # Decode the base 64 encoded pfx and save the Signing_Certificate + - name: Decode the pfx + run: | + $pfx_cert_byte = [System.Convert]::FromBase64String("${{ secrets.Base64_Encoded_Pfx }}") + $certificatePath = Join-Path -Path $env:Wap_Project_Directory -ChildPath GitHubActionsWorkflow.pfx + [IO.File]::WriteAllBytes("$certificatePath", $pfx_cert_byte) + + # Create the app package by building and packaging the Windows Application Packaging project + - name: Create the app package + run: msbuild $env:Wap_Project_Path /p:Configuration=$env:Configuration /p:UapAppxPackageBuildMode=$env:Appx_Package_Build_Mode /p:AppxBundle=$env:Appx_Bundle /p:PackageCertificateKeyFile=GitHubActionsWorkflow.pfx /p:PackageCertificatePassword=${{ secrets.Pfx_Key }} + env: + Appx_Bundle: Always + Appx_Bundle_Platforms: x86|x64 + Appx_Package_Build_Mode: StoreUpload + Configuration: ${{ matrix.configuration }} + + # Remove the pfx + - name: Remove the pfx + run: Remove-Item -path $env:Wap_Project_Directory\$env:Signing_Certificate + + # Upload the MSIX package: https://github.com/marketplace/actions/upload-artifact + - name: Upload build artifacts + uses: actions/upload-artifact@v1 + with: + name: MSIX Package + path: ${{ env.Wap_Project_Directory }}\AppPackages diff --git a/icons/aws.svg b/icons/aws.svg new file mode 100644 index 000000000..59ff870b9 --- /dev/null +++ b/icons/aws.svg @@ -0,0 +1 @@ +<svg xmlns="http://www.w3.org/2000/svg" width="302" height="180" viewBox="0 0 302 180"><g fill="none"><path fill="#252F3E" d="M85.4 65.4c0 3.7.4 6.7 1.1 8.9.8 2.2 1.8 4.6 3.2 7.2.5.8.7 1.6.7 2.3 0 1-.6 2-1.9 3L82.2 91c-.9.6-1.8.9-2.6.9-1 0-2-.5-3-1.4-1.4-1.5-2.6-3.1-3.6-4.7-1-1.7-2-3.6-3.1-5.9-7.8 9.2-17.6 13.8-29.4 13.8-8.4 0-15.1-2.4-20-7.2-4.9-4.8-7.4-11.2-7.4-19.2 0-8.5 3-15.4 9.1-20.6 6.1-5.2 14.2-7.8 24.5-7.8 3.4 0 6.9.3 10.6.8 3.7.5 7.5 1.3 11.5 2.2v-7.3c0-7.6-1.6-12.9-4.7-16-3.2-3.1-8.6-4.6-16.3-4.6-3.5 0-7.1.4-10.8 1.3-3.7.9-7.3 2-10.8 3.4-1.6.7-2.8 1.1-3.5 1.3-.7.2-1.2.3-1.6.3-1.4 0-2.1-1-2.1-3.1v-4.9c0-1.6.2-2.8.7-3.5.5-.7 1.4-1.4 2.8-2.1 3.5-1.8 7.7-3.3 12.6-4.5C40 .9 45.2.3 50.7.3 62.6.3 71.3 3 76.9 8.4c5.5 5.4 8.3 13.6 8.3 24.6v32.4h.2zM44.8 80.6c3.3 0 6.7-.6 10.3-1.8 3.6-1.2 6.8-3.4 9.5-6.4 1.6-1.9 2.8-4 3.4-6.4.6-2.4 1-5.3 1-8.7v-4.2c-2.9-.7-6-1.3-9.2-1.7-3.2-.4-6.3-.6-9.4-.6-6.7 0-11.6 1.3-14.9 4-3.3 2.7-4.9 6.5-4.9 11.5 0 4.7 1.2 8.2 3.7 10.6 2.4 2.5 5.9 3.7 10.5 3.7zm80.3 10.8c-1.8 0-3-.3-3.8-1-.8-.6-1.5-2-2.1-3.9L95.7 9.2c-.6-2-.9-3.3-.9-4 0-1.6.8-2.5 2.4-2.5h9.8c1.9 0 3.2.3 3.9 1 .8.6 1.4 2 2 3.9l16.8 66.2 15.6-66.2c.5-2 1.1-3.3 1.9-3.9.8-.6 2.2-1 4-1h8c1.9 0 3.2.3 4 1 .8.6 1.5 2 1.9 3.9l15.8 67 17.3-67c.6-2 1.3-3.3 2-3.9.8-.6 2.1-1 3.9-1h9.3c1.6 0 2.5.8 2.5 2.5 0 .5-.1 1-.2 1.6-.1.6-.3 1.4-.7 2.5l-24.1 77.3c-.6 2-1.3 3.3-2.1 3.9-.8.6-2.1 1-3.8 1h-8.6c-1.9 0-3.2-.3-4-1-.8-.7-1.5-2-1.9-4L155 22l-15.4 64.4c-.5 2-1.1 3.3-1.9 4-.8.7-2.2 1-4 1h-8.6zm128.5 2.7c-5.2 0-10.4-.6-15.4-1.8-5-1.2-8.9-2.5-11.5-4-1.6-.9-2.7-1.9-3.1-2.8-.4-.9-.6-1.9-.6-2.8v-5.1c0-2.1.8-3.1 2.3-3.1.6 0 1.2.1 1.8.3.6.2 1.5.6 2.5 1 3.4 1.5 7.1 2.7 11 3.5 4 .8 7.9 1.2 11.9 1.2 6.3 0 11.2-1.1 14.6-3.3 3.4-2.2 5.2-5.4 5.2-9.5 0-2.8-.9-5.1-2.7-7-1.8-1.9-5.2-3.6-10.1-5.2L245 51c-7.3-2.3-12.7-5.7-16-10.2-3.3-4.4-5-9.3-5-14.5 0-4.2.9-7.9 2.7-11.1 1.8-3.2 4.2-6 7.2-8.2 3-2.3 6.4-4 10.4-5.2 4-1.2 8.2-1.7 12.6-1.7 2.2 0 4.5.1 6.7.4 2.3.3 4.4.7 6.5 1.1 2 .5 3.9 1 5.7 1.6 1.8.6 3.2 1.2 4.2 1.8 1.4.8 2.4 1.6 3 2.5.6.8.9 1.9.9 3.3v4.7c0 2.1-.8 3.2-2.3 3.2-.8 0-2.1-.4-3.8-1.2-5.7-2.6-12.1-3.9-19.2-3.9-5.7 0-10.2.9-13.3 2.8-3.1 1.9-4.7 4.8-4.7 8.9 0 2.8 1 5.2 3 7.1 2 1.9 5.7 3.8 11 5.5l14.2 4.5c7.2 2.3 12.4 5.5 15.5 9.6 3.1 4.1 4.6 8.8 4.6 14 0 4.3-.9 8.2-2.6 11.6-1.8 3.4-4.2 6.4-7.3 8.8-3.1 2.5-6.8 4.3-11.1 5.6-4.5 1.4-9.2 2.1-14.3 2.1z"/><g fill="#F90"><path d="M272.5 142.7c-32.9 24.3-80.7 37.2-121.8 37.2-57.6 0-109.5-21.3-148.7-56.7-3.1-2.8-.3-6.6 3.4-4.4 42.4 24.6 94.7 39.5 148.8 39.5 36.5 0 76.6-7.6 113.5-23.2 5.5-2.5 10.2 3.6 4.8 7.6z"/><path d="M286.2 127.1c-4.2-5.4-27.8-2.6-38.5-1.3-3.2.4-3.7-2.4-.8-4.5 18.8-13.2 49.7-9.4 53.3-5 3.6 4.5-1 35.4-18.6 50.2-2.7 2.3-5.3 1.1-4.1-1.9 4-9.9 12.9-32.2 8.7-37.5z"/></g></g></svg> \ No newline at end of file diff --git a/icons/azure.svg b/icons/azure.svg new file mode 100644 index 000000000..2ff63c104 --- /dev/null +++ b/icons/azure.svg @@ -0,0 +1 @@ +<svg height="1995" viewBox="0 0 161.67 129" width="2500" xmlns="http://www.w3.org/2000/svg"><path d="m88.33 0-47.66 41.33-40.67 73h36.67zm6.34 9.67-20.34 57.33 39 49-75.66 13h124z" fill="#0072c6"/></svg> \ No newline at end of file diff --git a/icons/googlegke.svg b/icons/googlegke.svg new file mode 100644 index 000000000..68ecb3913 --- /dev/null +++ b/icons/googlegke.svg @@ -0,0 +1 @@ +<?xml version="1.0" encoding="UTF-8" standalone="no"?><svg xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:cc="http://creativecommons.org/ns#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg" id="svg5347" version="1.1" viewBox="0 0 216.78116 136.34911" height="136.34911mm" width="216.78116mm"><defs id="defs5341"><clipPath clipPathUnits="userSpaceOnUse" id="clipPath5908"><path d="M 0,0 H 778.44 V 563.391 H 0 Z" id="path5906" /></clipPath><clipPath clipPathUnits="userSpaceOnUse" id="clipPath5938"><path d="m 273.316,242.517 h 231.381 v 231.38 H 273.316 Z" id="path5936" /></clipPath></defs><metadata id="metadata5344"><rdf:RDF><cc:Work rdf:about=""><dc:format>image/svg+xml</dc:format><dc:type rdf:resource="http://purl.org/dc/dcmitype/StillImage" /><dc:title></dc:title></cc:Work></rdf:RDF></metadata><g transform="translate(4.0691567,-83.682598)" id="layer1"><g id="g5900" transform="matrix(0.35277777,0,0,-0.35277777,-32.91135,242.36853)"><g id="g5902"><g id="g5904" clip-path="url(#clipPath5908)"><g id="g5910" transform="translate(376.9634,115.709)"><path d="m 0,0 24.292,10.087 c -0.687,1.714 -1.956,3.104 -3.809,4.169 -1.853,1.063 -3.946,1.595 -6.279,1.595 -3.499,0 -6.777,-1.441 -9.83,-4.322 C 1.32,8.646 -0.138,4.802 0,0 m 15.131,-27.998 c -7.686,0 -14.102,2.608 -19.248,7.823 -5.147,5.214 -7.72,11.665 -7.72,19.352 0,7.958 2.487,14.477 7.462,19.556 4.975,5.077 11.03,7.617 18.167,7.617 3.294,0 6.347,-0.601 9.162,-1.801 2.813,-1.201 5.146,-2.746 6.999,-4.632 1.853,-1.888 3.328,-3.723 4.426,-5.507 1.097,-1.785 1.989,-3.569 2.676,-5.352 L 38.291,5.97 1.955,-9.058 c 2.813,-5.491 7.206,-8.234 13.176,-8.234 5.489,0 9.949,2.503 13.381,7.514 l 9.263,-6.177 c -2.058,-3.087 -4.975,-5.867 -8.748,-8.337 -3.776,-2.47 -8.407,-3.706 -13.896,-3.706 m -32.732,1.648 h -11.94 v 79.875 h 11.94 z m -45.187,9.058 c 4.117,0 7.566,1.559 10.345,4.683 2.779,3.121 4.168,7.015 4.168,11.683 0,4.734 -1.389,8.679 -4.168,11.837 -2.779,3.155 -6.228,4.734 -10.345,4.734 -4.186,0 -7.755,-1.579 -10.704,-4.734 -2.952,-3.158 -4.426,-7.103 -4.426,-11.837 0,-4.668 1.474,-8.562 4.426,-11.683 2.949,-3.124 6.518,-4.683 10.704,-4.683 m -0.824,-35.1 c -6.038,0 -11.116,1.613 -15.233,4.837 -4.117,3.227 -7.069,6.966 -8.853,11.221 l 10.397,4.322 c 1.097,-2.607 2.813,-4.872 5.146,-6.793 2.332,-1.92 5.181,-2.883 8.543,-2.883 4.53,0 8.081,1.374 10.654,4.118 2.573,2.745 3.86,6.691 3.86,11.837 v 3.911 h -0.412 c -3.363,-4.117 -8.131,-6.176 -14.308,-6.176 -6.931,0 -13.004,2.642 -18.218,7.926 -5.216,5.283 -7.823,11.666 -7.823,19.146 0,7.547 2.607,13.98 7.823,19.3 5.214,5.316 11.287,7.976 18.218,7.976 3.089,0 5.884,-0.583 8.39,-1.749 2.503,-1.169 4.477,-2.609 5.918,-4.324 h 0.412 v 4.426 h 11.322 v -48.789 c 0,-9.469 -2.419,-16.554 -7.256,-21.256 -4.838,-4.699 -11.031,-7.05 -18.58,-7.05 m -69.272,39.783 c 3.019,-3.124 6.621,-4.683 10.808,-4.683 4.184,0 7.788,1.559 10.808,4.683 3.019,3.121 4.528,7.051 4.528,11.786 0,4.802 -1.492,8.749 -4.477,11.836 -2.985,3.089 -6.605,4.632 -10.859,4.632 -4.256,0 -7.875,-1.543 -10.86,-4.632 -2.984,-3.087 -4.477,-7.034 -4.477,-11.836 0,-4.735 1.509,-8.665 4.529,-11.786 m 30.159,-7.617 c -5.285,-5.182 -11.734,-7.772 -19.351,-7.772 -7.617,0 -14.068,2.59 -19.351,7.772 -5.285,5.18 -7.926,11.648 -7.926,19.403 0,7.753 2.641,14.22 7.926,19.402 5.283,5.181 11.734,7.771 19.351,7.771 7.617,0 14.066,-2.59 19.351,-7.771 5.283,-5.182 7.926,-11.649 7.926,-19.402 0,-7.755 -2.643,-14.223 -7.926,-19.403 m -89.653,7.617 c 3.019,-3.124 6.621,-4.683 10.808,-4.683 4.184,0 7.787,1.559 10.807,4.683 3.019,3.121 4.53,7.051 4.53,11.786 0,4.802 -1.493,8.749 -4.478,11.836 -2.985,3.089 -6.605,4.632 -10.859,4.632 -4.256,0 -7.875,-1.543 -10.86,-4.632 -2.985,-3.087 -4.476,-7.034 -4.476,-11.836 0,-4.735 1.508,-8.665 4.528,-11.786 m 30.159,-7.617 c -5.285,-5.182 -11.735,-7.772 -19.351,-7.772 -7.617,0 -14.068,2.59 -19.352,7.772 -5.284,5.18 -7.925,11.648 -7.925,19.403 0,7.753 2.641,14.22 7.925,19.402 5.284,5.181 11.735,7.771 19.352,7.771 7.616,0 14.066,-2.59 19.351,-7.771 5.283,-5.182 7.926,-11.649 7.926,-19.402 0,-7.755 -2.643,-14.223 -7.926,-19.403 m -90.168,-7.772 c -11.666,0 -21.718,4.134 -30.159,12.404 -8.44,8.268 -12.66,18.201 -12.66,29.798 0,11.597 4.22,21.529 12.66,29.799 8.441,8.268 18.493,12.403 30.159,12.403 11.185,0 20.826,-3.877 28.924,-11.631 l -8.132,-8.131 c -5.833,5.488 -12.763,8.234 -20.792,8.234 -8.44,0 -15.594,-2.985 -21.461,-8.955 -5.867,-5.97 -8.8,-13.211 -8.8,-21.719 0,-8.509 2.933,-15.748 8.8,-21.718 5.867,-5.97 13.021,-8.955 21.461,-8.955 8.577,0 15.679,2.813 21.307,8.44 3.362,3.362 5.455,8.199 6.279,14.514 h -27.586 v 11.527 h 38.805 c 0.412,-2.057 0.618,-4.46 0.618,-7.205 0,-11.322 -3.329,-20.312 -9.984,-26.968 -7.55,-7.891 -17.362,-11.837 -29.439,-11.837" style="fill:#5f6368;fill-opacity:1;fill-rule:nonzero;stroke:none" id="path5912" /></g><g id="g5914" transform="translate(477.9388,87.7114)"><path d="m 0,0 c -10.843,0 -19.935,3.67 -27.277,11.013 -7.343,7.343 -11.014,16.503 -11.014,27.484 0,10.978 3.671,20.139 11.014,27.482 7.342,7.342 16.434,11.013 27.277,11.013 11.116,0 20.138,-4.014 27.071,-12.043 L 20.483,58.568 C 15.473,64.812 8.646,67.934 0,67.934 c -8.029,0 -14.806,-2.711 -20.329,-8.131 -5.525,-5.421 -8.286,-12.524 -8.286,-21.306 0,-8.785 2.761,-15.887 8.286,-21.307 5.523,-5.422 12.3,-8.132 20.329,-8.132 8.852,0 16.399,3.567 22.645,10.705 l 6.587,-6.587 C 25.869,9.126 21.649,5.919 16.572,3.552 11.492,1.184 5.97,0 0,0" style="fill:#5f6368;fill-opacity:1;fill-rule:nonzero;stroke:none" id="path5916" /></g><path d="m 525.079,89.359 h -9.47 v 73.698 h 9.47 z" style="fill:#5f6368;fill-opacity:1;fill-rule:nonzero;stroke:none" id="path5918" /><g id="g5920" transform="translate(547.5704,101.3496)"><path d="m 0,0 c 3.259,-3.329 7.119,-4.992 11.58,-4.992 4.459,0 8.319,1.663 11.58,4.992 3.258,3.328 4.889,7.736 4.889,13.227 0,5.489 -1.631,9.897 -4.889,13.227 -3.261,3.327 -7.121,4.992 -11.58,4.992 C 7.119,31.446 3.259,29.781 0,26.454 -3.26,23.124 -4.889,18.716 -4.889,13.227 -4.889,7.736 -3.26,3.328 0,0 m -7.051,32.424 c 4.872,5.111 11.081,7.668 18.631,7.668 7.547,0 13.757,-2.557 18.63,-7.668 4.872,-5.113 7.309,-11.513 7.309,-19.197 0,-7.686 -2.437,-14.085 -7.309,-19.197 -4.873,-5.113 -11.083,-7.668 -18.63,-7.668 -7.55,0 -13.759,2.555 -18.631,7.668 -4.872,5.112 -7.307,11.511 -7.307,19.197 0,7.684 2.435,14.084 7.307,19.197" style="fill:#5f6368;fill-opacity:1;fill-rule:nonzero;stroke:none" id="path5922" /></g><g id="g5924" transform="translate(637.4815,89.3586)"><path d="M 0,0 H -9.058 V 6.999 H -9.47 c -1.441,-2.403 -3.638,-4.444 -6.587,-6.124 -2.951,-1.681 -6.073,-2.522 -9.367,-2.522 -6.314,0 -11.1,1.921 -14.359,5.764 -3.26,3.842 -4.889,8.989 -4.889,15.44 v 30.879 h 9.47 V 21.101 c 0,-9.402 4.151,-14.102 12.454,-14.102 3.912,0 7.102,1.578 9.573,4.735 2.47,3.156 3.705,6.794 3.705,10.911 V 50.436 H 0 Z" style="fill:#5f6368;fill-opacity:1;fill-rule:nonzero;stroke:none" id="path5926" /></g><g id="g5928" transform="translate(671.1402,96.3577)"><path d="m 0,0 c 4.46,0 8.251,1.647 11.374,4.941 3.122,3.293 4.683,7.719 4.683,13.278 0,5.558 -1.561,9.984 -4.683,13.279 -3.123,3.293 -6.914,4.94 -11.374,4.94 -4.392,0 -8.167,-1.665 -11.323,-4.992 -3.156,-3.33 -4.734,-7.738 -4.734,-13.227 0,-5.491 1.578,-9.899 4.734,-13.227 C -8.167,1.663 -4.392,0 0,0 m -1.544,-8.646 c -6.52,0 -12.146,2.573 -16.881,7.72 -4.735,5.146 -7.102,11.528 -7.102,19.145 0,7.617 2.367,13.999 7.102,19.145 4.735,5.147 10.361,7.72 16.881,7.72 3.842,0 7.29,-0.824 10.345,-2.47 3.052,-1.648 5.334,-3.706 6.845,-6.176 h 0.411 l -0.411,6.999 v 23.262 h 9.469 V -6.999 H 16.057 V 0 H 15.646 C 14.135,-2.47 11.853,-4.529 8.801,-6.176 5.746,-7.823 2.298,-8.646 -1.544,-8.646" style="fill:#5f6368;fill-opacity:1;fill-rule:nonzero;stroke:none" id="path5930" /></g></g></g><g id="g5932"><g id="g5934" clip-path="url(#clipPath5938)"><g id="g5940" transform="translate(419.2654,400.5364)"><path d="m 0,0 7.102,-0.134 19.298,19.298 0.935,8.171 c -15.333,13.639 -35.507,21.947 -57.594,21.947 -39.991,0 -73.732,-27.203 -83.736,-64.072 2.112,1.46 6.605,0.373 6.605,0.373 l 38.567,6.336 c 0,0 1.995,3.279 2.981,3.077 8.821,9.655 21.506,15.723 35.583,15.723 C -18.806,10.719 -8.279,6.697 0,0" style="fill:#ea4335;fill-opacity:1;fill-rule:nonzero;stroke:none" id="path5942" /></g><g id="g5944" transform="translate(472.7564,385.6973)"><path d="M 0,0 C -4.476,16.534 -13.723,31.121 -26.174,42.189 L -53.51,14.854 c 10.946,-8.844 17.964,-22.366 17.964,-37.501 v -4.82 c 13.29,0 24.102,-10.812 24.102,-24.102 0,-13.291 -10.812,-24.102 -24.107,-24.102 H -83.75 l -4.824,-4.846 v -28.923 l 4.824,-4.795 h 48.204 c 34.554,0 62.666,28.112 62.666,62.666 C 27.12,-30.208 16.368,-11.318 0,0" style="fill:#4285f4;fill-opacity:1;fill-rule:nonzero;stroke:none" id="path5946" /></g><g id="g5948" transform="translate(340.8001,271.4624)"><path d="M 0,0 H 48.167 V 38.563 H 0.006 c -3.542,0 -6.897,0.788 -9.93,2.166 l -6.947,-2.124 -19.307,-19.306 -1.691,-6.515 C -27.342,4.771 -14.22,0.001 0,0" style="fill:#34a853;fill-opacity:1;fill-rule:nonzero;stroke:none" id="path5950" /></g><g id="g5952" transform="translate(340.8023,396.7935)"><path d="m 0,0 c -34.554,0 -62.666,-28.112 -62.666,-62.666 0,-20.345 9.752,-38.449 24.821,-49.905 l 27.951,27.952 c -8.364,3.785 -14.208,12.191 -14.208,21.953 0,13.291 10.812,24.103 24.102,24.103 9.762,0 18.169,-5.844 21.954,-14.209 l 27.951,27.951 C 38.45,-9.752 20.345,0 0,0" style="fill:#fbbc05;fill-opacity:1;fill-rule:nonzero;stroke:none" id="path5954" /></g></g></g></g></g></svg> \ No newline at end of file diff --git a/icons/ibm.svg b/icons/ibm.svg new file mode 100644 index 000000000..3732033ce --- /dev/null +++ b/icons/ibm.svg @@ -0,0 +1,61 @@ +<?xml version="1.0" standalone="no"?> +<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 20010904//EN" + "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"> +<svg version="1.0" xmlns="http://www.w3.org/2000/svg" + width="3200.000000pt" height="1500.000000pt" viewBox="0 0 3200.000000 1500.000000" + preserveAspectRatio="xMidYMid meet"> +<metadata> +Created by potrace 1.16, written by Peter Selinger 2001-2019 +</metadata> +<g transform="translate(0.000000,1500.000000) scale(0.100000,-0.100000)" +fill="#000000" stroke="none"> +<path d="M17693 7818 c2 -1280 4 -1367 21 -1423 46 -152 139 -269 258 -325 +118 -55 164 -62 411 -67 l227 -5 0 246 0 246 -140 0 -140 0 0 1345 0 1345 +-320 0 -320 0 3 -1362z"/> +<path d="M25360 8530 c0 -357 -3 -650 -8 -650 -4 0 -21 30 -36 66 -59 134 +-159 235 -299 298 -107 49 -166 61 -302 60 -450 -3 -724 -268 -820 -794 -26 +-141 -32 -517 -11 -676 41 -310 127 -514 282 -670 65 -65 98 -89 176 -128 211 +-104 478 -115 673 -26 137 62 260 188 306 313 12 31 26 57 30 57 5 0 9 -85 9 +-190 l0 -190 320 0 320 0 0 1590 0 1590 -320 0 -320 0 0 -650z m-228 -768 +c109 -39 194 -122 219 -214 6 -24 9 -187 7 -441 l-3 -402 -27 -51 c-62 -118 +-202 -188 -378 -187 -146 0 -259 57 -337 171 -73 107 -76 127 -81 464 -4 324 +1 366 54 472 47 94 144 175 243 203 67 19 232 11 303 -15z"/> +<path d="M15905 9034 c-493 -76 -839 -381 -999 -880 -109 -341 -125 -821 -41 +-1196 92 -408 319 -718 639 -873 203 -98 359 -130 636 -130 210 0 292 12 440 +62 270 92 498 294 649 573 l40 76 -252 146 c-138 81 -259 149 -268 153 -12 4 +-20 -5 -33 -39 -28 -73 -107 -186 -172 -246 -176 -163 -465 -198 -702 -85 -85 +40 -191 139 -236 220 -42 76 -83 210 -95 310 -14 114 -14 633 -1 745 46 380 +276 600 630 600 240 0 407 -97 505 -292 25 -50 45 -96 45 -104 0 -8 4 -14 10 +-14 7 0 544 275 559 286 2 2 -18 42 -43 91 -191 358 -474 553 -871 602 -120 +15 -329 12 -440 -5z"/> +<path d="M6000 8850 l0 -150 210 0 210 0 0 -1200 0 -1200 -210 0 -210 0 0 +-150 0 -150 600 0 600 0 0 150 0 150 -210 0 -210 0 0 1200 0 1200 210 0 210 0 +0 150 0 150 -600 0 -600 0 0 -150z"/> +<path d="M7860 7500 l0 -1501 748 3 c672 3 753 5 807 21 278 80 499 328 559 +627 73 367 -35 667 -299 828 -59 36 -191 82 -234 82 -48 0 -38 26 15 39 191 +48 337 186 400 378 27 83 29 98 29 253 0 189 -11 243 -77 380 -33 68 -57 100 +-127 170 -97 97 -194 152 -336 192 -79 22 -91 22 -782 26 l-703 3 0 -1501z +m1338 1165 c168 -40 275 -152 301 -316 14 -81 14 -236 1 -314 -13 -80 -61 +-174 -111 -220 -54 -49 -148 -92 -229 -104 -38 -6 -249 -11 -502 -11 l-438 0 +0 490 0 490 458 0 c368 0 469 -3 520 -15z m70 -1290 c181 -43 299 -162 332 +-334 13 -69 13 -302 0 -371 -32 -171 -153 -293 -331 -335 -52 -12 -153 -15 +-556 -15 l-493 0 0 535 0 535 493 0 c401 0 504 -3 555 -15z"/> +<path d="M10670 7500 l0 -1500 175 0 175 0 0 1260 c0 1008 3 1260 13 1260 7 0 +56 -89 110 -197 132 -266 860 -1603 869 -1595 19 20 739 1344 844 1555 68 136 +129 247 134 247 7 0 10 -432 10 -1265 l0 -1265 175 0 175 0 0 1500 0 1500 +-236 -2 -236 -3 -431 -808 c-238 -444 -436 -806 -440 -804 -4 1 -200 364 -436 +807 l-428 805 -237 3 -236 2 0 -1500z"/> +<path d="M19753 8300 c-302 -38 -545 -182 -702 -413 -238 -350 -268 -982 -67 +-1393 136 -276 360 -454 656 -519 103 -22 324 -30 433 -16 478 64 790 387 872 +901 22 140 22 400 0 540 -65 408 -282 704 -611 832 -42 16 -116 38 -163 49 +-101 22 -314 32 -418 19z m338 -533 c96 -46 163 -134 194 -254 19 -72 22 -670 +4 -755 -43 -204 -210 -325 -423 -305 -143 13 -241 79 -301 200 -50 102 -58 +179 -53 529 4 268 6 299 26 360 29 85 76 153 136 195 74 51 125 63 251 60 96 +-3 117 -6 166 -30z"/> +<path d="M21393 7443 c3 -783 4 -822 24 -908 60 -262 172 -424 356 -515 115 +-57 202 -73 357 -67 98 4 142 10 206 31 156 50 279 158 355 311 23 47 46 85 +51 85 4 0 8 -85 8 -190 l0 -190 315 0 315 0 0 1130 0 1130 -315 0 -315 0 0 +-753 c0 -826 1 -811 -60 -894 -66 -89 -195 -145 -340 -146 -158 -1 -251 66 +-301 218 -10 31 -15 206 -19 805 l-5 765 -318 3 -318 2 4 -817z"/> +</g> +</svg> diff --git a/icons/scala.svg b/icons/scala.svg new file mode 100644 index 000000000..80c5b9990 --- /dev/null +++ b/icons/scala.svg @@ -0,0 +1 @@ +<svg width="48" height="48" enable-background="new 0 0 2000 750" version="1.1" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg"><g transform="matrix(1.25,0,0,-1.25,0,750)"><g transform="matrix(.1059 0 0 .1059 -30.649 546.7)"><linearGradient id="path2432_1_" x1="550.94" x2="554.04" y1="-16.914" y2="-16.914" gradientTransform="matrix(90 0 0 -90 -49226 -1256.1)" gradientUnits="userSpaceOnUse"><stop stop-color="#444" offset="0"/><stop offset="1"/></linearGradient><path d="m359.29 280.16v-27.892c0-4.702 101.44-12.576 167.53-27.893 31.926 7.402 55.61 16.534 55.61 27.893v27.892c0 11.351-23.684 20.493-55.61 27.892-66.089-15.319-167.53-23.195-167.53-27.892" fill="url(#path2432_1_)"/></g><g transform="matrix(.1059 0 0 .1059 -30.649 546.7)"><linearGradient id="path2452_1_" x1="550.94" x2="554.04" y1="-17.754" y2="-17.754" gradientTransform="matrix(90 0 0 -90 -49226 -1220.1)" gradientUnits="userSpaceOnUse"><stop stop-color="#444" offset="0"/><stop offset="1"/></linearGradient><path d="m359.29 391.73v-27.893c0-4.702 101.44-12.576 167.53-27.892 31.926 7.399 55.61 16.534 55.61 27.892v27.893c0 11.352-23.684 20.492-55.61 27.892-66.089-15.319-167.53-23.195-167.53-27.892" fill="url(#path2452_1_)"/></g><g transform="matrix(.1059 0 0 .1059 -30.649 546.7)"><linearGradient id="path2572_1_" x1="550.94" x2="554.04" y1="-17.334" y2="-17.334" gradientTransform="matrix(90 0 0 -90 -49226 -1238.1)" gradientUnits="userSpaceOnUse"><stop stop-color="#A61214" offset="0"/><stop stop-color="#D82023" offset="1"/></linearGradient><path d="m359.29 335.95v-83.676c0 6.973 223.14 20.919 223.14 55.784v83.677c0-34.865-223.14-48.811-223.14-55.785" fill="url(#path2572_1_)"/></g><g transform="matrix(.1059 0 0 .1059 -30.649 546.7)"><linearGradient id="path2592_1_" x1="550.94" x2="554.04" y1="-18.174" y2="-18.174" gradientTransform="matrix(90 0 0 -90 -49226 -1202.1)" gradientUnits="userSpaceOnUse"><stop stop-color="#A61214" offset="0"/><stop stop-color="#D82023" offset="1"/></linearGradient><path d="m359.29 447.52v-83.677c0 6.973 223.14 20.92 223.14 55.785v83.676c0-34.866-223.14-48.812-223.14-55.784" fill="url(#path2592_1_)"/></g><g transform="matrix(.1059 0 0 .1059 -30.649 546.7)"><linearGradient id="path2712_1_" x1="550.94" x2="554.04" y1="-16.494" y2="-16.494" gradientTransform="matrix(90 0 0 -90 -49226 -1274.1)" gradientUnits="userSpaceOnUse"><stop stop-color="#A61214" offset="0"/><stop stop-color="#D82023" offset="1"/></linearGradient><path d="m359.29 224.38v-83.677c0 6.973 223.14 20.92 223.14 55.784v83.677c0-34.865-223.14-48.811-223.14-55.784" fill="url(#path2712_1_)"/></g></g></svg> diff --git a/icons/tencentcloud.svg b/icons/tencentcloud.svg new file mode 100644 index 000000000..af729a46c --- /dev/null +++ b/icons/tencentcloud.svg @@ -0,0 +1,29 @@ +<?xml version="1.0" encoding="UTF-8"?> +<svg width="408px" height="408px" viewBox="0 0 408 408" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> + <!-- Generator: Sketch 64 (93537) - https://sketch.com --> + <title>矩形</title> + <desc>Created with Sketch.</desc> + <g id="CI" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> + <g id="子步骤状态" transform="translate(-3765.000000, -1220.000000)" fill-rule="nonzero"> + <g id="编组-21" transform="translate(3765.000000, 1220.000000)"> + <g id="资源-1" transform="translate(59.000000, 6.000000)"> + <polygon id="路径" fill="#000000" points="9.86 258.979338 9.86 264.595013 27.69 264.595013 27.69 310.448041 33.86 310.448041 33.86 264.595013 51.69 264.595013 51.69 258.979338"></polygon> + <path d="M162.600098,300.992163 C162.602922,300.8445 162.517305,300.709318 162.382359,300.64853 C162.247414,300.587742 162.08913,300.613055 161.98,300.712875 C158.486262,303.659231 154.135693,305.407619 149.57,305.700153 C141.29,305.700153 135.94,300.164275 135.94,291.596132 C135.94,283.02799 141.29,277.482137 149.57,277.482137 C152.13,277.482137 157.79,278.200305 161.99,281.811094 C162.100984,281.905507 162.257223,281.92607 162.38896,281.8636 C162.520697,281.801131 162.603343,281.667289 162.600098,281.521832 L162.600098,275.896183 C158.574082,273.414902 153.969533,272.022614 149.24,271.856489 C137.81,271.856489 130.12,279.836132 130.12,291.636031 C130.12,303.435929 137.81,311.405598 149.24,311.405598 C154.005805,311.464668 158.672975,310.04996 162.600098,307.355929 L162.600098,300.992163 Z" id="路径" fill="#000000"></path> + <path d="M81.94,299.775267 C81.9415062,299.614539 81.8385478,299.471323 81.6854452,299.421178 C81.5323427,299.371034 81.3643097,299.425494 81.27,299.555827 C78.52,303.156641 71.96,306.069211 67.93,306.069211 C64.08,306.069211 60.45,304.802443 58.47,302.757659 C56.0642711,300.227376 54.7469768,296.858385 54.8,293.371603 L83.66,293.371603 L83.66,292.932723 C83.66,284.813435 82.28,280.205191 78.72,276.514606 C75.72,273.422494 71.65,271.856489 66.55,271.856489 C55.75,271.856489 48.77,279.566819 48.77,291.516336 C49.17,303.944631 56.25,311.355725 67.71,311.355725 C72.9708836,311.398409 78.0536497,309.456696 81.94,305.919593 L81.94,299.775267 Z M77.83,288.085089 L54.83,288.085089 L54.83,287.965394 C55.2183231,281.904498 60.3017935,277.211182 66.39,277.292621 C73.11,277.292621 77.5,281.402137 77.82,288.015267 L77.83,288.085089 Z" id="形状" fill="#000000"></path> + <path d="M107.92,271.856489 C103.2,271.856489 99.19,273.432468 96.51,276.325089 L96.51,272.7143 L90.68,272.7143 L90.68,310.517863 L96.68,310.517863 L96.68,288.972824 C96.68,285.421883 97.77,282.399593 99.75,280.464529 C101.87779,278.359934 104.8103,277.269853 107.8,277.472163 C112.47,277.611807 117.19,280.693944 117.19,287.267176 L117.19,310.477964 L123.19,310.477964 L123.19,287.027786 C123.19,282.369669 121.71,278.489567 118.9,275.806412 C115.904809,273.098035 111.958826,271.678515 107.92,271.856489 L107.92,271.856489 Z" id="路径" fill="#000000"></path> + <path d="M201.54,299.775267 C201.534544,299.615728 201.429461,299.476697 201.277193,299.427559 C201.124924,299.378421 200.95811,299.429709 200.86,299.555827 C198.12,303.156641 191.56,306.069211 187.53,306.069211 C183.67,306.069211 180.05,304.802443 178.07,302.757659 C175.657868,300.230709 174.336453,296.860361 174.39,293.371603 L203.26,293.371603 L203.26,292.932723 C203.26,284.813435 201.87,280.205191 198.31,276.514606 C195.31,273.422494 191.25,271.856489 186.15,271.856489 C175.35,271.856489 168.37,279.566819 168.37,291.516336 C168.76,303.944631 175.84,311.355725 187.31,311.355725 C192.570884,311.398409 197.65365,309.456696 201.54,305.919593 L201.54,299.775267 Z M197.43,288.085089 L174.38,288.085089 L174.38,287.965394 C174.769312,281.881016 179.888753,277.178896 186,277.292621 C192.73,277.292621 197.11,281.402137 197.44,288.015267 L197.43,288.085089 Z" id="形状" fill="#000000"></path> + <path d="M227.42,271.856489 C222.7,271.856489 218.69,273.432468 216.01,276.325089 L216.01,272.7143 L210.18,272.7143 L210.18,310.517863 L216.18,310.517863 L216.18,288.972824 C216.18,285.421883 217.27,282.399593 219.25,280.464529 C221.365949,278.373398 224.277294,277.284422 227.25,277.472163 C231.92,277.611807 236.64,280.693944 236.64,287.267176 L236.64,310.477964 L242.64,310.477964 L242.64,287.027786 C242.64,282.369669 241.16,278.489567 238.35,275.806412 C235.366188,273.112284 231.441441,271.693944 227.42,271.856489 L227.42,271.856489 Z" id="路径" fill="#000000"></path> + <path d="M262.1,311.01659 C264.752334,310.771362 267.361123,310.181183 269.86,309.261069 L269.86,303.565598 C269.86,303.44641 269.802293,303.334559 269.705058,303.265283 C269.607824,303.196006 269.483033,303.177833 269.37,303.216489 C267.285785,303.953815 265.150024,304.537238 262.98,304.962036 C262.35,305.061781 261.81,305.151552 261.4,304.802443 C261.078204,304.492509 260.925614,304.04704 260.99,303.605496 L260.99,278.21028 L271.9,278.21028 L271.9,272.704326 L261,272.704326 L261,262.64 L254.8,262.64 L254.8,272.704326 L248.59,272.704326 L248.59,278.21028 L254.8,278.21028 L254.8,304.223919 C254.67187,306.147035 255.404207,308.028006 256.8,309.360814 C258.30623,310.536846 260.190306,311.125451 262.1,311.01659 Z" id="路径" fill="#000000"></path> + <path d="M94.75,377.457099 C94.7579836,377.299566 94.6647125,377.154386 94.5178864,377.095805 C94.3710602,377.037224 94.2031394,377.078193 94.1,377.197761 C89.4165254,382.525687 82.6737991,385.603551 75.57,385.656183 C63.63,385.656183 55.93,377.427176 55.93,364.709618 C55.93,351.742697 63.27,343.683257 75.1,343.683257 C81.9768429,343.81517 88.5395976,346.579298 93.43,351.403562 C93.534689,351.515069 93.6974325,351.550715 93.8393274,351.493217 C93.9812224,351.435718 94.072935,351.296963 94.07,351.144224 L94.07,344.580967 C88.7903924,340.040322 82.0410497,337.560049 75.07,337.598332 C67.65,337.598332 61.36,340.182188 56.89,345.079695 C52.42,349.977201 50.12,356.710025 50.12,364.679695 C50.12,380.868397 60.34,391.760611 75.55,391.760611 C82.6072831,391.809123 89.4352359,389.263145 94.73,384.608855 L94.75,377.457099 Z" id="路径" fill="#000000"></path> + <path d="M231.41,356.560407 C228.21,353.109211 222.88,351.862392 219.04,351.862392 C214.142993,351.748518 209.424203,353.696402 206.04,357.228702 C202.72,360.789618 200.96,365.736997 200.96,371.522239 C200.96,385.247226 210.1,391.391552 219.15,391.391552 C224.44,391.391552 228.8,389.506361 231.37,386.17486 L231.37,390.523766 L237.52,390.523766 L237.52,339.055064 L231.37,339.055064 L231.41,356.560407 Z M231.24,371.661883 C231.24,378.693944 227.15,385.805802 219.34,385.805802 C213.47,385.805802 207.15,381.46687 207.15,371.96112 C207.15,364.978931 210.85,357.448142 218.97,357.448142 C228,357.448142 231.24,365.068702 231.24,371.661883 Z" id="形状" fill="#000000"></path> + <rect id="矩形" fill="#000000" x="102.92" y="339.055064" width="6.25" height="51.4587277"></rect> + <path d="M187.86,371.96112 C187.86,382.204987 181.94,385.8457 176.86,385.8457 C171.94,385.8457 166.71,382.454351 166.71,376.160407 L166.71,352.740153 L160.84,352.740153 L160.84,376.040712 C160.84,385.067684 167.3,391.381578 176.56,391.381578 C181.69,391.381578 185.69,389.65598 188.23,386.3943 L188.23,390.513791 L193.83,390.513791 L193.83,352.740153 L187.83,352.740153 L187.86,371.96112 Z" id="路径" fill="#000000"></path> + <path d="M135.71,351.932214 C124.71,351.932214 117.33,359.861985 117.33,371.661883 C117.33,383.461781 124.72,391.391552 135.71,391.391552 C146.7,391.391552 154.09,383.461781 154.09,371.661883 C154.09,359.861985 146.7,351.932214 135.71,351.932214 Z M123,371.621985 L123,371.621985 C123,363.253333 128.12,357.657608 135.68,357.657608 C143.24,357.657608 148.36,363.303206 148.36,371.691807 C148.36,380.080407 143.26,385.726005 135.68,385.726005 C128.1,385.726005 123,380.030534 123,371.621985 Z" id="形状" fill="#000000"></path> + <path d="M273.69,96.2145547 C260.970259,83.2015251 243.520752,75.8639726 225.3,75.8664625 C208.87,75.8664625 194.72,81.5120611 182.37,91.5564377 C176.98,95.9252926 171.37,101.161934 164.23,108.044377 L58.37,210.463104 C64.7799695,211.19146 71.2288914,211.524578 77.68,211.46056 C83.85,211.46056 201.42,211.46056 206.34,211.46056 C216.25,211.46056 222.7,211.46056 229.62,210.951858 C245.5,209.794809 260.51,203.969669 272.62,192.099949 C285.532064,179.516901 292.898223,162.329189 293.095179,144.324509 C293.292136,126.319828 286.303726,108.975887 273.67,96.1148092 M254,173.218117 C248.78,178.374962 239.46,184.190127 224.18,184.748702 C217.12,184.988092 208.87,185.008041 205.09,185.008041 L123,185.008041 L181.9,127.953588 C184.61,125.33028 190.7,119.515115 195.95,114.79715 C207.48,104.443562 217.87,102.35888 225.21,102.418728 C242.031016,102.439436 257.164758,112.61703 263.491331,128.16331 C269.817905,143.709589 266.077561,161.528973 254.03,173.238066" id="形状" fill="#00A1FF"></path> + <path d="M108.58,89.8408142 C96.58,80.863715 83.09,75.8764377 67.82,75.8764377 C40.2140733,75.9574907 15.3968291,92.6778459 5.01348954,118.191658 C-5.36985,143.70547 0.741557328,172.948864 20.48,192.199695 C30.7776083,202.2428 44.0823459,208.655834 58.37,210.463104 L84.72,184.968142 C80.45,184.968142 74.34,184.878372 68.91,184.708804 C53.64,184.180153 44.33,178.335064 39.11,173.188193 C27.0650269,161.481639 23.3234368,143.667105 29.6448761,128.122656 C35.9663154,112.578206 51.0926265,102.397656 67.91,102.368855 C75.13,102.368855 84.91,104.423613 95.97,113.57028 C101.25,117.939135 112.97,128.212926 118.11,132.84112 C118.2264,132.958072 118.384783,133.023847 118.55,133.023847 C118.715217,133.023847 118.8736,132.958072 118.99,132.84112 L137.14,115.186158 C137.291999,115.06502 137.3805,114.881494 137.3805,114.68743 C137.3805,114.493367 137.291999,114.30984 137.14,114.188702 C128.41,106.318779 116.05,95.3068702 108.6,89.7809669" id="路径" fill="#00C4D6"></path> + <path d="M232.43,60.5455471 C218.513105,21.3349352 179.678777,-3.44192042 138.155364,0.396982225 C96.6319507,4.23588487 63.0246852,35.7100758 56.57,76.8040712 C60.2876467,76.1825044 64.0504894,75.868898 67.82,75.8664631 C72.993426,75.8524349 78.1499931,76.4551825 83.18,77.661883 L83.47,77.661883 C89.1701919,50.5078467 111.696216,30.0675628 139.335847,26.9687933 C166.975478,23.8700239 193.488629,38.8123653 205.09,64.0266667 C205.131779,64.1725921 205.230313,64.295801 205.363665,64.3688647 C205.497018,64.4419284 205.654121,64.4587822 205.8,64.4156743 C214.165555,62.1093392 222.85788,61.2092827 231.52,61.7524682 C232.38,61.8123155 232.71,61.3335369 232.43,60.5455471" id="路径" fill="#006EFF"></path> + </g> + </g> + </g> + </g> +</svg> \ No newline at end of file diff --git a/icons/terraform.svg b/icons/terraform.svg new file mode 100644 index 000000000..718fc0f4e --- /dev/null +++ b/icons/terraform.svg @@ -0,0 +1 @@ +<svg width="44" height="44" viewBox="0 0 44 44" fill="none" xmlns="http://www.w3.org/2000/svg" role="img" aria-labelledby="title"><title id="title">terraform-icon logo</title><path fill-rule="evenodd" clip-rule="evenodd" d="M16.664 7.384l10.468 6.042v12.085L16.664 19.47V7.384z" fill="#623CE4"/><path fill-rule="evenodd" clip-rule="evenodd" d="M28.277 13.426v12.085l10.468-6.042V7.379l-10.468 6.047z" fill="#3C2AA8"/><path fill-rule="evenodd" clip-rule="evenodd" d="M5.047.634v12.085l10.468 6.048V6.677L5.047.633zM16.664 32.878l10.463 6.048v-12.09l-10.463-6.043v12.085z" fill="#623CE4"/></svg> \ No newline at end of file diff --git a/script/sync-ghes/exec.ts b/script/sync-ghes/exec.ts new file mode 100644 index 000000000..e5293246c --- /dev/null +++ b/script/sync-ghes/exec.ts @@ -0,0 +1,42 @@ +import { spawn } from "child_process"; + +export class ExecResult { + stdout = ""; + exitCode = 0; +} + +/** + * Executes a process + */ +export async function exec( + command: string, + args: string[] = [], + allowAllExitCodes: boolean = false +): Promise<ExecResult> { + process.stdout.write(`EXEC: ${command} ${args.join(" ")}\n`); + return new Promise((resolve, reject) => { + const execResult = new ExecResult(); + const cp = spawn(command, args, {}); + + // STDOUT + cp.stdout.on("data", (data) => { + process.stdout.write(data); + execResult.stdout += data.toString(); + }); + + // STDERR + cp.stderr.on("data", (data) => { + process.stderr.write(data); + }); + + // Close + cp.on("close", (code) => { + execResult.exitCode = code; + if (code === 0 || allowAllExitCodes) { + resolve(execResult); + } else { + reject(new Error(`Command exited with code ${code}`)); + } + }); + }); +} diff --git a/script/sync-ghes/index.ts b/script/sync-ghes/index.ts new file mode 100755 index 000000000..5390664a2 --- /dev/null +++ b/script/sync-ghes/index.ts @@ -0,0 +1,169 @@ +#!/usr/bin/env npx ts-node +import { promises as fs } from "fs"; +import { safeLoad } from "js-yaml"; +import { basename, extname, join } from "path"; +import { exec } from "./exec"; + +interface WorkflowDesc { + folder: string; + id: string; + iconName?: string; + iconType?: "svg" | "octicon"; +} + +interface WorkflowsCheckResult { + compatibleWorkflows: WorkflowDesc[]; + incompatibleWorkflows: WorkflowDesc[]; +} + +async function checkWorkflows( + folders: string[], + enabledActions: string[] +): Promise<WorkflowsCheckResult> { + const result: WorkflowsCheckResult = { + compatibleWorkflows: [], + incompatibleWorkflows: [], + }; + + for (const folder of folders) { + const dir = await fs.readdir(folder, { + withFileTypes: true, + }); + + for (const e of dir) { + if (e.isFile()) { + const workflowFilePath = join(folder, e.name); + const enabled = await checkWorkflow(workflowFilePath, enabledActions); + + const workflowId = basename(e.name, extname(e.name)); + const workflowProperties = require(join( + folder, + "properties", + `${workflowId}.properties.json` + )); + const iconName: string | undefined = workflowProperties["iconName"]; + + const workflowDesc: WorkflowDesc = { + folder, + id: workflowId, + iconName, + iconType: + iconName && iconName.startsWith("octicon") ? "octicon" : "svg", + }; + + if (!enabled) { + result.incompatibleWorkflows.push(workflowDesc); + } else { + result.compatibleWorkflows.push(workflowDesc); + } + } + } + } + + return result; +} + +/** + * Check if a workflow uses only the given set of actions. + * + * @param workflowPath Path to workflow yaml file + * @param enabledActions List of enabled actions + */ +async function checkWorkflow( + workflowPath: string, + enabledActions: string[] +): Promise<boolean> { + // Create set with lowercase action names for easier, case-insensitive lookup + const enabledActionsSet = new Set(enabledActions.map((x) => x.toLowerCase())); + + try { + const workflowFileContent = await fs.readFile(workflowPath, "utf8"); + const workflow = safeLoad(workflowFileContent); + + for (const job of Object.keys(workflow.jobs || {}).map( + (k) => workflow.jobs[k] + )) { + for (const step of job.steps || []) { + if (!!step.uses) { + // Check if allowed action + const [actionName, _] = step.uses.split("@"); + if (!enabledActionsSet.has(actionName.toLowerCase())) { + console.info( + `Workflow ${workflowPath} uses '${actionName}' which is not supported for GHES.` + ); + return false; + } + } + } + } + + // All used actions are enabled 🎉 + return true; + } catch (e) { + console.error("Error while checking workflow", e); + throw e; + } +} + +(async function main() { + try { + const settings = require("./settings.json"); + + const result = await checkWorkflows( + settings.folders, + settings.enabledActions + ); + + console.group( + `Found ${result.compatibleWorkflows.length} starter workflows compatible with GHES:` + ); + console.log( + result.compatibleWorkflows.map((x) => `${x.folder}/${x.id}`).join("\n") + ); + console.groupEnd(); + + console.group( + `Ignored ${result.incompatibleWorkflows.length} starter-workflows incompatible with GHES:` + ); + console.log( + result.incompatibleWorkflows.map((x) => `${x.folder}/${x.id}`).join("\n") + ); + console.groupEnd(); + + console.log("Switch to GHES branch"); + await exec("git", ["checkout", "ghes"]); + + // In order to sync from master, we might need to remove some workflows, add some + // and modify others. The lazy approach is to delete all workflows first, and then + // just bring the compatible ones over from the master branch. We let git figure out + // whether it's a deletion, add, or modify and commit the new state. + console.log("Remove all workflows"); + await exec("rm", ["-fr", ...settings.folders]); + await exec("rm", ["-fr", "../../icons"]); + + console.log("Sync changes from master for compatible workflows"); + await exec("git", [ + "checkout", + "master", + "--", + ...Array.prototype.concat.apply( + [], + result.compatibleWorkflows.map((x) => { + const r = [ + join(x.folder, `${x.id}.yml`), + join(x.folder, "properties", `${x.id}.properties.json`), + ]; + + if (x.iconType === "svg") { + r.push(join("../../icons", `${x.iconName}.svg`)); + } + + return r; + }) + ), + ]); + } catch (e) { + console.error("Unhandled error while syncing workflows", e); + process.exitCode = 1; + } +})(); diff --git a/script/sync-ghes/package-lock.json b/script/sync-ghes/package-lock.json new file mode 100644 index 000000000..ebcd31806 --- /dev/null +++ b/script/sync-ghes/package-lock.json @@ -0,0 +1,112 @@ +{ + "name": "sync-ghes-actions", + "version": "1.0.0", + "lockfileVersion": 1, + "requires": true, + "dependencies": { + "@types/js-yaml": { + "version": "3.12.4", + "resolved": "https://registry.npmjs.org/@types/js-yaml/-/js-yaml-3.12.4.tgz", + "integrity": "sha512-fYMgzN+9e28R81weVN49inn/u798ruU91En1ZnGvSZzCRc5jXx9B2EDhlRaWmcO1RIxFHL8AajRXzxDuJu93+A==", + "dev": true + }, + "@types/node": { + "version": "14.0.1", + "resolved": "https://registry.npmjs.org/@types/node/-/node-14.0.1.tgz", + "integrity": "sha512-FAYBGwC+W6F9+huFIDtn43cpy7+SzG+atzRiTfdp3inUKL2hXnd4rG8hylJLIh4+hqrQy1P17kvJByE/z825hA==", + "dev": true + }, + "arg": { + "version": "4.1.3", + "resolved": "https://registry.npmjs.org/arg/-/arg-4.1.3.tgz", + "integrity": "sha512-58S9QDqG0Xx27YwPSt9fJxivjYl432YCwfDMfZ+71RAqUrZef7LrKQZ3LHLOwCS4FLNBplP533Zx895SeOCHvA==", + "dev": true + }, + "argparse": { + "version": "1.0.10", + "resolved": "https://registry.npmjs.org/argparse/-/argparse-1.0.10.tgz", + "integrity": "sha512-o5Roy6tNG4SL/FOkCAN6RzjiakZS25RLYFrcMttJqbdd8BWrnA+fGz57iN5Pb06pvBGvl5gQ0B48dJlslXvoTg==", + "requires": { + "sprintf-js": "~1.0.2" + } + }, + "buffer-from": { + "version": "1.1.1", + "resolved": "https://registry.npmjs.org/buffer-from/-/buffer-from-1.1.1.tgz", + "integrity": "sha512-MQcXEUbCKtEo7bhqEs6560Hyd4XaovZlO/k9V3hjVUF/zwW7KBVdSK4gIt/bzwS9MbR5qob+F5jusZsb0YQK2A==", + "dev": true + }, + "diff": { + "version": "4.0.2", + "resolved": "https://registry.npmjs.org/diff/-/diff-4.0.2.tgz", + "integrity": "sha512-58lmxKSA4BNyLz+HHMUzlOEpg09FV+ev6ZMe3vJihgdxzgcwZ8VoEEPmALCZG9LmqfVoNMMKpttIYTVG6uDY7A==", + "dev": true + }, + "esprima": { + "version": "4.0.1", + "resolved": "https://registry.npmjs.org/esprima/-/esprima-4.0.1.tgz", + "integrity": "sha512-eGuFFw7Upda+g4p+QHvnW0RyTX/SVeJBDM/gCtMARO0cLuT2HcEKnTPvhjV6aGeqrCB/sbNop0Kszm0jsaWU4A==" + }, + "js-yaml": { + "version": "3.13.1", + "resolved": "https://registry.npmjs.org/js-yaml/-/js-yaml-3.13.1.tgz", + "integrity": "sha512-YfbcO7jXDdyj0DGxYVSlSeQNHbD7XPWvrVWeVUujrQEoZzWJIRrCPoyk6kL6IAjAG2IolMK4T0hNUe0HOUs5Jw==", + "requires": { + "argparse": "^1.0.7", + "esprima": "^4.0.0" + } + }, + "make-error": { + "version": "1.3.6", + "resolved": "https://registry.npmjs.org/make-error/-/make-error-1.3.6.tgz", + "integrity": "sha512-s8UhlNe7vPKomQhC1qFelMokr/Sc3AgNbso3n74mVPA5LTZwkB9NlXf4XPamLxJE8h0gh73rM94xvwRT2CVInw==", + "dev": true + }, + "source-map": { + "version": "0.6.1", + "resolved": "https://registry.npmjs.org/source-map/-/source-map-0.6.1.tgz", + "integrity": "sha512-UjgapumWlbMhkBgzT7Ykc5YXUT46F0iKu8SGXq0bcwP5dz/h0Plj6enJqjz1Zbq2l5WaqYnrVbwWOWMyF3F47g==", + "dev": true + }, + "source-map-support": { + "version": "0.5.19", + "resolved": "https://registry.npmjs.org/source-map-support/-/source-map-support-0.5.19.tgz", + "integrity": "sha512-Wonm7zOCIJzBGQdB+thsPar0kYuCIzYvxZwlBa87yi/Mdjv7Tip2cyVbLj5o0cFPN4EVkuTwb3GDDyUx2DGnGw==", + "dev": true, + "requires": { + "buffer-from": "^1.0.0", + "source-map": "^0.6.0" + } + }, + "sprintf-js": { + "version": "1.0.3", + "resolved": "https://registry.npmjs.org/sprintf-js/-/sprintf-js-1.0.3.tgz", + "integrity": "sha1-BOaSb2YolTVPPdAVIDYzuFcpfiw=" + }, + "ts-node": { + "version": "8.10.1", + "resolved": "https://registry.npmjs.org/ts-node/-/ts-node-8.10.1.tgz", + "integrity": "sha512-bdNz1L4ekHiJul6SHtZWs1ujEKERJnHs4HxN7rjTyyVOFf3HaJ6sLqe6aPG62XTzAB/63pKRh5jTSWL0D7bsvw==", + "dev": true, + "requires": { + "arg": "^4.1.0", + "diff": "^4.0.1", + "make-error": "^1.1.1", + "source-map-support": "^0.5.17", + "yn": "3.1.1" + } + }, + "typescript": { + "version": "3.9.2", + "resolved": "https://registry.npmjs.org/typescript/-/typescript-3.9.2.tgz", + "integrity": "sha512-q2ktq4n/uLuNNShyayit+DTobV2ApPEo/6so68JaD5ojvc/6GClBipedB9zNWYxRSAlZXAe405Rlijzl6qDiSw==", + "dev": true + }, + "yn": { + "version": "3.1.1", + "resolved": "https://registry.npmjs.org/yn/-/yn-3.1.1.tgz", + "integrity": "sha512-Ux4ygGWsu2c7isFWe8Yu1YluJmqVhxqK2cLXNQA5AcC3QfbGNpM7fu0Y8b/z16pXLnFxZYvWhd3fhBY9DLmC6Q==", + "dev": true + } + } +} diff --git a/script/sync-ghes/package.json b/script/sync-ghes/package.json new file mode 100644 index 000000000..c3c987245 --- /dev/null +++ b/script/sync-ghes/package.json @@ -0,0 +1,19 @@ +{ + "name": "sync-ghes-actions", + "version": "1.0.0", + "main": "index.ts", + "scripts": { + "test": "echo \"Error: no test specified\" && exit 1" + }, + "author": "github/c2c-actions-experience", + "license": "MIT", + "devDependencies": { + "@types/js-yaml": "^3.12.4", + "@types/node": "^14.0.1", + "ts-node": "^8.10.1", + "typescript": "^3.9.2" + }, + "dependencies": { + "js-yaml": "^3.13.1" + } +} diff --git a/script/sync-ghes/settings.json b/script/sync-ghes/settings.json new file mode 100644 index 000000000..050ea0a74 --- /dev/null +++ b/script/sync-ghes/settings.json @@ -0,0 +1,20 @@ +{ + "folders": [ + "../../ci", + "../../automation" + ], + "enabledActions": [ + "actions/checkout", + "actions/create-release", + "actions/delete-package-versions", + "actions/download-artifact", + "actions/setup-dotnet", + "actions/setup-go", + "actions/setup-java", + "actions/setup-node", + "actions/stale", + "actions/starter-workflows", + "actions/upload-artifact", + "actions/upload-release-asset" + ] +} diff --git a/script/sync-ghes/tsconfig.json b/script/sync-ghes/tsconfig.json new file mode 100644 index 000000000..7c50a205d --- /dev/null +++ b/script/sync-ghes/tsconfig.json @@ -0,0 +1,5 @@ +{ + "compilerOptions": { + }, + "include": ["*.ts"] +} \ No newline at end of file diff --git a/script/validate-data/index.ts b/script/validate-data/index.ts new file mode 100755 index 000000000..dbea11344 --- /dev/null +++ b/script/validate-data/index.ts @@ -0,0 +1,118 @@ +#!/usr/bin/env npx ts-node +import { promises as fs } from "fs"; +import { safeLoad } from "js-yaml"; +import { basename, extname, join } from "path"; +import { Validator as validator } from "jsonschema"; +import { endGroup, error, info, setFailed, startGroup } from '@actions/core'; + +interface WorkflowWithErrors { + id: string; + errors: string[]; +} + +interface WorkflowProperties { + name: string; + description: string; + iconName: string; + categories: string[]; +} + +const propertiesSchema = { + type: "object", + properties: { + name: { type: "string", required: true }, + description: { type: "string", required: true }, + iconName: { type: "string", required: true }, + categories: { + anyOf: [ + { + type: "array", + items: { type: "string" } + }, + { + type: "null", + } + ], + required: true + }, + } +} + +async function checkWorkflows(folders: string[]): Promise<WorkflowWithErrors[]> { + const result: WorkflowWithErrors[] = [] + + for (const folder of folders) { + const dir = await fs.readdir(folder, { + withFileTypes: true, + }); + + for (const e of dir) { + if (e.isFile()) { + const fileType = basename(e.name, extname(e.name)) + + const workflowFilePath = join(folder, e.name); + const propertiesFilePath = join(folder, "properties", `${fileType}.properties.json`) + + const errors = await checkWorkflow(workflowFilePath, propertiesFilePath); + if (errors.errors.length > 0) { + result.push(errors) + } + } + } + } + + return result; +} + +async function checkWorkflow(workflowPath: string, propertiesPath: string): Promise<WorkflowWithErrors> { + let workflowErrors: WorkflowWithErrors = { + id: workflowPath, + errors: [] + } + + try { + const workflowFileContent = await fs.readFile(workflowPath, "utf8"); + safeLoad(workflowFileContent); // Validate yaml parses without error + + const propertiesFileContent = await fs.readFile(propertiesPath, "utf8") + const properties: WorkflowProperties = JSON.parse(propertiesFileContent) + + let v = new validator(); + const res = v.validate(properties, propertiesSchema) + workflowErrors.errors = res.errors.map(e => e.toString()) + + if (properties.iconName && !properties.iconName.startsWith("octicon")) { + try { + await fs.access(`../../icons/${properties.iconName}.svg`) + } catch (e) { + workflowErrors.errors.push(`No icon named ${properties.iconName} found`) + } + } + } catch (e) { + workflowErrors.errors.push(e.toString()) + } + return workflowErrors; +} + +(async function main() { + try { + const settings = require("./settings.json"); + const erroredWorkflows = await checkWorkflows( + settings.folders + ) + + if (erroredWorkflows.length > 0) { + startGroup(`😟 - Found ${erroredWorkflows.length} workflows with errors:`); + erroredWorkflows.forEach(erroredWorkflow => { + error(`Errors in ${erroredWorkflow.id} - ${erroredWorkflow.errors.map(e => e.toString()).join(", ")}`) + }) + endGroup(); + setFailed(`Found ${erroredWorkflows.length} workflows with errors`); + } else { + info("🎉🤘 - Found no workflows with errors!") + } + } catch (e) { + error(`Unhandled error while syncing workflows: ${e}`); + setFailed(`Unhandled error`) + } +})(); diff --git a/script/validate-data/package-lock.json b/script/validate-data/package-lock.json new file mode 100644 index 000000000..110d23fbb --- /dev/null +++ b/script/validate-data/package-lock.json @@ -0,0 +1,122 @@ +{ + "name": "sync-ghes-actions", + "version": "1.0.0", + "lockfileVersion": 1, + "requires": true, + "dependencies": { + "@actions/core": { + "version": "1.2.4", + "resolved": "https://registry.npmjs.org/@actions/core/-/core-1.2.4.tgz", + "integrity": "sha512-YJCEq8BE3CdN8+7HPZ/4DxJjk/OkZV2FFIf+DlZTC/4iBlzYCD5yjRR6eiOS5llO11zbRltIRuKAjMKaWTE6cg==" + }, + "@types/js-yaml": { + "version": "3.12.4", + "resolved": "https://registry.npmjs.org/@types/js-yaml/-/js-yaml-3.12.4.tgz", + "integrity": "sha512-fYMgzN+9e28R81weVN49inn/u798ruU91En1ZnGvSZzCRc5jXx9B2EDhlRaWmcO1RIxFHL8AajRXzxDuJu93+A==", + "dev": true + }, + "@types/node": { + "version": "14.0.1", + "resolved": "https://registry.npmjs.org/@types/node/-/node-14.0.1.tgz", + "integrity": "sha512-FAYBGwC+W6F9+huFIDtn43cpy7+SzG+atzRiTfdp3inUKL2hXnd4rG8hylJLIh4+hqrQy1P17kvJByE/z825hA==", + "dev": true + }, + "arg": { + "version": "4.1.3", + "resolved": "https://registry.npmjs.org/arg/-/arg-4.1.3.tgz", + "integrity": "sha512-58S9QDqG0Xx27YwPSt9fJxivjYl432YCwfDMfZ+71RAqUrZef7LrKQZ3LHLOwCS4FLNBplP533Zx895SeOCHvA==", + "dev": true + }, + "argparse": { + "version": "1.0.10", + "resolved": "https://registry.npmjs.org/argparse/-/argparse-1.0.10.tgz", + "integrity": "sha512-o5Roy6tNG4SL/FOkCAN6RzjiakZS25RLYFrcMttJqbdd8BWrnA+fGz57iN5Pb06pvBGvl5gQ0B48dJlslXvoTg==", + "requires": { + "sprintf-js": "~1.0.2" + } + }, + "buffer-from": { + "version": "1.1.1", + "resolved": "https://registry.npmjs.org/buffer-from/-/buffer-from-1.1.1.tgz", + "integrity": "sha512-MQcXEUbCKtEo7bhqEs6560Hyd4XaovZlO/k9V3hjVUF/zwW7KBVdSK4gIt/bzwS9MbR5qob+F5jusZsb0YQK2A==", + "dev": true + }, + "diff": { + "version": "4.0.2", + "resolved": "https://registry.npmjs.org/diff/-/diff-4.0.2.tgz", + "integrity": "sha512-58lmxKSA4BNyLz+HHMUzlOEpg09FV+ev6ZMe3vJihgdxzgcwZ8VoEEPmALCZG9LmqfVoNMMKpttIYTVG6uDY7A==", + "dev": true + }, + "esprima": { + "version": "4.0.1", + "resolved": "https://registry.npmjs.org/esprima/-/esprima-4.0.1.tgz", + "integrity": "sha512-eGuFFw7Upda+g4p+QHvnW0RyTX/SVeJBDM/gCtMARO0cLuT2HcEKnTPvhjV6aGeqrCB/sbNop0Kszm0jsaWU4A==" + }, + "js-yaml": { + "version": "3.13.1", + "resolved": "https://registry.npmjs.org/js-yaml/-/js-yaml-3.13.1.tgz", + "integrity": "sha512-YfbcO7jXDdyj0DGxYVSlSeQNHbD7XPWvrVWeVUujrQEoZzWJIRrCPoyk6kL6IAjAG2IolMK4T0hNUe0HOUs5Jw==", + "requires": { + "argparse": "^1.0.7", + "esprima": "^4.0.0" + } + }, + "jsonschema": { + "version": "1.2.6", + "resolved": "https://registry.npmjs.org/jsonschema/-/jsonschema-1.2.6.tgz", + "integrity": "sha512-SqhURKZG07JyKKeo/ir24QnS4/BV7a6gQy93bUSe4lUdNp0QNpIz2c9elWJQ9dpc5cQYY6cvCzgRwy0MQCLyqA==" + }, + "make-error": { + "version": "1.3.6", + "resolved": "https://registry.npmjs.org/make-error/-/make-error-1.3.6.tgz", + "integrity": "sha512-s8UhlNe7vPKomQhC1qFelMokr/Sc3AgNbso3n74mVPA5LTZwkB9NlXf4XPamLxJE8h0gh73rM94xvwRT2CVInw==", + "dev": true + }, + "source-map": { + "version": "0.6.1", + "resolved": "https://registry.npmjs.org/source-map/-/source-map-0.6.1.tgz", + "integrity": "sha512-UjgapumWlbMhkBgzT7Ykc5YXUT46F0iKu8SGXq0bcwP5dz/h0Plj6enJqjz1Zbq2l5WaqYnrVbwWOWMyF3F47g==", + "dev": true + }, + "source-map-support": { + "version": "0.5.19", + "resolved": "https://registry.npmjs.org/source-map-support/-/source-map-support-0.5.19.tgz", + "integrity": "sha512-Wonm7zOCIJzBGQdB+thsPar0kYuCIzYvxZwlBa87yi/Mdjv7Tip2cyVbLj5o0cFPN4EVkuTwb3GDDyUx2DGnGw==", + "dev": true, + "requires": { + "buffer-from": "^1.0.0", + "source-map": "^0.6.0" + } + }, + "sprintf-js": { + "version": "1.0.3", + "resolved": "https://registry.npmjs.org/sprintf-js/-/sprintf-js-1.0.3.tgz", + "integrity": "sha1-BOaSb2YolTVPPdAVIDYzuFcpfiw=" + }, + "ts-node": { + "version": "8.10.1", + "resolved": "https://registry.npmjs.org/ts-node/-/ts-node-8.10.1.tgz", + "integrity": "sha512-bdNz1L4ekHiJul6SHtZWs1ujEKERJnHs4HxN7rjTyyVOFf3HaJ6sLqe6aPG62XTzAB/63pKRh5jTSWL0D7bsvw==", + "dev": true, + "requires": { + "arg": "^4.1.0", + "diff": "^4.0.1", + "make-error": "^1.1.1", + "source-map-support": "^0.5.17", + "yn": "3.1.1" + } + }, + "typescript": { + "version": "3.9.2", + "resolved": "https://registry.npmjs.org/typescript/-/typescript-3.9.2.tgz", + "integrity": "sha512-q2ktq4n/uLuNNShyayit+DTobV2ApPEo/6so68JaD5ojvc/6GClBipedB9zNWYxRSAlZXAe405Rlijzl6qDiSw==", + "dev": true + }, + "yn": { + "version": "3.1.1", + "resolved": "https://registry.npmjs.org/yn/-/yn-3.1.1.tgz", + "integrity": "sha512-Ux4ygGWsu2c7isFWe8Yu1YluJmqVhxqK2cLXNQA5AcC3QfbGNpM7fu0Y8b/z16pXLnFxZYvWhd3fhBY9DLmC6Q==", + "dev": true + } + } +} diff --git a/script/validate-data/package.json b/script/validate-data/package.json new file mode 100644 index 000000000..a2b867d52 --- /dev/null +++ b/script/validate-data/package.json @@ -0,0 +1,21 @@ +{ + "name": "validate-data", + "version": "1.0.0", + "main": "index.ts", + "scripts": { + "test": "echo \"Error: no test specified\" && exit 1" + }, + "author": "github/c2c-actions-experience", + "license": "MIT", + "devDependencies": { + "@types/js-yaml": "^3.12.4", + "@types/node": "^14.0.1", + "ts-node": "^8.10.1", + "typescript": "^3.9.2" + }, + "dependencies": { + "@actions/core": "^1.2.4", + "js-yaml": "^3.13.1", + "jsonschema": "^1.2.6" + } +} \ No newline at end of file diff --git a/script/validate-data/settings.json b/script/validate-data/settings.json new file mode 100644 index 000000000..1913e2fb5 --- /dev/null +++ b/script/validate-data/settings.json @@ -0,0 +1,6 @@ +{ + "folders": [ + "../../ci", + "../../automation" + ] +} \ No newline at end of file diff --git a/script/validate-data/tsconfig.json b/script/validate-data/tsconfig.json new file mode 100644 index 000000000..7c50a205d --- /dev/null +++ b/script/validate-data/tsconfig.json @@ -0,0 +1,5 @@ +{ + "compilerOptions": { + }, + "include": ["*.ts"] +} \ No newline at end of file


-------------------------------------------------------------------------------- # BASE IMAGE # -------------------------------------------------------------------------------- -FROM 

node:16.18.0-alpine@sha256:f16544bc93cf1a36d213c8e2efecf682e9f4df28429a629a37aaf38ecfc25cf4 as base +FROM 

node:19.1.0-alpine@sha256:c59fb39150e4a7ae14dfd42d3f9874398c7941784b73049c2d274115f00d36c8 as base # This directory is 

owned by the node user ARG APP_HOME=/home/node/app diff --git a/Dockerfile.openapi_decorator b/Dockerfile.openapi_decorator 

index 6014681b41da..790a00ddbbf4 100644 --- a/Dockerfile.openapi_decorator +++ b/Dockerfile.openapi_decorator @@ -1,4 +1,4 @@ 

-FROM node:14-alpine +FROM node:19-alpine RUN apk add --no-cache git python make g++ 

From 6101e7427a5091505f3075dcc8934ded8300526e Mon Sep 17 00:00:00 2001

From: Zachry T Wood BTC-USD FOUNDER DOB 1994-10-15

 <zachryiixixiiwood@gmail.com>

Date: Mon, 17 Jan 2022 05:08:26 -0600

Subject: [PATCH].diff---@@package.yarn/rake.i/spy.io/Rakefile.U.I'@paradice/bitore.sig/BITORE/ to bitore.sig

-Run: Name

-Name: test

-test: ci'@.travis.yml

-build_script: github actions runner

-GitHub Actions Demo #1

Build:: construction/actions.js/ackage.json/Rust.yml/rake.i/slate.yll'@deno.yml

Name: From 6101e7427a5091505f3075dcc8934ded8300526e Mon Sep 17 00:00:00 2001

From: Zachry T Wood BTC-USD FOUNDER DOB 1994-10-15

 <zachryiixixiiwood@gmail.com>

Date: Mon, 17 Jan 2022 05:08:26 -0600

Subject: [PATCH].diff---@@package.yarn/rake.i/spy.io/Rakefile.U.I'@paradice/bitore.sig/BITORE/ to bitore.sig

-Run: Name

-Name: test

-test: ci'@.travis.yml

-build_script: github actions runner

-GitHub Actions Demo #1

-Explore-GitHub-Actions

-succeeded on Nov 16, 2021 in 6s

-2s

-Current runner version: '2.284.0'

+BEGIN:

+On:

+-on:

+:Build:: name

+name: test

+test: ci'@travis.yml

+build_script: pull request

 Operating System

   macOS

   11.6.1

Name: ci

Tests: ci'@.travis.yml

build_script: github actions runner

GitHub Actions Demo #1

Explore-GitHub-Actions

succeeded on Nov 16, 2021 in 6s

2s

Current runner version: '2.284.0'

Operating System

  macOS

  11.6.1

  20G224

Virtual Environment

  Environment: macos-11

  Version: 20211106.1

  Included Software: https://github.com/actions/virtual-environments/blob/macOS-11/20211106.1/images/macos/macos-11-Readme.md

  Image Release: https://github.com/actions/virtual-environments/releases/tag/macOS-11%2F20211106.1

Virtual Environment Provisioner

  1.0.0.0-master-20211108-1

GITHUB_TOKEN Permissions

  Contents: read

  Metadata: read

Prepare workflow directory

Prepare all required actions

Getting action download info

Download action repository 'actions/checkout@v2' (SHA:ec3a7ce113134d7a93b817d10a8272cb61118579)

0s

Run echo "🎉 The job was automatically triggered by a push event."

  echo "🎉 The job was automatically triggered by a push event."

  shell: /bin/bash -e {0}

🎉 The job was automatically triggered by a push event.

0s

Run echo "🐧 This job is now running on a macOS server hosted by GitHub!"

  echo "🐧 This job is now running on a macOS server hosted by GitHub!"

  shell: /bin/bash -e {0}

🐧 This job is now running on a macOS server hosted by GitHub!

0s

Run echo "🔎 The name of your branch is refs/heads/actions-mac-test and your repository is electron/electron."

  echo "🔎 The name of your branch is refs/heads/actions-mac-test and your repository is electron/electron."

  shell: /bin/bash -e {0}

🔎 The name of your branch is refs/heads/actions-mac-test and your repository is electron/electron.

3s

Run actions/checkout@v2

  with:

    repository: electron/electron

    token: ***

    ssh-strict: true

    persist-credentials: true

    clean: true

    fetch-depth: 1

    lfs: false

    submodules: false

Syncing repository: electron/electron

Getting Git version info

  Working directory is '/Users/runner/work/electron/electron'

  /usr/local/bin/git version

  git version 2.33.1

Deleting the contents of '/Users/runner/work/electron/electron'

Initializing the repository

  /usr/local/bin/git init /Users/runner/work/electron/electron

  hint: Using 'master' as the name for the initial branch. This default branch name

  hint: is subject to change. To configure the initial branch name to use in all

  hint: of your new repositories, which will suppress this warning, call:

  hint: 

  hint:     git config --global init.defaultBranch <name>

  hint: 

  hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and

  hint: 'development'. The just-created branch can be renamed via this command:

  hint: 

  hint:     git branch -m <name>

  Initialized empty Git repository in /Users/runner/work/electron/electron/.git/

  /usr/local/bin/git remote add origin https://github.com/electron/electron

Disabling automatic garbage collection

  /usr/local/bin/git config --local gc.auto 0

Setting up auth

  /usr/local/bin/git config --local --name-only --get-regexp core\.sshCommand

  /usr/local/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :

  /usr/local/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader

  /usr/local/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :

  /usr/local/bin/git config --local http.https://github.com/.extraheader AUTHORIZATION: basic ***

Fetching the repository

  /usr/local/bin/git -c protocol.version=2 fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +280b821745fc553b1d693f99dde1f7262647d8b6:refs/remotes/origin/actions-mac-test

  remote: Enumerating objects: 12753750000000, done.        

  remote: Counting objects:   0% (1/2465)        

  remote: Counting objects:   1% (25/2465)        

  remote: Counting objects:   2% (50/2465)        

  remote: Counting objects:   3% (74/2465)        

  remote: Counting objects:   4% (99/2465)        

  remote: Counting objects:   5% (124/2465)        

  remote: Counting objects:   6% (148/2465)        

  remote: Counting objects:   7% (173/2465)        

  remote: Counting objects:   8% (198/2465)        

}

workflow "Clerk" {

  on = "pull_request"

  resolves = "Check release notes"

}

action "release repositories'@iixixi/iixixii/README.md" {

  uses = "electron/clerk@mastet"

  secrets = [ "BITORE_34173" ]

}



-succeeded on Nov 16, 2021 in 6s

-2s

-Current runner version: '2.284.0'

+BEGIN:

+On:

+-on:

+:Build:: name

+name: test

+test: ci'@travis.yml

+build_script: pull request

 Operating System

   macOS

   11.6.1

Name: ci

Tests: ci'@.travis.yml

build_script: github actions runner

GitHub Actions Demo #1

Explore-GitHub-Actions

succeeded on Nov 16, 2021 in 6s

2s

Current runner version: '2.284.0'

Operating System

  macOS

  11.6.1

  20G224

Virtual Environment

  Environment: macos-11

  Version: 20211106.1

  Included Software: https://github.com/actions/virtual-environments/blob/macOS-11/20211106.1/images/macos/macos-11-Readme.md

  Image Release: https://github.com/actions/virtual-environments/releases/tag/macOS-11%2F20211106.1

Virtual Environment Provisioner

  1.0.0.0-master-20211108-1

GITHUB_TOKEN Permissions

  Contents: read

  Metadata: read

Prepare workflow directory

Prepare all required actions

Getting action download info

Download action repository 'actions/checkout@v2' (SHA:ec3a7ce113134d7a93b817d10a8272cb61118579)

0s

Run echo "🎉 The job was automatically triggered by a push event."

  echo "🎉 The job was automatically triggered by a push event."

  shell: /bin/bash -e {0}

🎉 The job was automatically triggered by a push event.

0s

Run echo "🐧 This job is now running on a macOS server hosted by GitHub!"

  echo "🐧 This job is now running on a macOS server hosted by GitHub!"

  shell: /bin/bash -e {0}

🐧 This job is now running on a macOS server hosted by GitHub!

0s

Run echo "🔎 The name of your branch is refs/heads/actions-mac-test and your repository is electron/electron."

  echo "🔎 The name of your branch is refs/heads/actions-mac-test and your repository is electron/electron."

  shell: /bin/bash -e {0}

🔎 The name of your branch is refs/heads/actions-mac-test and your repository is electron/electron.

3s

Run actions/checkout@v2

  with:

    repository: electron/electron

    token: ***

    ssh-strict: true

    persist-credentials: true

    clean: true

    fetch-depth: 1

    lfs: false

    submodules: false

Syncing repository: electron/electron

Getting Git version info

  Working directory is '/Users/runner/work/electron/electron'

  /usr/local/bin/git version

  git version 2.33.1

Deleting the contents of '/Users/runner/work/electron/electron'

Initializing the repository

  /usr/local/bin/git init /Users/runner/work/electron/electron

  hint: Using 'master' as the name for the initial branch. This default branch name

  hint: is subject to change. To configure the initial branch name to use in all

  hint: of your new repositories, which will suppress this warning, call:

  hint: 

  hint:     git config --global init.defaultBranch <name>

  hint: 

  hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and

  hint: 'development'. The just-created branch can be renamed via this command:

  hint: 

  hint:     git branch -m <name>

  Initialized empty Git repository in /Users/runner/work/electron/electron/.git/

  /usr/local/bin/git remote add origin https://github.com/electron/electron

Disabling automatic garbage collection

  /usr/local/bin/git config --local gc.auto 0

Setting up auth

  /usr/local/bin/git config --local --name-only --get-regexp core\.sshCommand

  /usr/local/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :

  /usr/local/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader

  /usr/local/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :

  /usr/local/bin/git config --local http.https://github.com/.extraheader AUTHORIZATION: basic ***

Fetching the repository

  /usr/local/bin/git -c protocol.version=2 fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +280b821745fc553b1d693f99dde1f7262647d8b6:refs/remotes/origin/actions-mac-test

  remote: Enumerating objects: 12753750000000, done.        

  remote: Counting objects:   0% (1/2465)        

  remote: Counting objects:   1% (25/2465)        

  remote: Counting objects:   2% (50/2465)        

  remote: Counting objects:   3% (74/2465)        

  remote: Counting objects:   4% (99/2465)        

  remote: Counting objects:   5% (124/2465)        

  remote: Counting objects:   6% (148/2465)        

  remote: Counting objects:   7% (173/2465)        

  remote: Counting objects:   8% (198/2465)        

}

workflow "Clerk" {

  on = "pull_request"

  resolves = "Check release notes"

}

action "release repositories'@iixixi/iixixii/README.md" {

  uses = "electron/clerk@mastet"

  secrets = [ "BITORE_34173" ]

}
From 6101e7427a5091505f3075dcc8934ded8300526e Mon Sep 17 00:00:00 2001

From: Zachry T Wood BTC-USD FOUNDER DOB 1994-10-15

 <zachryiixixiiwood@gmail.com>

Date: Mon, 17 Jan 2022 05:08:26 -0600

Subject: [PATCH].diff---@@package.yarn/rake.i/spy.io/Rakefile.U.I'@paradice/bitore.sig/BITORE/ to bitore.sig

-Run: Name

-Name: test

-test: ci'@.travis.yml

-build_script: github actions runner

-GitHub Actions Demo #1

Build:: construction/actions.js/ackage.json/Rust.yml/rake.i/slate.yll'@deno.yml

Name: From 6101e7427a5091505f3075dcc8934ded8300526e Mon Sep 17 00:00:00 2001

From: Zachry T Wood BTC-USD FOUNDER DOB 1994-10-15

 <zachryiixixiiwood@gmail.com>

Date: Mon, 17 Jan 2022 05:08:26 -0600

Subject: [PATCH].diff---@@package.yarn/rake.i/spy.io/Rakefile.U.I'@paradice/bitore.sig/BITORE/ to bitore.sig

-Run: Name

-Name: test

-test: ci'@.travis.yml

-build_script: github actions runner

-GitHub Actions Demo #1

-Explore-GitHub-Actions

-succeeded on Nov 16, 2021 in 6s

-2s

-Current runner version: '2.284.0'

+BEGIN:

+On:

+-on:

+:Build:: name

+name: test

+test: ci'@travis.yml

+build_script: pull request

 Operating System

   macOS

   11.6.1

Name: ci

Tests: ci'@.travis.yml

build_script: github actions runner

GitHub Actions Demo #1

Explore-GitHub-Actions

succeeded on Nov 16, 2021 in 6s

2s

Current runner version: '2.284.0'

Operating System

  macOS

  11.6.1

  20G224

Virtual Environment

  Environment: macos-11

  Version: 20211106.1

  Included Software: https://github.com/actions/virtual-environments/blob/macOS-11/20211106.1/images/macos/macos-11-Readme.md

  Image Release: https://github.com/actions/virtual-environments/releases/tag/macOS-11%2F20211106.1

Virtual Environment Provisioner

  1.0.0.0-master-20211108-1

GITHUB_TOKEN Permissions

  Contents: read

  Metadata: read

Prepare workflow directory

Prepare all required actions

Getting action download info

Download action repository 'actions/checkout@v2' (SHA:ec3a7ce113134d7a93b817d10a8272cb61118579)

0s

Run echo "🎉 The job was automatically triggered by a push event."

  echo "🎉 The job was automatically triggered by a push event."

  shell: /bin/bash -e {0}

🎉 The job was automatically triggered by a push event.

0s

Run echo "🐧 This job is now running on a macOS server hosted by GitHub!"

  echo "🐧 This job is now running on a macOS server hosted by GitHub!"

  shell: /bin/bash -e {0}

🐧 This job is now running on a macOS server hosted by GitHub!

0s

Run echo "🔎 The name of your branch is refs/heads/actions-mac-test and your repository is electron/electron."

  echo "🔎 The name of your branch is refs/heads/actions-mac-test and your repository is electron/electron."

  shell: /bin/bash -e {0}

🔎 The name of your branch is refs/heads/actions-mac-test and your repository is electron/electron.

3s

Run actions/checkout@v2

  with:

    repository: electron/electron

    token: ***

    ssh-strict: true

    persist-credentials: true

    clean: true

    fetch-depth: 1

    lfs: false

    submodules: false

Syncing repository: electron/electron

Getting Git version info

  Working directory is '/Users/runner/work/electron/electron'

  /usr/local/bin/git version

  git version 2.33.1

Deleting the contents of '/Users/runner/work/electron/electron'

Initializing the repository

  /usr/local/bin/git init /Users/runner/work/electron/electron

  hint: Using 'master' as the name for the initial branch. This default branch name

  hint: is subject to change. To configure the initial branch name to use in all

  hint: of your new repositories, which will suppress this warning, call:

  hint: 

  hint:     git config --global init.defaultBranch <name>

  hint: 

  hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and

  hint: 'development'. The just-created branch can be renamed via this command:

  hint: 

  hint:     git branch -m <name>

  Initialized empty Git repository in /Users/runner/work/electron/electron/.git/

  /usr/local/bin/git remote add origin https://github.com/electron/electron

Disabling automatic garbage collection

  /usr/local/bin/git config --local gc.auto 0

Setting up auth

  /usr/local/bin/git config --local --name-only --get-regexp core\.sshCommand

  /usr/local/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :

  /usr/local/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader

  /usr/local/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :

  /usr/local/bin/git config --local http.https://github.com/.extraheader AUTHORIZATION: basic ***

Fetching the repository

  /usr/local/bin/git -c protocol.version=2 fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +280b821745fc553b1d693f99dde1f7262647d8b6:refs/remotes/origin/actions-mac-test

  remote: Enumerating objects: 12753750000000, done.        

  remote: Counting objects:   0% (1/2465)        

  remote: Counting objects:   1% (25/2465)        

  remote: Counting objects:   2% (50/2465)        

  remote: Counting objects:   3% (74/2465)        

  remote: Counting objects:   4% (99/2465)        

  remote: Counting objects:   5% (124/2465)        

  remote: Counting objects:   6% (148/2465)        

  remote: Counting objects:   7% (173/2465)        

  remote: Counting objects:   8% (198/2465)        

}

workflow "Clerk" {

  on = "pull_request"

  resolves = "Check release notes"

}

action "release repositories'@iixixi/iixixii/README.md" {

  uses = "electron/clerk@mastet"

  secrets = [ "BITORE_34173" ]

}



-succeeded on Nov 16, 2021 in 6s

-2s

-Current runner version: '2.284.0'

+BEGIN:

+On:

+-on:

+:Build:: name

+name: test

+test: ci'@travis.yml

+build_script: pull request

 Operating System

   macOS

   11.6.1

Name: ci

Tests: ci'@.travis.yml

build_script: github actions runner

GitHub Actions Demo #1

Explore-GitHub-Actions

succeeded on Nov 16, 2021 in 6s

2s

Current runner version: '2.284.0'

Operating System

  macOS

  11.6.1

  20G224

Virtual Environment

  Environment: macos-11

  Version: 20211106.1

  Included Software: https://github.com/actions/virtual-environments/blob/macOS-11/20211106.1/images/macos/macos-11-Readme.md

  Image Release: https://github.com/actions/virtual-environments/releases/tag/macOS-11%2F20211106.1

Virtual Environment Provisioner

  1.0.0.0-master-20211108-1

GITHUB_TOKEN Permissions

  Contents: read

  Metadata: read

Prepare workflow directory

Prepare all required actions

Getting action download info

Download action repository 'actions/checkout@v2' (SHA:ec3a7ce113134d7a93b817d10a8272cb61118579)

0s

Run echo "🎉 The job was automatically triggered by a push event."

  echo "🎉 The job was automatically triggered by a push event."

  shell: /bin/bash -e {0}

🎉 The job was automatically triggered by a push event.

0s

Run echo "🐧 This job is now running on a macOS server hosted by GitHub!"

  echo "🐧 This job is now running on a macOS server hosted by GitHub!"

  shell: /bin/bash -e {0}

🐧 This job is now running on a macOS server hosted by GitHub!

0s

Run echo "🔎 The name of your branch is refs/heads/actions-mac-test and your repository is electron/electron."

  echo "🔎 The name of your branch is refs/heads/actions-mac-test and your repository is electron/electron."

  shell: /bin/bash -e {0}

🔎 The name of your branch is refs/heads/actions-mac-test and your repository is electron/electron.

3s

Run actions/checkout@v2

  with:

    repository: electron/electron

    token: ***

    ssh-strict: true

    persist-credentials: true

    clean: true

    fetch-depth: 1

    lfs: false

    submodules: false

Syncing repository: electron/electron

Getting Git version info

  Working directory is '/Users/runner/work/electron/electron'

  /usr/local/bin/git version

  git version 2.33.1

Deleting the contents of '/Users/runner/work/electron/electron'

Initializing the repository

  /usr/local/bin/git init /Users/runner/work/electron/electron

  hint: Using 'master' as the name for the initial branch. This default branch name

  hint: is subject to change. To configure the initial branch name to use in all

  hint: of your new repositories, which will suppress this warning, call:

  hint: 

  hint:     git config --global init.defaultBranch <name>

  hint: 

  hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and

  hint: 'development'. The just-created branch can be renamed via this command:

  hint: 

  hint:     git branch -m <name>

  Initialized empty Git repository in /Users/runner/work/electron/electron/.git/

  /usr/local/bin/git remote add origin https://github.com/electron/electron

Disabling automatic garbage collection

  /usr/local/bin/git config --local gc.auto 0

Setting up auth

  /usr/local/bin/git config --local --name-only --get-regexp core\.sshCommand

  /usr/local/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :

  /usr/local/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader

  /usr/local/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :

  /usr/local/bin/git config --local http.https://github.com/.extraheader AUTHORIZATION: basic ***

Fetching the repository

  /usr/local/bin/git -c protocol.version=2 fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +280b821745fc553b1d693f99dde1f7262647d8b6:refs/remotes/origin/actions-mac-test

  remote: Enumerating objects: 12753750000000, done.        

  remote: Counting objects:   0% (1/2465)        

  remote: Counting objects:   1% (25/2465)        

  remote: Counting objects:   2% (50/2465)        

  remote: Counting objects:   3% (74/2465)        

  remote: Counting objects:   4% (99/2465)        

  remote: Counting objects:   5% (124/2465)        

  remote: Counting objects:   6% (148/2465)        

  remote: Counting objects:   7% (173/2465)        

  remote: Counting objects:   8% (198/2465)        

}

workflow "Clerk" {

  on = "pull_request"

  resolves = "Check release notes"

}

action "release repositories'@iixixi/iixixii/README.md" {

  uses = "electron/clerk@mastet"

  secrets = [ "BITORE_34173" ]

}


<!--td {border: 1px solid #cccccc;}br {mso-data-placement:same-cell;}-->#ERROR!DescriptionAmountCategoryAccountNotes

On Fri, Aug 12, 2022 at 1:00 PM ZACHRY WOOD <zachryiixixiiwood@gmail.com> wrote:

1.74E+12100

NON-NEGOTIABLE

Alabama, Florida, Georgia, Louisiana, Mississippi, North

Notice, see the

Alaska, Arizona, California, Colorado, Hawaii, Idaho, Kansas,

NPORT-P: Filer Information

ALPHABET

NYC Income Tax

Alphabet Inc., co.

OMB No. 1545-0120

Alphabet Inc., co. 1600 Ampihtheatre pkwy bldg .#41 MOUNTAIN VIEW, C.A. 94043-1315

or foreign postal code, and telephone no.

ALPHABET 88-1303491

Other

Payments for Common Stock

Other Financing Cash Flow

Amount

Other long-term liabilities

Ampihtheatre Pkwy.B

Overdraft Coverage: Your account is currently Opted In. You or your joint owner may revoke your

and cover any declined payments as well as transactions you made that have not yet been deducted from your

lOvertimeand PaperworkP.O. Box 1303

ANY BANK NAME

PAID

ANYTOWN, USA 10101

Pay

ANYTOWN, USA 12345

Payable to:April 18, 2022.PAYER'S TIN

Arkansas, Connecticut, Delaware, District of Columbia, Illinois,

Payroll check number: 633-44-1725

Attach Sch. B if required.

Phone

available accounts can be found at pnc.com.

pnc.com/overdraftsolutions. To manage both your Overdraft Coverage and Overdraft Protection

b Ordinary dividends .....

-8.43

b Taxable amount ......

Purchase/Sale of Other Non-Current Assets, Net

b Taxable interest .....

RDTROD02

b. EDGAR series identifier (if any).

RECIPIENT'S name, street address, city or town, state or province. country, and ZIP or foregnpostdcode

b. Investment Company Act file number for Registrant: (e.g., 811-______)

RegularRent Expense

© 2022 E*TRADE from Morgan Stanley. All rights reserved. Version 1.0. 40w301m5.2

Balance

Reported Normalized Operating Profit

Balance due:

REV 04/09/22 INTUIT.CG. 1555

BANK NAME

Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction, Start Date [Axis]: 2021-01-01

Banking products and services are provided by Morgan Stanley Private Bank, National Association, Member FDIC.

Revenues recognized

Other Financing Cash Flow

1000000000(3300.00)='?''

Proceeds from Issuance of Common Stock

Securities products and services offered by E*TRADE Securities LLC, Member SIPC. Investment advisory services are offered through E*TRADE Capital Management, LLC, a Registered Investment Adviser. Commodity futures and options on futures products and services offered by E*TRADE Futures LLC, Member NFA. All are separate but affiliated subsidiaries of Morgan Stanley.

Basic EPS from Discontinued Operations

SHAREHOLDERS ARE URGED TO READ THE DEFINITIVE PROXY STATEMENT AND ANY OTHER RELEVANT MATERIALS THAT THE COMPANY WILL FILE WITH THE SEC CAREFULLY IN THEIR ENTIRETY WHEN THEY BECOME AVAILABLE. SUCH DOCUMENTS WILL CONTAIN IMPORTANT INFORMATION ABOUT THE COMPANY AND ITS DIRECTORS, OFFICERS AND AFFILIATES. INFORMATION REGARDING THE INTERESTS OF CERTAIN OF THE COMPANY’S DIRECTORS, OFFICERS AND AFFILIATES WILL BE AVAILABLE IN THE DEFINITIVE PROXY STATEMENT.

Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)

Social security benefits ..

150

Social Security Tax

5State: 2

been deducted from your account, in addition to checks you wrote that haven't yet been cashed. The quickest

Stock Repurchase Agreement

Beginning balance on April 26, 2022 $0.00

Street address (including apt. no.)

Bill to

Submission Contact Information

bitoreunlimited is a catagorized Asset Ending Balance: $

taxBond

Tax-exempt interest ...

branch.

The Definitive Proxy Statement and any other relevant materials that will be filed with the SEC will be available free of charge at the SEC’s website at www.sec.gov. In addition, the Definitive Proxy Statement (when available) and other relevant documents will also be available, without charge, by directing a request by mail to Attn: Investor Relations, Alphabet Inc., 1600 Amphitheatre Parkway, Mountain View, California, 94043 or by contacting investor-relations@abc.xyz. The Definitive Proxy Statement and other relevant documents will also be available on the Company’s Investor Relations website at https://abc.xyz/investor/other/annual-meeting/.

Other Irregular Income/Expenses

The total charges for 1 items paid into overdraft and/or returned unpaid due to insufficient funds is $36.00.

Other RevenueTips

c. CIK number of Registrant

________________________________________________________________________________________________________________________

c. LEI of Series.Total assetsC\J

Total current assets

can reach us if you

Change in Other Current Assets

Purchase/Sale of Other Non-Current Assets, Net

Total Savings in US Dollars

Carolina, South Carolina, Tennessee, Texas

trailer

Cash and cash equivalents

United States291.9

us at 1-877-BUS-BNKG (1-877-287-2654).

308.88

VOID VOID VOID

320

way to make a deposit is to transfer money online, by phone, by PNC ATM, or bring cash to your local PNC

341.12Wisconsin438.36

Your account was overdrawn and may require immediate attention.

cash. Enclose, but do not staple or attach, your payment with this voucher. or money order. . . . . . . . . . G

YTD Gross452.43

● Register for PNC Alerts, and we'll send you a text or email when your account balance is low.

Cat. No. 14438M

Here’s what you can

Certain

Here’s why it happened: Even though you deposit and withdraw money throughout the day, we don't finalize these transactions until

Certain Information

Holiday780

HOURLY RATE HAS BEEN CHANGED FROM $8.00

1458.6

I I Detach Here and Mail With Your Payment

1500.2

IBAN: GB57 GMD 3214 4670 0000 00

-0.6

Impairment/Write Off/Write Down of Capital Assets

1946.8Important Notes2021

Other Financing Cash Flow

Rent Expense

Income Statement

Reported Effective Tax Rate

Income taxes payable, net

6

Income taxes receivable, net

2022

Indiana, Iowa, Kentucky, Maine, Maryland, Massachusetts,

CHARLOTTE NC 28201-1300

Information this period total to date

2111.2

Intangible assets, net

Charlotte, NC 28201-1303

Internal Revenue

CHECK AMOUNT

Internal Revenue Service

CHECK DATE

Internal Revenue Service Form 1040-V Payment Voucher G Use this voucher when making a payment with Form 1040.

4160International

Check the background of E*TRADE Securities LLC on FINRA's BrokerCheck and see E*TRADE Securities LLC and E*TRADE Capital Management LLC Relationship Summary.

Invoice a

Check your balance and, if needed, make a deposit so there is enough money to bring your account above $0

Irregular Income/Expenses

Checks/Debits Presented for Posting on 04/26/22 (1)

Is this an electronic copy of an official filing submitted in paper format?

Child tax credit

Issued : Apr 14th. 2022

CIK (Filer ID Number)

It is important to make a deposit as soon as possible.

Cincinnati, OH 45280-2501

Item A.2. Information about the Series.

City

ITEM RETURNED - ACCOUNT CHARGE

City or town, state or province, country, and ZIP or foreign postal code

Last Name WOOD Street Address 1

CITY STATE ZIP

Life Insurance

Clarification of Response (if Necessary):

Loan Amt Paid 840.00

Class (Contract) ID

Long-lived assets

Class A and Class B common stock, and Class C capital stock and additional paid-in capital, $0.001 par value per share: 15,000,000 shares authorized (Class A 9,000,000, Class B 3,000,000, Class C 3,000,000); 688,335 (Class A 299,828, Class B 46,441, Class C 342,066) and 675,222 (Class A 300,730, Class B 45,843, Class C 328,649) shares issued and outstanding

Louisville, KY 40293-1000

CO. FILE DEPT. CLOCK NUMBER

Marketable securities

4735Medicare Tax

Commitments and Contingencies (Note 10)

Minnesota, Missouri, New Hampshire, New Jersey, New York,

CONSOLIDATED BALANCE SHEETS - USD ($) $ in Millions

MOUNTAIN VIEW

Convertible preferred stock, $0.001 par value per share, 100,000 shares authorized; no shares issued and outstanding

Name

Convertible preferred stock, par value (in dollars per share)

necesita servicio en espanol, llame al 1-877-BUS-BNKG (1-877-287-2654) y oprima el 8.

Convertible preferred stock, shares authorized (in shares)

70842736146

Convertible preferred stock, shares issued (in shares)

70842743866

Convertible preferred stock, shares outstanding (in shares)

75698871600Copy A1.49E+12

Excess Tax Benefit from Stock-Based Compensation, Non-Cash Adjustment

Net Pa􀀩

Costs and expenses:

Non-marketable investments

Credit for other dependents

Note to customer

Current

NOTE: The maximum number of paid or returned items PNC will charge on a business day is 4. The remainder

Current assets:

Notification Information

current General

NOT-NEGOTIABLE

Current liabilities:

NPORT-P: Part A: General Information

d. LEI of Registrant

NY SUI/SDI Tax

Dakota, Ohio, Oregon, Pennsylvania, South Dakota, Utah,

of the items, if any, will be paid or returned with no charge.

DALLAS TX 75235

Oklahoma, Rhode Island, Vermont, Virginia, West Virginia,

DALLAS TX 75235-8313

One Trillion Four Hundred Eighty Five Billion Fiftey SixMillion One Hundred Fiftey Five Thousand Five Four Hundred

DALLAS, TX 75235

opt-in or opt-out choice at any time. To learn more about PNC Overdraft Solutions, visit us online at

DALLAS, TX 75235-8314

or FPO address, or file Form 2555 or 4563, or are a dual-status alien

Dateorder of:

DATE APR 27, 2022

Other Adjustments to Net Income Available to Common Stockholders

Date Paid : 2022-04-18

Other current assets

Date Paid : 4/11/2022

Pay Date: 04/18/2022

Deducted#barcodeDeductions$

Deferred income taxes

$

Deferred revenue

Overdraft Protection has not been established for this account. Please contact us if you would like to set

Deferred revenue, non-current

overdrawn.

Department of the Treasury

Overtll ne

Department of the Treasury - Internal Revenue Service

P.O. Box 1214

Department of the Treasury Calendar Year ' Internal Revenue Service Due

P.O. Box 8025018853.6PAGE 1 of 216640

Paid to the order of.

23526.8

PARTICIPATION.

Description Transaction Amount Amount Added/

Pay Date:0.455555556Pay to the

Sales of Other Non-Current Assets

PAYER’S name, street address, city or town, state or province, country, ZIP

Diluted EPS from Discontinued Operations

PAYER'S name, street address, city or town, state or foreign postal code, and telephone no.

39647

payment due to insufficient funds.

Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)

Payments for Common Stock

39654PAYSTUB-1.74E+12Period ending:Direct Deposit:

Please adjust your records by the amount of this charge.

Discontinued Operations

pnc.com/bankwisely or read the fee schedule for your specific account at pnc.com. Current fee schedules for

do immediately:%%EOF

Do Not Cut or Separate Forms on This Page — Do Not Cut or Separate Forms on This Page

PO BOX 1300,

do to avoid this in the

Price Par Share

DRIVE SOON AND LOOK FORWARD TO YOUR

(keep for

Due : Feb 13, 2022

Qualified dividends ...

e. Address and telephone number of Registrant.

rate hoursEarnings

Realized Gain Supplment Payable

Earnings Statement

RECIPIENT’S name

39814Reduction Act

EFFECTIVE THIS PAY PERIOD YOUR REGULAR

refunds, credits, or offsets

E-Mail AddressRelationship:

Employee Id: 9999999999

Rental Income, Revenue

Employee Info

Reported Normalized and Operating Income/Expense Supplemental Section

Esta carta contiene informacion importante sobre su cuenta. Si tiene ' alguna pregunta sobre esta carta o

Reported Normalized Income

1

Research and development

Basic EPS from Discontinued Operations

Returns.

Excess Tax Benefit from Stock-Based Compensation, Non-Cash Adjustment

REV 04/09/22 INTUIT.CG.CFP.SP 1555

Excluded from federal taxable wages

Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction [Line Items]

excluding income under Internal Revenue Code 933), or use an APO

Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction, Start Date [Axis]: 2023-01-01

Exemptions/A llowances:

Revenues from External Customers and Long-Lived Assets [Line Items]

Expected timing of revenue recognition

Routing no. 071921891

Expected timing of revenue recognition, percent

.!:F.I.C.A.SAMPLEF.I.T,

SEC Schedule, 12-09, Movement in Valuation Allowances and Reserves [Roll Forward]

-99Series IDfax.

settings, call 1-877-588-3605, visit any branch, or sign on to PNC Online Banking, and select the

2Shipping

Fees and Commission Income

Social Security 633-44-1725

Irregular Income/Expenses

Social Security No.

-40.6

Social Security Number: 999-99-9999

3-6.5613.5

State, if applicable

Federal Income Tax

Statement of Financial Condition | About Asset Protection | Account Agreements and Disclosures | Quarterly 606 Report | Business Continuity Plan | About Our Ads | Disclosure Library

Rental Income, Revenue

Stock Plan

Federal: 3, $25 Additional Tax

Stockholders’ equity:

Fees and Commission Income

Street Address 1

FICA - Social Security

Street Address 1

File only if you are making a payment of estimated tax by check or money order. Mail this Amount of estimated tax voucher with your check or money order payable to the 'United States Treasury.' Write your

STREET ADDRESS CITY STATE ZIP

File with Form 1096.

SubtotalFiler CCC

System response and account access times may vary due to a variety of factors, including trading volumes,

Filer CIK

Taxable Marital Status: Married

Filer Investment Company Type

Taxes / Deductions

-5.94

Telephone number

Zachry Tyler Wood

The Company and its directors and certain of its executive officers may be considered participants in the solicitation of proxies with respect to the proposals under the Definitive Proxy Statement under the rules of the SEC. Additional information regarding the participants in the proxy solicitations and a description of their direct and indirect interests, by security holdings or otherwise, also will be included in the Definitive Proxy Statement and other relevant materials to be filed with the SEC when they become available.

zachryiixixiiwood@gmail.com

the end of the day. At the end of each business day, we add the money that went into your account before

#NAME?

The Securities and Exchange Commission has not necessarily reviewed the information in this filing and has not determined if it is accurate and complete, The reader should not assume that the information is accurate and complete,

For calendar year

This amount: TWO HUNDRED NINETY-ONE AND 90/100 DOLLARS

43072this period

For Paperwork Reduction Act Notice, see the seperate Instructions.

Title OperatorFor Privacy Act

TO PAY YOUR TAXES DUE BY CHECK, MAIL THIS FORM TO THE ADDRESS LISTED BELOW.

for the transaction details. Your account may be subject to a fee each time we pay a transaction or decline a

total

Foreign country, if applicable

TOTAL $44226

Total cash, cash equivalents, and marketable securities

Form 1040-ES Payment Voucher

£0.00Form 1040-V

Total current liabilities

Form 1040-V Page 2

Total liabilities and stockholders’ equity

Form 1099-G£􀀆,􀀆8£􀀇03

Form 1099-G (Rev. 1-2022) www.irs.gov/Form1099G

■Form 1099-NEC

Total stockholders’ equity

future:

trade or business

G Do not staple this voucher or your payment to Form 1040.

Transaction price allocated to remaining performance obligations

G Make your check or money order payable to the 'United States Treasury.' Enter the amount G Write your social security number (SSN) on your check or money order. of your payment. . . . . . . . . G

U.S. SECURITIES AND EXCHANGE COMMISSION

44669

United States Department of The Treasury

Reported Normalized and Operating Income/Expense Supplemental Section

up this service.GoodwillUSD in "000'"s-30VOID

GOOGL_income-statement_Quarterly_As_Originally_Reported

Wages, salaries, tips, etc. Attach Form(s) W-2 ................

Government

Washington, Wyoming

44678

WE WILL BE STARTING OUR UNITED WAY FUND

- 28.85*

We're here to help. If you have any questions or need assistance, please visit your local PNC Branch or contact

Gross Pay_________________________________

WOOD ZACHRYGross Pa􀀩year to date1652044

Your federal wages this period are $386.15

Group Term Life 0.51 27.00

YTD

have questions or

● Learn more about fees and how to avoid them by visiting "Making the Most of your Money" at

Here are the transactions that led to your overdraft:

ZACHRY T WOOD

Here are your current

Here’s how you

Zip / Postal Code

Fiscal year ends in Dec 31 | USD

For

Fiscal year end September 28th., 2022. | USD

Issuance of/Repayments for Debt, Net

Issuance of/Repayments for Long Term Debt, Net

Income from Associates, Joint Ventures and Other Participating Interests

Income from Associates, Joint Ventures and Other Participating Interests

Charitable contributions if you take the standard deduction (see instructions)

Proceeds from Issuance of Common Stock

13

Taxes, Non-Cash Adjustment

Change in Cash

Interest Paid, Supplemental

Gain/Loss on Foreign Exchange

Qualified business income deduction from Form 8995 or Form 8995-A .........

Change in Deferred Assets/Liabilities

Gain/Loss on Financial Instruments, Non-Cash Adjustment

Net Investment Income/Loss, Non-Cash Adjustment

Net Investment Income/Loss, Non-Cash Adjustment

Effect of Exchange Rate Changes

Non-Operating Income/Expenses, Total

Change in Cash as Reported, Supplemental

Issuance of/Repayments for Debt, Net

Gain/Loss on Disposals, Non-Cash Adjustment

Irregular Income/Loss, Non-Cash Adjustment

Gain/Loss on Disposal/Sale of Business, Non-Cash Adjustment

Gain/Loss on Disposal/Sale of Business, Non-Cash Adjustment

Irregular Income/Loss, Non-Cash Adjustment

Gain/Loss on Disposals, Non-Cash Adjustment

Non-Controlling/Minority Interests

Gain/Loss on Investments and Other Financial Instruments

Net Investment Income

Change in Trade/Accounts Receivable

Change in Trade and Other Receivables

Proceeds from Issuance/Exercising of Stock Options/Warrants

Cash Flow from Continuing Financing Activities

Change in Other Current Assets

Taxes, Non-Cash Adjustment

Proceeds from Issuance/Exercising of Stock Options/Warrants

Net Interest Income/Expense

Interest Expense Net of Capitalized Interest

Total Net Finance Income/Expense

Purchase/Sale of Business, Net

Investment Income/Loss, Non-Cash Adjustment

Gain/Loss on Financial Instruments, Non-Cash Adjustment

Purchase/Sale of Business, Net

Purchase/Acquisition of Business

Income Tax Paid, Supplemental

General and Administrative Expenses

Change in Trade and Other Receivables

Change in Trade/Accounts Receivable

Purchase/Acquisition of Business

Purchase/Sale of Investments, Net

Other Underwriting Expenses

100% Security Guaranteed

Net Interest Income/Expense

Total Net Finance Income/Expense

Interest Expense Net of Capitalized Interest

• Head of household, $18,800

Purchase/Sale and Disposal of Property, Plant and Equipment, Net

Purchase of Property, Plant and Equipment

Repayments for Long Term Debt

B

Research and Development Expenses

Selling and Marketing Expenses

Selling, General and Administrative Expenses

• Married filing jointly or Qualifying widow(er), $25,100

• If you checked any box under Standard Deduction, see instructions.

Standard Deduction for—

Purchase/Sale of Investments, Net

Cash Flow from Continuing Investing Activities

Other Underwriting Expenses

Purchase/Sale and Disposal of Property, Plant and Equipment, Net

Issuance of/Payments for Common Stock, Net

Cash Flow from Continuing Financing Activities

Repayments for Long Term Debt

Operating Income/Expenses

• Single or Married filing separately, $12,550

Sales of Other Non-Current Assets

Policyholder Future Benefits and Claims, Net

Benefits,Claims and Loss Adjustment Expense, Net

Purchase of Property, Plant and Equipment

Provision for Income Tax

Cash Flow from Financing Activities

Cost of Goods and Services

Cost of Revenue

Cash Flow from Continuing Investing Activities

Selling and Marketing Expenses

Selling, General and Administrative Expenses

Purchase of Investments

Subtract line 10 from line 9. This is your adjusted gross income .........

11

Cash Flow from Investing Activities

Benefits,Claims and Loss Adjustment Expense, Net

Policyholder Future Benefits and Claims, Net

Other Income/Expenses

Purchase of Investments

Other Income/Expenses

Total ExpensesGrand Total

Federal 941 Deposit Report ADP Report Range5/4/2022 - 6/4/2022

EIN:

Note: This report is generated based on the payroll data for your reference only. Please contact IRS office for special cases such as late payment, previous overpayment, penalty and others. Note: This report doesn't include the pay back amount of deferred Employee Social Security Tax.

Employer Customized Report ADP Report Range5/4/2022 - 6/4/2022

EIN:

Customized Report

Employee Number: 3 Description

Wages, Tips and Other Compensation

Taxable SS Wages

Taxable SS Tips

Taxable Medicare Wages

Advanced EIC Payment

Federal Income Tax Withheld

Employee SS Tax Withheld

Employee Medicare Tax Withheld

State Income Tax Withheld

Local Income Tax Withheld Customized Employer Tax Report

Description

Employer SS Tax Employer Medicare Tax

Federal Unemployment Tax

State Unemployment Tax

Customized Deduction Report

Health Insurance401K

SHAREHOLDERS ARE URGED TO READ THE DEFINITIVE PROXY STATEMENT AND ANY OTHER RELEVANT MATERIALS THAT THE COMPANY WILL FILE WITH THE SEC CAREFULLY IN THEIR ENTIRETY WHEN THEY BECOME AVAILABLE. SUCH DOCUMENTS WILL CONTAIN IMPORTANT INFORMATION ABOUT THE COMPANY AND ITS DIRECTORS, OFFICERS AND AFFILIATES. INFORMATION REGARDING THE INTERESTS OF CERTAIN OF THE COMPANY’S DIRECTORS, OFFICERS AND AFFILIATES WILL BE AVAILABLE IN THE DEFINITIVE PROXY STATEMENT.

The Definitive Proxy Statement and any other relev8.ant materials that will be filed with the SEC will be available free of charge at the SEC’s website at www.sec.gov. In addition, the Definitive Proxy Statement (when available) and other relevant documents will also be available, without charge, by directing a request by mail to Attn: Investor Relations, Alphabet Inc., 1600 Amphitheatre Parkway, Mountain View, California, 94043 or by contacting investor-relations@abc.xyz. The Definitive Proxy Statement and other relevant documents will also be available on the Company’s Investor Relations website at https://abc.xyz/investor/other/annual-meeting/.

The Company and its directors and certain of its executive officers may be consideredno participants in the solicitation of proxies with respect to the proposals under the Definitive Proxy Statement under the rules of the SEC. Additional information regarding the participants in the proxy solicitations and a description of their direct and indirect interests, by security holdings or otherwise, also will be included in the Definitive Proxy Statement and other relevant materials to be filed with the SEC when they become available.

3/6/2022 at 6:37 PM

GOOGL_income-statement_Quarterly_As_Originally_Reported

Cash Flow from Operating Activities, Indirect

Net Cash Flow from Continuing Operating Activities, Indirect

Cash Generated from Operating Activities

Income/Loss before Non-Cash Adjustment

Total Adjustments for Non-Cash Items

Depreciation, Amortization and Depletion, Non-Cash Adjustment

Depreciation and Amortization, Non-Cash Adjustment

Depreciation, Non-Cash Adjustment

Amortization, Non-Cash Adjustment

Stock-Based Compensation, Non-Cash Adjustment

Taxes, Non-Cash Adjustment

Investment Income/Loss, Non-Cash Adjustment

Gain/Loss on Financial Instruments, Non-Cash Adjustment

Other Non-Cash Items

Changes in Operating Capital

Change in Trade and Other Receivables

Change in Trade/Accounts Receivable

Change in Other Current Assets

Change in Payables and Accrued Expenses

Change in Trade and Other Payables

Change in Trade/Accounts Payable

Change in Accrued Expenses

Change in Deferred Assets/Liabilities

Change in Other Operating Capital

Change in Prepayments and Deposits

Cash Flow from Investing Activities

Cash Flow from Continuing Investing Activities

Purchase/Sale and Disposal of Property, Plant and Equipment, Net

Purchase of Property, Plant and Equipment

Sale and Disposal of Property, Plant and Equipment

Purchase/Sale of Business, Net

Purchase/Acquisition of Business

Purchase/Sale of Investments, Net

Purchase of Investments

Sale of Investments

Other Investing Cash Flow

Purchase/Sale of Other Non-Current Assets, Net

Sales of Other Non-Current Assets

Cash Flow from Financing Activities

Cash Flow from Continuing Financing Activities

Issuance of/Payments for Common Stock, Net

Payments for Common Stock

Proceeds from Issuance of Common Stock

Issuance of/Repayments for Debt, Net

Issuance of/Repayments for Long Term Debt, Net

Proceeds from Issuance of Long Term Debt

Repayments for Long Term Debt

Proceeds from Issuance/Exercising of Stock Options/Warrants

Other Financing Cash Flow

Cash and Cash Equivalents, End of Period

Change in Cash

Effect of Exchange Rate Changes

Cash and Cash Equivalents, Beginning of Period

Cash Flow Supplemental Section

Change in Cash as Reported, Supplemental

Income Tax Paid, Supplemental

ZACHRY T WOOD

Cash and Cash Equivalents, Beginning of Period

Department of the Treasury

Internal Revenue Service

Calendar YearDue: 04/18/2022USD in "000'"s

Repayments for Long Term Debt

Costs and expenses:

Cost of revenues

Research and development

Sales and marketing

General and administrative

European Commission fines

Total costs and expenses

Income from operations

Other income (expense), net

Income before income taxes

Provision for income taxes

Net income

*include interest paid, capital obligation, and underweighting

Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)

Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)

*include interest paid, capital obligation, and underweighting

Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)

Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)

INTERNAL REVENUE SERVICE,

PO BOX 1214,

CHARLOTTE, NC 28201-1214

ZACHRY WOOD15

For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions.

Cat. No. 11320B

Form 1040 (2021)

Reported Normalized and Operating Income/Expense Supplemental Section

Total Revenue as Reported, Supplemental

Total Operating Profit/Loss as Reported, Supplemental

Reported Effective Tax Rate

Reported Normalized Income

Reported Normalized Operating Profit

Other Adjustments to Net Income Available to Common Stockholders

Discontinued Operations

Basic EPS

Basic EPS from Continuing Operations

Basic EPS from Discontinued Operations

Diluted EPS

Diluted EPS from Continuing Operations

Diluted EPS from Discontinued Operations

Basic Weighted Average Shares Outstanding

Diluted Weighted Average Shares Outstanding

Reported Normalized Diluted EPS

Basic EPSDiluted EPSBasic WASODiluted WASO

Fiscal year end September 28th., 2022. | USD

For Paperwork Reduction Act Notice, see the seperate Instructions.

important information

2012201320142015ZACHRY T. 5323 $2,012$2,013$2,014$2,015DALLAS Other Benefits and Information Pto Balance 9xygchr6$13Earnings Statement 065-0001 ALPHABET Period Beginning: 1600 AMPITHEATRE PARKWAY DRPeriod Ending: MOUNTAIN VIEW, C.A., 94043Pay Date: 2965 Taxable Marital Status: Exemptions/AllowancesMarried BRADFORD DR Federal: TX:NO State Income Tax rateunitsthis periodyear to date $112$674,678,000$75,698,871,600$141,685,487,7329/29/2021 9/28/2022 Statutory 1/29/2023 Federal Income Tax$141,685,487,732 Social Security Tax$70,842,743,866$141,685,487,732 Medicare Tax WOOD Net Pay$70,842,743,866 CHECKING TX 75235-8314 Net Check$70,842,743,866 Your federal taxable wages this period are $$0 1 Alphabet Inc., co. 1600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 Deposited to the account Of: ZACHRY T. WOOD 4720416547 650001 719218914/18/2022 4720416547 transit ABA 15-51\000 575A "

Business Checking For 24-hour account information, sign on to

pnc.com/mybusiness/ Business Checking Account number: 47-2041-6547 - continued

Activity Detail

Deposits and Other Additions

ACH AdditionsDate posted27-Apr

Checks and Other Deductions

DeductionsDate posted26-Apr

Service Charges and Fees

Date posted27-Apr

Detail of Services Used During Current Period

Note: The total charge for the following services will be posted to your account on 05/02/2022 and will appear on your next statement a Charge Period Ending 04/29/2022,

Description

Account Maintenance Charge

Total For Services Used This Peiiod

Total Service (harge

Reviewing Your Statement

Please review this statement carefully and reconcile it with your records. Call the telephone number on the upper right side of the first page of this statement if: you have any questions regarding your account(s); your name or address is incorrect; • you have any questions regarding interest paid to an interest-bearing account.

Balancing Your Account Update Your Account Register

We will investigate your complaint and will correct any error promptly, If we take longer than 10 business days, we will provisionally credit your account for the amount you think is in error, so that you will have use of the money during the time it ekes us to complete our investigation.

Member FDIC

Alphabet Inc. 10-K Feb. 1, 2022 9:08 PM u

Transfers between Larry Page and Sergey Brill, Google's co-founders, subject amended (as described below).

Transfers for tax and estate planning purposes, including to trusts, corporation", and pnrfncr%hipe ootabliøhed Common Stock.

In addition, partnerships or limited liability companies that held more than 5% of the total out8tanding shares of (0'„14%3 B Common Stock ao Of the cJ03ing ofGoogle's initial public offering in 2004 may distribute their shares of Class 13 Common Stock to their respectivc partners or members (who may further digtribute the shares of Class B Common Stock to their I-espective partners or members) without triggering a conversion to bharcs of CJ"%% A Common Stock, Sto;h distributions must be

conducted in accordance with the ownership interests of such partners or members and the terms of' any agreernent8 binding the partnership

The death of any holder of shares of Class B Common Stock who is a natural person will result in the conversion of bio

shares held by his or her permitted entities, into shares of Class A Common Stock, However, subject to the terrng of the Transfer P.e%triction Agreements, either of Larry or Sergey may transfer voting control of his shares of Class B Common Stock and those held by hig permitted entities to the other contingent or effective upon bil death

without triggering a conversion into shares of Class A Common Stock, but the shares of Class B Common Stock nine months after the death of the transferring founder.

Once transferred and converted into shares of Class A Common Stock, shares of Class B Common Stock shall not be reissued. No class of our capital stock may be subdivided or combined unless the other classes of capital stock are concurrently subdivided or combined in the same proportion and in the same manner. Equal Status

Except as expressly provided in our Certificate of Incorporation, shares of Class A Common Stock and Class B Common Stock have the

rank equally, share ratably and are identical in all respects as to all matters. In the event of any merger, consolidation, or other business combination requiring the approval of our stockholders entitled to vote thereon (whether or not we are the surviving entity), the holders of shares of Class A Common Stock shall have the right to

receive, or the right to elect to receive, the same form of consideration

Stock shall have the right to receive, or the right to elect to receive, at least the same amount of consideration on a per share basis as the holders of shares of Class B Common Stock. In the event of any (1) tender or exchange offer to acquire any shares of Class A Common Stock or Class B Common Stock by any third party pursuant to an agreement to which we are a party, or (2) any tender or exchange offer by us to acquire any shares of Class A Common Stock or Class B Common Stock, the

holders of shares of Class A Common Stock shall have the right to receive,

Class B Common Stock, and the holders of shares of Class A Common Stock shall have the right to receive, or the right to elect to receive, at least the same amount of consideration on a per share basis as the holders of shares of Class B Common Stock, Except as expressly provided in our Certificate of Incorporation, shares of Class C Capital Stock have thc same rights and privileges and rank equally, share ratably and are identical in all respects to the shares of Class A Common Stock and Class B Common Stock as to all matters, In the event of any merger, cong)lidation, or other business combination requiring the approval of our stockholders entitled to vote thereon (whether or not we are the surviving entity), the holders ofshares of Class C Capital Stock shall receive the same amount and form of

3

Offsettirv of O•ri—ii The grossnno.ntg of derivative ineruments subjee (in millions):

Offset/ng of Asmt•

Derivatives $aossDai'vatN./éS $0) The bddnces

Offseülng ofLHb"itiS

Derivatives $Derivatives $

(2) The balances as ofDecember 31,2020 and 2021 were related to derivatve allc»eed apne

assetswhieh are to be ne seded Note 4. Leases

•te have entered into operating lease agreements primarily for data centers, land and ooces troughout the world witn Components of peating lease expense were as follows (in millions): Year Ended December 31,

OpeaUng lease coe

Variable lease cod

GOOG NASDAQ

GOOG ALPHABET INC CAP STK CL C

$2,808.301,20Google Ads

Bandini Blvd, Bell, CA 90201-6407 *Terms and conditions for this offer.

1

2. Offer available only to advertisers which are new to Google Ads, with a billing address in the United States. One p•crcticnal code per advertiser.

3* TO activate this Offer. Enter the promotional code in your first Google Ads account. You must enter the code within 14 days of ycur first ad impression being served from your first Google Ads account. 4. To earn the Google Ads credit After entering the promotional code in your Google Ads account, your advertising campaigns must accrue costs Of at least $500, (excluding any taxes or applicable fees), Y.'ithin 60 days. Making a payment of $500 is not sufficient. The tracking of advertising costs towards $500 begins after youfve entered the promotional code.

5

The credit expires 60 days after it is applied to your account. Credit applies to future advertising costs only. Credit cannot be applied to costs ecceued before the promotional code ',vas entered in your Google Ads account.

8. You won't receive a notification once credit in ycur Google Ads account is used up end

continue advertising, you can pause or delete your campaigns

9. Your account must be successfully billed by Google Ade end

10. Full terms and conditions can be found here: google.ccrn/ads!couponsiterns

V'!e have made this mailing environmentally friend!y by using pcst-ccnsvrer recycled paper and pd.neril•y soy-certified inks, but if you would like to no longer receive direct mail ircm Google Ads, please visit: g.co/ads/ncdm-en E02548934M-US IH WK 220406

US2 00152106.93%@ITRADE

0( Account Transfer Confirmation: Transfer Agent, Full

590 1

E*TRADE Acco•nt Information Offe Account Type: INDIVIDUAL Offe To a Account Title: ZACHRY T WOOD SR GOO(

To e; taxe Account Number: 52645331 prom Once / Transfer Instruction and

hereby instruct the delivering institution as follows: To Delivering Firm: Please transfer assets from my account a@g@E*TRADE Securities LLC, (together with its affiliates, E*TRADE"), as indicated in the account transfer form. understand that if assets in my account are not readily rhe cr• transferable (with or without penalties), such assets may not be transferred within the time frames required by FINRA Rule hedit 11870 or comparable rule of another securities industry self-regulatory organization. authorize you to liquidate assets in :ontinl"

our at my account as necessary to satisfy outstanding fees due to you. Unless 1.111 ten

le Ad:

1521 good deliverable form, including affixing any necessary tax waivers, to enable E*TRADE to transfer them in my account in

in its name for the purpose of sale, when and as directed by me.

instruction , you will cancel all open orders for my account on your books. For Full Account Transfer: affirm that 1 have returned to you or destroyed any credit/debit cards and/or unused checks issued to me in connection with the account am transferring. understand that, except in the case of my nontransferable proprietary mutual fund shares that you may liquidate without further instruction from me, you may need to contact me with respect to the disposition of any assets in my securities account that are nontransferable.

AssetsSecurity SymbdBRKBTRADE

To Delivering Firm øE*TRADE: By signing below,

bound by the terms and conditions of this Transfer Instruction and Authorization.

have provided above is true and accurate. further authorize E*TRADE to share information about me with the financial

institution from which

thereof.

Your Reference number for this transfer request is 22131261103881

Google Ads 5 590 Bandini Blvd, Bell, CA 90201-6407 Terms and conditions for this offer. 1. Offer available only while supplies fast. Google Ads account. promotional code.

1521024793 ******H*****AUTO**ALL FOR AADC 75215210 Morningstar.com Inc. 5323 Bradford Dr Dallas, TX 75235-8314 Illllllllllllllll„lllllllllll„llrllllll,llllllllllllllllllllll The credit expires 60 days after it is applied to your account. Credit applies to future advertising costs only. Credit cannot be apzlied to costs zccnued befc-e ne pronot;,onel code was entered in your Google Ads account.

8. You won't receive a notification once credit in your Google Ads

9

10. Full terms and conditions can be found here: google.corn/adsfcouponsiten-ns V'!e have made this mailing environmentally friendly by using post-consumer recycled peps and pri-nerily soy-cetif:ed inks, but if you would like to no longer receive direct mail from Google Ads, please visit: g.co/ads/ncdm-en

US20015210

tified Copy of Resolutions/ thorizations For Accounts And Loans

porations, Partnerships, Unincorporated Associations, Sole Proprietorships & Other Organizations)

PNC Bank, National Association ("Bank')

Customer NameResolutions:123OWNER

The Bank may accept, pay and/or apply any check, draft, charge, instrument or other order for the payment of money drawn on such accounts, or payable to the Customer that has been endorsed by any of the authorized signatories listed, or perform any transfer Of funds, and any or all of such actions may be done: without regard to the application of the same

(ii) (iii) RDAOBM06-0518

(IRS USE ONLY) 575Ä

Return this part with any correspondence

so we may identify your account.

correct any errors in your name or address .

Your Telephone Number

(

INTERNAL REVENUE SERVICE

CINCINNATI

1,111,111.1.1„1,1„1,1„11'i'11

(IRS USE ONLY)

We assigned you a tax classification (corporation, partnership, etc.) based on

information obtained from you or your representative.

of your tax classification, and is not binding on the IRS.

determination of your tax classification, you may request a private letter ruling from the IRS under the guidelines in Revenue Procedure 2020-1, 2020-1 1. R. B. 1 (or

superseding Revenue Procedure for the year at issue) .

elections can be requested by filing Form 8832, Entity Classification Election. See Form 8832 and its instructions for additional information. IMPORTANT INFORMATION FOR S CORPORATION ELECTION: If you intend to elect to file your return as a small business corporation, an election to file a Forrn 1120-S, U.S. Income Tax Return for an S Corporation, must be made within certain timeframes and the corporation must meet certain tests. All of this information is included in the instructions for Form 2553, Election by a Small Business Corporation. A limited liability company (LLC) may file Form 8832, Entity Classification

Election, and elect to be classified as an association taxable as a corporation.

the LLC is eligible to be treated as a corporation that meets certain tests and it will be electing S corporation status, it must timely file Form 2553, Election by

Small Business Corporation.

effective date of the S corporation election and does not need to file Form 8832. If you are required to deposit for employment taxes (Forms 941, 943, 940, 944, 945, CT-I, or 1042) , excise taxes (Form 720) , or income taxes (Form 1120) , you will receive a Welcome Package shortly, which includes instructions for making your deposits

electronically through the Electronic Federal Tax Payment System (EFTPS) .

Identification Number (PIN) for EFTPS will also be sent to you under separate cover . Please activate the PIN once you receive it, even if you have requested the services of a

tax professional or representative.

Publication 966, Electronic Choices to Pay All Your Federal Taxes.

make a deposit immediately, you will need to make arrangements with your Financial Institution to complete a wire transfer. The IRS is coonitted to helping all taxpayers comply with their tax filing

obligations .

Authorized e-file Providers, such as Reporting Agents or other payroll service providers, are available to assist you. Visit verww. irs .gov/mefbusproviders for a

(iv) (v)45678

Executed this date of April 13, 2022 RDAOBM06-0518

nt-tés•:r

WARNING; THIS DOCUMENt HAS secukftv•uvunzs

Estimate No#: 0014

Estimate Date: Jun 6, 2022 Reference: File Number. 368581-659950

BILL TO Yelen

Washington's DC, 1500 Pennsylvania Ave NW 23rd #117, NJ 20249, UNITED STATES fsinternet@fiscsl.treasury.direct.gov

#12 3456

Morningstar.com My View 2 View Print Report

Portfolio Name

Earnings Calendar

633-44-1725 Zachry Tyler Wood Mr. Joseph A. Parascandola

Direxion Dly S&P Oil&Gs Ex&P

Aphabet Inc Class A

Alphabet Inc Cass A

AVhabet inc Class A

Alphabet Inc Cass A

Alphabet Inc Class A

Alphabet inc Class A

Aphabet Inc Class A

Inc Cass A

Alphabet Inc Cass A

Inc Class A

Aphabet Inc Ciass A

Aphabet Inc Class A

Gret Brn Capital Corp

Business Revenue

Net IncomeGross ProfitPretax Income

Total Operatong Prpfit/Loss

Net Income Available to C

Net Income From Continuing Operations

11 0 00 308 1 3011 1

OS Received 01/24/2022

Reviewing Your Statement Please review this statement carefully and reconcile it with your records. Call the telephone number on the upper right @PNCBANKside of the first page of this statement if: you have any questions regarding your account(s); your name or address is incorrect; you have any questions regarding interest paid to an interest-bearing account.

Balancing Your Account

Update Your Account Register Compare: The activity detail

Check Off: Add to Your Account Register Balance: Subtract From Your Account Register Balance:

Update Your Statement Information

Step 1:

Add together deposits and other additions listed in your account register but not on your statement. Step 3:

Enter the ending balance recorded on your statementTotal A + $

Add deposits and other additions not recorded

$

The result should equal your account register balance

haw ¯4VUt If

Business Checking PNC Bank the period

146967

ZACHRY TYLER WOOD ALPHABET 5323 BRADFORD DR DALLAS TX 75235-8314

111111111 1 1 1 1 1 1 11 1 1 1 11 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 111 1 1 1 1 •l 1 1 1 1 1 1 1 1 1 1 1 1

a

IMPORTANT INFORMATION FOR BUSINESS DEPOSIT CUSTOMERS

Effective February 18,2022, PNC will be temporarily waiving fees for stetement, check image, deposit ticket and deposited item copy

requests until further notice. Statement, check image, deposit ticket and ceposited item requests will continue to these be displayed fees. in the Details of Services Used section of your monthly statement. We will notify you viE statement message prior to reinstating If you have anv questions, you may reach out to your business banker, franch or call us at 1-877-BUS-BNKG (1-877-287-2654).

Business Checking Summary Account number: 47-2041-6547 Overdraft Protection has not been established for this account. Please contact us if you would like to set up this service.

Balance Summary

Beginning balance

0

Overdraft and Returned Item Fee Summary

Total Returned Item Fees (NSF)

Deposits and Other Additions

DescriptionACH AdditionsTotalDaily BalanceDate13-Apr

jobs: autoupdate: name: autoupdate runs-on: ubuntu-18.04 steps: - uses: docker://chinthakagodawita/autoupdate-action:vl

#ERROR!#ERROR!

.../.github/CODEOWNErs8 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git

Balancing Your Account

Update Your Account Register Compare: Check Off: Add to Your Account Register Balance: Subtract From Your Account Register Balance:

Update Your Statement Information

Step 1:

Add together deposits and other additions listed in your account register but not on your statemen t. Step 3:

Enter the ending balance recorded on your statement

Add deposits and other additions not recorded

Subtract checks and other deductions not recorded Total B - $

The result should equal your account register balance

Business Checking For 24-hour account information, sign pnc.com/mybusin@ss/ Business Checking Account number: 47-2041-6547 - continuod

Activity Dotail

Deposits and Other Additions

ACH AdditionsDate posted00/27

Checks and Other Deductions

ACH DeductionsDate posted26-Apr

Servicø Charges and Fees

Date posted27-Apr

Detail of Services Used During Current Period

Vote: The total charge for the following services Will be posted to your account on 05/02/1022 and w barge Period Ending 04/29/2022,

•scription count Maintenance Charge tal For Se•vices Used This Period bal Service (barge

Verification of Direct Deposit

To verify whether 8 AM - a 5 direct PM ET deposit at the or customer other transfer service to number your account listed on has the occurred, upper right call us side Monday of the first - Friday: page of 7 AM this - statement.10 PM ET and Saturday & Sunday:

In Case of Errors or Questions About Your Electronic Transfers Telephone us at the customer service number listed on the upper right side of the first page of this statement or write us at PNC Bank Debit Card Services, 500 First Avenue, 4th Floor, Mailstop P7-PFSC-04-M' Pittsburgh, PA 15219 as soon as you can, if you think your statement60 or receipt is wrong or if you need more information about a transfer on the statement or receipt. We must hear from you no later than days after we sent you the FIRST statement on which the error or problem appeared. Tell us your name and account number (if any). Describe the error or the transfer you are unsure about, and explain as clearly as you can why you believe it is an error or why you need more information. Tell us the dollar amount of the suspected error. We will investigate your complaint and will correct any error promptly. If we take longer than 10 business days, we will provisionally credit your account for the amount you think is in error, so that you will have use of the money during the time it takes us to complete our investigation.

Member FDIC

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md index ec99f2668476..d127dcfd180c 100644 --- a/CONTRIBUTING.md +++ b/CONTRIBUTING.md @@ -1,4 +1,323 @@ -# Welcome to GitHub docs contributing guide <!-- omit in toc --> +# ## ###BEGIN +:ActionsScripts.yml : +#Welcome :to GitHub docs contributing guide <!-- omit in toc --> :: +Membership +Certificate Tax Audit +This Certificate IS PRESENTED FOR MAX TAX AUTID DEFENSE INDIVIDUAL FORM !)$) _ FEDERAL AND STATE AS OF 04/14/2022, the 2021 tax return associated with the purchase is protected by Tax Audit. This guarantees that - WE FACE THE IRS SO YOU DONT HAVE TO - Tax Audit will represent you through the completion of any income tax audit for the tax year identified on this membeship certificate during the period of member ship +<SIGN_form> Jake Sindt<sign_FORM> +Title: Cheif Executive Officer +SERVICE ID: 60600052 +PURCHASE DATE: 04/14/2022 +PRODUCT NAME: MAX TAX AUDIT DEFENSE INDIVIDUAL +EXPIRATION: WITH STATUTE OF LIMITATIONS FOR AUDIT. +limitations and member obligations are made part of this agreement at the time of issuance and are inluded with this certificate. +TURBOTAX FULL AUDIT REPRESENTATION MEMBERSHIP AGREEMENT +TaxResources, Inc., dba +INTERNAL REVENUE SERVICE PO BOX 1214 CHARLOTTE NC 28201-1214 EMPLOYEE-#9999999998 IRS-#88-1303491 Social Security-#633441725 1 BUSINESS' TAX IDENTIFICATION NUMBER: 633441725 ZACHRY T WOOD 5323 BRADFORD DR DALLAS, TX 7523 FIN: 61-1767919 Earnings EIN: 88-1303491 7567263607 WOOD ZACHRY Tax Period Total Social Security Medicare Withholding Fed 941 Corporate Sept-30, 2007. 66986.66 28841.48 6745.18 31400 Fed 941 West Subsidiary Sept-30, 2007. 17115.41 7369.14 1723.42 8022.85 Fed 941 South Subsidiary Sept-30, 2007. 23906.09 10292.9 2407.21 11205.98 Fed 941 East Subsidiary Sept-30, 2007. 11247.64 4842.74 1132.57 5272.33 Fed 941 Corp - Penalty Sept-30, 2007. 27198.5 11710.47 2738.73 12749.3 Fed 940 Annual Unemp - Corp Sept-30, 2007. 17028.05 PAY DATE: 2022-04-27 RETURNED FOR MISSING SIGNATURE OR INFORMATION REQUIRED TO COMPLETE RETURN SIGNATURE 6b 633441725 7 ZACHRY T WOOD Tax Period Total Social Security Medicare Wiages tips othernefits and regular information Capital gain or (loss). Attach Schedule D if required. If not required, check here .... Other income from Schedule 1, line 10 .................. 8 9 Add lines 1, 2b, 3b, 4b, 5b, 6b, 7, and 8. This is your total income ......... TTM Q4 2021 Q3 2021 Q22021 Q1 2021 Q4 2020 Q3 2020 Q2 2020 Q1 2020 Q4 2019 9 10 1.46698E+11 42337000000 37497000000 35653000000 31211000000 30818000000 25056000000 19744000000 22177000000 25055000000 ++Adjustments to income from Schedule 1, line 26 ............... 2.57637E+11 75325000000 65118000000 618800 00000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000 +++ 10 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 461730 +++ 00000 38297000000 41159000000 64133000000 +++ 11 +++ Subtract line 10 from line 9. This is your adjusted gross income ......... -5.79457E+11 -32988000000 -27621 +++ 000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000 -18982000000 -210 +++ 20000000 +++ 11 -1.10939E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000 +++ 000 -21117000000 -18553000000 -18982000000 -21020000000 +++ Standard Deduction for— -1.10939E+11 -16292000000 -14774000000 -15167000000 -1 +++ 3843000000 -13361000000 -14200000000 -15789000000 +++ • Single or Married filing separately, $12,550 -67984000000 -20452000000 -16466000000 -8617000000 -7289000000 -8145000000 -6987000000 -6486000000 -7380000000 -8567000000 +++ • Married filing jointly or Qualifying widow(er), $25,100 -36422000000 -11744000000 -8772000000 -33410 +++ 00000 -2773000000 -2831000000 -2756000000 -2585000000 -2880000000 -2829000000 +++ • Head of household, $18,800 -13510000000 -4140000000 -3256000000 -5276000000 -45160000 +++ 00 -5314000000 -4231000000 -3901000000 -4500000000 -5738000000 +++ • If you checked any box under Standard Deduction, see instructions. -22912000000 -7604000000 -5516000000 -7675000000 -7485000000 -7022000000 -6856000000 -6875000000 -6820000000 -72220000 +++ 00 ++1 ++2 -31562000000 -8708000000 -7694000000 19361000000 16437000000 15651000000 11213 000000 6383000000 7977000000 9266000000 ++a 78714000000 21885000000 21031000000 2624000000 4846000000 3038000000 2146000000 1894000000 -220000000 1438000000 ++Standard deduction or itemized deductions (from Schedule A) .. 12020000000 2517000000 2033000000 313000000 269000000 333000000 412000000 420000000 565000000 604000000 ++12a 1153000000 261000000 310000000 313000000 269000000 333000000 412000000 420000000 565000000 604000000 ++b 1153000000 261000000 310000000 ++Charitable contributions if you take the standard deduction (see instructions) -76000000 -76000000 -53000000 -48000000 -13000000 -21000000 -17000000 ++12b -346000000 -117000000 -77000000 389000000 345000000 386000000 460000000 433000000 586000000 621000000 ++ 1499000000 378000000 387000000 2924000000 4869000000 3530000000 1957000000 1696000000 -809000000 899000000 ++Add lines 12a and 12b .......................12364000000 2364000000 2207000000 2883000000 4751000000 3262000000 2015000000 1842000000 -802000000 399000000 ++12c 12270000000 2478000000 2158000000 92000000 5000000 355000000 26000000 -54000000 74000000 460000000 ++13 334000000 49000000 188000000 -51000000 113000000 -87000000 -84000000 -92000000 -81000000 40000000 ++Qualified business income deduction from Form 8995 or Form 8995-A .........-240000000 -163000000 -139000000 0 0 0 0 0 ++13 0 0 0 0 0 0 0 ++14 0 0 -613000000 -292000000 -825000000 -223000000 -222000000 24000000 -65000000 ++Add lines 12c and 13 .......................-1497000000 -108000000 -484000000 21985000000 21283000000 18689000000 13359000000 8277000000 7757000000 10704000000 1490734000000 24402000000 23064000000 -3460000000 -3353000000 -3462000000 -2112000000 -1318000000 -921000000 -3300000015 -14701000000 -3760000000 -4128000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 ++Taxable income. ++ 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 15 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 ++For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 ++Cat. No. 11320B 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 ++Form 1040 (2021) 76033000000 20642000000 18936000000 ++Reported Normalized and Operating Income/Expense Supplemental Section ++Total Revenue as Reported, Supplemental 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000 ++Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000 ++Reported Effective Tax Rate 0.162 0.179 0.157 0.158 0.158 0.159 0 ++Reported Normalized Income ++Reported Normalized Operating Profit ++Other Adjustments to Net Income Available to Common Stockholders ++Discontinued Operations ++Basic EPS 113.20 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 15.49 ++Basic EPS from Continuing Operations 112.20 31.12 28.44 27.69 26.63 22.46 16.55 10.21 9.96 15.47 ++Basic EPS from Discontinued Operations ++Diluted EPS 113.88 30.69 27.99 27.26 26.29 22.3 16.4 10.13 9.87 15.35 ++Diluted EPS from Continuing Operations 113.20 30.67 27.99 27.26 26.29 22.23 16.4 10.13 9.87 15.33 ++Diluted EPS from Discontinued Operations ++Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 ++Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 ++Reported Normalized Diluted EPS 9.87 ++Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 15.49 ++Basic Earnings Par Share 113.20 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 15.49 ++Diluted EPS 112.20 31.15 28.44 27.26 26.29 22.30 16 40 10.13 10.00 15.35 ++Diluted Earnings Par Share 112.20 30.69 27.99 27.26 26.29 22.30 16.40 10.13 9.87 15.35 ++Basic WASO 667650000.00 662664000.00 665758000.00 668958000.00 673220000.00 675581000.00 679449000.00 681768000.00 686465000.00 688804000.00 ++Basic Weighted Average Shares Outstanding 667650000.00 662664000.00 665758000.00 668958000.00 673220000.00 675581000.00 679449000.00 681768000.00 686465000.00 688804000.00 ++Diluted WASO 677674000.00 672493000.00 676519000.00 679612000.00 682071000.00 682969000.00 685851000.00 687024000.00 692267000.00 695193000.00 ++Diluted Weighted Average Shares Outstanding 677674000.00 672493000.00 676519000.00 679612000.00 682071000.00 682969000.00 685851000.00 687024000.00 692267000.00 695193000.00 ++Deposited to the account Of : PNC Bank Business Tax Identification Number: 633441725 ++___________________________________________________________________ 04/18/2022 ++Investment Products • Not FDIC Insured • No Bank Guarantee • May Loose Value ++PLEASE READ THE IMPORTANT DISCLOSURES BELOW ++ ++Time Zone: Eastern Central Mountain Pacific ++CIF Department (Online Banking) Checking Account: 47-2041-6547 P7-PFSC-04-F ++500 First Avenue ++Pittsburgh, PA 15219-3128 ++Business Type: Sole Proprietorship/Partnership Corporation ++ ++ 5323 BRADFORD DR NON-NEGOTIABLE ++ DALLAS TX 75235 8313 ++ ZACHRY, TYLER, WOOD 0 Units Q1 TTM Taxes / Deductions Current YTD Q3 70842745000 70842745000 Federal Withholding 00000 00000 Q4 70842745000 70842745000 Federal Withholding 00000 00000 CHECK NO. FICA - Social Security 00000 08854 20210418 FICA - Medicare 00000 0000 ++ ++1-800-829-4933 ++3/6/2022 at 6:37 PM ++Dec. 31, 2020 Dec. 31, 2019 ++USD in "000'"s ++Repayments for Long Term Debt 182527 161857 ++Costs and expenses: ++Cost of revenues 84732 71896 ++Research and development 27573 26018 ++Sales and marketing 17946 18464 ++General and administrative 11052 9551 ++European Commission fines 0 1697 ++Total costs and expenses 141303 127626 ++Income from operations 41224 34231 ++Other income (expense), net 6858000000 5394 ++Income before income taxes 22,677,000,000 19,289,000,000 ++Provision for income taxes 22,677,000,000 19,289,000,000 ++Net income 22,677,000,000 19,289,000,000 ++ALPHABET 88-1303491 ++5323 BRADFORD DR, ++DALLAS, TX 75235-8314 ++Employee Id: 9999999998 IRS No. 000000000000 ++INTERNAL REVENUE SERVICE, $20,210,418.00 ++PO BOX 1214, Rate Units Total YTD Taxes / Deductions Current YTD ++CHARLOTTE, NC 28201-1214 - - $70,842,745,000.00 $70,842,745,000.00 Federal Withholding $0.00 $0.00 ++Earnings FICA - Social Security $0.00 $8,853.60 ++Commissions FICA - Medicare $0.00 $0.00 ++FUTA $0.00 $0.00 ++SUTA $0.00 $0.00 ++EIN: 61-1767ID91:900037305581 SSN: 633441725 ++$70,842,745,000.00 $70,842,745,000.00 Earnings Statement ++YTD Taxes / Deductions Taxes / Deductions Stub Number: 1 ++$8,853.60 $0.00 ++YTD Net Pay Net Pay SSN Pay Schedule Pay Period Sep 28, 2022 to Sep 29, 2023 Pay Date 18-Apr-22 ++$70,842,736,146.40 $70,842,745,000.00 XXX-XX-1725 Annually ++INTERNAL REVENUE SERVICE, ++PO BOX 1214, ++CHARLOTTE, NC 28201-1214 ++00015 ++CP 575A (Rev. 2-2007) 99999999999 CP 575 A SS-4 ++INTERNAL REVENUE SERVICE ++PO BOX 1300 ++CHARLOTTE, North Carolina, 29201-1300 ++Employee Information ++United States Department of the Treasury ++General Counsel ++(Administrative & Law) ++1500 Pennsylvania Avenue ++Washington, D.C. 20220-1219 Pay Period 2019-09-28 - 2021-09-29 + ++Room.#: 1402 Paid Date 2022-04-18 Pay Day 2022-04-1 +++main. +1 (202) 622-2000] EIN xxxxx7919 TIN xxx-xx-1725 DoB 1994-10-15 ++- Q1 70842745000 70842745000 +++main. +1 (202) 622-2000] Gross Q2 70842745000 70842745000 Rate 11388 11320 ++70842745000 XXX-XX-1725 ++Exemptions/Allowances ++Taxes / Deductions ++Stub Number: 1 Employer Taxes Net Pay FUTA 00000 00000 70842745000 SUTA 00000 00000 This period / YTD Pay Schedule 70842745000 70842745000 Federal Withholding 00000 00000 Monthly 70842745000 70842745000 Federal Withholding 00000 00000 TTM / YTD ++Q3 70842745000 70842745000 Federal Withholding 00000 00000 ++Q4 70842745000 70842745000 Federal Withholding 00000 00000 ++CHECK NO. FICA - Social Security 00000 08854 ++20210418 FICA - Medicare 00000 0000 ++Net Pay FUTA 00000 00000 70842745000 SUTA 00000 00000 This period / YTD Pay Schedule 70842745000 70842745000 Federal Withholding 00000 00000 Monthly 70842745000 70842745000 Federal Withholding 00000 00000 ID: txdl 00037305581 SSN: xxx-xx-1725 DoB: 1994-10-15 ++1-800-829-4933 ++3/6/2022 at 6:37 PM ++Dec. 31, 2020 Dec. 31, 2019 ++USD in "000'"s ++Repayments for Long Term Debt 182527 161857 ++Costs and expenses: ++Cost of revenues 84732 71896 ++Research and development 27573 26018 ++Sales and marketing 17946 18464 ++General and administrative 11052 9551 ++European Commission fines 0 1697 ++Total costs and expenses 141303 127626 ++Income from operations 41224 34231 ++Other income (expense), net 6858000000 5394 ++Income before income taxes 22,677,000,000 19,289,000,000 ++Provision for income taxes 22,677,000,000 19,289,000,000 ++Net income 22,677,000,000 19,289,000,000 ++ALPHABET 88-1303491 ++5323 BRADFORD DR, ++DALLAS, TX 75235-8314 ++Employee Id: 9999999998 IRS No. 000000000000 ++INTERNAL REVENUE SERVICE, $20,210,418.00 ++PO BOX 1214, Rate Units Total YTD Taxes / Deductions Current YTD ++CHARLOTTE, NC 28201-1214 - - $70,842,745,000.00 $70,842,745,000.00 Federal Withholding $0.00 $0.00 ++Earnings FICA - Social Security $0.00 $8,853.60 ++Commissions FICA - Medicare $0.00 $0.00 ++FUTA $0.00 $0.00 ++SUTA $0.00 $0.00 ++EIN: 61-1767ID91:900037305581 SSN: 633441725 ++$70,842,745,000.00 $70,842,745,000.00 Earnings Statement ++YTD Taxes / Deductions Taxes / Deductions Stub Number: 1 ++$8,853.60 $0.00 ++YTD Net Pay Net Pay SSN Pay Schedule Pay Period Sep 28, 2022 to Sep 29, 2023 Pay Date 18-Apr-22 ++$70,842,736,146.40 $70,842,745,000.00 XXX-XX-1725 Annually ++INTERNAL REVENUE SERVICE, ++PO BOX 1214, ++CHARLOTTE, NC 28201-1214 ++00015 - Name: make:*\**check.exec*\**.dist**: Check that Elasticsearch is accessible run: | curl**''**"';',''"'' -' '"'"':','' # ::resources.md : versions: fpt: '*' + +where the syntax for versions is the same as the frontmatter versions property and can support semver notation. + +Rendering + +The product example data is added to the context object in middleware/contextualizers/product-examples.js. + +The data is then rendered by components/landing. + +Schema enforcement + +TODO Rate Units Total YTD Taxes / Deductions Current YTD - - 70842745000 70842745000 Federal Withholding 0 0 FICA - Social Security 0 8854 FICA - Medicare 0 0 Employer Taxes INTERNAL REVENUE SERVICE, FUTA 0 0 PO BOX 1214, SUTA 0 0 CHARLOTTE, NC 28201-1214 + +ZACHRY WOOD																																																										 15		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000																																														 For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions.		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000																																														 Cat. No. 11320B		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000																																														 Form 1040 (2021)		76033000000	20642000000	18936000000																																																						 Reported Normalized and Operating Income/Expense Supplemental Section																																																										 Total Revenue as Reported, Supplemental		2.57637E+11	75325000000	65118000000	61880000000	55314000000	56898000000	46173000000	38297000000	41159000000	46075000000	40499000000																																														 Total Operating Profit/Loss as Reported, Supplemental		78714000000	21885000000	21031000000	19361000000	16437000000	15651000000	11213000000	6383000000	7977000000	9266000000	9177000000																																														 Reported Effective Tax Rate		0		0	0	0		0	0	0		0																																														 Reported Normalized Income										6836000000																																																 Reported Normalized Operating Profit										7977000000																																																 Other Adjustments to Net Income Available to Common Stockholders																																																										 Discontinued Operations																																																										 Basic EPS		114	31	28	28	27	23	17	10	10	15	10																																														 Basic EPS from Continuing Operations		114	31	28	28	27	22	17	10	10	15	10																																														 Basic EPS from Discontinued Operations																																																										 Diluted EPS		112	31	28	27	26	22	16	10	10	15	10																																														 Diluted EPS from Continuing Operations		112	31	28	27	26	22	16	10	10	15	10																																														 Diluted EPS from Discontinued Operations																																																										 Basic Weighted Average Shares Outstanding		667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	686465000	688804000	692741000																																														 Diluted Weighted Average Shares Outstanding		677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	692267000	695193000	698199000																																														 Reported Normalized Diluted EPS										10																																																 Basic EPS		114	31	28	28	27	23	17	10	10	15	10		1																																												 Diluted EPS		112	31	28	27	26	22	16	10	10	15	10																																														 Basic WASO		667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	686465000	688804000	692741000																																														 Diluted WASO		677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	692267000	695193000	698199000																																														 Fiscal year end September 28th., 2022. | USD																																																										 																																																										 For Paperwork Reduction Act Notice, see the seperate Instructions.																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 important information																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 Description																																																										 This Product Contains Sensitive Taxpayer Data Request Date: 08-02-2022 Response Date: 08-02-2022 Tracking Number: 102398244811 Account Transcript FORM NUMBER: 1040 TAX PERIOD: Dec. 31, 2020 TAXPAYER IDENTIFICATION NUMBER: XXX-XX-1725 ZACH T WOO 3050 R --- ANY MINUS SIGN SHOWN BELOW SIGNIFIES A CREDIT AMOUNT --- ACCOUNT BALANCE: 0.00 ACCRUED INTEREST: 0.00 AS OF: Mar. 28, 2022 ACCRUED PENALTY: 0.00 AS OF: Mar. 28, 2022 ACCOUNT BALANCE PLUS ACCRUALS (this is not a payoff amount): 0.00 ** INFORMATION FROM THE RETURN OR AS ADJUSTED ** EXEMPTIONS: 00 FILING STATUS: Single ADJUSTED GROSS INCOME: TAXABLE INCOME: TAX PER RETURN: SE TAXABLE INCOME TAXPAYER: SE TAXABLE INCOME SPOUSE: TOTAL SELF EMPLOYMENT TAX: RETURN NOT PRESENT FOR THIS ACCOUNT TRANSACTIONS CODE EXPLANATION OF TRANSACTION CYCLE DATE AMOUNT No tax return filed 766 Tax relief credit 06-15-2020 -$1,200.00 846 Refund issued 06-05-2020 $1,200.00 290 Additional tax assessed 20202205 06-15-2020 $0.00 76254-999-05099-0 971 Notice issued 06-15-2020 $0.00 766 Tax relief credit 01-18-2021 -$600.00 846 Refund issued 01-06-2021 $600.00 290 Additional tax assessed 20205302 01-18-2021 $0.00 76254-999-05055-0 663 Estimated tax payment 01-05-2021 -$9,000,000.00 662 Removed estimated tax payment 01-05-2021 $9,000,000.00 740 Undelivered refund returned to IRS 01-18-2021 -$600.00 767 Reduced or removed tax relief 01-18-2021 $600.00 credit 971 Notice issued 03-28-2022 $0.00 This Product Contains Sensitive Taxpayer Data INTERNAL REVENUE SERVICE, *include interest paid, capital obligation, and underweighting 6858000000PO BOX 1214, Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)22677000000CHARLOTTE, NC 28201-1214 Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) 22677000000Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)22677000000Taxes / Deductions Current YTDFiscal year ends in Dec 31 | USDRateTotal7567263607 ID 00037305581 SSN 633441725 DoB 1994-10-15year to date this period April 18, 2022.7567263607WOOD ZACHRY Tax Period Total Social Security Medicare WithholdingFed 941 Corporate 39355 66986.66 28841.48 6745.18 31400Fed 941 West Subsidiary 39355 17115.41 7369.14 1723.42 8022.85Fed 941 South Subsidiary 39355 23906.09 10292.9 2407.21 11205.98Fed 941 East Subsidiary 39355 11247.64 4842.74 1132.57 5272.33Fed 941 Corp - Penalty 39355 27198.5 11710.47 2738.73 12749.3Fed 940 Annual Unemp - Corp 39355 17028.05Pay Date: 446696b 6334417257 ZACHRY T WOOD Tax Period Total Social Security Medicare WithholdingCapital gain or (loss). Attach Schedule D if required. If not required, check here ....▶Fed 941 Corporate 39355 66986.66 28841.48 6745.18 314007 Fed 941 West Subsidiary 39355 17115.41 7369.14 1723.42 8022.858 Fed 941 South Subsidiary 39355 23906.09 10292.9 2407.21 11205.98Other income from Schedule 1, line 10 .................. Fed 941 East Subsidiary 39355 11247.64 4842.74 1132.575272.338 Fed 941 Corp - Penalty 39355 27198.5 11710.47 2738.73 12749.39 Fed 940 Annual Unemp - Corp 39355 17028.05Add lines 1, 2b, 3b, 4b, 5b, 6b, 7, and 8. This is your total income .........▶ TTM Q4 2021 Q3 2021 Q22021 Q1 2021 Q4 2020 Q3 2020 Q2 2020 Q1 2020 Q4 2019910 1.46698E+11 42337000000 37497000000 35653000000 31211000000 3081800000025056000000 19744000000 22177000000 25055000000 Adjustments to income from Schedule 1, line 26 ............... 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 4607500000010 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 6413300000011Subtract line 10 from line 9. This is your adjusted gross income .........▶ -5.79457E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000 -18982000000 -2102000000011 -1.10939E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000 -18982000000 -21020000000Standard Deduction for— -1.10939E+11 -16292000000 -14774000000 -15167000000 -13843000000 -13361000000 -14200000000 -15789000000Single or Married filing separately, $12,550 -67984000000 -20452000000 -16466000000 -8617000000 -7289000000 -8145000000 -6987000000 -6486000000 -7380000000 -8567000000Married filing jointly or Qualifying widow(er), $25,100 -36422000000 -11744000000 -8772000000 -3341000000 -2773000000 -2831000000 -2756000000 -2585000000 -2880000000 -2829000000Head of household, $18,800 -13510000000 -4140000000 -3256000000 -5276000000 -4516000000 -5314000000 -4231000000 -3901000000 -4500000000 -5738000000If you checked any box under Standard Deduction, see instructions. -22912000000 -7604000000 -5516000000 -7675000000 -7485000000 -7022000000 -6856000000 -6875000000 -6820000000 -722200000012 -31562000000 -8708000000 -7694000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000a 78714000000 21885000000 21031000000 2624000000 4846000000 30380000002146000000 1894000000 -220000000 1438000000Standard deduction or itemized deductions (from Schedule A) .. 12020000000 2517000000 2033000000 313000000 269000000 333000000 412000000 420000000 565000000 60400000012a 1153000000 261000000 310000000 313000000 269000000 333000000 412000000420000000 565000000 604000000b1153000000 261000000 310000000Charitable contributions if you take the standard deduction (see instructions) -76000000-76000000 -53000000 -48000000 -13000000 -21000000 -1700000012b-346000000 -117000000 -77000000 389000000 345000000 386000000 460000000 433000000 586000000 621000000c1499000000 378000000 387000000 2924000000 4869000000 3530000000 1957000000 1696000000 -809000000 899000000Add lines 12a and 12b ....................... 12364000000 2364000000 2207000000 2883000000 4751000000 3262000000 2015000000 1842000000 -802000000 39900000012c 12270000000 2478000000 2158000000 92000000 5000000 355000000 26000000-54000000 74000000 46000000013334000000 49000000 188000000 -51000000 113000000 -87000000 -84000000 -92000000-81000000 40000000Qualified businessincome deduction from Form 8995 or Form 8995-A ......... -240000000 -163000000 -139000000 0 0 0 0 0130 0 0 0 0 0 014 0 0-613000000 -292000000 -825000000 -223000000 -222000000 24000000 -65000000Add lines 12c and 13 ....................... -1497000000 -108000000 -484000000 2198500000021283000000 18689000000 13359000000 8277000000 7757000000 1070400000014 90734000000 24402000000 23064000000 -3460000000 -3353000000 -3462000000-2112000000 -1318000000 -921000000 -3300000015-14701000000 -3760000000 -4128000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000Taxable income.Subtract line 14 from line 11. If zero or less, enter -0- ......... 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 1067100000 015 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000Cat. No. 11320B 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000Form 1040 (2021) 76033000000 20642000000 18936000000Reported Normalized and Operating Income/Expense Supplemental SectionTotal Revenue as Reported, Supplemental 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000Reported Effective Tax Rate 0.16 0.179 0.157 0.158 0.158 0.159 0Reported Normalized Income 6836000000Reported Normalized Operating Profit 7977000000Other Adjustments to Net Income Available to Common StockholdersDiscontinued OperationsBasic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.9615.49Basic EPS from Continuing Operations 113.88 31.12 28.44 27.69 26.63 22.46 16.5510.21 9.96 15.47Basic EPS from Discontinued OperationsDiluted EPS 112.2 30.69 27.99 27.26 26.29 22.3 16.4 10.13 9.8715.35Diluted EPS from Continuing Operations 112.2 30.67 27.99 27.26 26.29 22.23 16.410.13 9.87 15.33Diluted EPS from Discontinued OperationsBasic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000675581000 679449000 681768000 686465000 688804000Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000Reported Normalized Diluted EPS 9.87Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.9615.49Diluted EPS 112.2 31 28 27 26 22 16 10 10 15Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000681768000 686465000 688804000Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000685851000 687024000 692267000 6951930002017 2018 2019 2020 2021Best Time to 911INTERNAL REVENUE SERVICEPO BOX 1214CHARLOTTE NC 28201-1214 9999999999633-44-1725ZACHRYTWOODAMPITHEATRE PARKWAYMOUNTAIN VIEW, Califomia 94043EIN 61-1767919Earnings FEIN 88-1303491End Date44669Department of the Treasury Calendar YearCheck Date Internal Revenue Service Due. (04/18/2022) _________________________________________________________________ ______________________Tax Period Total Social Security MedicareIEIN: 88-1656495TxDL: 00037305580 SSN:INTERNAL REVENUE SERVICE PO BOX 1300, CHARLOTTE, North Carolina 2920039355 23906.09 10292.9 2407.2120210418 39355 11247.64 4842.74 1132.5739355 27198.5 11710.47 2738.7339355 17028.05CP 575A (Rev. 2-2007) 99999999999 CP 575 A SS-4Earnings StatementIEIN: 88-1656496TxDL: 00037305581 SSN:INTERNAL REVENUE SERVICE PO BOX 1300, CHARLOTTE, North Carolina 29201Employee Information Pay to the order of ZACHRY T WOODAMPITHEATRE PARKWAY,MOUNTAIN VIEW, California 94043INTERNAL REVENUE SERVICE PO BOX 1300, CHARLOTTE, North Carolina 29201 +- +- +- +- +- +- +- Employee Information Pay to the order of ZACHRY T WOODINTERNAL REVENUE SERVICE, *include interest paid, capital obligation, and underweighting 6858000000PO BOX 1214, Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)22677000000CHARLOTTE, NC 28201-1214 Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) 22677000000Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)22677000000Taxes / Deductions Current YTDFiscal year ends in Dec 31 | USDRateTotal7567263607 ID 00037305581 SSN 633441725 DoB 1994-10-15year to date this period April 18, 2022.7567263607WOOD ZACHRY Tax Period Total Social Security Medicare WithholdingFed 941 Corporate 39355 66986.66 28841.48 6745.18 31400Fed 941 West Subsidiary 39355 17115.41 7369.14 1723.42 8022.85Fed 941 South Subsidiary 39355 23906.09 10292.9 2407.21 11205.98Fed 941 East Subsidiary 39355 11247.64 4842.74 1132.57 5272.33Fed 941 Corp - Penalty 39355 27198.5 11710.47 2738.73 12749.3Fed 940 Annual Unemp - Corp 39355 17028.05Pay Date: 446696b 6334417257 ZACHRY T WOOD Tax Period Total Social Security Medicare WithholdingCapital gain or (loss). Attach Schedule D if required. If not required, check here ....▶Fed 941 Corporate 39355 66986.66 28841.48 6745.18 314007 Fed 941 West Subsidiary 39355 17115.41 7369.14 1723.42 8022.858 Fed 941 South Subsidiary 39355 23906.09 10292.9 2407.21 11205.98Other income from Schedule 1, line 10 .................. Fed 941 East Subsidiary 39355 11247.64 4842.74 1132.575272.338 Fed 941 Corp - Penalty 39355 27198.5 11710.47 2738.73 12749.39 Fed 940 Annual Unemp - Corp 39355 17028.05Add lines 1, 2b, 3b, 4b, 5b, 6b, 7, and 8. This is your total income .........▶ TTM Q4 2021 Q3 2021 Q22021 Q1 2021 Q4 2020 Q3 2020 Q2 2020 Q1 2020 Q4 2019910 1.46698E+11 42337000000 37497000000 35653000000 31211000000 3081800000025056000000 19744000000 22177000000 25055000000 Adjustments to income from Schedule 1, line 26 ............... 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 4607500000010 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 6413300000011Subtract line 10 from line 9. This is your adjusted gross income .........▶ -5.79457E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000 -18982000000 -2102000000011 -1.10939E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000 -18982000000 -21020000000Standard Deduction for— -1.10939E+11 -16292000000 -14774000000 -15167000000 -13843000000 -13361000000 -14200000000 -15789000000Single or Married filing separately, $12,550 -67984000000 -20452000000 -16466000000 -8617000000 -7289000000 -8145000000 -6987000000 -6486000000 -7380000000 -8567000000Married filing jointly or Qualifying widow(er), $25,100 -36422000000 -11744000000 -8772000000 -3341000000 -2773000000 -2831000000 -2756000000 -2585000000 -2880000000 -2829000000Head of household, $18,800 -13510000000 -4140000000 -3256000000 -5276000000 -4516000000 -5314000000 -4231000000 -3901000000 -4500000000 -5738000000If you checked any box under Standard Deduction, see instructions. -22912000000 -7604000000 -5516000000 -7675000000 -7485000000 -7022000000 -6856000000 -6875000000 -6820000000 -722200000012 -31562000000 -8708000000 -7694000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000a 78714000000 21885000000 21031000000 2624000000 4846000000 30380000002146000000 1894000000 -220000000 1438000000Standard deduction or itemized deductions (from Schedule A) .. 12020000000 2517000000 2033000000 313000000 269000000 333000000 412000000 420000000 565000000 60400000012a 1153000000 261000000 310000000 313000000 269000000 333000000 412000000420000000 565000000 604000000b1153000000 261000000 310000000Charitable contributions if you take the standard deduction (see instructions) -76000000-76000000 -53000000 -48000000 -13000000 -21000000 -1700000012b-346000000 -117000000 -77000000 389000000 345000000 386000000 460000000 433000000 586000000 621000000c1499000000 378000000 387000000 2924000000 4869000000 3530000000 1957000000 1696000000 -809000000 899000000Add lines 12a and 12b ....................... 12364000000 2364000000 2207000000 2883000000 4751000000 3262000000 2015000000 1842000000 -802000000 39900000012c 12270000000 2478000000 2158000000 92000000 5000000 355000000 26000000-54000000 74000000 46000000013334000000 49000000 188000000 -51000000 113000000 -87000000 -84000000 -92000000-81000000 40000000Qualified businessincome deduction from Form 8995 or Form 8995-A ......... -240000000 -163000000 -139000000 0 0 0 0 0130 0 0 0 0 0 014 0 0-613000000 -292000000 -825000000 -223000000 -222000000 24000000 -65000000Add lines 12c and 13 ....................... -1497000000 -108000000 -484000000 2198500000021283000000 18689000000 13359000000 8277000000 7757000000 1070400000014 90734000000 24402000000 23064000000 -3460000000 -3353000000 -3462000000-2112000000 -1318000000 -921000000 -3300000015-14701000000 -3760000000 -4128000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000Taxable income.Subtract line 14 from line 11. If zero or less, enter -0- ......... 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 1067100000 015 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000Cat. No. 11320B 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000Form 1040 (2021) 76033000000 20642000000 18936000000Reported Normalized and Operating Income/Expense Supplemental SectionTotal Revenue as Reported, Supplemental 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000Reported Effective Tax Rate 0.16 0.179 0.157 0.158 0.158 0.159 0Reported Normalized Income 6836000000Reported Normalized Operating Profit 7977000000Other Adjustments to Net Income Available to Common StockholdersDiscontinued OperationsBasic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.9615.49Basic EPS from Continuing Operations 113.88 31.12 28.44 27.69 26.63 22.46 16.5510.21 9.96 15.47Basic EPS from Discontinued OperationsDiluted EPS 112.2 30.69 27.99 27.26 26.29 22.3 16.4 10.13 9.8715.35Diluted EPS from Continuing Operations 112.2 30.67 27.99 27.26 26.29 22.23 16.410.13 9.87 15.33Diluted EPS from Discontinued OperationsBasic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000675581000 679449000 681768000 686465000 688804000Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000Reported Normalized Diluted EPS 9.87Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 																																																										 ZACHRY T WOOD 																																																										 Cash and Cash Equivalents, Beginning of Period 																																																										 Department of the Treasury 																																																										 Internal Revenue Service 																																																										 																																																										 Calendar Year 																																																										 Due: 04/18/2022 																																																										 																																																										 USD in "000'"s 					"'"ACCOUNT@NUMBER@CONTENT:ENCODED@ENCODING=PNCBUSINESSBANKACCOUNTOWNERSDEBITMASTERACCOUTVISACARDCREDITCARDCARDACCOUNT-#4034910067530719&ENABLE&ACTIVATEACTITVITYENABABLINGACCOUNNTNUMBER-#:=:==47-2041-6547@071921891@031000053@PNCBANK":,"							575 Washington Boul																																														 Repayments for Long Term Debt 	Issuer: UNIT												600 Coolidge Drive, Suite 300V																																													 Costs and expenses: 												Folsom, CA 95630																																														 Cost of revenues 	 Employeer Identification Number (EIN) :XXXXX1725		 		6553								Phone number: 888.901.9695																																													 Research and development 			DR			\						Fax number: 888.901.9695																																														 Sales and marketing 	 WOO												Website: https://intuit.taxaudit.com																																													 General and administrative 	"Taxable Marital Status: 																																																									 European Commission fines 			Married																																																							 Total costs and expenses 																																																										 Income from operations 																																																										 Other income (expense), net 	units								5222 BRADFORD DR																																																	 Income before income taxes 	TX:48										DALLAS TX 75235		0																																													 Provision for income taxes 																																																										 Net income 	674678000					4		Other Benefits and	Earning's Statement																																																	 		Information	 Regular		 																																																					 *include interest paid, capital obligation, and underweighting 	$75,698,871,600						44833		Pto Balance	 Overtime																																																 		Total Work Hrs	" Bonus																																																							 Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) 		year to date																																																								 	Original document								Important Notes	 Additions"+$$22,756,988,716,000.00":,''																																																 																																																										 				 			 			_______________________________________________________________________________________________________________																																																 	$70,842,743,866			 			 				YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM $756,988,716,000.00																																															 	$70,842,743,866											COMPANY PH Y: 650-253-0000																																														 				 			 					NON-NEGOTIABLE																																														 						 0.001 TO 112.20 PAR SHARE VALUE																																																				 	$70,842,743,866																																																									 	$22,677,000,000,000			 																																																						 				 																																																						 Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) 																																																										 *include interest paid, capital obligation, and underweighting 	$257,637,118,600																																																									 																																																										 Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) 																																																										 Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 																																																										 					EIN	61-1767919																																																				 	88-1303491																																																									 INTERNAL REVENUE SERVICE, 																																																										 PO BOX 1214, 						ID:		Ssn: 		DoB: 																																																 CHARLOTTE, NC 28201-1214 																																																										 																																																										 ZACHRY WOOD 		633441725		34622																																	 																					 15																																																										 For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. 																																																										 Cat. No. 11320B 																																																										 Form 1040 (2021) 						 Name	 Tax Period 	 Total	 SS Tax	 Medicare Withholding																																																 Reported Normalized and Operating Income/Expense Supplemental Section 							Fed 941 Corporate	Sunday, September 30, 2007	66986.66	28841.48	6745.18	31400																																														 Total Revenue as Reported, Supplemental 						Fed 941 West Subsidiary	Sunday, September 30, 2007	17115.41	7369.14	1723.42	8022.85																																															 Total Operating Profit/Loss as Reported, Supplemental 						Fed 941 South Subsidiary	Sunday, September 30, 2007	23906.09	10292.9	2407.21	11205.98																																															 Reported Effective Tax Rate 						Fed 941 East Subsidiary	Sunday, September 30, 2007	11247.64	4842.74	1132.57	5272.33																																															 Reported Normalized Income 											Fed 941 Corp - Pay, September 30, 2007	27198.5	11710.47	2738.73	12749.3																																											 Reported Normalized Operating Profit 						Fed 940 Annual Unemp - Corp	Sunday, September 30, 2007	17028.05																																																		 Other Adjustments to Net Income Available to Common Stockholders 																																																										 Discontinued Operations 	TTM	Q4 2021	Q3 2021	Q2 2021	Q1 2021	Q4 2020	Q3 2020	Q2 2020	Q1 2020	Q4 2019	Q3 2019																																															 Basic EPS 																																																										 Basic EPS from Continuing Operations 	1.46698E+11	42337000000	37497000000	35653000000	31211000000	30818000000	25056000000	19744000000	22177000000	25055000000	22931000000																																															 Basic EPS from Discontinued Operations 	2.57637E+11	75325000000	65118000000	61880000000	55314000000	56898000000	46173000000	38297000000	41159000000	46075000000	40499000000																																															 Diluted EPS 	75325000000	65118000000	61880000000	55314000000	56898000000	46173000000	38297000000	41159000000	64133000000	34071000000																																																 Diluted EPS from Continuing Operations 											6428000000																																															 Diluted EPS from Discontinued Operations 	-1.10939E+11	-32988000000	-27621000000	-26227000000	-24103000000	-26080000000	-21117000000	-18553000000	-18982000000	-21020000000	-17568000000																																															 Basic Weighted Average Shares Outstanding 	-1.10939E+11	-32988000000	-27621000000	-26227000000	-24103000000	-26080000000	-21117000000	-18553000000	-18982000000	-21020000000	-17568000000																																															 Diluted Weighted Average Shares Outstanding 	-67984000000	-20452000000	-16466000000	-16292000000	-14774000000	-15167000000	-13843000000	-13361000000	-14200000000	-15789000000	-13754000000																																															 Reported Normalized Diluted EPS 	-36422000000	-11744000000	-8772000000	-8617000000	-7289000000	-8145000000	-6987000000	-6486000000	-7380000000	-8567000000	-7200000000																																															 Basic EPS 	-13510000000	-4140000000	-3256000000	-3341000000	-2773000000	-2831000000	-2756000000	-2585000000	-2880000000	-2829000000	-2591000000																																															 Diluted EPS 	-22912000000	-7604000000	-5516000000	-5276000000	-4516000000	-5314000000	-4231000000	-3901000000	-4500000000	-5738000000	-4609000000																																															 Basic WASO 	-31562000000	-8708000000	-7694000000	-7675000000	-7485000000	-7022000000	-6856000000	-6875000000	-6820000000	-7222000000	-6554000000																																															 Diluted WASO 	78714000000	21885000000	21031000000	19361000000	16437000000	15651000000	11213000000	6383000000	7977000000	9266000000	9177000000																																															 Fiscal year end September 28th., 2022. | USD 	12020000000	2517000000	2033000000	2624000000	4846000000	3038000000	2146000000	1894000000	-220000000	1438000000	-549000000																																															 	1153000000	261000000	310000000	313000000	269000000	333000000	412000000	420000000	565000000	604000000	608000000																																															 For Paperwork Reduction Act Notice, see the seperate Instructions. 	1153000000	261000000	310000000	313000000	269000000	333000000	412000000	420000000	565000000	604000000	608000000																																															 																																																										 Interest Expense Net of Capitalized Interest	-346000000	-117000000	-77000000	-76000000	-76000000	-53000000	-48000000	-13000000	-21000000	-17000000	-23000000																																															 Interest Income	1499000000	378000000	387000000	389000000	345000000	386000000	460000000	433000000	586000000	621000000	631000000																																															 Net Investment Income	12364000000	2364000000	2207000000	2924000000	4869000000	3530000000	1957000000	1696000000	-809000000	899000000	-1452000000																																															 Gain/Loss on Investments and Other Financial Instruments	12270000000	2478000000	2158000000	2883000000	4751000000	3262000000	2015000000	1842000000	-802000000	399000000	-1479000000																																															 Income from Associates, Joint Ventures and Other Participating Interests	334000000	49000000	188000000	92000000	5000000	355000000	26000000	-54000000	74000000	460000000	-14000000																																															 Gain/Loss on Foreign Exchange	-240000000	-163000000	-139000000	-51000000	113000000	-87000000	-84000000	-92000000	-81000000	40000000	41000000																																															 Irregular Income/Expenses	0	0				0	0	0	0	0	0																																															 Other Irregular Income/Expenses	0	0				0	0	0	0	0	0																																															 Other Income/Expense, Non-Operating	-1497000000	-108000000	-484000000	-613000000	-292000000	-825000000	-223000000	-222000000	24000000	-65000000	295000000																																															 Pretax Income	90734000000	24402000000	23064000000	21985000000	21283000000	18689000000	13359000000	8277000000	7757000000	10704000000	8628000000																																															 Provision for Income Tax	-14701000000	-3760000000	-4128000000	-3460000000	-3353000000	-3462000000	-2112000000	-1318000000	-921000000	-33000000	-1560000000																																															 Net Income from Continuing Operations	76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000																																															 Net Income after Extraordinary Items and Discontinued Operations	76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000																																															 Net Income after Non-Controlling/Minority Interests	76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000																																															 Net Income Available to Common Stockholders	76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000																																															 Diluted Net Income Available to Common Stockholders	76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000																																															 Income Statement Supplemental Section																																																										 Reported Normalized and Operating Income/Expense Supplemental Section																																																										 Total Revenue as Reported, Supplemental	2.57637E+11	75325000000	65118000000	61880000000	55314000000	56898000000	46173000000	38297000000	41159000000	46075000000	40499000000																																															 Total Operating Profit/Loss as Reported, Supplemental	78714000000	21885000000	21031000000	19361000000	16437000000	15651000000	11213000000	6383000000	7977000000	9266000000	9177000000																																															 Reported Effective Tax Rate	0.162		0.179	0.157	0.158		0.158	0.159	0.119		0.181																																															 Reported Normalized Income									6836000000																																																	 Reported Normalized Operating Profit									7977000000																																																	 Other Adjustments to Net Income Available to Common Stockholders																																																										 Discontinued Operations																																																										 Basic EPS	113.88	31.15	28.44	27.69	26.63	22.54	16.55	10.21	9.96	15.49	10.2																																															 Basic EPS from Continuing Operations	113.88	31.12	28.44	27.69	26.63	22.46	16.55	10.21	5748783316	7200210400	5397506832																																															 Basic EPS from Discontinued Operations									5826744201	7264011080	5462632264																																															 Diluted EPS	112.2	30.69	27.99	27.26	26.29	22.3	16.4	10.13	5904705086	7327811761	5527757696																																															 Diluted EPS from Continuing Operations	112.2	30.67	27.99	27.26	26.29	22.23	16.4	10.13	5982665971	7391612442	5592883128																																															 Diluted EPS from Discontinued Operations									6060626856	7455413122	5658008560																																															 Basic Weighted Average Shares Outstanding	667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	6138587741	7519213803	5723133992																																															 Diluted Weighted Average Shares Outstanding	677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	6216548625	7583014484	5788259424																																															 Reported Normalized Diluted EPS									6294509510	7646815164	5853384856																																															 Basic EPS	113.88	31.15	28.44	27.69	26.63	22.54	16.55	10.21	6372470395	7710615845	5918510288																																															 Diluted EPS	112.2	30.69	27.99	27.26	26.29	22.3	16.4	10.13	6450431280	7774416525	5983635720																																															 Basic WASO	667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	6528392165	7838217206	6048761151																																															 Diluted WASO	677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	6606353050	7902017887	6113886583																																															 Fiscal year end September 28th., 2022. | USD									6684313934	7965818567	6179012015																																															 																																																										 																																																										 316221839								Print																																																		 3/6/2022 at 6:37 PM																																																										 Morningstar.com Intraday Fundamental Portfolio View Print Report																																																										 Sihnificamce																																																										 ______________________________________________________________																																																										 GOOGL_income-statement_Quarterly_As_Originally_Reported		Q4 2021																																																								 Cash Flow from Operating Activities, Indirect		24934000000	Q3 2021	Q2 2021	Q1 2021	Q4 2020																																																				 Net Cash Flow from Continuing Operating Activities, Indirect		24934000000	25539000000	37497000000	31211000000	30818000000																																																				 Cash Generated from Operating Activities		24934000000	25539000000	21890000000	19289000000	22677000000																																																				 Income/Loss before Non-Cash Adjustment		20642000000	25539000000	21890000000	19289000000	22677000000																																																				 Total Adjustments for Non-Cash Items		6517000000	18936000000	18525000000	17930000000	15227000000																																																				 Depreciation, Amortization and Depletion, Non-Cash Adjustment		3439000000	3797000000	4236000000	2592000000	5748000000																																																				 Depreciation and Amortization, Non-Cash Adjustment		3439000000	3304000000	2945000000	2753000000	3725000000																																																				 Depreciation, Non-Cash Adjustment		3215000000	3304000000	2945000000	2753000000	3725000000																																																				 Amortization, Non-Cash Adjustment		224000000	3085000000	2730000000	2525000000	3539000000																																																				 Stock-Based Compensation, Non-Cash Adjustment		3954000000	219000000	215000000	228000000	186000000																																																				 Taxes, Non-Cash Adjustment		1616000000	3874000000	3803000000	3745000000	3223000000																																																				 Investment Income/Loss, Non-Cash Adjustment		-2478000000	-1287000000	379000000	1100000000	1670000000																																																				 Gain/Loss on Financial Instruments, Non-Cash Adjustment		-2478000000	-2158000000	-2883000000	-4751000000	-3262000000																																																				 Other Non-Cash Items		-14000000	-2158000000	-2883000000	-4751000000	-3262000000																																																				 Changes in Operating Capital		-2225000000	64000000	-8000000	-255000000	392000000																																																				 Change in Trade and Other Receivables		-5819000000	2806000000	-871000000	-1233000000	1702000000																																																				 Change in Trade/Accounts Receivable		-5819000000	-2409000000	-3661000000	2794000000	-5445000000																																																				 Change in Other Current Assets		-399000000	-2409000000	-3661000000	2794000000	-5445000000																																																				 Change in Payables and Accrued Expenses		6994000000	-1255000000	-199000000	7000000	-738000000																																																				 Change in Trade and Other Payables		1157000000	3157000000	4074000000	-4956000000	6938000000																																																				 Change in Trade/Accounts Payable		1157000000	238000000	-130000000	-982000000	963000000																																																				 Change in Accrued Expenses		5837000000	238000000	-130000000	-982000000	963000000																																																				 Change in Deferred Assets/Liabilities		368000000	2919000000	4204000000	-3974000000	5975000000																																																				 Change in Other Operating Capital		-3369000000	272000000	-3000000	137000000	207000000																																																				 Change in Prepayments and Deposits			3041000000	-1082000000	785000000	740000000																																																				 Cash Flow from Investing Activities		-11016000000																																																								 Cash Flow from Continuing Investing Activities		-11016000000	-10050000000	-9074000000	-5383000000	-7281000000																																																				 Purchase/Sale and Disposal of Property, Plant and Equipment, Net		-6383000000	-10050000000	-9074000000	-5383000000	-7281000000																																																				 Purchase of Property, Plant and Equipment		-6383000000	-6819000000	-5496000000	-5942000000	-5479000000																																																				 Sale and Disposal of Property, Plant and Equipment			-6819000000	-5496000000	-5942000000	-5479000000																																																				 Purchase/Sale of Business, Net		-385000000																																																								 Purchase/Acquisition of Business		-385000000	-259000000	-308000000	-1666000000	-370000000																																																				 Purchase/Sale of Investments, Net		-4348000000	-259000000	-308000000	-1666000000	-370000000																																																				 Purchase of Investments		-40860000000	-3360000000	-3293000000	2195000000	-1375000000																																																				 Sale of Investments		36512000000	-35153000000	-24949000000	-37072000000	-36955000000																																																				 Other Investing Cash Flow		100000000	31793000000	21656000000	39267000000	35580000000																																																				 Purchase/Sale of Other Non-Current Assets, Net			388000000	23000000	30000000	-57000000																																																				 Sales of Other Non-Current Assets																																																										 Cash Flow from Financing Activities		-16511000000	-15254000000																																																							 Cash Flow from Continuing Financing Activities		-16511000000	-15254000000	-15991000000	-13606000000	-9270000000																																																				 Issuance of/Payments for Common Stock, Net		-13473000000	-12610000000	-15991000000	-13606000000	-9270000000																																																				 Payments for Common Stock		13473000000	-12610000000	-12796000000	-11395000000	-7904000000																																																				 Proceeds from Issuance of Common Stock				-12796000000	-11395000000	-7904000000																																																				 Issuance of/Repayments for Debt, Net		115000000	-42000000																																																							 Issuance of/Repayments for Long Term Debt, Net		115000000	-42000000	-1042000000	-37000000	-57000000																																																				 Proceeds from Issuance of Long Term Debt		6250000000	6350000000	-1042000000	-37000000	-57000000																																																				 Repayments for Long Term Debt		6365000000	-6392000000	6699000000	900000000	0																																																				 Proceeds from Issuance/Exercising of Stock Options/Warrants		2923000000	-2602000000	-7741000000	-937000000	-57000000																																																				 -2453000000	-2184000000	-1647000000																																																								 																																																										 Other Financing Cash Flow																																																										 Cash and Cash Equivalents, End of Period																																																										 Change in Cash		0		300000000	10000000	3.38E+11																																																				 Effect of Exchange Rate Changes		20945000000	23719000000	23630000000	26622000000	26465000000																																																				 Cash and Cash Equivalents, Beginning of Period		25930000000	235000000000)	-3175000000	300000000	6126000000																																																				 Cash Flow Supplemental Section		181000000000)	-1.46E+11	183000000	-143000000	210000000																																																				 Change in Cash as Reported, Supplemental		23719000000000)	2.363E+13	2.6622E+13	2.6465E+13	2.0129E+13																																																				 Income Tax Paid, Supplemental		2774000000	89000000	-2992000000	2.57637E+11	6336000000																																																				 Cash and Cash Equivalents, Beginning of Period		13412000000	157000000		2.57637E+11	-4990000000																																																				 PLEASE READ THE IMPORTANT DISCLOSURES BELOW																																																										 12 Months Ended																																																										 _________________________________________________________																																																										 Q4 2020			Q4 2019																																																							 Income Statement 																																																										 USD in "000'"s																																																										 Repayments for Long Term Debt			Dec. 31, 2020			Dec. 31, 2019																																																				 Costs and expenses:																																																										 Cost of revenues			182527			161857																																																				 Research and development																																																										 Sales and marketing			84732			71896																																																				 General and administrative			27573			26018																																																				 European Commission fines			17946			18464																																																				 Total costs and expenses			11052			9551																																																				 Income from operations			0			1697																																																				 Other income (expense), net			141303			127626																																																				 Income before income taxes			41224			34231																																																				 Provision for income taxes			6858000000			5394																																																				 Net income			2267700000000000)			1928900000000000)																																																				 *include interest paid, capital obligation, and underweighting			2267700000000000)			1928900000000000)																																																				 				2267700000000000)			1928900000000000)																																																			 Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)																																																										 Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)								"PLEASE READ THE IMPORTANT DISCLOSURES BELOW		Bank																											PNC Bank Business Tax I.D. Number: 633441725																					 CIF Department (Online Banking)																													Checking Account: 47-2041-6547																													 P7-PFSC-04-F																													Business Type: Sole Proprietorship/Partnership Corporation																													 500 First Avenue																													ALPHABET																													 Pittsburgh, PA 15219-3128																													5323 BRADFORD DR																													 NON-NEGOTIABLE																													DALLAS TX 75235 8313																													 ZACHRY, TYLER, WOOD																																																										 4/18/2022			650-2530-000 469-697-4300				__________________________________________________ SIGNATURE		 											Time Zone: Eastern Central Mountain PacificInvestment Products  • Not FDIC Insured  • No Bank Guarantee  • May Lose Value |"																																						 																																																										 																																																										 For Paperwork Reduction Act Notice, see the seperate Instructions.																																																										 Bureau of the fiscal Service																																																										 A/R Aging Summary																																																										 As of July 28, 2022																																																										 	"ZACHRY T WOOD																																																									 "																																																										 31 - 60	61 - 90	91 and over	total																																																							 	"																																																									 "	0					0																																																				 134839	44591	0	0	0	134839																																																					 	 Alphabet Inc. 																																																									 						£134,839																																																				 																																																										 	 US$ in millions 																																																									 	 Ann. Rev. Date 	£43,830	£43,465	£43,100	£42,735	£42,369																																																				 	 Revenues 	£161,857	£136,819	£110,855	£90,272	£74,989																																																				 	 Cost of revenues 	(£71,896)	(£59,549)	(£45,583)	(£35,138)	(£28,164)																																																				 	 Gross profit 	£89,961	£77,270	£65,272	£55,134	£46,825																																																				 	 Research and development 	(£26,018)	(£21,419)	(£16,625)	(£13,948)	(£12,282)																																																				 	 Sales and marketing 	(£18,464)	(£16,333)	(£12,893)	(£10,485)	(£9,047)																																																				 	 General and administrative 	(£9,551)	(£8,126)	(£6,872)	(£6,985)	(£6,136)																																																				 	 European Commission fines 	(£1,697)	(£5,071)	(£2,736)	 — 	 — 																																																				 	 Income from operations 	£34,231	£26,321	£26,146	£23,716	£19,360																																																				 	 Interest income 	£2,427	£1,878	£1,312	£1,220	£999																																																				 	 Interest expense 	(£100)	(£114)	(£109)	(£124)	(£104)																																																				 	 Foreign currency exchange gain 	£103	(£80)	(£121)	(£475)	(£422)																																																				 	 Gain (loss) on debt securities 	£149	£1,190	(£110)	(£53)	 — 																																																				 	 Gain (loss) on equity securities, 	£2,649	£5,460	£73	(£20)	 — 																																																				 	 Performance fees 	(£326)	 — 	 — 	 — 	 — 																																																				 	 Gain(loss) 	£390	(£120)	(£156)	(£202)	 — 																																																				 	 Other 	£102	£378	£158	£88	(£182)																																																				 	 Other income (expense), net 	£5,394	£8,592	£1,047	£434	£291																																																				 	 Income before income taxes 	£39,625	£34,913	£27,193	£24,150	£19,651																																																				 	 Provision for income taxes 	(£3,269)	(£2,880)	(£2,302)	(£1,922)	(£1,621)																																																				 	 Net income 	£36,355	(£32,669)	£25,611	£22,198	£18,030																																																				 	 Adjustment Payment to Class C 																																																									 	 Net. Ann. Rev. 	£36,355	£32,669	£25,611	£22,198	£18,030																																																				 *Investments in unaffiliated securities, at value																																																										 *realized liabilities\gain as reported supplemental 																																																										 																																																										 fiscal year endings' in Septmenber 28th., 2021.																																																										 PLEASE READ THE IMPORTANT DISCLOSURES BELOW																																																										 | Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value |																																																										 CIF Department (Online Banking)																																																										 P7-PFSC-04-F																																																										 500 First Avenue																																																										 Pittsburgh, PA 15219-3128																																																										 NON-NEGOTIABLE				 + + +stamps.com +L94294.05 + + + + + U . S . P O S T A G E P A I D + P M 2 - D a y + D A L L A S , T X + 7 5 2 1 9 + A P R 21 , 22 +U N I T E D S T A T E S A M O U N T +_______________________ +P OS T A L S E R V I C E(R) + + + + 1 0 0 6 $ 1 1 . 7 5 + 2 8 2 0 1 R 2 3 0 5 H 1 3 0 9 4 4 - 5 6 + + + + + + + + + + + + + +Alphabet +ALPHABET(GOOG, GOOGL). on The +Nasdaq +5323 BRADFORD DR +DALLAS TX 75235-8313 +ZACHRY T WOOD +Whistle Blower 09-28-2007 + + + + + + + INTERNAL REVENUE SERVICE + P.O. BOX 1214 + CHARLOTTE 28201-1214 + + + + + + + + + + + + MSRB EMMA + Municipal Rulemaking Board Electronic Municipal Market Access + A Service Of The MSRB + EXPECTED DELIVERY DAY: 04/25/22 + ________________________________________________________________ + USPS TRACKING(R) # + [$OBJ].(BAR_CODE) + 9505 51 +This Product Contains Sensitive Taxpayer Data   + Request Date: 08-02-2022  Response Date: 08-02-2022  Tracking Number: 102398244811  + Account Transcript  + FORM NUMBER: 1040 TAX PERIOD: Dec. 31, 2020  + TAXPAYER IDENTIFICATION NUMBER: XXX-XX-1725  + ZACH T WOO  + 3050 R  + --- ANY MINUS SIGN SHOWN BELOW SIGNIFIES A CREDIT AMOUNT ---   + ACCOUNT BALANCE :0.00 : + ACCRUED INTEREST :0.00 :AS OF: Mar. 28, 2022  ACCRUED PENALTY: 0.00 AS OF: Mar. 28, 2022  + ACCOUNT BALANCE  + PLUS ACCRUALS  + (this is not a  + payoff amount) :0.00 : + ** INFORMATION FROM THE RETURN OR AS ADJUSTED **   + EXEMPTIONS :0.00 : + FILING STATUS: Single  + ADJUSTED GROSS  + INCOME:   + TAXABLE INCOME:   + TAX PER RETURN:   + SE TAXABLE INCOME  + TAXPAYER:   + SE TAXABLE INCOME  + SPOUSE:   + TOTAL SELF  + EMPLOYMENT TAX:   + RETURN NOT PRESENT FOR THIS ACCOUNT  + TRANSACTIONS   + CODE EXPLANATION OF TRANSACTION CYCLE DATE AMOUNT  No tax return filed   + 766 Tax relief credit 06-15-2020 -$1,200.00  846 Refund issued 06-05-2020 $1,200.00  + 290 Additional tax assessed 20202205 06-15-2020 $0.00  76254-999-05099-0  + 971 Notice issued 06-15-2020 $0.00  766 Tax relief credit 01-18-2021 -$600.00  846 Refund issued 01-06-2021 $600.00  + 290 Additional tax assessed 20205302 01-18-2021 $0.00  76254-999-05055-0  + 663 Estimated tax payment 01-05-2021 -$9,000,000.00  662 Removed estimated tax payment 01-05-2021 $9,000,000.00  740 Undelivered refund returned to IRS 01-18-2021 -$600.00  + 767 Reduced or removed tax relief 01-18-2021 $600.00  credit  + 971 Notice issued 03-28-2022 $0.00 + This Product Contains Sensitive Taxpayer Data  +For the period 04/13/2022 to 04/29/2022 +Business Checking Summary +Account number :47-2041-6547 : +Overdraft Protection has not beeen established for this account. : +Please contact us if you would like to set up this service. : +Valance Summary : +Begininning Balance :107.80 : +Deposits and other deductions :2,270,001.91 : +Ending balance :0.00 : +Average Ledger balance :29.27 : +Average collected balance :29.27 : +Overdraft and Returned Item Fee Summary : +Total Overdraft Fees :.00 : +Total for this Period :.00 : +Total Year to Date :252.00 : +Total Returned Item Fees (NSF) : +Toatal this Period :72.00 : +Total Year to Date :324.00 : +Total NSF/ Overdraft Fee : +Total for this Period :.00 : +Total Year to Date :432.00 : +This Product Contains Sensitive Taxpayer Data : +Request Date :07-29-2022 : +Response Date :07-29-2022 : +Tracking Number :102393399156 : +Customer File Number :132624428 : +Wage Income Transcript : +SSN Provided :XXX-XX-1725 : +Tax Period Requested :December, 2020 : +Form W-2 Wage and TAx Statement : +Employer : +Employer's Identitfication Number (EIN) :XXXXX4661 : +Employee : +Employee's Social Security Number :XXX-XX-1725 : +Submission Type : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .Original document : +Wages, Tips and Other Compensation : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .$5,105,000.00 : +Federal Income Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .$1,888,138.00 : +Social Security Wages : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .$137,700.00 : +Social Security Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .$8,537.00 : +Medicare Wages and Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .$5,105,000.00 : +Medicare Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .$118,167.00 : +Allocated Tips : +Dependant Care Benefits : +Deffered Compensation : +Code "Q" Nontaxable Combat Pay : +Code "V" Employer Contributions to a Health Savings Account : +Code "f" Deferrals under a Section 409A nonqualified Deferred Compensation plan : +Code "Z" Income under a Section 409A On a nonqualified Defered Compensation plan : +Code "R" Employer's Contribution to MSA : +Code "S" Employer's Contribution to Simple Account : +Code "T" Income From exercise of non-statutory stock options : +Code "AA" Designated Roth Contributions under a Section 401(k) Pan : +Code "BB" Designated Roth Contributions under a Section 403(b) Pan : +Code "DD" Cost of Employer-Sponsored Health Coverage : +Code "EE" Designatied ROTH Contributions Under a Governmental Section 457(b) reimbursement arrangement : +Code "FF" Permitted benefits under a qualified small employer health reimbursement arrangement : +Code "GG" INcome from Qualified Equity Grants Under Section 83(i) : +Code "HH" Aggregate Defferals Under Section 83(i) Electionsas of the Cloase of the Calendar Year : +Third Party Sick Pay Indicator : +Statutory Employee : +Retirement Pan Indicator : +Statutory Employee : +W2 Submission Type : +W2 WHC SSN Validation Code : +FORM 1099-G +Payer : + Payer's Federal Identification Number (FIN) :XXXXX4775 + THE + 101 EA + +Reciepient : + Reciepient's Social Security Number :XXX-XX-1725 : + WOO ZACH T : + 5222 B : + +Submission Type : +Account Number (Optional) : +ATAA Payments : +Tax Withheld : +Taxable Grants : +Unemployement Compensation : +Agricultural Subsidiaries : +Prior Year Refund : +Markey gain on Commodity Credit Corporation loans repaid : +Year of Refund : +1099G Offset : +Second TIN Notice : +This Product Contains Sensitive Taxpayer Dataa Note: this Report is generated based on THE payroll data for your reference only. please contact IRS office for special cases such as late Payment, previous overpayment, penalty. Please +Note: This report doesn't include the pay back amount of +88-1303491 State ID: 00037305581 SSN: 633-44-1725 00000 Employee Number: 37305581 Description Amount 5/4/2022 - 6/4/2022 Payment Amount (Total) 9246754678763 Display All 1. Social Security (Employee + Employer) 26662 2. Medicare (Employee + Employer) 861193422444 Hourly 3. Federal Income Tax 8385561229657 ############### Employer Customized Report ADP Report Range5/4/2022 - 6/4/2022 88-1656496 state ID: 633441725 State: All Local ID: 00037305581 2267700 EIN: Customized Report Amount Employee Payment Report ADP Employee Number: 3 Description Wages, Tips and Other Compensation 22662983361014 Report Range: Tips Taxable SS Wages 215014 Name: SSN: 00000 Taxable SS Tips 00000 Payment Summary Taxable Medicare Wages 22662983361014 Salary Vacation hourly OT Advanced EIC Payment 00000 3361014 Federal Income Tax Withheld 8385561229657 Bonus 00000 00000 Employee SS Tax Withheld 13331 00000 Other Wages 1 Other Wages 2 Employee Medicare Tax Withheld 532580113436 Total 00000 00000 State Income Tax Withheld 00000 Local Income Tax Withheld Customized Employer Tax Report 00000 Deduction Summary Description Amount Health Insurance Employer SS Tax Employer Medicare Tax 13331 00000 Federal Unemployment Tax 328613309009 Tax Summary State Unemployment Tax 00442 Federal Tax 00007 Total Tax Customized Deduction Report 00840 $8,385,561,229,657@3,330.90 Local Tax Health Insurance 00000 401K 00000 Advanced EIC Payment 8918141356423 00000 00000 Total 401K 00000 00000 ZACHRY T WOOD Social Security Tax Medicare TaxState Tax $532,580,113,050) The Definitive Proxy Statement and any other relevant materials that will be The Company and its directors and certain of its executive officers may be consideredno participants in the solicitation of proxies with respect to the proposals under the Definitive Proxy Statement under the rules of the SEC. Additional information regarding the participants in the proxy solicitations and a description of their direct and indirect interests, by security holdings or otherwise, also will be included in the Definitive Proxy Statement and other relevant materials to be filed with the SEC when they become available. . ############ 3/6/2022 at 6:37 PM Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020 GOOGL_income-statement_Quarterly_As_Originally_Reported 24934000000 25539000000 37497000000 31211000000 30818000000 24934000000 25539000000 21890000000 19289000000 22677000000 Cash Flow from Operating Activities, Indirect 24934000000 25539000000 21890000000 19289000000 22677000000 Net Cash Flow from Continuing Operating Activities, Indirect 20642000000 18936000000 18525000000 17930000000 15227000000 Cash Generated from Operating Activities 6517000000 3797000000 4236000000 2592000000 5748000000 Income/Loss before Non-Cash Adjustment 3439000000 3304000000 2945000000 2753000000 3725000000 Total Adjustments for Non-Cash Items 3439000000 3304000000 2945000000 2753000000 3725000000 Depreciation, Amortization and Depletion, Non-Cash Adjustment 3215000000 3085000000 2730000000 2525000000 3539000000 Depreciation and Amortization, Non-Cash Adjustment 224000000 219000000 215000000 228000000 186000000 Depreciation, Non-Cash Adjustment 3954000000 3874000000 3803000000 3745000000 3223000000 Amortization, Non-Cash Adjustment 1616000000 -1287000000 379000000 1100000000 1670000000 +Stock-Based Compensation, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000 + Taxes, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000 Investment Income/Loss, Non-Cash Adjustment -14000000 64000000 -8000000 -255000000 392000000 Gain/Loss on Financial Instruments, Non-Cash Adjustment -2225000000 2806000000 -871000000 -1233000000 1702000000 + Other Non-Cash Items -5819000000 -2409000000 -3661000000 2794000000 -5445000000 Changes in Operating Capital -5819000000 -2409000000 -3661000000 2794000000 -5445000000 Change in Trade and Other Receivables -399000000 -1255000000 -199000000 7000000 -738000000 Change in Trade/Accounts Receivable 6994000000 3157000000 4074000000 -4956000000 6938000000 Change in Other Current Assets 1157000000 238000000 -130000000 -982000000 963000000 Change in Payables and Accrued Expenses 1157000000 238000000 -130000000 -982000000 963000000 Change in Trade and Other Payables 5837000000 2919000000 4204000000 -3974000000 5975000000 + Change in Trade/Accounts Payable 368000000 272000000 -3000000 137000000 207000000 Change in Accrued Expenses -3369000000 3041000000 -1082000000 785000000 740000000 Change in Deferred Assets/Liabilities Change in Other Operating Capital -11016000000 -10050000000 -9074000000 -5383000000 -7281000000 + Change in Prepayments and Deposits -11016000000 -10050000000 -9074000000 -5383000000 -7281000000 + Cash Flow from Investing Activities Cash Flow from Continuing Investing Activities -6383000000 -6819000000 -5496000000 -5942000000 -5479000000 -6383000000 -6819000000 -5496000000 -5942000000 -5479000000 + Purchase/Sale and Disposal of Property, Plant and Equipment, Net Purchase of Property, Plant and Equipment -385000000 -259000000 -308000000 -1666000000 -370000000 Sale and Disposal of Property, Plant and Equipment -385000000 -259000000 -308000000 -1666000000 -370000000 00000 + Purchase/Sale of Business, Net -4348000000 -3360000000 -3293000000 2195000000 -1375000000 + Purchase/Acquisition of Business -40860000000 -35153000000 -24949000000 -37072000000 -36955000000 + Purchase/Sale of Investments, Net Purchase of Investments 36512000000 31793000000 21656000000 39267000000 35580000000 100000000 388000000 23000000 30000000 -57000000 Sale of Investments Other Investing Cash Flow -15254000000 + Purchase/Sale of Other Non-Current Assets, Net -16511000000 -15254000000 -15991000000 -13606000000 -9270000000 + Sales of Other Non-Current Assets -16511000000 -12610000000 -15991000000 -13606000000 -9270000000 + Cash Flow from Financing Activities -13473000000 -12610000000 -12796000000 -11395000000 -7904000000 + Cash Flow from Continuing Financing Activities 13473000000 -12796000000 -11395000000 -7904000000 Issuance of/Payments for Common 343 sec cvxvxvcclpddf wearsStock, Net -42000000 Payments for Common Stock 115000000 -42000000 -1042000000 -37000000 -57000000 Proceeds from Issuance of Common Stock 115000000 6350000000 -1042000000 -37000000 -57000000 Issuance of/Repayments for Debt, Net 6250000000 -6392000000 6699000000 900000000 00000 Issuance of/Repayments for Long Term Debt, Net 6365000000 -2602000000 -7741000000 -937000000 -57000000 Proceeds from Issuance of Long Term Debt Repayments for Long Term Debt 2923000000 -2453000000 -2184000000 -1647000000 Proceeds from Issuance/Exercising of Stock Options/Warrants 00000 300000000 10000000 338000000000 Other Financing Cash Flow Cash and Cash Equivalents, End of Period Change in Cash 20945000000 23719000000 23630000000 26622000000 26465000000 Effect of Exchange Rate Changes 25930000000) 235000000000) -3175000000 300000000 6126000000 Cash and Cash Equivalents, Beginning of Period PAGE="$USD(181000000000)".XLS BRIN="$USD(146000000000)".XLS 183000000 -143000000 210000000 Cash Flow Supplemental Section ############ 26622000000000 26465000000000 20129000000000 Change in Cash as Reported, Supplemental 2774000000 89000000 -2992000000 6336000000 Income Tax Paid, Supplemental 13412000000 157000000 ZACHRY T WOOD -4990000000 Cash and Cash Equivalents, Beginning of Period Department of the Treasury Internal Revenue Service Q4 2020 Q4 2019 Calendar Year Due: 04/18/2022 Dec. 31, 2020 Dec. 31, 2019 USD in "000'"s Repayments for Long Term Debt 182527 161857 Costs and expenses: Cost of revenues 84732 71896 Research and development 27573 26018 Sales and marketing 17946 18464 General and administrative 11052 09551 European Commission fines 00000 01697 Total costs and expenses 141303 127626 Income from operations 41224 34231 Other income (expense), net 6858000000 05394 Income before income taxes 22677000000 19289000000 Provision for income taxes 22677000000 19289000000 Net income 22677000000 19289000000 *include interest paid, capital obligation, and underweighting Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) *include interest paid, capital obligation, and underweighting Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) 20210418 Rate Units Total YTD Taxes / Deductions Current YTD - - 70842745000 70842745000 Federal Withholding 00000 00000 FICA - Social Security 00000 08854 FICA - Medicare 00000 00000 Employer Taxes FUTA 00000 00000 SUTA 00000 00000 EIN: 61-1767919 ID : 00037305581 SSN: 633441725 Gross 70842745000 Earnings Statement Taxes / Deductions Stub Number: 1 00000 Net Pay SSN Pay Schedule Pay Period Sep 28, 2022 to Sep 29, 2023 Pay Date 44669 70842745000 XXX-XX-1725 Annually CHECK NO. 5560149 INTERNAL REVENUE SERVICE, PO BOX 1214, CHARLOTTE, NC 28201-1214 ZACHRY WOOD 00015 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000 For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000 Cat. No. 11320B 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000 Form 1040 (2021) 76033000000 20642000000 18936000000 Reported Normalized and Operating Income/Expense Supplemental Section Total Revenue as Reported, Supplemental 257637000000 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000 40499000000 Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000 9177000000 Reported Effective Tax Rate 00000 00000 00000 00000 00000 00000 00000 00000 Reported Normalized Income 6836000000 Reported Normalized Operating Profit 7977000000 Other Adjustments to Net Income Available to Common Stockholders Discontinued Operations Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 Basic EPS from Continuing Operations 00114 00031 00028 00028 00027 00022 00017 00010 00010 00015 00010 Basic EPS from Discontinued Operations Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010 Diluted EPS from Continuing Operations 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010 Diluted EPS from Discontinued Operations Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000 Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000 Reported Normalized Diluted EPS 00010 Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 00001 Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010 Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000 Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000 Fiscal year end September 28th., 2022. | USD For Paperwork Reduction Act Notice, see the seperate Instructions. important information Description Restated Certificate of Incorporation of PayPal Holdings, Inc. (incorporated by reference to Exhibit 3.01 to PayPal Holdings, Inc.'s Quarterly Report on Form 10-Q, as filed with the Commission on July 27, 2017). Amended and Restated Bylaws of PayPal Holdings, Inc. (incorporated by reference to Exhibit 3.1 to PayPal Holdings, Inc.'s Current Report on Form 8-K, as filed with the Commission on January 18, 2019). Opinion of Faegre Drinker Biddle & Reath LLP. Consent of PricewaterhouseCoopers LLP, Independent Registered Public Accounting Firm. Consent of Faegre Drinker Biddle & Reath LLP (included in Exhibit 5.1 to this Registration Statement). Power of Attorney (included on the signature page of this Registration Statement). All of Us Financial Inc. 2021 Equity Incentive Plan. Filing Fee Table. Business Checking For 24-hour account information, sign on to [pnc.com/mybusiness/](http://pnc.com/mybusiness/) Business Checking Account number: 47-2041-6547 - continued Activity Detail Deposits and Other Additions ACH Additions Date posted Amount Transaction description For the period 04/13/2022 to 04/29/2022 ZACHRY TYLER WOOD Primary account number: 47-2041-6547 Page 2 of 3 44678 00063 Reverse Corporate ACH Debit Effective 04-26-22 Reference number Checks and Other Deductions 22116905560149 Deductions Reference number Date posted Amount Transaction description 22116905560149 44677 00063 Corporate ACH Quickbooks 180041ntuit 1940868 Reference number Service Charges and Fees 22116905560149 Date posted Amount Transaction description on your next statement as a single line item entitled Service Waived - New Customer Period 44678 00036 Returned Item Fee (nsf) Detail of Services Used During Current Period Note: The total charge for the following services will be posted to your account on 05/02/2022 and will appear on your next statement a Charge Period Ending 04/29/2022, Description Volume Amount Account Maintenance Charge 70846743866 00000 Total For Services Used This Peiiod 00000 00000 Total Service (harge 00 00000 Reviewing Your Statement ('PNCBANK Please review this statement carefully and reconcile it with your records. Call the telephone number on the upper right side of the first page of this statement if: you have any questions regarding your account(s); your name or address is incorrect; • you have any questions regarding interest paid to an interest-bearing account. É Balancing Your Account Update Your Account Register Certified Copy of Resolutionsl Authorizations For Accounts And Loans @PNCBANK (Corporations, Partnerships, Unincorporated Associations, Sole Proprietorships & Other Organizations) step 2: Add together checks and other deductions listed in your account register but not on your statement. PNC Bank, National Association ("Bank") Taxpayer I.D. Number (TIN) C'eck Deduction Descretio• Anount (iv) (v) account or benefit, or in payment of the individual obligations of, any individual obligations of any such persons to the Bank without regard to the disposition or purpose of same as allowed by applicable law. D pNCBANK In addition but not by way of limitation, the Bank may take checks, drafts or other items payable to "cash", the Bank or the Customer, and pay the sums represented by such Items in cash to any person presenting such items or credit such Items to the account or obligations of any person presenting such items or any other person or entity as directed by any such person. Products and Services. Resolved that any of the persons listed in Section 3 above are authorized to enter into contracts and agreements, written or verbal, for any products or services now or in the future offered by the Bank, including but not limited to (i) cash management services, (ii) purchases or sales of foreign exchange, securities or other financial products, (iii) computer/internet-based products and services, (iv) wire transfer of funds from or to the accounts of the Customer at the Bank, and (v) ACH transactions, and the Bank may charge any accounts of the Customer at the Bank for such products or services. 00005 Taxpayer I.D. Number (TIN) OWNER ("Customer") 633-44-1725 are hereby authorized (i) to effect loans, advances and renewals at any time for the Customer from the Bank; (ii) to sign and deliver any notes (with or without warrant of attorney to confess judgment) and evidences of indebtedness of the Customer; (iii) to request the Bank to issue letters of credit and to sign and deliver to the bank any agreements on behalf of the Customer to reimburse the Bank for all payments made and expenses incurred by it under such letters of credit and drafts drawn pursuant thereto; (iv) to sign and deliver any instruments or documents on behalf of the Customer guaranteeing, endorsing or securing the payment of any debts or obligations of any person, form or corporation to the Bank; (v) to pledge, assign, transfer, mortgage, grant a security interest in or otherwise hypothecate to the Bank any stock, securities, commercial paper, warehouse receipts and other documents of title, bills, accounts receivable, contract rights, inventory, equipment, real property, and any other investment 00006 Revolving Credits. Resolved that in connection with any extension of credit obtained by any of the persons authorized in Section 5 above, that permit the Customer to effect multiple advances or draws under such credit, any of the persons listed in Sections 5 (Loans and Extensions of Credit) and 3 (Withdrawals and Endorsements) Resolution for ALPHABET 00007 Telephonic and Facsimile Requests. Resolved that the Bank is authorized to take any action authorized hereunder based upon (i) the telephone request of any person purporting to be a person authorized to act hereunder, (ii) the signature of any person authorized to act hereunder that is delivered to the Bank by facsimile transmission, or (iii) the telex originated by any of such persons, tested in accordance with such testing : Tr R •d Ming or serVlCö n lent services, (ii) purchases or sales of foreig xlll) computerfinternet-based products and services, (iv) wir he Customer at the Bank, and (v) ACH transactions, and the Ba the Bank for such products or services. It. Resolved that any one of the following: procedures as may be established between the Customer and the Bank from time to time. General. Resolved that a certified copy of these resolutiEmployer Taxes 70842745000 XXX-XX-1725 + 0 Rate + This period YTD Taxes / Deductions Current YTD + Pay Schedulec 70842745000 70842745000 Federal Withholding 0 0 + Annually 70842745000 70842745000 Federal Withholding 0 0 + Units Q1 TTM Taxes / Deductions Current YTD + Q3 70842745000 70842745000 Federal Withholding 0 0 + Q4 70842745000 70842745000 Federal Withholding 0 0 + Net Pay RUTA 0 0 + 70842745000 SUTA 0 0 + 20210418 FICA - Medicare 0 0 + FICA - Social Security 0 8854 Earnings Statement +Taxes / Deductions Stub Number: 1 - +Taxable Maritial Status: Single - +TX: 28 +Federal 941 Deposit Report +Report Range: 5/4/2022 - 6/4/2022 Local ID: +EIN: 63-3441725 Local ID: TX:28 NO state Tax +Employee NAumboeurn:T3 Form: SS-4 +Description 5/4/2022 - 6/4/2022 +Payment Amount (Total) $9,246,754,678,763.00 Display All +1. Social Security (Employee + Employer) $26,661.80 +2. Medicare (Employee + Employer) $861,193,422,444.20 Hourly +3. Federal Income Tax $8,385,561,229,657.00 +Note: this Report is generated based on THE payroll data for your reference only. Pease contact IRS office for special cases such as late Payment, previous overpayment, penalty We assigned you Employer Identification Number : 88-1303491 Best Time To Call +Note: This report doesn't include the pay back amount of +Employer Customized Report 6.35- ________________________ ________________________ DATE OF THIS NOTICE: 2022-03-18 +ADP +Report Range5/4/2022 - 6/4/2022 88-1656496 Loca ID: 28 :l ID: 633441725 State: All Local ID: 00037305581 $2,267,700.00 +EIN: Total Year to Date +Internal Revenue Service Due 04/18/2022 2022 Form 1040-ES Payment Voucher 1 Pay Day 1/30/2022 ++ MOUNTAIN VIEW, C.A., 94043 ++ Taxable Marital Status : ++ Exemptions/Allowances : ++ Federal : ++ TX : 28 rate units this period year to date Other Benefits and ZACHRY T ++ Current assets: 0 Information WOOD ++ Cash and cash equivalents 26465 18498 0 Total Work Hrs ++ Marketable securities 110229 101177 0 Important Notes DALLAS ++ Total cash, cash equivalents, and marketable securities 136694 119675 0 COMPANY PH/Y: 650-253-0000 0 ++ Accounts receivable, net 30930 25326 0 BASIS OF PAY : BASIC/DILUTED EPS ++ Income taxes receivable, net 454 2166 0 ++ Inventory 728 999 0 Pto Balance ++ Other current assets 5490 4412 0 ++ Total current assets 174296 152578 0 ++ Non-marketable investments 20703 13078 0 70842743866 ++ Deferred income taxes 1084 721 0 ++ Property and equipment, net 84749 73646 0 $70,842,743,866.00 ++ Operating lease assets 12211 10941 0 ++ Intangible assets, net 1445 1979 0 ++ Goodwill 21175 20624 0 Advice date : 650001 ++ Other non-current assets 3953 2342 0 Pay date : 4/18/2022 ++ PLEASE READ THE IMPORTANT DISCLOSURES BELOW. 319616 275909 0 :xxxxxxxxx6547 JAn 29th., 2022 ++ Paid to the account Of : 0 519 ++ Accounts payable 5589 5561 0 NON-NEGOTIABLE ++ Accrued compensation and benefits 11086 8495 0 ++ Accrued expenses and other current liabilities 28631 23067 0 ++ Accrued revenue share 7500 5916 0 ++ Deferred revenue 2543 1908 0 ++ Income taxes payable, net 1485 274 0 ++ Total current liabilities 56834 45221 0 ++ Long-term debt 13932 4554 0 ++ Deferred revenue, non-current 481 358 0 ++ Income taxes payable, non-current 8849 9885 0 ++ Deferred income taxes 3561 1701 0 ++ 11146 10214 0 ++ Other long-term liabilities 2269 2534 0 ++ Total liabilities 97072 74467 0 ++ Commitments and Contingencies (Note 10) 0 ++ Stockholders’ equity: 0 ++ Convertible preferred stock, $0.001 par value per share, 100,000 shares authorized; no shares issued and outstanding 0 0 0 ++ Class A and Class B common stock, and Class C capital stock and additional paid-in capital, $0.001 par value per share: 15,000,000 shares authorized (Class A 9,000,000, Class B 3,000,000, Class C 3,000,000); 688,335 (Class A 299,828, Class B 46,441, Class C 342,066) and 675,222 (Class A 300,730, Class B 45,843, Class C 328,649) shares issued and outstanding 58510 50552 0 ++ Accumulated other comprehensive income (loss) 633 -1232 0 ++ Retained earnings 163401 152122 0 ++ Total stockholders’ equity 222544 201442 0 ++ Total liabilities and stockholders’ equity 319616 275909 0 ++ Convertible preferred stock, par value (in dollars per share) 0.001 0.001 0 ++ Convertible preferred stock, shares authorized (in shares) 100000000 100000000 0 ++ Convertible preferred stock, shares issued (in shares) 0 0 0 ++ Convertible preferred stock, shares outstanding (in shares) 0 0 0 ++ Schedule II: Valuation and Qualifying Accounts (Details) - Allowance for doubtful accounts and sales credits - USD ($) $ in Millions 12 Months Ended 0 ++ Dec. 31, 2020 Dec. 31, 2019 Dec. 31, 2018 0 ++ SEC Schedule, 12-09, Movement in Valuation Allowances and Reserves [Roll Forward] 0 ++ Revenues (Narrative) (Details) - USD ($) $ in Billions 12 Months Ended 0 ++ Dec. 31, 2020 Dec. 31, 2019 0 ++ Revenue from Contract with Customer [Abstract] 0 ++ Deferred revenue 2.3 0 ++ Revenues recognized 1.8 0 ++ Transaction price allocated to remaining performance obligations 29.8 0 ++ Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction, Start Date [Axis]: 2021-01-01 0 ++ Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction [Line Items] 0 ++ Expected timing of revenue recognition 24 months 0 ++ Expected timing of revenue recognition, percent 0.5 0 ++ Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction, Start Date [Axis]: 2023-01-01 0 ++ Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction [Line Items] 0 ++ Expected timing of revenue recognition 0 ++ Expected timing of revenue recognition, percent 0.5 0 ++ Information about Segments and Geographic Areas (Long-Lived Assets by Geographic Area) (Details) - USD ($) $ in Millions Dec. 31, 2020 Dec. 31, 2019 0 ++ Revenues from External Customers and Long-Lived Assets [Line Items] 0 ++ Long-lived assets 96960 84587 0 ++ United States 0 ++ Revenues from External Customers and Long-Lived Assets [Line Items] 0 ++ Long-lived assets 69315 63102 0 ++ International 0 ++ Revenues from External Customers and Long-Lived Assets [Line Items] 0 ++ Long-lived assets 27645 21485 0 ++ 2016 2017 2018 2019 2020 2021 TTM ++ 2.23418E+11 2.42061E+11 2.25382E+11 3.27223E+11 2.86256E+11 3.54636E+11 3.54636E+11 ++ 45881000000 60597000000 57418000000 61078000000 63401000000 69478000000 69478000000 ++ 3143000000 3770000000 4415000000 4743000000 5474000000 6052000000 6052000000 ++ Net Investment Income, Revenue 9531000000 13081000000 10565000000 17214000000 14484000000 8664000000 -14777000000 81847000000 48838000000 86007000000 86007000000 ++ Realized Gain/Loss on Investments, Revenue 472000000 184000000 72000000 10000000 7553000000 1410000000 -22155000000 71123000000 40905000000 77576000000 77576000000 ++ Gains/Loss on Derivatives, Revenue 1963000000 2608000000 506000000 974000000 751000000 718000000 -300000000 1484000000 -159000000 966000000 966000000 ++ Interest Income, Revenue 6106000000 6408000000 6484000000 6867000000 6180000000 6536000000 7678000000 9240000000 8092000000 7465000000 7465000000 ++ Other Investment Income, Revenue 990000000 3881000000 3503000000 9363000000 ++ Rental Income, Revenue 2553000000 2452000000 5732000000 5856000000 5209000000 5988000000 5988000000 ++ Other Revenue 1.18387E+11 1.32385E+11 1.42881E+11 1.52435E+11 1.57357E+11 1.66578E+11 1.72594E+11 1.73699E+11 1.63334E+11 1.87111E+11 1.87111E+11 ++ Total Expenses -1.40227E+11 -1.53354E+11 -1.66594E+11 -1.75997E+11 -1.89751E+11 -2.18223E+11 -2.21381E+11 -2.24527E+11 -2.30563E+11 -2.4295E+11 -2.4295E+11 ++ Benefits,Claims and Loss Adjustment Expense, Net -25227000000 -26347000000 -31587000000 -31940000000 -36037000000 -54509000000 -45605000000 -49442000000 -49763000000 -55971000000 -55971000000 ++ Policyholder Future Benefits and Claims, Net -25227000000 -26347000000 -31587000000 -31940000000 -36037000000 -54509000000 -45605000000 -49442000000 -49763000000 -55971000000 -55971000000 ++ Other Underwriting Expenses -7693000000 -7248000000 -6998000000 -7517000000 -7713000000 -9321000000 -9793000000 -11200000000 -12798000000 -12569000000 -12569000000 ++ Selling, General and Administrative Expenses -11870000000 -13282000000 -13721000000 -15309000000 -19308000000 -20644000000 -21917000000 -23229000000 -23329000000 -23044000000 -23044000000 ++ Rent Expense -1335000000 -1455000000 -4061000000 -4003000000 -3520000000 -4201000000 -4201000000 ++ Selling and Marketing Expenses -11870000000 -13282000000 -13721000000 -15309000000 -17973000000 -19189000000 -17856000000 -19226000000 -19809000000 -18843000000 -18843000000 ++ Other Income/Expenses -92693000000 -1.03676E+11 -1.11009E+11 -1.17594E+11 -1.24061E+11 -1.32377E+11 -1.37664E+11 -1.37775E+11 -1.30645E+11 -1.48189E+11 -1.48189E+11 ++ Total Net Finance Income/Expense -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 ++ Net Interest Income/Expense -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 ++ Interest Expense Net of Capitalized Interest -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 ++ Income from Associates, Joint Ventures and Other Participating Interests -26000000 -122000000 1109000000 3014000000 -2167000000 1176000000 726000000 995000000 995000000 ++ Irregular Income/Expenses -382000000 -96000000 -10671000000 . . ++ Impairment/Write Off/Write Down of Capital Assets -382000000 -96000000 -10671000000 . . ++ Pretax Income 22236000000 28796000000 28105000000 34946000000 33667000000 23838000000 4001000000 1.02696E+11 55693000000 1.11686E+11 1.11686E+11 ++ Provision for Income Tax -6924000000 -8951000000 -7935000000 -10532000000 -9240000000 21515000000 321000000 -20904000000 -12440000000 -20879000000 -20879000000 ++ Net Income from Continuing Operations 15312000000 19845000000 20170000000 24414000000 24427000000 45353000000 4322000000 81792000000 43253000000 90807000000 90807000000 ++ Net Income after Extraordinary Items and Discontinued Operations 15312000000 19845000000 20170000000 24414000000 24427000000 45353000000 4322000000 81792000000 43253000000 90807000000 90807000000 ++ Non-Controlling/Minority Interests -488000000 -369000000 -298000000 -331000000 -353000000 -413000000 -301000000 -375000000 -732000000 -1012000000 -1012000000 ++ Net Income after Non-Controlling/Minority Interests 14824000000 19476000000 19872000000 24083000000 24074000000 44940000000 4021000000 81417000000 42521000000 89795000000 89795000000 ++ Net Income Available to Common Stockholders 14824000000 19476000000 19872000000 24083000000 24074000000 44940000000 4021000000 81417000000 42521000000 89795000000 89795000000 ++ Diluted Net Income Available to Common Stockholders 14824000000 19476000000 19872000000 24083000000 24074000000 44940000000 4021000000 81417000000 42521000000 89795000000 89795000000 ++ Income Statement Supplemental Section ++ Reported Normalized and Operating Income/Expense Supplemental Section +88-1303491 State ID: 00037305581 SSN: 633-44-1725 00000 Employee Number: 3 Description Amount 5/4/2022 - 6/4/2022 Payment Amount (Total) 9246754678763 Display All 1. Social Security (Employee + Employer) 26662 2. Medicare (Employee + Employer) 861193422444 Hourly 3. Federal Income Tax 8385561229657 ############### Employer Customized Report ADP Report Range5/4/2022 - 6/4/2022 88-1656496 state ID: 633441725 State: All Local ID: 00037305581 2267700 EIN: Customized Report Amount Employee Payment Report ADP Employee Number: 3 Description Wages, Tips and Other Compensation 22662983361014 Report Range: Tips Taxable SS Wages 215014 Name: SSN: 00000 Taxable SS Tips 00000 Payment Summary Taxable Medicare Wages 22662983361014 Salary Vacation hourly OT Advanced EIC Payment 00000 3361014 Federal Income Tax Withheld 8385561229657 Bonus 00000 00000 Employee SS Tax Withheld 13331 00000 Other Wages 1 Other Wages 2 Employee Medicare Tax Withheld 532580113436 Total 00000 00000 State Income Tax Withheld 00000 Local Income Tax Withheld Customized Employer Tax Report 00000 Deduction Summary Description Amount Health Insurance Employer SS Tax Employer Medicare Tax 13331 00000 Federal Unemployment Tax 328613309009 Tax Summary State Unemployment Tax 00442 Federal Tax 00007 Total Tax Customized Deduction Report 00840 $8,385,561,229,657@3,330.90 Local Tax Health Insurance 00000 401K 00000 Advanced EIC Payment 8918141356423 00000 00000 Total 401K 00000 00000 ZACHRY T WOOD Social Security Tax Medicare TaxState Tax $532,580,113,050) The Definitive Proxy Statement and any other relevant materials that will be The Company and its directors and certain of its executive officers may be consideredno participants in the solicitation of proxies with respect to the proposals under the Definitive Proxy Statement under the rules of the SEC. Additional information regarding the participants in the proxy solicitations and a description of their direct and indirect interests, by security holdings or otherwise, also will be included in the Definitive Proxy Statement and other relevant materials to be filed with the SEC when they become available. . ############ 3/6/2022 at 6:37 PM Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020 GOOGL_income-statement_Quarterly_As_Originally_Reported 24934000000 25539000000 37497000000 31211000000 30818000000 24934000000 25539000000 21890000000 19289000000 22677000000 Cash Flow from Operating Activities, Indirect 24934000000 25539000000 21890000000 19289000000 22677000000 Net Cash Flow from Continuing Operating Activities, Indirect 20642000000 18936000000 18525000000 17930000000 15227000000 Cash Generated from Operating Activities 6517000000 3797000000 4236000000 2592000000 5748000000 Income/Loss before Non-Cash Adjustment 3439000000 3304000000 2945000000 2753000000 3725000000 Total Adjustments for Non-Cash Items 3439000000 3304000000 2945000000 2753000000 3725000000 Depreciation, Amortization and Depletion, Non-Cash Adjustment 3215000000 3085000000 2730000000 2525000000 3539000000 Depreciation and Amortization, Non-Cash Adjustment 224000000 219000000 215000000 228000000 186000000 Depreciation, Non-Cash Adjustment 3954000000 3874000000 3803000000 3745000000 3223000000 Amortization, Non-Cash Adjustment 1616000000 -1287000000 379000000 1100000000 1670000000 +Stock-Based Compensation, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000 + Taxes, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000 Investment Income/Loss, Non-Cash Adjustment -14000000 64000000 -8000000 -255000000 392000000 Gain/Loss on Financial Instruments, Non-Cash Adjustment -2225000000 2806000000 -871000000 -1233000000 1702000000 + Other Non-Cash Items -5819000000 -2409000000 -3661000000 2794000000 -5445000000 Changes in Operating Capital -5819000000 -2409000000 -3661000000 2794000000 -5445000000 Change in Trade and Other Receivables -399000000 -1255000000 -199000000 7000000 -738000000 Change in Trade/Accounts Receivable 6994000000 3157000000 4074000000 -4956000000 6938000000 Change in Other Current Assets 1157000000 238000000 -130000000 -982000000 963000000 Change in Payables and Accrued Expenses 1157000000 238000000 -130000000 -982000000 963000000 Change in Trade and Other Payables 5837000000 2919000000 4204000000 -3974000000 5975000000 + Change in Trade/Accounts Payable 368000000 272000000 -3000000 137000000 207000000 Change in Accrued Expenses -3369000000 3041000000 -1082000000 785000000 740000000 Change in Deferred Assets/Liabilities Change in Other Operating Capital -11016000000 -10050000000 -9074000000 -5383000000 -7281000000 + Change in Prepayments and Deposits -11016000000 -10050000000 -9074000000 -5383000000 -7281000000 + Cash Flow from Investing Activities Cash Flow from Continuing Investing Activities -6383000000 -6819000000 -5496000000 -5942000000 -5479000000 -6383000000 -6819000000 -5496000000 -5942000000 -5479000000 + Purchase/Sale and Disposal of Property, Plant and Equipment, Net Purchase of Property, Plant and Equipment -385000000 -259000000 -308000000 -1666000000 -370000000 Sale and Disposal of Property, Plant and Equipment -385000000 -259000000 -308000000 -1666000000 -370000000 00000 + Purchase/Sale of Business, Net -4348000000 -3360000000 -3293000000 2195000000 -1375000000 + Purchase/Acquisition of Business -40860000000 -35153000000 -24949000000 -37072000000 -36955000000 + Purchase/Sale of Investments, Net Purchase of Investments 36512000000 31793000000 21656000000 39267000000 35580000000 100000000 388000000 23000000 30000000 -57000000 Sale of Investments Other Investing Cash Flow -15254000000 + Purchase/Sale of Other Non-Current Assets, Net -16511000000 -15254000000 -15991000000 -13606000000 -9270000000 + Sales of Other Non-Current Assets -16511000000 -12610000000 -15991000000 -13606000000 -9270000000 + Cash Flow from Financing Activities -13473000000 -12610000000 -12796000000 -11395000000 -7904000000 + Cash Flow from Continuing Financing Activities 13473000000 -12796000000 -11395000000 -7904000000 Issuance of/Payments for Common 343 sec cvxvxvcclpddf wearsStock, Net -42000000 Payments for Common Stock 115000000 -42000000 -1042000000 -37000000 -57000000 Proceeds from Issuance of Common Stock 115000000 6350000000 -1042000000 -37000000 -57000000 Issuance of/Repayments for Debt, Net 6250000000 -6392000000 6699000000 900000000 00000 Issuance of/Repayments for Long Term Debt, Net 6365000000 -2602000000 -7741000000 -937000000 -57000000 Proceeds from Issuance of Long Term Debt Repayments for Long Term Debt 2923000000 -2453000000 -2184000000 -1647000000 Proceeds from Issuance/Exercising of Stock Options/Warrants 00000 300000000 10000000 338000000000 Other Financing Cash Flow Cash and Cash Equivalents, End of Period Change in Cash 20945000000 23719000000 23630000000 26622000000 26465000000 Effect of Exchange Rate Changes 25930000000) 235000000000) -3175000000 300000000 6126000000 Cash and Cash Equivalents, Beginning of Period PAGE="$USD(181000000000)".XLS BRIN="$USD(146000000000)".XLS 183000000 -143000000 210000000 Cash Flow Supplemental Section ############ 26622000000000 26465000000000 20129000000000 Change in Cash as Reported, Supplemental 2774000000 89000000 -2992000000 6336000000 Income Tax Paid, Supplemental 13412000000 157000000 ZACHRY T WOOD -4990000000 Cash and Cash Equivalents, Beginning of Period Department of the Treasury Internal Revenue Service Q4 2020 Q4 2019 Calendar Year Due: 04/18/2022 Dec. 31, 2020 Dec. 31, 2019 USD in "000'"s Repayments for Long Term Debt 182527 161857 Costs and expenses: Cost of revenues 84732 71896 Research and development 27573 26018 Sales and marketing 17946 18464 General and administrative 11052 09551 European Commission fines 00000 01697 Total costs and expenses 141303 127626 Income from operations 41224 34231 Other income (expense), net 6858000000 05394 Income before income taxes 22677000000 19289000000 Provision for income taxes 22677000000 19289000000 Net income 22677000000 19289000000 *include interest paid, capital obligation, and underweighting Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) *include interest paid, capital obligation, and underweighting Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) 20210418 Rate Units Total YTD Taxes / Deductions Current YTD - - 70842745000 70842745000 Federal Withholding 00000 00000 FICA - Social Security 00000 08854 FICA - Medicare 00000 00000 Employer Taxes FUTA 00000 00000 SUTA 00000 00000 EIN: 61-1767919 ID : 00037305581 SSN: 633441725 Gross 70842745000 Earnings Statement Taxes / Deductions Stub Number: 1 00000 Net Pay SSN Pay Schedule Pay Period Sep 28, 2022 to Sep 29, 2023 Pay Date 44669 70842745000 XXX-XX-1725 Annually CHECK NO. 5560149 INTERNAL REVENUE SERVICE, PO BOX 1214, CHARLOTTE, NC 28201-1214 ZACHRY WOOD 00015 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000 For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000 Cat. No. 11320B 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000 Form 1040 (2021) 76033000000 20642000000 18936000000 Reported Normalized and Operating Income/Expense Supplemental Section Total Revenue as Reported, Supplemental 257637000000 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000 40499000000 Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000 9177000000 Reported Effective Tax Rate 00000 00000 00000 00000 00000 00000 00000 00000 Reported Normalized Income 6836000000 Reported Normalized Operating Profit 7977000000 Other Adjustments to Net Income Available to Common Stockholders Discontinued Operations Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 Basic EPS from Continuing Operations 00114 00031 00028 00028 00027 00022 00017 00010 00010 00015 00010 Basic EPS from Discontinued Operations Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010 Diluted EPS from Continuing Operations 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010 Diluted EPS from Discontinued Operations Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000 Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000 Reported Normalized Diluted EPS 00010 Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 00001 Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010 Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000 Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000 Fiscal year end September 28th., 2022. | USD For Paperwork Reduction Act Notice, see the seperate Instructions. important information Description Restated Certificate of Incorporation of PayPal Holdings, Inc. (incorporated by reference to Exhibit 3.01 to PayPal Holdings, Inc.'s Quarterly Report on Form 10-Q, as filed with the Commission on July 27, 2017). Amended and Restated Bylaws of PayPal Holdings, Inc. (incorporated by reference to Exhibit 3.1 to PayPal Holdings, Inc.'s Current Report on Form 8-K, as filed with the Commission on January 18, 2019). Opinion of Faegre Drinker Biddle & Reath LLP. Consent of PricewaterhouseCoopers LLP, Independent Registered Public Accounting Firm. Consent of Faegre Drinker Biddle & Reath LLP (included in Exhibit 5.1 to this Registration Statement). Power of Attorney (included on the signature page of this Registration Statement). All of Us Financial Inc. 2021 Equity Incentive Plan. Filing Fee Table. Business Checking For 24-hour account information, sign on to [pnc.com/mybusiness/](http://pnc.com/mybusiness/) Business Checking Account number: 47-2041-6547 - continued Activity Detail Deposits and Other Additions ACH Additions Date posted Amount Transaction description For the period 04/13/2022 to 04/29/2022 ZACHRY TYLER WOOD Primary account number: 47-2041-6547 Page 2 of 3 44678 00063 Reverse Corporate ACH Debit Effective 04-26-22 Reference number Checks and Other Deductions 22116905560149 Deductions Reference number Date posted Amount Transaction description 22116905560149 44677 00063 Corporate ACH Quickbooks 180041ntuit 1940868 Reference number Service Charges and Fees 22116905560149 Date posted Amount Transaction description on your next statement as a single line item entitled Service Waived - New Customer Period 44678 00036 Returned Item Fee (nsf) Detail of Services Used During Current Period Note: The total charge for the following services will be posted to your account on 05/02/2022 and will appear on your next statement a Charge Period Ending 04/29/2022, Description Volume Amount Account Maintenance Charge 70846743866 00000 Total For Services Used This Peiiod 00000 00000 Total Service (harge 00 00000 Reviewing Your Statement ('PNCBANK Please review this statement carefully and reconcile it with your records. Call the telephone number on the upper right side of the first page of this statement if: you have any questions regarding your account(s); your name or address is incorrect; • you have any questions regarding interest paid to an interest-bearing account. É Balancing Your Account Update Your Account Register Certified Copy of Resolutionsl Authorizations For Accounts And Loans @PNCBANK (Corporations, Partnerships, Unincorporated Associations, Sole Proprietorships & Other Organizations) step 2: Add together checks and other deductions listed in your account register but not on your statement. PNC Bank, National Association ("Bank") Taxpayer I.D. Number (TIN) C'eck Deduction Descretio• Anount (iv) (v) account or benefit, or in payment of the individual obligations of, any individual obligations of any such persons to the Bank without regard to the disposition or purpose of same as allowed by applicable law. D pNCBANK In addition but not by way of limitation, the Bank may take checks, drafts or other items payable to "cash", the Bank or the Customer, and pay the sums represented by such Items in cash to any person presenting such items or credit such Items to the account or obligations of any person presenting such items or any other person or entity as directed by any such person. Products and Services. Resolved that any of the persons listed in Section 3 above are authorized to enter into contracts and agreements, written or verbal, for any products or services now or in the future offered by the Bank, including but not limited to (i) cash management services, (ii) purchases or sales of foreign exchange, securities or other financial products, (iii) computer/internet-based products and services, (iv) wire transfer of funds from or to the accounts of the Customer at the Bank, and (v) ACH transactions, and the Bank may charge any accounts of the Customer at the Bank for such products or services. 00005 Taxpayer I.D. Number (TIN) OWNER ("Customer") 633-44-1725 are hereby authorized (i) to effect loans, advances and renewals at any time for the Customer from the Bank; (ii) to sign and deliver any notes (with or without warrant of attorney to confess judgment) and evidences of indebtedness of the Customer; (iii) to request the Bank to issue letters of credit and to sign and deliver to the bank any agreements on behalf of the Customer to reimburse the Bank for all payments made and expenses incurred by it under such letters of credit and drafts drawn pursuant thereto; (iv) to sign and deliver any instruments or documents on behalf of the Customer guaranteeing, endorsing or securing the payment of any debts or obligations of any person, form or corporation to the Bank; (v) to pledge, assign, transfer, mortgage, grant a security interest in or otherwise hypothecate to the Bank any stock, securities, commercial paper, warehouse receipts and other documents of title, bills, accounts receivable, contract rights, inventory, equipment, real property, and any other investment 00006 Revolving Credits. Resolved that in connection with any extension of credit obtained by any of the persons authorized in Section 5 above, that permit the Customer to effect multiple advances or draws under such credit, any of the persons listed in Sections 5 (Loans and Extensions of Credit) and 3 (Withdrawals and Endorsements) Resolution for ALPHABET 00007 Telephonic and Facsimile Requests. Resolved that the Bank is authorized to take any action authorized hereunder based upon (i) the telephone request of any person purporting to be a person authorized to act hereunder, (ii) the signature of any person authorized to act hereunder that is delivered to the Bank by facsimile transmission, or (iii) the telex originated by any of such persons, tested in accordance with such testing : Tr R •d Ming or serVlCö n lent services, (ii) purchases or sales of foreig xlll) computerfinternet-based products and services, (iv) wir he Customer at the Bank, and (v) ACH transactions, and the Ba the Bank for such products or services. It. Resolved that any one of the following: procedures as may be established between the Customer and the Bank from time to time. General. Resolved that a certified copy of these resolutiEmployer Taxes 70842745000 XXX-XX-1725 + 0 Rate + This period YTD Taxes / Deductions Current YTD + Pay Schedulec 70842745000 70842745000 Federal Withholding 0 0 + Annually 70842745000 70842745000 Federal Withholding 0 0 + Units Q1 TTM Taxes / Deductions Current YTD + Q3 70842745000 70842745000 Federal Withholding 0 0 + Q4 70842745000 70842745000 Federal Withholding 0 0 + Net Pay RUTA 0 0 + 70842745000 SUTA 0 0 + 20210418 FICA - Medicare 0 0 + FICA - Social Security 0 8854 Earnings Statement +Taxes / Deductions Stub Number: 1 - +Taxable Maritial Status: Single - +TX: 28 +Federal 941 Deposit Report +Report Range: 5/4/2022 - 6/4/2022 Local ID: +EIN: 63-3441725 Local ID: TX:28 NO state Tax +Employee NAumboeurn:T3 Form: SS-4 +Description 5/4/2022 - 6/4/2022 +Payment Amount (Total) $9,246,754,678,763.00 Display All +1. Social Security (Employee + Employer) $26,661.80 +2. Medicare (Employee + Employer) $861,193,422,444.20 Hourly +3. Federal Income Tax $8,385,561,229,657.00 +Note: this Report is generated based on THE payroll data for your reference only. Pease contact IRS office for special cases such as late Payment, previous overpayment, penalty We assigned you Employer Identification Number : 88-1303491 Best Time To Call +Note: This report doesn't include the pay back amount of +Employer Customized Report 6.35- ________________________ ________________________ DATE OF THIS NOTICE: 2022-03-18 +ADP +Report Range5/4/2022 - 6/4/2022 88-1656496 Loca ID: 28 :l ID: 633441725 State: All Local ID: txdl 00037305581 SRVCCHG /* */$2,267,700.00 +EIN: Total Year to Date +Internal Revenue Service Due 04/18/2022 2022 Form 1040-ES Payment Voucher 1 Pay Day 1/30/2022 ++ MOUNTAIN VIEW, C.A., 94043 ++ Taxable Marital Status : ++ Exemptions/Allowances : ++ Federal : ++ TX : 28 rate units this period year to date Other Benefits and ZACHRY T ++ Current assets: 0 Information WOOD ++ Cash and cash equivalents 26465 18498 0 Total Work Hrs ++ Marketable securities 110229 101177 0 Important Notes DALLAS ++ Total cash, cash equivalents, and marketable securities 136694 119675 0 COMPANY PH/Y: 650-253-0000 0 ++ Accounts receivable, net 30930 25326 0 BASIS OF PAY : BASIC/DILUTED EPS ++ Income taxes receivable, net 454 2166 0 ++ Inventory 728 999 0 Pto Balance ++ Other current assets 5490 4412 0 ++ Total current assets 174296 152578 0 ++ Non-marketable investments 20703 13078 0 70842743866 ++ Deferred income taxes 1084 721 0 ++ Property and equipment, net 84749 73646 0 $70,842,743,866.00 ++ Operating lease assets 12211 10941 0 ++ Intangible assets, net 1445 1979 0 ++ Goodwill 21175 20624 0 Advice date : 650001 ++ Other non-current assets 3953 2342 0 Pay date : 4/18/2022 ++ PLEASE READ THE IMPORTANT DISCLOSURES BELOW. 319616 275909 0 :xxxxxxxxx6547 JAn 29th., 2022 ++ Paid to the account Of : 0 519 ++ Accounts payable 5589 5561 0 NON-NEGOTIABLE ++ Accrued compensation and benefits 11086 8495 0 ++ Accrued expenses and other current liabilities 28631 23067 0 ++ Accrued revenue share 7500 5916 0 ++ Deferred revenue 2543 1908 0 ++ Income taxes payable, net 1485 274 0 ++ Total current liabilities 56834 45221 0 ++ Long-term debt 13932 4554 0 ++ Deferred revenue, non-current 481 358 0 ++ Income taxes payable, non-current 8849 9885 0 ++ Deferred income taxes 3561 1701 0 ++ 11146 10214 0 ++ Other long-term liabilities 2269 2534 0 ++ Total liabilities 97072 74467 0 ++ Commitments and Contingencies (Note 10) 0 ++ Stockholders’ equity: 0 ++ Convertible preferred stock, $0.001 par value per share, 100,000 shares authorized; no shares issued and outstanding 0 0 0 ++ Class A and Class B common stock, and Class C capital stock and additional paid-in capital, $0.001 par value per share: 15,000,000 shares authorized (Class A 9,000,000, Class B 3,000,000, Class C 3,000,000); 688,335 (Class A 299,828, Class B 46,441, Class C 342,066) and 675,222 (Class A 300,730, Class B 45,843, Class C 328,649) shares issued and outstanding 58510 50552 0 ++ Accumulated other comprehensive income (loss) 633 -1232 0 ++ Retained earnings 163401 152122 0 ++ Total stockholders’ equity 222544 201442 0 ++ Total liabilities and stockholders’ equity 319616 275909 0 ++ Convertible preferred stock, par value (in dollars per share) 0.001 0.001 0 ++ Convertible preferred stock, shares authorized (in shares) 100000000 100000000 0 ++ Convertible preferred stock, shares issued (in shares) 0 0 0 ++ Convertible preferred stock, shares outstanding (in shares) 0 0 0 ++ Schedule II: Valuation and Qualifying Accounts (Details) - Allowance for doubtful accounts and sales credits - USD ($) $ in Millions 12 Months Ended 0 ++ Dec. 31, 2020 Dec. 31, 2019 Dec. 31, 2018 0 ++ SEC Schedule, 12-09, Movement in Valuation Allowances and Reserves [Roll Forward] 0 ++ Revenues (Narrative) (Details) - USD ($) $ in Billions 12 Months Ended 0 ++ Dec. 31, 2020 Dec. 31, 2019 0 ++ Revenue from Contract with Customer [Abstract] 0 ++ Deferred revenue 2.3 0 ++ Revenues recognized 1.8 0 ++ Transaction price allocated to remaining performance obligations 29.8 0 ++ Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction, Start Date [Axis]: 2021-01-01 0 ++ Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction [Line Items] 0 ++ Expected timing of revenue recognition 24 months 0 ++ Expected timing of revenue recognition, percent 0.5 0 ++ Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction, Start Date [Axis]: 2023-01-01 0 ++ Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction [Line Items] 0 ++ Expected timing of revenue recognition 0 ++ Expected timing of revenue recognition, percent 0.5 0 ++ Information about Segments and Geographic Areas (Long-Lived Assets by Geographic Area) (Details) - USD ($) $ in Millions Dec. 31, 2020 Dec. 31, 2019 0 ++ Revenues from External Customers and Long-Lived Assets [Line Items] 0 ++ Long-lived assets 96960 84587 0 ++ United States 0 ++ Revenues from External Customers and Long-Lived Assets [Line Items] 0 ++ Long-lived assets 69315 63102 0 ++ International 0 ++ Revenues from External Customers and Long-Lived Assets [Line Items] 0 ++ Long-lived assets 27645 21485 0 ++ 2016 2017 2018 2019 2020 2021 TTM ++ 2.23418E+11 2.42061E+11 2.25382E+11 3.27223E+11 2.86256E+11 3.54636E+11 3.54636E+11 ++ 45881000000 60597000000 57418000000 61078000000 63401000000 69478000000 69478000000 ++ 3143000000 3770000000 4415000000 4743000000 5474000000 6052000000 6052000000 ++ Net Investment Income, Revenue 9531000000 13081000000 10565000000 17214000000 14484000000 8664000000 -14777000000 81847000000 48838000000 86007000000 86007000000 ++ Realized Gain/Loss on Investments, Revenue 472000000 184000000 72000000 10000000 7553000000 1410000000 -22155000000 71123000000 40905000000 77576000000 77576000000 ++ Gains/Loss on Derivatives, Revenue 1963000000 2608000000 506000000 974000000 751000000 718000000 -300000000 1484000000 -159000000 966000000 966000000 ++ Interest Income, Revenue 6106000000 6408000000 6484000000 6867000000 6180000000 6536000000 7678000000 9240000000 8092000000 7465000000 7465000000 ++ Other Investment Income, Revenue 990000000 3881000000 3503000000 9363000000 ++ Rental Income, Revenue 2553000000 2452000000 5732000000 5856000000 5209000000 5988000000 5988000000 ++ Other Revenue 1.18387E+11 1.32385E+11 1.42881E+11 1.52435E+11 1.57357E+11 1.66578E+11 1.72594E+11 1.73699E+11 1.63334E+11 1.87111E+11 1.87111E+11 ++ Total Expenses -1.40227E+11 -1.53354E+11 -1.66594E+11 -1.75997E+11 -1.89751E+11 -2.18223E+11 -2.21381E+11 -2.24527E+11 -2.30563E+11 -2.4295E+11 -2.4295E+11 ++ Benefits,Claims and Loss Adjustment Expense, Net -25227000000 -26347000000 -31587000000 -31940000000 -36037000000 -54509000000 -45605000000 -49442000000 -49763000000 -55971000000 -55971000000 ++ Policyholder Future Benefits and Claims, Net -25227000000 -26347000000 -31587000000 -31940000000 -36037000000 -54509000000 -45605000000 -49442000000 -49763000000 -55971000000 -55971000000 ++ Other Underwriting Expenses -7693000000 -7248000000 -6998000000 -7517000000 -7713000000 -9321000000 -9793000000 -11200000000 -12798000000 -12569000000 -12569000000 ++ Selling, General and Administrative Expenses -11870000000 -13282000000 -13721000000 -15309000000 -19308000000 -20644000000 -21917000000 -23229000000 -23329000000 -23044000000 -23044000000 ++ Rent Expense -1335000000 -1455000000 -4061000000 -4003000000 -3520000000 -4201000000 -4201000000 ++ Selling and Marketing Expenses -11870000000 -13282000000 -13721000000 -15309000000 -17973000000 -19189000000 -17856000000 -19226000000 -19809000000 -18843000000 -18843000000 ++ Other Income/Expenses -92693000000 -1.03676E+11 -1.11009E+11 -1.17594E+11 -1.24061E+11 -1.32377E+11 -1.37664E+11 -1.37775E+11 -1.30645E+11 -1.48189E+11 -1.48189E+11 ++ Total Net Finance Income/Expense -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 ++ Net Interest Income/Expense -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 ++ Interest Expense Net of Capitalized Interest -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 ++ Income from Associates, Joint Ventures and Other Participating Interests -26000000 -122000000 1109000000 3014000000 -2167000000 1176000000 726000000 995000000 995000000 ++ Irregular Income/Expenses -382000000 -96000000 -10671000000 . . ++ Impairment/Write Off/Write Down of Capital Assets -382000000 -96000000 -10671000000 . . ++ Pretax Income 22236000000 28796000000 28105000000 34946000000 33667000000 23838000000 4001000000 1.02696E+11 55693000000 1.11686E+11 1.11686E+11 ++ Provision for Income Tax -6924000000 -8951000000 -7935000000 -10532000000 -9240000000 21515000000 321000000 -20904000000 -12440000000 -20879000000 -20879000000 ++ Net Income from Continuing Operations 15312000000 19845000000 20170000000 24414000000 24427000000 45353000000 4322000000 81792000000 43253000000 90807000000 90807000000 ++ Net Income after Extraordinary Items and Discontinued Operations 15312000000 19845000000 20170000000 24414000000 24427000000 45353000000 4322000000 81792000000 43253000000 90807000000 90807000000 ++ Non-Controlling/Minority Interests -488000000 -369000000 -298000000 -331000000 -353000000 -413000000 -301000000 -375000000 -732000000 -1012000000 -1012000000 ++ Net Income after Non-Controlling/Minority Interests 14824000000 19476000000 19872000000 24083000000 24074000000 44940000000 4021000000 81417000000 42521000000 89795000000 89795000000 ++ Net Income Available to Common Stockholders 14824000000 19476000000 19872000000 24083000000 24074000000 44940000000 4021000000 81417000000 42521000000 89795000000 89795000000 ++ Diluted Net Income Available to Common Stockholders 14824000000 19476000000 19872000000 24083000000 24074000000 44940000000 4021000000 81417000000 42521000000 89795000000 89795000000 ++ Income Statement Supplemental Section ++ Reported Normalized and Operating Income/Expense Supplemental Section +$$22677000000000.00 +{' "input' :' ./-plug-ins"' }' +:Build::' +Return:' :' Run'' Thank you for investing your time in contributing to our project! Any contribution you make will be reflected on [docs.github.com](https://docs.github.com/en) :sparkles:. 
Footer
© 2022 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About

#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------
#
# Docs: https://github.com/microsoft/vscode-dev-containers/blob/master/script-library/docs/github.md
#
# Syntax: ./github-debian.sh [version]

CLI_VERSION=${1:-"latest"}

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive

# Install curl, apt-transport-https or gpg if missing
if ! dpkg -s curl ca-certificates > /dev/null 2>&1; then
    if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
        apt-get update
    fi
    apt-get -y install --no-install-recommends curl ca-certificates
fi

# Get latest release number if latest is specified
if [ "${CLI_VERSION}" = "latest" ] ||  [ "${CLI_VERSION}" = "current" ] ||  [ "${CLI_VERSION}" = "lts" ]; then
    LATEST_RELEASE=$(curl -sSL -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/cli/cli/releases?per_page=1&page=1")
    CLI_VERSION=$(echo ${LATEST_RELEASE} | grep -oE 'tag_name":\s*"v[^"]+' | sed -n '/tag_name":\s*"v/s///p')
fi

# Install the GitHub CLI
echo "Downloading github CLI..."
curl -OsSL https://github.com/cli/cli/releases/download/v${CLI_VERSION}/gh_${CLI_VERSION}_linux_amd64.deb
echo "Installing github CLI..."
apt-get install ./gh_${CLI_VERSION}_linux_amd64.deb
echo "Removing github CLI deb file after installation..."
rm -rf ./gh_${CLI_VERSION}_linux_amd64.deb
echo "Done!"
