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
Initial commit
 paradice
@zakwarlord7
zakwarlord7 committed 1 hour ago 
0 parents commit 2832f51629187efa8ba5311ae625d211a24deb22
Show file tree Hide file tree
Showing 35 changed files with 46,726 additions and 0 deletions.
 202  
.github/workflows/:rake.i
@@ -0,0 +1,202 @@
# This workflow uses actions that are not certified by GitHub.
# They are provided by a third-party and are governed by
# separate terms of service, privacy policy, and support
# documentation.

# 💁 The OpenShift Starter workflow will:
# - Checkout your repository
# - Perform a container image build
# - Push the built image to the GitHub Container Registry (GHCR)
# - Log in to your OpenShift cluster
# - Create an OpenShift app from the image and expose it to the internet

# ℹ️ Configure your repository and the workflow with the following steps:
# 1. Have access to an OpenShift cluster. Refer to https://www.openshift.com/try
# 2. Create the OPENSHIFT_SERVER and OPENSHIFT_TOKEN repository secrets. Refer to:
#   - https://github.com/redhat-actions/oc-login#readme
#   - https://docs.github.com/en/actions/reference/encrypted-secrets
#   - https://cli.github.com/manual/gh_secret_set
# 3. (Optional) Edit the top-level 'env' section as marked with '🖊️' if the defaults are not suitable for your project.
# 4. (Optional) Edit the build-image step to build your project.
#    The default build type is by using a Dockerfile at the root of the repository,
#    but can be replaced with a different file, a source-to-image build, or a step-by-step buildah build.
# 5. Commit and push the workflow file to your default branch to trigger a workflow run.

# 👋 Visit our GitHub organization at https://github.com/redhat-actions/ to see our actions and provide feedback.

name: OpenShift

env:
  # 🖊️ EDIT your repository secrets to log into your OpenShift cluster and set up the context.
  # See https://github.com/redhat-actions/oc-login#readme for how to retrieve these values.
  # To get a permanent token, refer to https://github.com/redhat-actions/oc-login/wiki/Using-a-Service-Account-for-GitHub-Actions
  OPENSHIFT_SERVER: ${{ secrets.OPENSHIFT_SERVER }}
  OPENSHIFT_TOKEN: ${{ secrets.OPENSHIFT_TOKEN }}
  # 🖊️ EDIT to set the kube context's namespace after login. Leave blank to use your user's default namespace.
  OPENSHIFT_NAMESPACE: ""

  # 🖊️ EDIT to set a name for your OpenShift app, or a default one will be generated below.
  APP_NAME: ""

  # 🖊️ EDIT with the port your application should be accessible on.
  # If the container image exposes *exactly one* port, this can be left blank.
  # Refer to the 'port' input of https://github.com/redhat-actions/oc-new-app
  APP_PORT: ""

  # 🖊️ EDIT to change the image registry settings.
  # Registries such as GHCR, Quay.io, and Docker Hub are supported.
  IMAGE_REGISTRY: ghcr.io/${{ github.repository_owner }}
  IMAGE_REGISTRY_USER: ${{ github.actor }}
  IMAGE_REGISTRY_PASSWORD: ${{ github.token }}

  # 🖊️ EDIT to specify custom tags for the container image, or default tags will be generated below.
  IMAGE_TAGS: ""

on:
  # https://docs.github.com/en/actions/reference/events-that-trigger-workflows
  workflow_dispatch:
  push:
    # Edit to the branch(es) you want to build and deploy on each push.
    branches: [ "paradice" ]

jobs:
  # 🖊️ EDIT if you want to run vulnerability check on your project before deploying
  # the application. Please uncomment the below CRDA scan job and configure to run it in
  # your workflow. For details about CRDA action visit https://github.com/redhat-actions/crda/blob/main/README.md
  #
  # TODO: Make sure to add 'CRDA Scan' starter workflow from the 'Actions' tab.
  # For guide on adding new starter workflow visit https://docs.github.com/en/github-ae@latest/actions/using-workflows/using-starter-workflows

  crda-scan:
    uses: ./.github/workflows/crda.yml
    secrets:
      CRDA_KEY: ${{ secrets.CRDA_KEY }}
      # SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}       # Either use SNYK_TOKEN or CRDA_KEY

  openshift-ci-cd:
    # 🖊️ Uncomment this if you are using CRDA scan step above
    # needs: crda-scan
    name: Build and deploy to OpenShift
    runs-on: ubuntu-20.04
    environment: production

    outputs:
      ROUTE: ${{ steps.deploy-and-expose.outputs.route }}
      SELECTOR: ${{ steps.deploy-and-expose.outputs.selector }}

    steps:
    - name: Check for required secrets
      uses: actions/github-script@v6
      with:
        script: |
          const secrets = {
            OPENSHIFT_SERVER: `${{ secrets.OPENSHIFT_SERVER }}`,
            OPENSHIFT_TOKEN: `${{ secrets.OPENSHIFT_TOKEN }}`,
          };

          const GHCR = "ghcr.io";
          if (`${{ env.IMAGE_REGISTRY }}`.startsWith(GHCR)) {
            core.info(`Image registry is ${GHCR} - no registry password required`);
          }
          else {
            core.info("A registry password is required");
            secrets["IMAGE_REGISTRY_PASSWORD"] = `${{ secrets.IMAGE_REGISTRY_PASSWORD }}`;
          }

          const missingSecrets = Object.entries(secrets).filter(([ name, value ]) => {
            if (value.length === 0) {
              core.error(`Secret "${name}" is not set`);
              return true;
            }
            core.info(`✔️ Secret "${name}" is set`);
            return false;
          });

          if (missingSecrets.length > 0) {
            core.setFailed(`❌ At least one required secret is not set in the repository. \n` +
              "You can add it using:\n" +
              "GitHub UI: https://docs.github.com/en/actions/reference/encrypted-secrets#creating-encrypted-secrets-for-a-repository \n" +
              "GitHub CLI: https://cli.github.com/manual/gh_secret_set \n" +
              "Also, refer to https://github.com/redhat-actions/oc-login#getting-started-with-the-action-or-see-example");
          }
          else {
            core.info(`✅ All the required secrets are set`);
          }

    - name: Check out repository
      uses: actions/checkout@v3

    - name: Determine app name
      if: env.APP_NAME == ''
      run: |
        echo "APP_NAME=$(basename $PWD)" | tee -a $GITHUB_ENV

    - name: Determine image tags
      if: env.IMAGE_TAGS == ''
      run: |
        echo "IMAGE_TAGS=latest ${GITHUB_SHA::12}" | tee -a $GITHUB_ENV

    # https://github.com/redhat-actions/buildah-build#readme
    - name: Build from Dockerfile
      id: build-image
      uses: redhat-actions/buildah-build@v2
      with:
        image: ${{ env.APP_NAME }}
        tags: ${{ env.IMAGE_TAGS }}

        # If you don't have a Dockerfile/Containerfile, refer to https://github.com/redhat-actions/buildah-build#scratch-build-inputs
        # Or, perform a source-to-image build using https://github.com/redhat-actions/s2i-build
        # Otherwise, point this to your Dockerfile/Containerfile relative to the repository root.
        dockerfiles: |
          ./Dockerfile

    # https://github.com/redhat-actions/push-to-registry#readme
    - name: Push to registry
      id: push-image
      uses: redhat-actions/push-to-registry@v2
      with:
        image: ${{ steps.build-image.outputs.image }}
        tags: ${{ steps.build-image.outputs.tags }}
        registry: ${{ env.IMAGE_REGISTRY }}
        username: ${{ env.IMAGE_REGISTRY_USER }}
        password: ${{ env.IMAGE_REGISTRY_PASSWORD }}

    # The path the image was pushed to is now stored in ${{ steps.push-image.outputs.registry-path }}

    - name: Install oc
      uses: redhat-actions/openshift-tools-installer@v1
      with:
        oc: 4

    # https://github.com/redhat-actions/oc-login#readme
    - name: Log in to OpenShift
      uses: redhat-actions/oc-login@v1
      with:
        openshift_server_url: ${{ env.OPENSHIFT_SERVER }}
        openshift_token: ${{ env.OPENSHIFT_TOKEN }}
        insecure_skip_tls_verify: true
        namespace: ${{ env.OPENSHIFT_NAMESPACE }}

    # This step should create a deployment, service, and route to run your app and expose it to the internet.
    # https://github.com/redhat-actions/oc-new-app#readme
    - name: Create and expose app
      id: deploy-and-expose
      uses: redhat-actions/oc-new-app@v1
      with:
        app_name: ${{ env.APP_NAME }}
        image: ${{ steps.push-image.outputs.registry-path }}
        namespace: ${{ env.OPENSHIFT_NAMESPACE }}
        port: ${{ env.APP_PORT }}

    - name: Print application URL
      env:
        ROUTE: ${{ steps.deploy-and-expose.outputs.route }}
        SELECTOR: ${{ steps.deploy-and-expose.outputs.selector }}
      run: |
        [[ -n ${{ env.ROUTE }} ]] || (echo "Determining application route failed in previous step"; exit 1)
        echo
        echo "======================== Your application is available at: ========================"
        echo ${{ env.ROUTE }}
        echo "==================================================================================="
        echo
        echo "Your app can be taken down with: \"oc delete all --selector='${{ env.SELECTOR }}'\""
 95  
.github/workflows/aws.yml
@@ -0,0 +1,95 @@
# This workflow will build and push a new container image to Amazon ECR,
# and then will deploy a new task definition to Amazon ECS, when there is a push to the "paradice" branch.
#
# To use this workflow, you will need to complete the following set-up steps:
#
# 1. Create an ECR repository to store your images.
#    For example: `aws ecr create-repository --repository-name my-ecr-repo --region us-east-2`.
#    Replace the value of the `ECR_REPOSITORY` environment variable in the workflow below with your repository's name.
#    Replace the value of the `AWS_REGION` environment variable in the workflow below with your repository's region.
#
# 2. Create an ECS task definition, an ECS cluster, and an ECS service.
#    For example, follow the Getting Started guide on the ECS console:
#      https://us-east-2.console.aws.amazon.com/ecs/home?region=us-east-2#/firstRun
#    Replace the value of the `ECS_SERVICE` environment variable in the workflow below with the name you set for the Amazon ECS service.
#    Replace the value of the `ECS_CLUSTER` environment variable in the workflow below with the name you set for the cluster.
#
# 3. Store your ECS task definition as a JSON file in your repository.
#    The format should follow the output of `aws ecs register-task-definition --generate-cli-skeleton`.
#    Replace the value of the `ECS_TASK_DEFINITION` environment variable in the workflow below with the path to the JSON file.
#    Replace the value of the `CONTAINER_NAME` environment variable in the workflow below with the name of the container
#    in the `containerDefinitions` section of the task definition.
#
# 4. Store an IAM user access key in GitHub Actions secrets named `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.
#    See the documentation for each action used below for the recommended IAM policies for this IAM user,
#    and best practices on handling the access key credentials.

name: Deploy to Amazon ECS

on:
  push:
    branches:
      - "paradice"

env:
  AWS_REGION: MY_AWS_REGION                   # set this to your preferred AWS region, e.g. us-west-1
  ECR_REPOSITORY: MY_ECR_REPOSITORY           # set this to your Amazon ECR repository name
  ECS_SERVICE: MY_ECS_SERVICE                 # set this to your Amazon ECS service name
  ECS_CLUSTER: MY_ECS_CLUSTER                 # set this to your Amazon ECS cluster name
  ECS_TASK_DEFINITION: MY_ECS_TASK_DEFINITION # set this to the path to your Amazon ECS task definition
                                               # file, e.g. .aws/task-definition.json
  CONTAINER_NAME: MY_CONTAINER_NAME           # set this to the name of the container in the
                                               # containerDefinitions section of your task definition

permissions:
  contents: read

jobs:
  deploy:
    name: Deploy
    runs-on: ubuntu-latest
    environment: production

    steps:
    - name: Checkout
      uses: actions/checkout@v3

    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v1
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: ${{ env.AWS_REGION }}

    - name: Login to Amazon ECR
      id: login-ecr
      uses: aws-actions/amazon-ecr-login@v1

    - name: Build, tag, and push image to Amazon ECR
      id: build-image
      env:
        ECR_REGISTRY: ${{ steps.login-ecr.outputs.registry }}
        IMAGE_TAG: ${{ github.sha }}
      run: |
        # Build a docker container and
        # push it to ECR so that it can
        # be deployed to ECS.
        docker build -t $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG .
        docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
        echo "::set-output name=image::$ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG"
    - name: Fill in the new image ID in the Amazon ECS task definition
      id: task-def
      uses: aws-actions/amazon-ecs-render-task-definition@v1
      with:
        task-definition: ${{ env.ECS_TASK_DEFINITION }}
        container-name: ${{ env.CONTAINER_NAME }}
        image: ${{ steps.build-image.outputs.image }}

    - name: Deploy Amazon ECS task definition
      uses: aws-actions/amazon-ecs-deploy-task-definition@v1
      with:
        task-definition: ${{ steps.task-def.outputs.task-definition }}
        service: ${{ env.ECS_SERVICE }}
        cluster: ${{ env.ECS_CLUSTER }}
        wait-for-service-stability: true
 4,318  
.github/workflows/blank.yml
Large diffs are not rendered by default.

 58  
.github/workflows/greetings.yml
@@ -0,0 +1,58 @@
'"**'"'Name: Greetings
on: ["pull_request_t":"2017 2018 2019 2020 2021
++ Best Time to 911
++ INTERNAL REVENUE SERVICE
++ PO BOX 1214
++ CHARLOTTE NC 28201-1214 9999999999
++ 633-44-1725
++ ZACHRYTWOOD
++ AMPITHEATRE PARKWAY
++ MOUNTAIN VIEW, Califomia 94043
++ EIN 61-1767919
++ Earnings FEIN 88-1303491
++ End Date
++ 44669
++ Department of the Treasury Calendar Year
++ Check Date
++ Internal Revenue Service Due. (04/18/2022)
++41224 Stub Number: 1+-+-+-+- Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)+- INTERNAL REVENUE SERVICE, *include interest paid, capital obligation, and underweighting 6858000000+- PO BOX 1214, Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) 22677000000+- CHARLOTTE, NC 28201-1214 Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) 22677000000+- Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) 22677000000Taxes / Deductions Current YTD+- Fiscal year ends in Dec 31 | USDRate+-Total+- 7567263607 DoB: 1994-10-15YTD+-+- April 18, 2022.-7567263607WOOD ZACHRY Tax Period Total Social Security Medicare Withholding+- Fed 941 Corporate 39355 66986.66 28841.48 6745.18 31400+- Fed 941 West Subsidiary 39355 17115.41 7369.14 1723.42 8022.85+- Fed 941 South Subsidiary 39355 23906.09 10292.9 2407.21 11205.98+- Fed 941 East Subsidiary 39355 11247.64 4842.74 1132.57 5272.33+- Fed 941 Corp - Penalty 39355 27198.5 11710.47 2738.73 12749.3+- Fed 940 Annual Unemp - Corp 39355 17028.05+-+- Pay Date:-44669+- 6b 633441725+- 7 ZACHRY T WOOD Tax Period Total Social Security Medicare Withholding+- Capital gain or (loss). Attach Schedule D if required. If not required, check here ....▶ Fed 941 Corporate 39355 66986.66 28841.48 6745.18 31400+- 7 Fed 941 West Subsidiary 39355 17115.41 7369.14 1723.42 8022.85+- 8 Fed 941 South Subsidiary 39355 23906.09 10292.9 2407.21 11205.98+- Other income from Schedule 1, line 10 .................. Fed 941 East Subsidiary 39355 11247.64 4842.74 1132.57 5272.33+- 8 Fed 941 Corp - Penalty 39355 27198.5 11710.47 2738.73 12749.3+- 9 Fed 940 Annual Unemp - Corp 39355 17028.05+- Add lines 1, 2b, 3b, 4b, 5b, 6b, 7, and 8. This is your total income .........▶ TTM Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020 Q3 2020 Q2 2020 Q1 2020 Q4 2019-9+- 10 1.46698E+11 42337000000 37497000000 35653000000 31211000000 30818000000 25056000000 19744000000 22177000000 25055000000+- Adjustments to income from Schedule 1, line 26 ............... 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000+- 10 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 64133000000-11+- Subtract line 10 from line 9. This is your adjusted gross income .........▶ -5.79457E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000 -18982000000 -21020000000-3.28E+11#NAME?+- • Single or Married filing separately, $12,550 -67984000000 -20452000000 -16466000000 -8617000000 -7289000000 -8145000000 -6987000000 -6486000000 -7380000000 -8567000000+- • Married filing jointly or Qualifying widow(er), $25,100 -36422000000 -11744000000 -8772000000 -3341000000 -2773000000 -2831000000 -2756000000 -2585000000 -2880000000 -2829000000+- • Head of household, $18,800 -13510000000 -4140000000 -3256000000 -5276000000 -4516000000 -5314000000 -4231000000 -3901000000 -4500000000 -5738000000+- • If you checked any box under Standard Deduction, see instructions. -22912000000 -7604000000 -5516000000 -7675000000 -7485000000 -7022000000 -6856000000 -6875000000 -6820000000 -7222000000+- 12 -31562000000 -8708000000 -7694000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000+- a 78714000000 21885000000 21031000000 2624000000 4846000000 3038000000 2146000000 1894000000 -220000000 1438000000+- Standard deduction or itemized deductions (from Schedule A) .. 12020000000 2517000000 2033000000 313000000 269000000 333000000 412000000 420000000 565000000 604000000+- 12a 1153000000 261000000 310000000 313000000 269000000 333000000 412000000 420000000 565000000 604000000ZACHRY WOOD <zachryiixixiiwood@gmail.com>+- b 1153000000 261000000 310000000ZACHRY TYLER WOOD's Paycheck#NAME?ZACHRY WOOD <zachryiixixiiwood@gmail.com>Sat, Oct 22, 2022 at 4:52 AM+- 12b -346000000 -117000000 -77000000 389000000 345000000 386000000 460000000 433000000 586000000 621000000To Pastor. Robert Michael Wood<jc4unme316@ahoo.com>+- c 1499000000 378000000 387000000 2924000000 4869000000 3530000000 1957000000 1696000000 -809000000 899000000INTERNAL REVENUE SERVICE, *include interest paid, capital obligation, and underweighting 6858000000
PO BOX 1214, Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
22677000000
CHARLOTTE, NC 28201-1214 Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) 22677000000
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
22677000000
Taxes / Deductions Current YTD
Fiscal year ends in Dec 31 | USD
Rate
Total
7567263607 ID 00037305581 SSN 633441725 DoB 1994-10-15
year to date :
this period :
April 18, 2022.
7567263607
WOOD ZACHRY Tax Period Total Social Security Medicare Withholding
Fed 941 Corporate 39355 66986.66 28841.48 6745.18 31400
Fed 941 West Subsidiary 39355 17115.41 7369.14 1723.42 8022.85
Fed 941 South Subsidiary 39355 23906.09 10292.9 2407.21 11205.98
Fed 941 East Subsidiary 39355 11247.64 4842.74 1132.57 5272.33
Fed 941 Corp - Penalty 39355 27198.5 11710.47 2738.73 12749.3
Fed 940 Annual Unemp - Corp 39355 17028.05"**":,''
]

jobs:
  greeting:
    runs-on: ubuntu-latest
    permissions:
      issues: write
      pull-requests: write
    steps:
    - uses: actions/first-interaction@v1
      with:
        repo-token: ${{ secrets.GITHUB_TOKEN }}
        issue-message: "Message that will be displayed on users' first issue"
        pr-message: "Message that will be displayed on users' first pull request"
 # Display some statistics at the end regarding the stale workflow (only when the logs are enabled).
    enable-statistics: # optional, default is true
    # A comma delimited list of labels to add when a stale issue or pull request receives activity and has the stale-issue-label or stale-pr-label removed from it.
    labels-to-add-when-unstale: # optional, default is 
 113  
.github/workflows/jekyll.yml
@@ -0,0 +1,113 @@
# This workflow uses actions that are not certified by GitHub.
# They are provided by a third-party and are governed by
# separate terms of service, privacy policy, and support
# documentation.

# Sample workflow for building and deploying a Jekyll site to GitHub Pages
name: Deploy Jekyll site to Pages

on:
  # Runs on pushes targeting the default branch
  push:
    branches: ["paradice"]

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# Sets permissions of the GITHUB_TOKEN to allow deployment to GitHub Pages
permissions:
  contents: read
  pages: write
  id-token: write

# Allow one concurrent deployment
concurrency:
  group: "pages"
  cancel-in-progress: true

jobs:
  # Build job
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      - name: Setup Ruby
        uses: ruby/setup-ruby@0a29871fe2b0200a17a4497bae54fe5df0d973aa # v1.115.3
        with:
          ruby-version: '3.0' # Not needed with a .ruby-version file
          bundler-cache: true # runs 'bundle install' and caches installed gems automatically
          cache-version: 0 # Increment this number if you need to re-download cached gems
      - name: Setup Pages
        id: pages
        uses: actions/configure-pages@v2
      - name: Build with Jekyll
        # Outputs to the './_site' directory by default
        run: bundle exec jekyll build --baseurl "${{ steps.pages.outputs.base_path }}"
        env:
          JEKYLL_ENV: production
      - name: Upload artifact
        # Automatically uploads an artifact from the './_site' directory by default
        uses: actions/upload-pages-artifact@v1

  # Deployment job
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v1
																
																
																
																
																
																
																
																
																
																
INTERNAL REVENUE SERVICE,                                                                        																
PO BOX 1214,                                                                        																
CHARLOTTE, NC 28201-1214                                                                        																
																
ZACHRY WOOD                                                                        								12 Months Ended                                                                								
15								_________________________________________________________                                                                								
For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions.                                                                        								                        Q4 2020                        Q4  2019                								
Cat. No. 11320B                                                                        								Income Statement                                                                 								
Form 1040 (2021)                                                                        								USD in "000'"s                                                                								
Reported Normalized and Operating Income/Expense Supplemental Section                                                                        								Repayments for Long Term Debt                        Dec. 31, 2020                        Dec. 31, 2019                								
Total Revenue as Reported, Supplemental                                                                        								Costs and expenses:                                                                								
Total Operating Profit/Loss as Reported, Supplemental                                                                        								Cost of revenues                        182527                        161857                								
Reported Effective Tax Rate                                                                        								Research and development                                                                								
Reported Normalized Income                                                                        								Sales and marketing                        84732                        71896                								
Reported Normalized Operating Profit                                                                        								General and administrative                        27573                        26018                								
Other Adjustments to Net Income Available to Common Stockholders                                                                        								European Commission fines                        17946                        18464                								
Discontinued Operations                                                                        								Total costs and expenses                        11052                        9551                								
Basic EPS                                                                        								Income from operations                        0                        1697                								
Basic EPS from Continuing Operations                                                                        								Other income (expense), net                        141303                        127626                								
Basic EPS from Discontinued Operations                                                                        								Income before income taxes                        41224                        34231                								
Diluted EPS                                                                        								Provision for income taxes                        6858000000                        5394                								
Diluted EPS from Continuing Operations                                                                        								Net income                        22677000000                        19289000000                								
Diluted EPS from Discontinued Operations                                                                        								*include interest paid, capital obligation, and underweighting                        22677000000                        19289000000                								
Basic Weighted Average Shares Outstanding                                                                        								                        22677000000                        19289000000                								
Diluted Weighted Average Shares Outstanding                                                                        								Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)                                                                								
Reported Normalized Diluted EPS                                                                        								Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)                                                                								
Basic EPS                                                                        																
Diluted EPS                                                                        																
Basic WASO                                                                        								For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see the seperate Instructions.                                                                								
Diluted WASO                                                                        																
Fiscal year end September 28th., 2022. | USD                                                                        								Returned for Signature                                                                								
								Date.______________09/01/2022                        								
For Paperwork Reduction Act Notice, see the seperate Instructions.                                                                        																
																
																
																
																
																
																
important information                                                                        																
 364  
.github/workflows/objective-c-xcode.yml
Large diffs are not rendered by default.

 4,813  
.github/workflows/openshift.yml
Large diffs are not rendered by default.

 1,852  
.github/workflows/slate.yml
Large diffs are not rendered by default.

 1,619  
.github/workflows/stale.yml
Large diffs are not rendered by default.

 58  
0719218914720416547
@@ -0,0 +1,58 @@
- 👋 Hi, I’m @zakwarlord7
- 👀 I’m interested in ...
- 🌱 I’m currently learning ...
- 💞️ I’m looking to collaborate on ...
- 📫 How to reach me ...
2021 BUSINESS SUMMARY		
Jan 01 - Dec 31		



INCOME	 	AMOUNT
 	 	-


SCHEDULE C DEDUCTIONS	SPENDING	DEDUCTIONS
Advertising	-	-
Assets	-	-
Car and truck	-	-
Commissions	-	-
Communication	-	-
Contract labor	-	-
Equipment rent and lease	-	-
Home Office Expenses	-	-
Insurance	-	-
Interest paid	-	-
Legal and professional services	-	-
Materials & Supplies	-	-
Meals	-	-
Office expenses	-	-
Other business expenses	-	-
Rent and lease (business bldg/land)	-	-
Repairs and maintenance	-	-
Taxes and licenses	-	-
Travel expenses	-	-
Uncategorized	-	-
Utilities	-	-
TOTAL	-	-
OTHER 
DEDUCTIONS	
SPENDING	
DEDUCTION 
ESTIMATE 
Savings 
Account 
TAX 
PAYMENTS	 	
AMOUNT
Payment 
Summary	 	-
TRANSFERS	 
AMOUNT
DEBIT :Debit card-#4034910067530719 :  
payment	 	-
Personal  deposit	 	-
Personal Transfer install :uses :WIZARD/install/installer/src.code.dist/.dir'@sun.java.org/ install ::<!---
zakwarlord7/zakwarlord7 is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes--->chrome-extension://bpmcpldpdmajfigpchkicefoigmkfalc/views/app.html

 203  
:rake.io
@@ -0,0 +1,203 @@
- 👋 Hi, I’m @zakwarlord7
- 👀 I’m interested in ...
- 🌱 I’m currently learning ...
- 💞️ I’m looking to collaborate on ...
- 📫 How to reach me ...
<!---
zakwarlord7/zakwarlord7 is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes.
--->
12/31/2020	CONSOLIDATED STATEMENTS OF COMPREHENSIVE INCOME - USD ($) $ in Millions	12 Months Ended		
Income Revenue Report		Dec. 31, 2020	Dec. 31, 2019	Dec. 31, 2018
  Alphabet Inc Co	Statement of Comprehensive Income [Abstract]			
	Net income	 $ 40,269 	 $ 34,343 	 $ 30,736 

	Other comprehensive income (loss):			
	Change in foreign currency translation adjustment	1,139 	(119)	(781)
	Available-for-sale investments:			
	Change in net unrealized gains (losses)	1,313 	1,611 	88 
	Less: reclassification adjustment for net (gains) losses included in net income	(513)	(111)	(911)
	Net change, net of tax benefit (expense) of $156, $(221), and $(230)	800 	1,500 	(823)
	Cash flow hedges:			
	Change in net unrealized gains (losses)	42 	22 	290 
	Less: reclassification adjustment for net (gains) losses included in net income	(116)	(299)	98 
	Net change, net of tax benefit (expense) of $(103), $42, and $11	(74)	(277)	388 
	Other comprehensive income (loss)	1,865 	1,104 	(1,216)
	Comprehensive income	 $ 42,134 	 $ 35,447 	 $ 29,520 



	CONSOLIDATED BALANCE SHEETS (Parenthetical) - $ / shares	Dec. 31, 2020	Dec. 31, 2019	
	Stockholders’ equity:			
	Convertible preferred stock, par value per share (in dollars per share)	$0.00 	$0.00 	
	Convertible preferred stock, shares authorized (in shares)	100,000,000	100,000,000	
	Convertible preferred stock, shares issued (in shares)	0	0	
	Convertible preferred stock, shares outstanding (in shares)	0	0	
	Common stock and capital stock, par value (in dollars per share)	$0.00 	$0.00 	
	Common stock and capital stock, shares authorized (in shares)	15,000,000,000	15,000,000,000	
	Common stock and capital stock, shares issued (in shares)	675,222,000	688,335,000	
	Common stock and capital stock, shares outstanding (in shares)	675,222,000	688,335,000	
	Class A Common Stock			
	Stockholders’ equity:			
	Common stock and capital stock, shares authorized (in shares)	9,000,000,000	9,000,000,000	
	Common stock and capital stock, shares issued (in shares)	300,730,000	299,828,000	
	Common stock and capital stock, shares outstanding (in shares)	300,730,000	299,828,000	
	Class B Common Stock			
	Stockholders’ equity:			
	Common stock and capital stock, shares authorized (in shares)	3,000,000,000	3,000,000,000	
	Common stock and capital stock, shares issued (in shares)	45,843,000	46,441,000	
	Common stock and capital stock, shares outstanding (in shares)	45,843,000	46,441,000	
	Class C Capital Stock			
	Stockholders’ equity:			
	Common stock and capital stock, shares authorized (in shares)	3,000,000,000	3,000,000,000	
	Common stock and capital stock, shares issued (in shares)	328,649,000	342,066,000	
curl -v -X POST https://api-m.sandbox.paypal.com/v2/checkout/orders \
-H "Content-Type: application/json" \
-H "Authorization: Bearer <Access-Token>" \
-d '{
  "intent": "CAPTURE",
  "purchase_units": [
    {
      "amount": {
        "currency_code": "USD",
        "value": "100.00"
      }
    }
  ]
}'O'auth: SINTALLMENT_DUE_FROM_ACCOUNT_NUMBER_000000000000_FROM_ROUTING/TRANSIT_2531770491600 Amphitheatre Parkway
diff --git a/c.i b/c.i
new file mode 100644
index 000000000000..0531aead4f92
--- /dev/null
+++ b/c.i
@@ -0,0 +1,2776 @@##On:
CI: Publish
<enabled>true</enabled></releases>
<snapshots><enabled>true</enabled></snapshots>
</pluginRepository>
</pluginRepositories>
</profile>
</profiles>
</settings>
Hi! Thanks for your interest in contributing to the GitHub CLI!
We accept pull requests for bug fixes and features where we've discussed the approach in an issue and given the go-ahead for a community member to work on it. We'd also love to hear about ideas for new features as issues.
Please do:
* Check existing issues to verify that the [bug][bug issues] or [feature request][feature request issues] has not already been submitted.
* Open an issue if things aren't working as expected.
* Open an issue to propose a significant change.
* Open a pull request to fix a bug.
* Open a pull request to fix documentation about a command.
* Open a pull request for any issue labelled [`help wanted`][hw] or [`good first issue`][gfi].
Please avoid:
* Opening pull requests for issues marked `needs-design`, `needs-investigation`, or `blocked`.
* Adding installation instructions specifically for your OS/package manager.
* Opening pull requests for any issue marked `core`. These issues require additional context from
  the core CLI team at GitHub and any external pull requests will not be accepted.
## Building the project
Prerequisites:
- Go 1.13+ for building the binary
- Go 1.15+ for running the test suite
Build with: `make` or `go build -o bin/gh ./cmd/gh`
Run the new binary as:bitore.net/user//bin/bash*
Run tests with: `make test` or `go test ./...`
## Submitting a pull request
1. Create a new branch: `git checkout -b my-branch-name`
1. Make your change, add tests, and ensure tests pass
1. Submit a pull request: `gh pr create --web`
Contributions to this project are [released][legal] to the public under the [project's open source license][license].
Please note that this project adheres to a [Contributor Code of Conduct][code-of-conduct]. By participating in this project you agree to abide by its terms.
We generate manual pages from source on every release. You do not need to submit pull requests for documentation specifically; manual pages for commands will automatically get updated after your pull requests gets accepted.
## Design guidelines
You may reference the [CLI Design System][] when suggesting features, and are welcome to use our [Google Docs Template][] to suggest designs.
## Resources
- [How to Contribute to OPEN.js][package.yarn]
- [Using Pull Requests][]
- [GitHub Help][Markdown]
[bug issues]: https://github.com/cli/cli/issues?q=is%3Aopen+is%3Aissue+label%3Abug
[feature request issues]: https://github.com/cli/cli/issues?q=is%3Aopen+is%3Aissue+label%3Aenhancement
[hw]: https://github.com/cli/cli/labels/help%20wanted
[gfi]: https://github.com/cli/cli/labels/good%20first%20issue
[legal]: https://docs.github.com/en/free-pro-team@latest/github/site-policy/github-terms-of-service#6-contributions-under-repository-license
[license]: ../LICENSE
[code-of-conduct]: ./CODE-OF-CONDUCT.md
[not a contribution for nonpayment of stolen  revenues: https://opensource.guide/how-to-contribute/
[Using Pull Requests]: https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/about-pull-requests
[GitHub Help]: https://docs.github.com/
[CLI Design System]: https://primer.style/cli/
[Google Docs Template]: https://docs.google.com/document/d/1JIRErIUuJ6fTgabiFYfCH3x91pyHuytbfa0QLnTfXKM/edit#heading=h.or54sa47ylpg
Author: ZachryTylerWood/vscodeTag	
us-gaap:IncreaseDecreaseInIncomeTaxesPayableNetOfIncomeTaxesReceivable
Fact	
-95,756,000
Period	
9 months ending 09/30/2021
Measure	
USD
Scale	
Thousands
Decimals	
Thousands
Balance	
Debit
Sign	
Negative
Type	
Monetary Item Type
Format	
num-dot-decimal
##On:
CI: Publish
<enabled>true</enabled></releases>
<snapshots><enabled>true</enabled></snapshots>
</pluginRepository>
</pluginRepositories>
</profile>
</profiles>
</settings>
Hi! Thanks for your interest in contributing to the GitHub CLI!
We accept pull requests for bug fixes and features where we've discussed the approach in an issue and given the go-ahead for a community member to work on it. We'd also love to hear about ideas for new features as issues.
Please do:
* Check existing issues to verify that the [bug][bug issues] or [feature request][feature request issues] has not already been submitted.
* Open an issue if things aren't working as expected.
* Open an issue to propose a significant change.
* Open a pull request to fix a bug.
* Open a pull request to fix documentation about a command.
* Open a pull request for any issue labelled [`help wanted`][hw] or [`good first issue`][gfi].
Please avoid:
* Opening pull requests for issues marked `needs-design`, `needs-investigation`, or `blocked`.
* Adding installation instructions specifically for your OS/package manager.
* Opening pull requests for any issue marked `core`. These issues require additional context from
  the core CLI team at GitHub and any external pull requests will not be accepted.
## Building the project
Prerequisites:
- Go 1.13+ for building the binary
- Go 1.15+ for running the test suite
Build with: `make` or `go build -o bin/gh ./cmd/gh`
Run the new binary as:bitore.net/user//bin/bash*
Run tests with: `make test` or `go test ./...`
## Submitting a pull request
1. Create a new branch: `git checkout -b my-branch-name`
1. Make your change, add tests, and ensure tests pass
1. Submit a pull request: `gh pr create --web`
Contributions to this project are [released][legal] to the public under the [project's open source license][license].
Please note that this project adheres to a [Contributor Code of Conduct][code-of-conduct]. By participating in this project you agree to abide by its terms.
We generate manual pages from source on every release. You do not need to submit pull requests for documentation specifically; manual pages for commands will automatically get updated after your pull requests gets accepted.
## Design guidelines
You may reference the [CLI Design System][] when suggesting features, and are welcome to use our [Google Docs Template][] to suggest designs.
## Resources
- [How to Contribute to OPEN.js][package.yarn]
- [Using Pull Requests][]
- [GitHub Help][Markdown]
[bug issues]: https://github.com/cli/cli/issues?q=is%3Aopen+is%3Aissue+label%3Abug
[feature request issues]: https://github.com/cli/cli/issues?q=is%3Aopen+is%3Aissue+label%3Aenhancement
[hw]: https://github.com/cli/cli/labels/help%20wanted
[gfi]: https://github.com/cli/cli/labels/good%20first%20issue
[legal]: https://docs.github.com/en/free-pro-team@latest/github/site-policy/github-terms-of-service#6-contributions-under-repository-license
[license]: ../LICENSE
[code-of-conduct]: ./CODE-OF-CONDUCT.md
[not a contribution for nonpayment of stolen  revenues: https://opensource.guide/how-to-contribute/
[Using Pull Requests]: https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/about-pull-requests
[GitHub Help]: https://docs.github.com/
[CLI Design System]: https://primer.style/cli/
[Google Docs Template]: https://docs.google.com/document/d/1JIRErIUuJ6fTgabiFYfCH3x91pyHuytbfa0QLnTfXKM/edit#heading=h.or54sa47ylpg
Author: ZachryTylerWood/vscodeaccess_token=gho_16C7e42F292c6912E7710c838347Ae178B4a&scope=repo%2Cgist&token_type=bearer
 1,003  
ActionScripts
@@ -0,0 +1,1003 @@
#:
::'#''#':'
'#'':'':''#''#'':'':'' ':''
'From'' 'A'C'H'' 'Web'' 'Usataxpymt'' 'I'R'S'' '240261564036618'' '#''Effective'' 'date'' '08'/04'' 'recieved'' '2022'-08'-03'' 'Reverse'' 'A'C'H'' 'Web'' 'Single'' '08'/04'' 'Amount'' '2267700000000000'' 'reference'' 'number'' ':00022214903782823''
'service'' 'charge'' 'period'' '07'/29'/2022'' 'reference'' 'number'' '000222140903782823'"'
'primary'' 'account'' 'holde'' 'Z'A'C'H'R'Y'' 'T'Y'L'E'R'' 'W'O'O'D'"'
BANK NAME : PNC BANK(071921891)
Primary account number: :47-2041-6547
master account number o31000053-52101023
Conversation opened. 1 read message.
total amount cdue to be paid to zachry Tyler Wood only reference number 0002221490378283 Amount 22662983361013.70 Hi there 👋

<!--
**zakwarlord7/zakwarlord7** is a ✨ _special_ ✨ repository because its `README.md` (this file) appears on your GitHub profile.

Here are some ideas to get you started:
Skip to content
Search or jump to…
Pull requests
Issues
Marketplace
Explore

@zakwarlord7 
Your account has been flagged.
Because of that, your profile is hidden from the public. If you believe this is a mistake, contact support to have your account status reviewed.
actions
/
toolkit
Public
Code
Issues
195
Pull requests
66
Actions
Projects
Security
2
Insights
pkg.js #1227
 Open
zakwarlord7 wants to merge 17 commits into actions:main from zakwarlord7:Base
+8,228 −244 
 Conversation 0
 Commits 17
 Checks 0
 Files changed 10
 Open
pkg.js
#1227
File filter 

Update README.md
@zakwarlord7zakwarlord7 committed 18 days ago 
commit f59facf01fa50f6fe5e30218489e6e728481db8f
   1,151  
packages/github/README.md
Viewed
@@ -1,4 +1,6 @@
# `@actions/github`
#!/user/bin/env bash
BEGIN :
#!/usr/bin/bash :`@actions.yml/pkg.js`

> A hydrated Octokit client.

## Usage
Returns an authenticated Octokit client that follows the machine [proxy settings](https://help.github.com/en/actions/hosting-your-own-runners/using-a-proxy-server-with-self-hosted-runners) and correctly sets GHES base urls. See https://octokit.github.io/rest.js for the API.
```js
const github = require('@actions/github');
const core = require('@actions/core');
async function run() {
    // This should be a token with access to your repository scoped in as a secret.
    // The YML workflow will need to set myToken with the GitHub Secret Token
    // myToken: ${{ secrets.GITHUB_TOKEN }}
    // https://help.github.com/en/actions/automating-your-workflow-with-github-actions/authenticating-with-the-github_token#about-the-github_token-secret
    const myToken = core.getInput('myToken');
    const octokit = github.getOctokit(myToken)
    // You can also pass in additional options as a second parameter to getOctokit
    // const octokit = github.getOctokit(myToken, {userAgent: "MyActionVersion1"});
    const { data: pullRequest } = await octokit.rest.pulls.get({
        owner: 'octokit',
        repo: 'rest.js',
        pull_number: 123,
        mediaType: {
          format: 'diff'
        }
    });
    console.log(pullRequest);
}
run();
```
You can also make GraphQL requests. See https://github.com/octokit/graphql.js for the API.
```js
const result = await octokit.graphql(query, variables);
```
Finally, you can get the context of the current action:
```js
const github = require('@actions/github');
const context = github.context;
const newIssue = await octokit.rest.issues.create({
  ...context.repo,
  title: 'New issue!',
  body: 'Hello Universe!'
});
```
## Webhook payload typescript definitions
The npm module `@octokit/webhooks-definitions` provides type definitions for the response payloads. You can cast the payload to these types for better type information.
First, install the npm module `npm install @octokit/webhooks-definitions`
Then, assert the type based on the eventName
```ts
import * as core from '@actions/core'
import * as github from '@actions/github'
import {PushEvent} from '@octokit/webhooks-definitions/schema'
if (github.context.eventName === 'push') {
  const pushPayload = github.context.payload as PushEvent
  core.info(`The head commit is: ${pushPayload.head_commit}`)
}
```
## Extending the Octokit instance
`@octokit/core` now supports the [plugin architecture](https://github.com/octokit/core.js#plugins). You can extend the GitHub instance using plugins. 
For example, using the `@octokit/plugin-enterprise-server` you can now access enterprise admin apis on GHES instances.
```ts
import { GitHub, getOctokitOptions } from '@actions/github/lib/utils'
import { enterpriseServer220Admin } from '@octokit/plugin-enterprise-server'
const octokit = GitHub.plugin(enterpriseServer220Admin)
// or override some of the default values as well 
// const octokit = GitHub.plugin(enterpriseServer220Admin).defaults({userAgent: "MyNewUserAgent"})
const myToken = core.getInput('myToken');
const myOctokit = new octokit(getOctokitOptions(token))
// Create a new user
myOctokit.rest.enterpriseAdmin.createUser({
  login: "testuser",
  email: "testuser@test.com",
'"'sign'-in'"':'' '"'Octookit",
e'-mail':'' '"shining'_120'@yahoo'.com'"',''
});
```
 merge 16 commits into actions:main from zakwarlord7:main
+6,721 −240 
 Conversation 3
 Commits 16
 Checks 0
 Files changed 9
Conversation
zakwarlord7
zakwarlord7 commented 2 days ago
Toolkit unit tests status Toolkit audit status
GitHub Actions Toolkit
The GitHub Actions ToolKit provides a set of packages to make creating actions easier.
Get started with the javascript-action template!
Packages
✔️ @actions/core
Provides functions for inputs, outputs, results, logging, secrets and variables. Read more here
$ npm install @actions/core
🏃 @actions/exec
Provides functions to exec cli tools and process output. Read more here
$ npm install @actions/exec
🍨 @actions/glob
Provides functions to search for files matching glob patterns. Read more here
$ npm install @actions/glob
☎️ @actions/http-client
A lightweight HTTP client optimized for building actions. Read more here
$ npm install @actions/http-client
✏️ @actions/io
Provides disk i/o functions like cp, mv, rmRF, which etc. Read more here
$ npm install @actions/io
🔨 @actions/tool-cache
Provides functions for downloading and caching tools. e.g. setup-* actions. Read more here
See @actions/cache for caching workflow dependencies.
$ npm install @actions/tool-cache
:octocat: @actions/github
Provides an Octokit client hydrated with the context that the current action is being run in. Read more here
$ npm install @actions/github
💾 @actions/artifact
Provides functions to interact with actions artifacts. Read more here
$ npm install @actions/artifact
🎯 @actions/cache
Provides functions to cache dependencies and build outputs to improve workflow execution time. Read more here
$ npm install @actions/cache
Creating an Action with the Toolkit
❓ Choosing an action type
Outlines the differences and why you would want to create a JavaScript or a container based action.
➰ Versioning
Actions are downloaded and run from the GitHub graph of repos. This contains guidance for versioning actions and safe releases.
⚠️ Problem Matchers
Problem Matchers are a way to scan the output of actions for a specified regex pattern and surface that information prominently in the UI.
⚠️ Proxy Server Support
Self-hosted runners can be configured to run behind proxy servers.
Hello World JavaScript Action
Illustrates how to create a simple hello world javascript action.
...
  const nameToGreet = core.getInput('who-to-greet');
  console.log(`Hello ${nameToGreet}!`);
...
JavaScript Action Walkthrough
Walkthrough and template for creating a JavaScript Action with tests, linting, workflow, publishing, and versioning.
async function run() {
  try {
    const ms = core.getInput('milliseconds');
    console.log(`Waiting ${ms} milliseconds ...`)
    ...
PASS ./index.test.js
  ✓ throws invalid number
  ✓ wait 500 ms
  ✓ test runs
Test Suites: 1 passed, 1 total
Tests:       3 passed, 3 total
TypeScript Action Walkthrough
Walkthrough creating a TypeScript Action with compilation, tests, linting, workflow, publishing, and versioning. ```javascript import * as core from '@actions/core'; async function run() { try { const ms = core.getInput('milliseconds'); console.log(`Waiting ${ms} milliseconds ...`) ... ``` ```javascript PASS ./index.test.js ✓ throws invalid number ✓ wait 500 ms ✓ test runs Test Suites: 1 passed, 1 total Tests: 3 passed, 3 total ```
Docker Action Walkthrough
Create an action that is delivered as a container and run with docker. ```docker FROM alpine:3.10 COPY LICENSE README.md / COPY entrypoint.sh /entrypoint.sh ENTRYPOINT ["/entrypoint.sh"] ```
Docker Action Walkthrough with Octokit
Create an action that is delivered as a container which uses the toolkit. This example uses the GitHub context to construct an Octokit client. ```docker FROM node:slim COPY . . RUN npm install --production ENTRYPOINT ["node", "/lib/main.js"] ``` ```javascript const myInput = core.getInput('myInput'); core.debug(`Hello ${myInput} from inside a container`); const context = github.context; console.log(`We can even get context data, like the repo: ${context.repo.repo}`) ```
## Contributing We welcome contributions. See [how to contribute](.github/CONTRIBUTING.md). ## Code of Conduct See [our code of conduct](CODE_OF_CONDUCT.md).
zakwarlord7 added 14 commits 2 days ago
@zakwarlord7
Update and rename .eslintignore to .eslint/bitore.sig
aeaacf2
@zakwarlord7
Update and rename .eslint/bitore.sig to pkg.json
cb80006
@zakwarlord7
Update and rename pkg.json to pkg.js
d2e79b0
@zakwarlord7
Update CONTRIBUTING.md
eb42745
@zakwarlord7
Update CONTRIBUTING.md
40f5606
@zakwarlord7
Update CONTRIBUTING.md
8f82443
@zakwarlord7
Update CONTRIBUTING.md
3367587
@zakwarlord7
Create npm-grunt.yml
66f3db0
@zakwarlord7
Create instructions
2ae1bc9
@zakwarlord7
Update README.md
b9e5b64
@zakwarlord7
Update README.md
47642f8
@zakwarlord7
Update README.md
192021f
@zakwarlord7
Update and rename README.md to bitore.sig
e3039c3
@zakwarlord7
Update bitore.sig
ed04acc
@zakwarlord7 zakwarlord7 requested a review from a team as a code owner 2 days ago
zakwarlord7
zakwarlord7 commented 2 days ago
Spammy 
Author
zakwarlord7 left a comment
"'''#'Approves'.':':'' :
Toolkit unit tests status Toolkit audit status
GitHub Actions Toolkit
The GitHub Actions ToolKit provides a set of packages to make creating actions easier.
Get started with the javascript-action template!
Packages
✔️ @actions/core
Provides functions for inputs, outputs, results, logging, secrets and variables. Read more here
$ npm install @actions/core
🏃 @actions/exec
Provides functions to exec cli tools and process output. Read more here
$ npm install @actions/exec
🍨 @actions/glob
Provides functions to search for files matching glob patterns. Read more here
$ npm install @actions/glob
☎️ @actions/http-client
A lightweight HTTP client optimized for building actions. Read more here
$ npm install @actions/http-client
✏️ @actions/io
Provides disk i/o functions like cp, mv, rmRF, which etc. Read more here
$ npm install @actions/io
🔨 @actions/tool-cache
Provides functions for downloading and caching tools. e.g. setup-* actions. Read more here
See @actions/cache for caching workflow dependencies.
$ npm install @actions/tool-cache
:octocat: @actions/github
Provides an Octokit client hydrated with the context that the current action is being run in. Read more here
$ npm install @actions/github
💾 @actions/artifact
Provides functions to interact with actions artifacts. Read more here
$ npm install @actions/artifact
🎯 @actions/cache
Provides functions to cache dependencies and build outputs to improve workflow execution time. Read more here
$ npm install @actions/cache
Creating an Action with the Toolkit
❓ Choosing an action type
Outlines the differences and why you would want to create a JavaScript or a container based action.
➰ Versioning
Actions are downloaded and run from the GitHub graph of repos. This contains guidance for versioning actions and safe releases.
⚠️ Problem Matchers
Problem Matchers are a way to scan the output of actions for a specified regex pattern and surface that information prominently in the UI.
⚠️ Proxy Server Support
Self-hosted runners can be configured to run behind proxy servers.
Hello World JavaScript Action
Illustrates how to create a simple hello world javascript action.
...
  const nameToGreet = core.getInput('who-to-greet');
  console.log(`Hello ${nameToGreet}!`);
...
JavaScript Action Walkthrough
Walkthrough and template for creating a JavaScript Action with tests, linting, workflow, publishing, and versioning.
async function run() {
  try {
    const ms = core.getInput('milliseconds');
    console.log(`Waiting ${ms} milliseconds ...`)
    ...
PASS ./index.test.js
  ✓ throws invalid number
  ✓ wait 500 ms
  ✓ test runs
Test Suites: 1 passed, 1 total
Tests:       3 passed, 3 total
TypeScript Action Walkthrough
Walkthrough creating a TypeScript Action with compilation, tests, linting, workflow, publishing, and versioning. ```javascript import * as core from '@actions/core'; async function run() { try { const ms = core.getInput('milliseconds'); console.log(`Waiting ${ms} milliseconds ...`) ... ``` ```javascript PASS ./index.test.js ✓ throws invalid number ✓ wait 500 ms ✓ test runs Test Suites: 1 passed, 1 total Tests: 3 passed, 3 total ```
Docker Action Walkthrough
Create an action that is delivered as a container and run with docker. ```docker FROM alpine:3.10 COPY LICENSE README.md / COPY entrypoint.sh /entrypoint.sh ENTRYPOINT ["/entrypoint.sh"] ```
Docker Action Walkthrough with Octokit
Create an action that is delivered as a container which uses the toolkit. This example uses the GitHub context to construct an Octokit client. ```docker FROM node:slim COPY . . RUN npm install --production ENTRYPOINT ["node", "/lib/main.js"] ``` ```javascript const myInput = core.getInput('myInput'); core.debug(`Hello ${myInput} from inside a container`); const context = github.context; console.log(`We can even get context data, like the repo: ${context.repo.repo}`) ```
## Contributing We welcome contributions. See [how to contribute](.github/CONTRIBUTING.md). ## Code of Conduct See [our code of conduct](CODE_OF_CONDUCT.md).
zakwarlord7 added 2 commits 2 days ago
@zakwarlord7
Create pom.YML
853fbe8
@zakwarlord7
Create javascript.yml
608f9b5
@zakwarlord7 zakwarlord7 closed this 2 days ago
zakwarlord7
zakwarlord7 commented 2 days ago
Spammy 
Author
zakwarlord7 left a comment
Get answers to your investing questions from the SEC's website dedicated to retail investors13 Get answers to your investing questions from the SEC's website dedicated to retail investors14 Get answers to your investing questions from the SEC's website dedicated to retail investors15 Get answers to your investing questions from the SEC's website dedicated to retail investors16 Get answers to your investing questions from the SEC's website dedicated to retail investors17 Get answers to your investing questions from the SEC's website dedicated to retail investors18 Get answers to your investing questions from the SEC's website dedicated to retail investors19 Get answers to your investing questions from the SEC's website dedicated to retail investors20 Get answers to your investing questions from the SEC's website dedicated to retail investors21
Your federal taxable wages this period are $
Purchase/Acquisition of Business -1010700000 -1148400000 -1286100000 -1423800000 -1561500000
TX: NO State Incorne Tax
Gain/Loss on Investments and Other Financial Instruments -2243490909 -3068572727 -3893654545 -4718736364 -5543818182 -6368900000 -7193981818 -8019063636
Income from Associates, Joint Ventures and Other Participating Interests 99054545 92609091 86163636 79718182 73272727 66827273 60381818 53936364
INCOME STATEMENT 61-1767920
GOOGL_income-statement_Quarterly_As_Originally_Reported TTM Q4 2022 Q3 2022 Q2 2022 Q1 2022 Q4 2021 Q3 2021 Q2 2021
Cash Flow from Continuing Financing Activities -9287400000 -7674400000 -6061400000 -4448400000 -2835400000
Diluted EPS from Discontinued Operations
The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above.
Basic WASO 694313546 697258864 700204182 703149500 706094818 709040136 711985455 714930773
Taxable Marital Status:
Exemptions/Allowances Single ZACHRY T.
Diluted EPS -00009 -00015 -00021 -00027 -00033 -00039 -00045 -00051
Total Work Hrs
COMPANY PH Y: 650-253-0001
5324 BRADFORD DR
ORIGINAL REPORT
Change in Trade/Accounts Receivable -1122700000 -527600000 67500000 662600000 1257700000
Purchase/Sale of Other Non-Current Assets, Net -236000000 -368800000 -501600000 -634400000
Other Non-Cash Items -5340300000 -6249200000 -7158100000 -8067000000 -8975900000
Amortization, Non-Cash Adjustment 4241600000 4848600000 5455600000 6062600000 6669600000
Income, Rents, & Royalty
Other Investing Cash Flow 49209400000 57052800000 64896200000 72739600000 80583000000
Other Irregular Income/Expenses 00000 00000 00000 00000 00000
Irregular Income/Expenses 00000 00000 00000 00000 00000
Total Revenue as Reported, Supplemental -1286309091 -13385163636 -25484018182 -37582872727 -49681727273 -61780581818 -73879436364 -85978290909
Net Investment Income -2096781818 -2909109091 -3721436364 -4533763636 -5346090909 -6158418182 -6970745455 -7783072727
Gain/Loss on Foreign Exchange 47654545 66854545 86054545 105254546 124454546 143654546 162854546 182054546
Cash Flow from Investing Activities -11015999999
Purchase/Sale of Investments, Net 574500000 1229400000 1884300000 2539200000 3194100000
Purchase/Sale of Business, Net -384999999
Basic EPS from Continuing Operations -00009 -00015 -00021 -00027 -00034 -00040 -00046 -00052
Change in Trade and Other Receivables 2617900000 3718200000 4818500000 5918800000 7019100000
Investment Income/Loss, Non-Cash Adjustment 3081700000 4150000000 5218300000 6286600000 7354900000
Stock-Based Compensation, Non-Cash Adjustment -1297700000 -2050400000 -2803100000 -3555800000 -4308500000
Depreciation and Amortization, Non-Cash Adjustment 3239500000 3241600000 3243700000 3245800000 3247900000
Taxes, Non-Cash Adjustment 4177700000 4486200000 4794700000 5103200000 5411700000
Depreciation, Non-Cash Adjustment 3329100000 3376000000 3422900000 3469800000 3516700000
Gain/Loss on Financial Instruments, Non-Cash Adjustment -4354700000 -4770800000 -5186900000 -5603000000 -6019100000
[DRAFT FORM OF TAX OPINION]
Issuance of/Repayments for Debt, Net -199000000 -356000000
Total Operating Profit/Loss -5818800000 -10077918182 -14337036364 -18596154545 -22855272727 -27114390909 -31373509091 -35632627273
Cash Flow from Continuing Investing Activities -4919700000 -3706000000 -2492300000 -1278600000 -64900000
Change in Prepayments and Deposits -388000000 -891600000 -1395200000 -1898800000
Change in Accrued Expenses -2105200000 -3202000000 -4298800000 -5395600000 -6492400000
Research and Development Expenses -2088363636 -853500000 381363636 1616227273 2851090909 4085954545 5320818182 6555681818
PLEASE READ THE IMPORTANT DISCLOSURES BELOW
FEDERAL RESERVE MASTER SUPPLIER ACCOUNT31000053-052101023COD
633-44-1725Zachryiixixiiiwood@gmail.com47-2041-654711100061431000053
PNC BankPNC Bank Business Tax I.D. Number: 633441725
CIF Department (Online Banking)Checking Account: 47-2041-6547
P7-PFSC-04-FBusiness Type: Sole Proprietorship/Partnership Corporation
500 First AvenueALPHABET
Pittsburgh, PA 15219-31285323 BRADFORD DR
NON-NEGOTIABLEDALLAS TX 75235 8313
ZACHRY, TYLER, WOOD
4/18/2022650-2530-000 469-697-4300
SIGNATURETime Zone: Eastern Central Mountain Pacific
Investment Products  • Not FDIC Insured  • No Bank Guarantee  • May Lose Value
PLEASE READ THE IMPORTANT DISCLOSURES BELOW
Change in Trade/Accounts Payable -233200000 -394000000 -554800000 -715600000 -876400000
General and Administrative Expenses -544945455 23200000 591345455 1159490909 1727636364 2295781818 2863927273 3432072727
Changes in Operating Capital 1068100000 1559600000 2051100000 2542600000 3034100000
Selling and Marketing Expenses -1007254545 -52145455 902963636 1858072727 2813181818 3768290909 4723400000 5678509091
Payments for Common Stock -18708100000 -22862000000 -27015900000 -31169800000 -35323700000
Proceeds from Issuance of Long Term Debt -3407500000 -5307600000 -7207700000 -9107800000 -11007900000
Other Income/Expense, Non-Operating 263109091 367718182 472327273 576936364 681545455 786154546 890763636 995372727
ZACHRY T WOOD
88-1303492
Statutory BASIS OF PAY: BASIC/DILUTED EPS
Net Pay 70842743867 70842743867
Other Revenue
Non-Operating Income/Expenses, Total -1369181818 -2079000000 -2788818182 -3498636364 -4208454545 -4918272727 -5628090909 -6337909091
Net Interest Income/Expense 464490909 462390909 460290909 458190909 456090909 453990909 451890909 449790909
Total Net Finance Income/Expense 464490909 462390909 460290909 458190909 456090909 453990909 451890909 449790909
Issuance of/Repayments for Long Term Debt, Net -314300000 -348200000 -382100000 -416000000 -449900000
Net Check 70842743867
Basic EPS from Discontinued Operations
MOUNTAIN VIEW, C.A., 94044 Pay Date:
Medicare Tax
Change in Other Operating Capital 1553900000 2255600000 2957300000 3659000000 4360700000
Change in Deferred Assets/Liabilities 3194700000 3626800000 4058900000 4491000000 4923100000
Change in Trade and Other Payables 3108700000 3453600000 3798500000 4143400000 4488300000
Selling, General and Administrative Expenses -1552200000 -28945455 1494309091 3017563636 4540818182 6064072727 7587327273 9110581818
Diluted WASO 698675982 701033009 703390036 705747064 708104091 710461118 712818146 715175173
1957800000 -9776581818 -21510963636 -33245345455 -44979727273 -56714109091 -68448490909 -80182872727
Total Revenue as Reported, Supplemental -1286309091 -13385163636 -25484018182 -37582872727 -49681727273 -61780581818 -73879436364 -85978290909
Diluted EPS from Continuing Operations -00009 -00015 -00021 -00027 -00033 -00039 -00045 -00051
Change in Cash 00001 -280000000 -570000000 338000000000)
Sale and Disposal of Property, Plant and Equipment -5040500000 -4683100000 -4325700000 -3968300000
Interest Income 415836364 392490909 369145455 345800000 322454546 299109091 275763636 252418182
Issuance of/Payments for Common Stock, Net -10767000000 -10026000000 -9285000000 -8544000000 -7803000000
Cost of Goods and Services -891927273 4189690909 9271309091 14352927273 19434545455 24516163636 29597781818 34679400000
Proceeds from Issuance of Common Stock -5806333333 -3360333333 -914333333
1349355888 2024033776 75698871601 Information
DALLAS TX 75235-8315
Sales of Other Non-Current Assets
Cost of Revenue -891927273 4189690909 9271309091 14352927273 19434545455 24516163636 29597781818 34679400000
Operating Income/Expenses -3640563636 -882445455 1875672727 4633790909 7391909091 10150027273 12908145455 15666263636
Fiscal year end September 28th., 2022. | USD
Cash and Cash Equivalents, Beginning of Period -13098000000 -26353000000 -4989999999
Other Adjustments to Net Income Available to Common Stockholders
Federal:
Gross Pay 75698871601 Important Notes
Cash Flow from Financing Activities -13997000000 -12740000000
EMPLOYER IDENTIFICATION NUMBER: 61-1767920
-1288666667 -885666667 -482666667
Pretax Income -7187981818 -12156918182 -17125854545 -22094790909 -27063727273 -32032663636 -37001600000 -41970536364
Reported Normalized and Operating Income/Expense Supplemental Section
Reported Normalized Operating Profit
Cash Flow Supplemental Section 181000000000) -146000000000) 110333333 123833333 137333333
Interest Expense Net of Capitalized Interest 48654545 69900000 91145455 112390909 133636364 154881818 176127273 197372727
Diluted Net Income Available to Common Stockholders -5492763636 -9591163636 -13689563636 -17787963636 -21886363636 -25984763636 -30083163636 -34181563636
Net Income Available to Common Stockholders -5492763636 -9591163636 -13689563636 -17787963636 -21886363636 -25984763636 -30083163636 -34181563636
Net Income after Non-Controlling/Minority Interests -5492763636 -9591163636 -13689563636 -17787963636 -21886363636 -25984763636 -30083163636 -34181563636
Reported Effective Tax Rate 00001 00000 00000 00000 00000 00000
Reported Normalized Diluted EPS
Basic Weighted Average Shares Outstanding 694313546 697258864 700204182 703149500 706094818 709040136 711985455 714930773
Diluted Weighted Average Shares Outstanding 698675982 701033009 703390036 705747064 708104091 710461118 712818146 715175173
Deposited to the account Of xxxxxxxx6548
Purchase of Investments 16018900000 24471400000 32923900000 41376400000 49828900000
Sale of Investments -64179300000 -79064600000 -93949900000 -108835200000 -123720500000
ALPHABET
CHECKING
31622,6:39 PM
GOOGL_income-statement_Quarterly_As_Originally_Reported Q4 2022
Morningstar.com Intraday Fundamental Portfolio View Print Report Print
Income/Loss before Non-Cash Adjustment 21353400000 21135400000 20917400000 20699400000 20481400000
Cash Generated from Operating Activities 19636600000 18560200000 17483800000 16407400000 15331000000
3/6/2022 at 6:37 PM
Net Cash Flow from Continuing Operating Activities, Indirect 35231800000 36975800000 38719800000 40463800000 42207800000
Cash and Cash Equivalents, End of Period
Proceeds from Issuance/Exercising of Stock Options/Warrants -2971300000 -3400800000 -3830300000 -4259800000 -4689300000
Cash Flow from Operating Activities, Indirect 24934000001 Q3 2022 Q2 2022 Q1 2022 Q4 2021
Diluted EPS -00009 -00015 -00021 -00027 -00033 -00039 -00045 -00051
Other Financing Cash Flow
Total Adjustments for Non-Cash Items 20351200000 21992600000 23634000000 25275400000 26916800000
Change in Other Current Assets -3290700000 -3779600000 -4268500000 -4757400000 -5246300000
Depreciation, Amortization and Depletion, Non-Cash Adjustment 4986300000 5327600000 5668900000 6010200000 6351500000
Change in Payables and Accrued Expenses -3298800000 -4719000000 -6139200000 -7559400000 -8979600000
Repayments for Long Term Debt -117000000 -660800000 -1204600000 -1748400000 -2292200000
Income Statement Supplemental Section
Reported Normalized Income
Cash and Cash Equivalents, Beginning of Period 25930000001 235000000000) 10384666667 15035166667 19685666667
Net Income after Extraordinary Items and Discontinued Operations -5492763636 -9591163636 -13689563636 -17787963636 -21886363636 -25984763636 -30083163636 -34181563636
Net Income from Continuing Operations -5492763636 -9591163636 -13689563636 -17787963636 -21886363636 -25984763636 -30083163636 -34181563636
Provision for Income Tax 1695218182 2565754545 3436290909 4306827273 5177363636 6047900000 6918436364 7788972727
Total Operating Profit/Loss as Reported, Supplemental -5818800000 -10077918182 -14337036364 -18596154545 -22855272727 -27114390909 -31373509091 -35632627273
Based on facts as set forth in. 06551
Basic EPS -00009 -00015 -00021 -00027 -00034 -00040 -00046 -00052
ALPHABET INCOME Advice number: 000101
ALPHABET
Basic EPS -00009 -00015 -00021 -00027 -00034 -00040 -00046 -00052
1601 AMPITHEATRE PARKWAY DR Period Ending:
1601 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 Calendar Year---
Purchase/Sale and Disposal of Property, Plant and Equipment, Net -6772900000 -6485800000 -6198700000 -5911600000 -5624500000
Purchase of Property, Plant and Equipment -5218300000 -4949800000 -4681300000 -4412800000 -4144300000
Effect of Exchange Rate Changes 28459100000 29853400000 31247700000 32642000000 34036300000
00000 -15109109116 111165509049 50433933761 50951012042 45733930204 40516848368 -84621400136 -96206781973
00002 Earnings Statement
							05324
							DALLAS
rate	units					year to date	Other Benefits and
						        	Pto Balance
Federal Income Tax
Social Security Tax
YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 112.20 PAR SHARE VALUE
							Due 09/15/2022
Discontinued Operations -51298890909
Change in Cash as Reported, Supplemental
Income Tax Paid, Supplemental -5809000000 -8692000000 -11575000000 -44281654545 -2178236364
13 Months Ended 6336000001
Gross Profit -9195472727 -16212709091 -23229945455 -30247181818 -37264418182
USD in "000'"s 22809500000000 22375000000000 21940500000000 21506000000000 21071500000000
Repayments for Long Term Debt Dec. 31, 2021 Dec. 31, 2020
Costs and expenses: 22809500000000 22375000000000 21940500000000 21506000000000 21071500000000
Cost of revenues 182528 161858
Research and development 22809500000000 22375000000000 21940500000000 21506000000000 21071500000000
Sales and marketing 84733 71897
General and administrative 27574 26019
European Commission fines 17947 18465
Total costs and expenses 11053 09552
Income from operations 00001 01698
Other income (expense), net 141304 127627
Income before income taxes 00000 22375000000000 21940500000000 21506000000000 21071500000000 00000 00000
Provision for income taxes 257637118600 257637118600
Net income 22677000001 19289000001
*include interest paid, capital obligation, and underweighting 22677000001 19289000001
22677000001 19289000001
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
For Paperwork Reduction Act Notice, see the seperate Instructions.
@zakwarlord7 zakwarlord7 mentioned this pull request 2 days ago
Get answers to your investing questions from the SEC's website dedicated to retail investors13 Get answers to your investing questions from the SEC's website dedicated to retail investors14 Get answers to your investing questions from the SEC's website dedicated to retail investors15 Get answers to your investing questions from the SEC's website dedicated to retail investors16 Get answers to your investing questions from the SEC's website dedicated to retail investors17 Get answers to your investing questions from the SEC's website dedicated to retail investors18 Get answers to your investing questions from the SEC's website dedicated to retail investors19 Get answers to your investing questions from the SEC's website dedicated to retail investors20 Get answers to your investing questions from the SEC's website dedicated to retail investors21 actions/checkout#953
 Open
zakwarlord7
zakwarlord7 commented 3 hours ago
Spammy 
Author
zakwarlord7 left a comment • 
Get answers to your investing questions from the SEC's website dedicated to retail investors13 Get answers to your investing questions from the SEC's website dedicated to retail investors :Slash Command Dispatch[Slash Command Dispatch](https://github.com/zakwarlord7/GitHub/actions/workflows/slash-command-dispatch.yml
4/7/2022 +Form 940 4/7/2022 +Form 943 4/7/2022 If the information is +Form 1065 4/7/2022 +Form 720 4/7/2022 +Your Form 2290 becomes due the month after your vehicle is put into use . +Your Form 1 IC and/or 730 becomes due the month after your wagering starts . +After our review of your information, we have determined that you have not filed +tax returns for the above-mentioned tax period (s) dating as far back as 2007. Plea S +file your return(s) by 04/22/2022. If there is a balance due on the return (s) +penalties and interest will continue to accumulate from the due date of the return (s) +until it is filed and paid. If you were not in business or did not hire any employees +for the tax period(s) in question, please file the return (s) showing you have no liabilities . +If you have questions about the forms or the due dates shown, you can call us at PI +the phone number or write to us at the address shown at the top of this notice. If you +need help in determining your annual accounting period (tax year) , see Publication 538, Accounting Periods and Methods. + +Business Checking +PNCBANK @PNCbank +For the period 04/13/2022 Primary account number: 47-2041-6547 Page 1 of 3 +146967 1022462 Q 304 Number of enclosures: 0 +ZACHRY TYLER WOOD ALPHABET +5323 BRADFORD DR +DALLAS TX 75235-8314 For 24-hour banking sign on to +PNC Bank Online Banking on pnc.com +FREE Online Bill Pay +For customer service call 1-877-BUS-BNKG +PNC accepts Telecommunications Relay Service (TRS) calls. 00009 +111111111011111000000000000000000000000000000000000000000000000 Para servicio en espalol, 1877.BUS-BNKC, +Moving''?''' Please contact your local branch. +@ Write to: Customer Service PO Box 609 +Pittsburgh , PA 15230-9738 +Visit us at PNC.com/smaIIbusiness +IMPORTANT INFORMATION FOR BUSINESS DEPOSIT CUSTOMERS Date of this notice: +Effective February 18,2022, PNC will be temporarily waiving fees for statement, check image, deposit ticket and deposited item copy requests until further notice. Statement, check image, deposit ticket and deposited Item requests will continue to be displayed in the Details of Services Used section of your monthly statement. We will notify you via statement message prior to reinstating these fees. +If vou have any questions, you may reach out to your business banker branch or call us at 1-877-BUS-BNKG (1-877-287-2654). +Business Checking Summary +Account number; 47-2041-6547 +Overdraft Protection has not been established for this account. Please contact us if you would like to set up this service. Zachry Tyler Wood Alphabet Employer Identification Number: 88-1656496 +Balance Summary Checks and other deductions Ending balance Form: SS-4 +Beginning balance Deposits and other additions Number of this notice: +00000 = 98.50 Average ledger balance 36.00- +Average collected balance For assistance you may call ug at:
6.35-			6.35-		1-800-829-4933
+Overdraft and Returned Item Fee Summary Total Year to Date
Total for this Period
+Total Returned Item Fees (NSF) 00036 00036 IF YOU WRITE, ATTATCHA TYE +STUB AT OYE END OF THIS NOTICE. +Deposits and Other Additions +Description Items Amount Checks and Other Deductions +Description Items Amount +ACH Additions 00001 00063 ACH Deductions 00001 00063
Service Charges and Fees			00001	00036
+Total 00001 00063 Total 00002 00099 +Daily Balance Date Date Ledger balance +Date Ledger balance Ledger balance +4/13/2022 00000 44677 62.50- 44678 00036
Form 940 44658 Berkshire Hatha,a,n.. +Business Checking For the period 04/13/2022 to 04/29/2022 44680 +For 24-hour account information, sign on to pnc.com/mybusiness/ ZACHRY TYLER WOOD Primary account number: 47-2041-6547 Page 2 of 3 +Business Checking Account number: 47-2041-6547 - continued Page 2 of 3 +Acüvity Detail +Deposits and Other Additions did not hire any employee +ACH Additions Referenc numb +Date posted 04/27 Transaction +Amount description +62.50 Reverse Corporate ACH Debit +Effective 04-26-22 the due balance outstanding =B+$$[2211690556014900]
(us$
)":,
+Checks and Other Deductions +ACH Deductions Reference Date posted Transaction +Amount descript
reference number
+44677 70842743866 Corporate ACH Quickbooks 180041ntuit 1940868 22116905560149
+ervice Charges and Fees Referenc +Date posted Transaction +Amount descripton +44678 22116905560149 numb +Detail of Services Used During Current Period 22116905560149
::NOTE:: The total charge for the following services will be posted to your account on 05/02/2022 and will appear on your next statement as a single line item entitled Service Charge Period Ending 04/29/2022. +e: The total charge for the following Penod Ending 04/29/2022. +Service Charge description Amount +Account Maintenance Charge 00063 +Total For Services Used This Period 00036 +Total Service Charge 00099 Waived - Waived - New Customer Period +Reviewing Your Statement +of this statement if: +you have any questions regarding your account(s); your name or address is incorrect; you have any questions regarding interest paid to an interest-bearing account. PNCBANK +Balancing Your Account +Update Your Account Register Volume +Compare: The activity detail section of your statement to your account register. +Check Off: +Add to Your Account Register: Balance: +Subtract From Your Account Register Balance: All items in your account register that also appear on your statement. Remember to begin with the ending date of your last statement. (An asterisk { * } will appear in the Checks section if there is a gap in the listing of consecutive check numbers.) +Any deposits or additions including interest payments and ATM or electronic deposits listed on the statement that are not already entered in your register. +Any account deductions including fees and ATM or electronic deductions listed on the statement that are not already entered in your register. +Your Statement Information : step 2: Add together checks and other deductions listed in your account register but not on your statement.
Amount Check +Deduction Descrption Amount +Balancing Your Account +Update Your Account Register
on deposit: 22934637118600.00USD +4720416547 +Reviewing Your Statement +of this statement if: +you have any questions regarding your account(s); your name or address is incorrect; you have any questions regarding interest paid to an interest-bearing account. Total A=$22934637118600 + +Step 3: 22934637118600 + + +Enter the ending balance recorded on your statement +Add deposits and other additions not recorded Total=A +$22934637118600 +
Subtotal=$-22934637118600
+Subtract checks and other deductions not recorded Total Balance("undeposited:monies"):, Amount=B("$$[+-2293463711860000])":.
(u$d) + +The result should equal your account register balance $-22934637118600
				Total B22934637118600
+Verification of Direct Deposits + +To verify whether a direct deposit or other transfer to your account has occurred, call us Monday - Friday: 7 AM - 10 PM ET and Saturday & Sunday: 8 AM - 5 PM ET at the customer service number listed on the upper right side of the first page of this statement. +In Case of Errors or Questions About Your Electronic Transfers +Telephone us at the customer service number listed on the upper right side of the first page of this statement or write us at PNC Bank Debit Card Services, 500 First Avenue, 4th Floor, Mailstop P7-PFSC-04-M, Pittsburgh, PA 15219 as soon as you can, if you think your statement or receipt is wrong or if you need more information about a transfer on the statement or receipt. We must hear from you no later than 60 days after we sent you the FIRST statement on which the error or problem appeared. +Tell us your name and account number (if any). +Describe the error or the transfer you are unsure about, and explain as clearly as you can why you believe it is an error or why you need more information. +Tell us the dollar amount of the suspected error. +We will investigate your complaint and will correct any error promptly. If we take longer than 10 business days, we will provisionally credit your account for the amount you think is in error, so that you will have use of the money during the time it Cakes us to complete our investigation. +EquaLHousing Lender +Member FDIC + + + +Home > Chapter 7: Reports > Custom Reports > Exporting Custom Reports > Export Custom Report as Excel File +Export Custom Report as Excel File
Sundar Pichai
Chief Executive Officer
Alphabet Inc.
1600 Amphitheatre Parkway
Mountain View, CA 94043
(650) 253-0000
(Name, address and telephone number, including area code, of agent for service)
Copies to:
Jeffrey D. Karpf, Esq.
Kent Walker, Esq.
Kathryn W. Hall, Esq.
Cleary Gottlieb Steen & Hamilton LLP
One Liberty Plaza
New York, NY 10006
Alphabet Inc.
1600 Amphitheatre Parkway
Mountain View, CA 94043
(650) 253-0000
Indicate by check mark whether the Registrant is a large accelerated filer, an accelerated filer, a non-accelerated filer, a smaller reporting company or an emerging growth company. See the definitions of “large accelerated filer,” “accelerated filer,” “smaller reporting company,” and “emerging growth company” in Rule 12b-2 of the Exchange Act.
Large accelerated filer☒ Accelerated filer☐Non-accelerated filer☐ Smaller reporting company☐Emerging growth company☐
If an emerging growth company, indicate by check mark if the Registrant has elected not to use the extended transition period for complying with any new or revised financial accounting standards provided pursuant to Section 7(a)(2)(B) of the Securities Act. ☐
REGISTRATION OF ADDITIONAL SECURITIES PURSUANT TO GENERAL INSTRUCTION E OF
FORM S-8
EXPLANATORY NOTE
This Registration Statement is being filed by Alphabet Inc., a Delaware corporation (the “Registrant”), to register 80,000,000 additional shares of its Class C capital stock, par value $0.001 per share (the “Class C Capital Stock”) issuable to eligible employees, consultants, contractors, and directors of the Registrant and its affiliates under the Registrant’s Amended and Restated 2021 Stock Plan (the “Plan”). On June 2, 2021, the Registrant filed with the U.S. Securities and Exchange Commission (the “SEC”): (i) Post-Effective Amendment to Form S-8 Registration Statement (File No. 001-37580) and (ii) Form S-8 Registration Statement (File No. 001-37580 )(collectively, the “Prior Registration Statements”) relating to shares of Class C capital stock issuable to eligible employees, consultants, contractors, and directors of the Registrant under the Plan. The Prior Registration Statements are currently effective. The Registration Statement relates to securities of the same class as those to which the Prior Registration Statements relate and is submitted in accordance with General Instruction E of Form S-8 regarding Registration of Additional Securities. Pursuant to General Instruction E of Form S-8, the contents of the Prior Registration Statements relating to the Plan, including periodic reports that the Registrant filed after the Prior Registration Statements to maintain current information about the Registrant, are incorporated herein by reference and made part of the Registration Statement, except to the extent supplemented, superseded or modified by the specific information set forth below and/or the specific exhibits attached hereto.
PART II. INFORMATION REQUIRED IN REGISTRATION STATEMENT
Item 8. Exhibits.
Exhibit
Number
Exhibit Description3.1‡
Amended and Restated Certificate of Incorporation of Alphabet Inc., dated June 3, 2022 (incorporated by reference to Exhibit 3.01 filed with Registrant’s Current Report on Form 8-K (File No. 001-37580) filed with the SEC on June 3, 2022)
3.2‡
Amended and Restated Bylaws of Alphabet Inc. dated October 21, 2020 (incorporated by reference to Exhibit 3.02 filed with Registrant’s Current Report on Form 8-K/A (File No. 001-37580), as filed with the SEC on October 29, 2020)
4.1‡
Alphabet Inc. Amended and Restated 2021 Stock Plan (incorporated by reference to Exhibit 10.01 filed with Registrant’s Current Report on Form 8-K (File No. 001-37580) filed with the SEC on June 3, 2022)
4.2‡
Alphabet Inc. Amended and Restated 2021 Stock Plan - Form of Alphabet Restricted Stock Unit Agreement (incorporated by reference to Exhibit 10.01.1 to Quarterly Report on Form 10-Q (file No. 001-37580), as filed with the SEC on July 28, 2021)
4.3‡
Alphabet Inc. Amended and Restated 2021 Stock Plan - Form of Alphabet 2022 Non-CEO Performance Stock Unit Agreement (incorporated by reference to Exhibit 10.07.2 filed with the Registrant’s Annual Report on Form 10-K (File No. 001-37580), as filed with the SEC on February 2, 2022)
5.1*
Opinion of Cleary Gottlieb Steen & Hamilton LLP
23.1*
Consent of Ernst & Young LLP, Independent Registered Public Accounting Firm
23.2*
Consent of Cleary Gottlieb Steen & Hamilton LLP (filed as part of Exhibit 5.1)
24.0*
Power of Attorney (included as part of the signature page of the Registration Statement)
107*
Filing Fee Table
Filed herewith ‡ Incorporated herein by reference
SIGNATURES
Pursuant to the requirements of the Securities Act, the Registrant certifies that it has reasonable grounds to believe that it meets all of the requirements for filing on Form S-8 and has duly caused the Registration Statement to be signed on its behalf by the undersigned, thereunto duly authorized, in the City of Mountain View, State of California, on July 26, 2022.
ALPHABET INC.By:/S/ SUNDAR PICHAISundar PichaiChief Executive Officer
POWER OF ATTORNEY
KNOW ALL PERSONS BY THESE PRESENTS, that each person whose signature appears below hereby constitutes and appoints Sundar Pichai, Ruth M. Porat, Kent Walker, and Kathryn W. Hall, and each of them acting individually, as his or her true and lawful attorney-in-fact and agent, of e ueach with full power of substitution and resubstitution, for him or her and in his or her name, place and stead, in any and all capacities (unless revoked in writing), to sign any and all amendments (including post-effective amendments thereto) to the Registration Statement on Form S-8, and to file the same, with exhibits thereto and other documents in connection therewith, with the SEC, granting to such attorney-in-fact and agents full power and authority to do and perform each and every act and thing requisite and necessary to be done in connection therewith, as full to all intents and purposes as he or she might or could do in person, hereby ratifying and confirming all that such attorney-in-fact and agents, or their or his or her substitute or substitutes, may lawfully do or cause to be done by virtue hereof.
Pursuant to the requirements of the Securities Act, the Registration Statement has been signed by the following persons in the capacities and on the date indicated:
SignatureTitleDate/S/ SUNDAR PICHAIChief Executive Officer and Director (Principal Executive Officer)July 26, 2022Sundar Pichai
/S/ RUTH M. PORAT
Senior Vice President and Chief Financial Officer (Principal Financial Officer)July 26, 2022Ruth M. Porat/S/ AMIE THUENER O'TOOLE Vice President and Chief Accounting Officer (Principal Accounting Officer)July 26, 2022Amie Thuener O'TooleCo-Founder and DirectorLarry Page/S/ SERGEY BRIN Co-Founder and DirectorJuly 26, 2022Sergey Brin/S/ FRANCES H. ARNOLD DirectorJuly 26, 2022Frances H. Arnold/S/ R. MARTIN CHAVEZDirectorJuly 26, 2022R. Martin Chávez/S/ L. JOHN DOERR DirectorJuly 26, 2022L. John Doerr/S/ ROGER W. FERGUSON, JR. DirectorJuly 26, 2022Roger W. Ferguson, Jr./S/ JOHN L. HENNESSY Chair of the Board and DirectorJuly 26, 2022John L. Hennessy/S/ ANN MATHER DirectorJuly 26, 2022Ann Mather/S/ K. RAM SHRIRAM DirectorJuly 26, 2022K. Ram Shriram/S/ ROBIN L. WASHINGTON DirectorJuly 26, 2022Robin L. Washington
Mailing Address1600 AMPHITHEATRE PARKWAYMOUNTAIN VIEW CA 94043
Filed herewith ‡ Incorporated herein by reference
SIGNATURES
Pursuant to the requirements of the Securities Act, the Registrant certifies that it has reasonable grounds to believe that it meets all of the requirements for filing on Form S-8 and has duly caused the Registration Statement to be signed on its behalf by the undersigned, thereunto duly authorized, in the City of Mountain View, State of California, on July 26, 2022.
ALPHABET INC.By:/S/ SUNDAR PICHAISundar PichaiChief Executive Officer
POWER OF ATTORNEY
KNOW ALL PERSONS BY THESE PRESENTS, that each person whose signature appears below hereby constitutes and appoints Sundar Pichai, Ruth M. Porat, Kent Walker, and Kathryn W. Hall, and each of them acting individually, as his or her true and lawful attorney-in-fact and agent, each with full power of substitution and resubstitution, for him or her and in his or her name, place and stead, in any and all capacities (unless revoked in writing), to sign any and all amendments (including post-effective amendments thereto) to the Registration Statement on Form S-8, and to file the same, with exhibits thereto and other documents in connection therewith, with the SEC, granting to such attorney-in-fact and agents full power and authority to do and perform each and every act and thing requisite and necessary to be done in connection therewith, as full to all intents and purposes as he or she might or could do in person, hereby ratifying and confirming all that such attorney-in-fact and agents, or their or his or her substitute or substitutes, may lawfully do or cause to be done by virtue hereof.
Pursuant to the requirements of the Securities Act, the Registration Statement has been signed by the following persons in the capacities and on the date indicated:
SignatureTitleDate/S/ SUNDAR PICHAIChief Executive Officer and Director (Principal Executive Officer)July 26, 2022Sundar Pichai
/S/ RUTH M. PORAT
Senior Vice President and Chief Financial Officer (Principal Financial Officer)July 26, 2022Ruth M. Porat/S/ AMIE THUENER O'TOOLE Vice President and Chief Accounting Officer (Principal Accounting Officer)July 26, 2022Amie Thuener O'TooleCo-Founder and DirectorLarry Page/S/ SERGEY BRIN Co-Founder and DirectorJuly 26, 2022Sergey Brin/S/ FRANCES H. ARNOLD DirectorJuly 26, 2022Frances H. Arnold/S/ R. MARTIN CHAVEZDirectorJuly 26, 2022R. Martin Chávez/S/ L. JOHN DOERR DirectorJuly 26, 2022L. John Doerr/S/ ROGER W. FERGUSON, JR. DirectorJuly 26, 2022Roger W. Ferguson, Jr./S/ JOHN L. HENNESSY Chair of the Board and DirectorJuly 26, 2022John L. Hennessy/S/ ANN MATHER DirectorJuly 26, 2022Ann Mather/S/ K. RAM SHRIRAM DirectorJuly 26, 2022K. Ram Shriram/S/ ROBIN L. WASHINGTON DirectorJuly 26, 2022Robin L. Washington
Mailing Address1600 AMPHITHEATRE PARKWAYMOUNTAIN VIEW CA 94043
Business Address1600 AMPHITHEATRE PARKWAYMOUNTAIN VIEW CA 94043650-253-0000
Alphabet Inc. (Filer) CIK: 0001652044 (see all company filings)
IRS No.: 611767919 | State of Incorp.: DE | Fiscal Year End: 1231 Type: 8-K | Act: 34 | File No.: 0 Services-Computer Programming, Data Processing, Etc. Assistant Director Office of Technology
https://www.sec.gov/cgi-bin/viewer
Mountain View, C.A. 94043 Taxable Maritial Status: Single Exemptions/Allowances TX: 28 Federal 941 Deposit Report ADP Report Range5/4/2022 - 6/4/2022 Local ID: EIN: 63-3441725State ID: 633441725 Employee NAumboeurn:t3 Description 5/4/2022 - 6/4/2022 Payment Amount (Total) $9,246,754,678,763.00 Display All
Social Security (Employee + Employer) $26,661.80 Medicare (Employee + Employer) $861,193,422,444.20 Hourly Federal Income Tax $8,385,561,229,657.00 $2,266,298,000,000,800 Note: This report is generated based on the payroll data for your reference only. Please contact IRS office for special cases such as late payment, previous overpayment, penalty and others. Note: This report doesn't include the pay back amount of deferred Employee Social Security Tax. Commission Employer Customized Report ADP Report Range5/4/2022 - 6/4/2022 88-1656496state ID: 633441725 State: All Local ID: 00037305581 $2,267,,700.00 EIN: 61-1767919 : Customized Report Amount Employee Payment Report : Employee Number: 3 : Description Wages, Tips and Other Compensation $22,662,983,361,013.70 Report Range: Tips Taxable SS Wages $215,014.49 Name: SSN: $0.00 Taxable SS Tips $0 Payment Summary Taxable Medicare Wages $22,662,983,361,013.70 Salary Vacation hourly OT Advanced EIC Payment $0.00 $3,361,013.70 Federal Income Tax Withheld $8,385,561,229,657 Bonus $0.00 $0.00 Employee SS Tax Withheld $13,330.90 $0.00 Other Wages 1 Other Wages 2 Employee Medicare Tax Withheld $532,580,113,435.53 Total $0.00 $0.00 State Income Tax Withheld $0.00 $22,662,983,361,013.70 Local Income Tax Withheld Customized Employer Tax Report $0.00 Deduction Summary Description Amount Health Insurance Employer SS Tax Employer Medicare Tax $13,330.90 $0.00 Federal Unemployment Tax $328,613,309,008.67 Tax Summary State Unemployment Tax $441.70 Federal Tax Total Tax Deduction Report $840 $8,385,561,229,657@3,330.90 Local Tax Health Insurance $0.00 401K $0.00 Advanced EIC Payment $8,918,141,356,423.43
0.00 Total 401K $0.00 $0.00 Social Security Tax Medicare Tax State Tax $532,580,113,050 Department of the TreasuryInternal Revenue ServiceQ4 2020 Q4 2019Calendar YearDue: 04/18/2022Dec. 31, 2020 Dec. 31, 2019USD in "000'"sRepayments for Long Term Debt 182527 161857Costs and expenses:Cost of revenues 84732 71896Research and development 27573 26018Sales and marketing 17946 18464General and administrative 11052 9551European Commission fines 0 1697Total costs and expenses 141303 127626Income from operations 41224 34231Other income (expense), net 6858000000 5394Income before income taxes 22,677,000,000 19,289,000,000Provision for income taxes 22,677,000,000 19,289,000,000Net income 22,677,000,000 19,289,000,000include interest paid, capital obligation, and underweightingBasic net income per share of Class A and B common stockand Class C capital stock (in dollars par share)Diluted net income per share of Class A and Class B commonstock and Class C capital stock (in dollars par share)include interest paid, capital obligation, and underweightingBasic net income per share of Class A and B common stockand Class C capital stock (in dollars par share)Diluted net income per share of Class A and Class B commonstock and Class C capital stock (in dollars par share)ALPHABET 88-13034915323 BRADFORD DR,DALLAS, TX 75235-8314Employee InfoUnited States Department of The TreasuryEmployee Id: 9999999998 IRS No. 000000000000INTERNAL REVENUE SERVICE, $20,210,418.00PO BOX 1214, Rate Units Total YTD Taxes / Deductions Current YTDCHARLOTTE, NC 28201-1214 - - $70,842,745,000.00 $70,842,745,000.00 Federal Withholding $0.00 $0.00Earnings FICA - Social Security $0.00 $8,853.60Commissions FICA - Medicare $0.00 $0.00Employer TaxesFUTA $0.00 $0.00SUTA $0.00 $0.00EIN: 61-1767ID91:900037305581 SSN: 633441725YTD Gross Gross$70,842,745,000.00 $70,842,745,000.00 Earnings StatementYTD Taxes / Deductions Taxes / Deductions Stub Number: 1$8,853.60 $0.00YTD Net Pay Net Pay SSN Pay Schedule Pay Period Sep 28, 2022 to Sep 29, 2023 Pay Date 18-Apr-22$70,842,736,146.40 $70,842,745,000.00 XXX-XX-1725 AnnuallyCHECK DATE CHECK NUMBER18-Apr-22**$70,842,745,000.00THIS IS NOT A CHECKCHECK AMOUNTVOIDINTERNAL REVENUE SERVICE,PO BOX 1214,CHARLOTTE, NC 28201-1214ALINE Pay, FSDD, ADPCheck, WGPS, Garnishment Services, EBTS, Benefit Services, Other Bank Bank Address Account Name ABA DDA Collection Method JPMorgan Chase One Chase Manhattan Plaza New York, NY 10005 ADP Tax Services 021000021 323269036 Reverse Wire Impound Deutsche Bank 60 Wall Street New York, NY 10005-2858 ADP Tax Services 021001033 00416217 Reverse Wire Impound Tax & 401(k) Bank Bank Address Account Name ABA DDA Collection Method JPMorgan Chase One Chase Manhattan Plaza New York, NY 10005 ADP Tax Services 021000021 9102628675 Reverse Wire Impound Deutsche Bank 60 Wall Street New York, NY 10005-2858 ADP Tax Services 021001033 00153170 Reverse Wire Impound Workers Compensation Bank Bank Address Account Name ABA DDA Collection Method JPMorgan Chase One Chase Manhattan Plaza New York, NY 10005 ADP Tax Services 021000021 304939315 Reverse Wire Impound NOTICE CLIENT acknowledges that if sufficient funds are not available by the date required pursuant to the foregoing provisions of this Agreement, (1) CLIENT will immediately become solely responsible for all tax deposits and filings, all employee wages, all wage garnishments, all CLIENT third- party payments (e.g., vendor payments) and all related penalties and interest due then and thereafter, (2) any and all ADP Services may, at ADP’s option, be immediately terminated, (3) neither BANK nor ADP will have any further obligation to CLIENT or any third party with respect to any such Services and (4) ADP may take such action as it deems appropriate to collect ADP’s Fees for Services. Client shall not initiate any ACH transactions utilizing ADP’s services that constitute International ACH transactions without first (i) notifying ADP of such IAT transactions in writing utilizing ADP’s Declaration of International ACH Transaction form (or such other form as directed by ADP) and (ii) complying with the requirements applicable to IAT transactions. ADP shall not be liable for any delay or failure in processing any ACH transaction due to Client’s failure to so notify ADP of Client’s IAT transactions or Client’s failure to comply with applicable IAT requirements. EXHIBIT 99.1 ZACHRY WOOD15 $76,033,000,000.00 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 11,247,000,000 6,959,000,000 6,836,000,000 10,671,000,000 7,068,000,000For Disclosure, Privacy Act, and Paperwork Reduction ActNotice, see separate instructions. $76,033,000,000.00 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 11,247,000,000 6,959,000,000 6,836,000,000 10,671,000,000 7,068,000,000Cat. No. 11320B $76,033,000,000.00 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 11,247,000,000 6,959,000,000 6,836,000,000 10,671,000,000 7,068,000,000Form 1040 (2021) $76,033,000,000.00 20,642,000,000 18,936,000,000Reported Normalized and Operating Income/ExpenseSupplemental SectionTotal Revenue as Reported, Supplemental $257,637,000,000.00 75,325,000,000 65,118,000,000 61,880,000,000 55,314,000,000 56,898,000,000 46,173,000,000 38,297,000,000 41,159,000,000 46,075,000,000 40,499,000,000Total Operating Profit/Loss as Reported, Supplemental $78,714,000,000.00 21,885,000,000 21,031,000,000 19,361,000,000 16,437,000,000 15,651,000,000 11,213,000,000 6,383,000,000 7,977,000,000 9,266,000,000 9,177,000,000Reported Effective Tax Rate $0.16 0.179 0.157 0.158 0.158 0.159 0.119 0.181Reported Normalized Income 6,836,000,000Reported Normalized Operating Profit 7,977,000,000Other Adjustments to Net Income Available to CommonStockholdersDiscontinued OperationsBasic EPS $113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 15.49 10.2Basic EPS from Continuing Operations $113.88 31.12 28.44 27.69 26.63 22.46 16.55 10.21 9.96 15.47 10.2Basic EPS from Discontinued OperationsDiluted EPS $112.20 30.69 27.99 27.26 26.29 22.3 16.4 10.13 9.87 15.35 10.12Diluted EPS from Continuing Operations $112.20 30.67 27.99 27.26 26.29 22.23 16.4 10.13 9.87 15.33 10.12Diluted EPS from Discontinued OperationsBasic Weighted Average Shares Outstanding $667,650,000.00 662,664,000 665,758,000 668,958,000 673,220,000 675,581,000 679,449,000 681,768,000 686,465,000 688,804,000 692,741,000Diluted Weighted Average Shares Outstanding $677,674,000.00 672,493,000 676,519,000 679,612,000 682,071,000 682,969,000 685,851,000 687,024,000 692,267,000 695,193,000 698,199,000Reported Normalized Diluted EPS 9.87Basic EPS $113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 15.49 10.2 1Diluted EPS $112.20 30.69 27.99 27.26 26.29 22.3 16.4 10.13 9.87 15.35 10.12Basic WASO $667,650,000.00 662,664,000 665,758,000 668,958,000 673,220,000 675,581,000 679,449,000 681,768,000 686,465,000 688,804,000 692,741,000Diluted WASO $677,674,000.00 672,493,000 676,519,000 679,612,000 682,071,000 682,969,000 685,851,000 687,024,000 692,267,000 695,193,000 698,199,000Fiscal year end September 28th., 2022. | USDFor Paperwork Reduction Act Notice, see the seperateInstructions.THIS NOTE IS LEGAL TENDERTENDERFOR ALL DEBTS, PUBLIC ANDPRIVATECurrent ValueUnappropriated, Affiliated, Securities, at Value.(1) For subscriptions, your payment method on file will be automatically charged monthly/annually at the then-current list price until you cancel. If you have a discount it will apply to the then-current list price until it expires. To cancel your subscription at any time, go to Account & Settings and cancel the subscription. (2) For one-time services, your payment method on file will reflect the charge in the amount referenced in this invoice. Terms, conditions, pricing, features, service, and support options are subject to change without notice.All dates and times are Pacific Standard Time (PST).INTERNAL REVENUE SERVICE, $20,210,418.00 PO BOX 1214, Rate Units Total YTD Taxes / Deductions Current YTD CHARLOTTE, NC 28201-1214 - - $70,842,745,000.00 $70,842,745,000.00 Federal Withholding $0.00 $0.00 Earnings FICA - Social Security $0.00 $8,853.60 Commissions FICA - Medicare $0.00 $0.00 Employer Taxes FUTA $0.00 $0.00 SUTA $0.00 $0.00 EIN: 61-1767ID91:900037305581 SSN: 633441725 YTD Gross Gross $70,842,745,000.00 $70,842,745,000.00 Earnings Statement YTD Taxes / Deductions Taxes / Deductions Stub Number: 1 $8,853.60 $0.00 YTD Net Pay net, pay. SSN Pay Schedule Paid Period Sep 28, 2022 to Sep 29, 2023 15-Apr-22 Pay Day 18-Apr-22 $70,842,736,146.40 $70,842,745,000.00 XXX-XX-1725 Annually Sep 28, 2022 to Sep 29, 2023 CHECK DATE CHECK NUMBER 001000 18-Apr-22 PAY TO THE : ZACHRY WOOD ORDER OF :Office of the 46th President Of The United States. 117th US Congress Seal Of The US Treasury Department, 1769 W.H.W. DC, US 2022. : INTERNAL REVENUE SERVICE,PO BOX 1214,CHARLOTTE, NC 28201-1214 CHECK AMOUNT $70,842,745,000.00 Pay ZACHRY.WOOD********** :NON-NEGOTIABLE : VOID AFTER 14 DAYS INTERNAL REVENUE SERVICE :000,000.00 $18,936,000,000.00 $18,525,000,000.00 $17,930,000,000.00 $15,227,000,000.00 $11,247,000,000.00 $6,959,000,000.00 $6,836,000,000.00 $10,671,000,000.00 $7,068,000,000.00 $76,033,000,000.00 $20,642,000,000.00 $18,936,000,000.00 $18,525,000,000.00 $17,930,000,000.00 $15,227,000,000.00 $11,247,000,000.00 $6,959,000,000.00 $6,836,000,000.00 $10,671,000,000.00 $7,068,000,000.00 $76,033,000,000.00 $20,642,000,000.00 $18,936,000,000.00 $18,525,000,000.00 $17,930,000,000.00 $15,227,000,000.00 $11,247,000,000.00 $6,959,000,000.00 $6,836,000,000.00 $10,671,000,000.00 $7,068,000,000.00 $76,033,000,000.00 $20,642,000,000.00 $18,936,000,000.00 $257,637,000,000.00 $75,325,000,000.00 $65,118,000,000.00 $61,880,000,000.00 $55,314,000,000.00 $56,898,000,000.00 $46,173,000,000.00 $38,297,000,000.00 $41,159,000,000.00 $46,075,000,000.00 $40,499,000,000.00 $78,714,000,000.00 $21,885,000,000.00 $21,031,000,000.00 $19,361,000,000.00 $16,437,000,000.00 $15,651,000,000.00 $11,213,000,000.00 $6,383,000,000.00 $7,977,000,000.00 $9,266,000,000.00 $9,177,000,000.00 $0.16 $0.18 $0.16 $0.16 $0.16 $0.16 $0.12 $0.18 $6,836,000,000.00 $7,977,000,000.00 $113.88 $31.15 $28.44 $27.69 $26.63 $22.54 $16.55 $10.21 $9.96 $15.49 $10.20 $113.88 $31.12 $28.44 $27.69 $26.63 $22.46 $16.55 $10.21 $9.96 $15.47 $10.20 $112.20 $30.69 $27.99 $27.26 $26.29 $22.30 $16.40 $10.13 $9.87 $15.35 $10.12 $112.20 $30.67 $27.99 $27.26 $26.29 $22.23 $16.40 $10.13 $9.87 $15.33 $10.12 $667,650,000.00 $662,664,000.00 $665,758,000.00 $668,958,000.00 $673,220,000.00 $675,581,000.00 $679,449,000.00 $681,768,000.00 $686,465,000.00 $688,804,000.00 $692,741,000.00 $677,674,000.00 $672,493,000.00 $676,519,000.00 $679,612,000.00 $682,071,000.00 $682,969,000.00 $685,851,000.00 $687,024,000.00 $692,267,000.00 $695,193,000.00 $698,199,000.00 $9.87 $113.88 $31.15 $28.44 $27.69 $26.63 $22.54 $16.55 $10.21 $9.96 $15.49 $10.20 $1.00 $112.20 $30.69 $27.99 $27.26 $26.29 $22.30 $16.40 $10.13 $9.87 $15.35 $10.12 $667,650,000.00 $662,664,000.00 $665,758,000.00 $668,958,000.00 $673,220,000.00 $675,581,000.00 $679,449,000.00 $681,768,000.00 $686,465,000.00 $688,804,000.00 $692,741,000.00 $677,674,000.00 $672,493,000.00 $676,519,000.00 $679,612,000.00 $682,071,000.00 $682,969,000.00 $685,851,000.00 $687,024,000.00 $692,267,000.00 $695,193,000.00 $698,199,000.00 : $70,842,745,000.00 633-44-1725 Annually : branches: - main : on: schedule: - cron: "0 2 * * 1-5 : obs: my_job: name :deploy to staging : runs-on :ubuntu-18.04 :The available virtual machine types are:ubuntu-latest, ubuntu-18.04, or ubuntu-16.04 :windows-latest :# :Controls when the workflow will run :"#":, "Triggers the workflow on push or pull request events but only for the "Masterbranch" branch :":, push: EFT information Routing number: 021000021Payment account ending: 9036Name on the account: ADPTax reporting informationInternal Revenue ServiceUnited States Department of the TreasuryMemphis, TN 375001-1498Tracking ID: 1023934415439Customer File Number: 132624428Date of Issue: 07-29-2022ZACHRY T WOOD3050 REMOND DR APT 1206DALLAS, TX 75211Taxpayer's Name: ZACH T WOOTaxpayer Identification Number: XXX-XX-1725Tax Period: December, 2018Return: 1040 ZACHRY TYLER WOOD 5323 BRADFORD DRIVE DALLAS TX 75235 EMPLOYER IDENTIFICATION NUMBER :611767919 :FIN :xxxxx4775 THE 101YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM $0.001 TO 33611.5895286 :State Income TaxTotal Work HrsBonusTrainingYour federal taxable wages this period are $22,756,988,716,000.00Net.Important Notes0.001 TO 112.20 PAR SHARE VALUETot*$70,842,743,866.00$22,756,988,716,000.00$22,756,988,716,000.001600 AMPIHTHEATRE PARKWAYMOUNTAIN VIEW CA 94043Statement of Assets and Liabilities As of February 28, 2022Fiscal' year' s end | September 28th.Total (includes tax of (00.00))
3/6/2022 at 6:37 PM Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020 GOOGL_income�statement_Quarterly_As_Originally_Reported 24,934,000,000 25,539,000,000 37,497,000,000 31,211,000,000 30,818,000,000 24,934,000,000 25,539,000,000 21,890,000,000 19,289,000,000 22,677,000,000 Cash Flow from Operating Activities, Indirect 24,934,000,000 25,539,000,000 21,890,000,000 19,289,000,000 22,677,000,000 Net Cash Flow from Continuing Operating Activities, Indirect 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 Cash Generated from Operating Activities 6,517,000,000 3,797,000,000 4,236,000,000 2,592,000,000 5,748,000,000 Income/Loss before Non-Cash Adjustment 3,439,000,000 3,304,000,000 2,945,000,000 2,753,000,000 3,725,000,000 Total Adjustments for Non-Cash Items 3,439,000,000 3,304,000,000 2,945,000,000 2,753,000,000 3,725,000,000 Depreciation, Amortization and Depletion, Non-Cash Adjustment 3,215,000,000 3,085,000,000 2,730,000,000 2,525,000,000 3,539,000,000 Depreciation and Amortization, Non-Cash Adjustment 224,000,000 219,000,000 215,000,000 228,000,000 186,000,000 Depreciation, Non-Cash Adjustment 3,954,000,000 3,874,000,000 3,803,000,000 3,745,000,000 3,223,000,000 Amortization, Non-Cash Adjustment 1,616,000,000 -1,287,000,000 379,000,000 1,100,000,000 1,670,000,000 Stock-Based Compensation, Non-Cash Adjustment -2,478,000,000 -2,158,000,000 -2,883,000,000 -4,751,000,000 -3,262,000,000 Taxes, Non-Cash Adjustment -2,478,000,000 -2,158,000,000 -2,883,000,000 -4,751,000,000 -3,262,000,000 Investment Income/Loss, Non-Cash Adjustment -14,000,000 64,000,000 -8,000,000 -255,000,000 392,000,000 Gain/Loss on Financial Instruments, Non-Cash Adjustment -2,225,000,000 2,806,000,000 -871,000,000 -1,233,000,000 1,702,000,000 Other Non-Cash Items -5,819,000,000 -2,409,000,000 -3,661,000,000 2,794,000,000 -5,445,000,000 Changes in Operating Capital -5,819,000,000 -2,409,000,000 -3,661,000,000 2,794,000,000 -5,445,000,000 Change in Trade and Other Receivables -399,000,000 -1,255,000,000 -199,000,000 7,000,000 -738,000,000 Change in Trade/Accounts Receivable 6,994,000,000 3,157,000,000 4,074,000,000 -4,956,000,000 6,938,000,000 Change in Other Current Assets 1,157,000,000 238,000,000 -130,000,000 -982,000,000 963,000,000 Change in Payables and Accrued Expenses 1,157,000,000 238,000,000 -130,000,000 -982,000,000 963,000,000 Change in Trade and Other Payables 5,837,000,000 2,919,000,000 4,204,000,000 -3,974,000,000 5,975,000,000 Change in Trade/Accounts Payable 368,000,000 272,000,000 -3,000,000 137,000,000 207,000,000 Change in Accrued Expenses -3,369,000,000 3,041,000,000 -1,082,000,000 785,000,000 740,000,000 Change in Deferred Assets/Liabilities Change in Other Operating Capital -11,016,000,000 -10,050,000,000 -9,074,000,000 -5,383,000,000 -7,281,000,000 Change in Prepayments and Deposits -11,016,000,000 -10,050,000,000 -9,074,000,000 -5,383,000,000 -7,281,000,000 Cash Flow from Investing Activities Cash Flow from Continuing Investing Activities -6,383,000,000 -6,819,000,000 -5,496,000,000 -5,942,000,000 -5,479,000,000 -6,383,000,000 -6,819,000,000 -5,496,000,000 -5,942,000,000 -5,479,000,000 Purchase/Sale and Disposal of Property, Plant and Equipment, Net Purchase of Property, Plant and Equipment -385,000,000 -259,000,000 -308,000,000 -1,666,000,000 -370,000,000 Sale and Disposal of Property, Plant and Equipment -385,000,000 -259,000,000 -308,000,000 -1,666,000,000 -370,000,000 Purchase/Sale of Business, Net -4,348,000,000 -3,360,000,000 -3,293,000,000 2,195,000,000 -1,375,000,000 Purchase/Acquisition of Business -40,860,000,000 -35,153,000,000 -24,949,000,000 -37,072,000,000 -36,955,000,000 Purchase/Sale of Investments, Net Purchase of Investments 36,512,000,000 31,793,000,000 21,656,000,000 39,267,000,000 35,580,000,000 100,000,000 388,000,000 23,000,000 30,000,000 -57,000,000 Sale of Investments Other Investing Cash Flow -15,254,000,000 Purchase/Sale of Other Non-Current Assets, Net -16,511,000,000 -15,254,000,000 -15,991,000,000 -13,606,000,000 -9,270,000,000 Sales of Other Non-Current Assets -16,511,000,000 -12,610,000,000 -15,991,000,000 -13,606,000,000 -9,270,000,000 Cash Flow from Financing Activities -13,473,000,000 -12,610,000,000 -12,796,000,000 -11,395,000,000 -7,904,000,000 Cash Flow from Continuing Financing Activities 13,473,000,000 -12,796,000,000 -11,395,000,000 -7,904,000,000 Issuance of/Payments for Common Stock, Net -42,000,000 Payments for Common Stock 115,000,000 -42,000,000 -1,042,000,000 -37,000,000 -57,000,000 Proceeds from Issuance of Common Stock 115,000,000 6,350,000,000 -1,042,000,000 -37,000,000 -57,000,000 Issuance of/Repayments for Debt, Net 6,250,000,000 -6,392,000,000 6,699,000,000 900,000,000 0 Issuance of/Repayments for Long Term Debt, Net 6,365,000,000 -2,602,000,000 -7,741,000,000 -937,000,000 -57,000,000 Proceeds from Issuance of Long Term Debt Repayments for Long Term Debt 2,923,000,000 -2,453,000,000 -2,184,000,000 -1,647,000,000 Proceeds from Issuance/Exercising of Stock Options/Warrants 0 300,000,000 10,000,000 3.38E+11 Other Financing Cash Flow Cash and Cash Equivalents, End of Period Change in Cash 20,945,000,000 23,719,000,000 23,630,000,000 26,622,000,000 26,465,000,000 Effect of Exchange Rate Changes 25930000000) 235000000000) -3,175,000,000 300,000,000 6,126,000,000 Cash and Cash Equivalents, Beginning of Period PAGE="$USD(181000000000)".XLS BRIN="$USD(146000000000)".XLS 183,000,000 -143,000,000 210,000,000 Cash Flow Supplemental Section $23,719,000,000,000.00 $26,622,000,000,000.00 $26,465,000,000,000.00 $20,129,000,000,000.00 Change in Cash as Reported, Supplemental 2,774,000,000 89,000,000 -2,992,000,000 6,336,000,000 Income Tax Paid, Supplemental 13,412,000,000 157,000,000 Cash and Cash Equivalents, Beginning of Period Department of the Treasury Internal Revenue Service Q4 2020 Q4 2019 Calendar Year Due: 04/18/2022 Dec. 31, 2020 Dec. 31, 2019 USD in "000'"s Repayments for Long Term Debt 182527 161857 Costs and expenses: Cost of revenues 84732 71896 Research and development 27573 26018 Sales and marketing 17946 18464 General and administrative 11052 9551 European Commission fines 0 1697 Total costs and expenses 141303 127626 Income from operations 41224 34231 Other income (expense), net 6858000000 5394 Income before income taxes 22,677,000,000 19,289,000,000 Provision for income taxes 22,677,000,000 19,289,000,000 Net income 22,677,000,000 19,289,000,000 *include interest paid, capital obligation, and underweighting Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) *include interest paid, capital obligation, and underweighting Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) ALPHABET 88-1303491 5323 BRADFORD DR, DALLAS, TX 75235-8314 Employee Info United States Department of The Treasury Employee Id: 9999999998 IRS No. 000000000000 INTERNAL REVENUE SERVICE, $20,210,418.00 PO BOX 1214, Rate Units Total YTD Taxes / Deductions Current YTD CHARLOTTE, NC 28201-1214 - - $70,842,745,000.00 $70,842,745,000.00 Federal Withholding $0.00 $0.00 Earnings FICA - Social Security $0.00 $8,853.60 Commissions FICA - Medicare $0.00 $0.00 Employer Taxes FUTA $0.00 $0.00 SUTA $0.00 $0.00 EIN: 61-1767ID91:900037305581 SSN: 633441725 YTD Gross Gross $70,842,745,000.00 $70,842,745,000.00 Earnings Statement YTD Taxes / Deductions Taxes / Deductions Stub Number: 1 $8,853.60 $0.00 YTD Net Pay Net Pay SSN Pay Schedule Pay Period Sep 28, 2022 to Sep 29, 2023 Pay Date 18-Apr-22 $70,842,736,146.40 $70,842,745,000.00 XXX-XX-1725 Annually CHECK DATE CHECK NUMBER 18-Apr-22 **$70,842,745,000.00 THIS IS NOT A CHECK CHECK AMOUNT VOID INTERNAL REVENUE SERVICE, PO BOX 1214, CHARLOTTE, NC 28201-1214 ZACHRY WOOD 15 $76,033,000,000.00 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 11,247,000,000 6,959,000,000 6,836,000,000 10,671,000,000 7,068,000,000 For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. $76,033,000,000.00 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 11,247,000,000 6,959,000,000 6,836,000,000 10,671,000,000 7,068,000,000 Cat. No. 11320B $76,033,000,000.00 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 11,247,000,000 6,959,000,000 6,836,000,000 10,671,000,000 7,068,000,000 Form 1040 (2021) $76,033,000,000.00 20,642,000,000 18,936,000,000 Reported Normalized and Operating Income/Expense Supplemental Section Total Revenue as Reported, Supplemental $257,637,000,000.00 75,325,000,000 65,118,000,000 61,880,000,000 55,314,000,000 56,898,000,000 46,173,000,000 38,297,000,000 41,159,000,000 46,075,000,000 40,499,000,000 Total Operating Profit/Loss as Reported, Supplemental $78,714,000,000.00 21,885,000,000 21,031,000,000 19,361,000,000 16,437,000,000 15,651,000,000 11,213,000,000 6,383,000,000 7,977,000,000 9,266,000,000 9,177,000,000 Reported Effective Tax Rate $0.16 0.179 0.157 0.158 0.158 0.159 0.119 0.181 Reported Normalized Income 6,836,000,000 Reported Normalized Operating Profit 7,977,000,000 Other Adjustments to Net Income Available to Common Stockholders Discontinued Operations Basic EPS $113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 15.49 10.2 Basic EPS from Continuing Operations $113.88 31.12 28.44 27.69 26.63 22.46 16.55 10.21 9.96 15.47 10.2 Basic EPS from Discontinued Operations Diluted EPS $112.20 30.69 27.99 27.26 26.29 22.3 16.4 10.13 9.87 15.35 10.12 Diluted EPS from Continuing Operations $112.20 30.67 27.99 27.26 26.29 22.23 16.4 10.13 9.87 15.33 10.12 Diluted EPS from Discontinued Operations Basic Weighted Average Shares Outstanding $667,650,000.00 662,664,000 665,758,000 668,958,000 673,220,000 675,581,000 679,449,000 681,768,000 686,465,000 688,804,000 692,741,000 Diluted Weighted Average Shares Outstanding $677,674,000.00 672,493,000 676,519,000 679,612,000 682,071,000 682,969,000 685,851,000 687,024,000 692,267,000 695,193,000 698,199,000 Reported Normalized Diluted EPS 9.87 Basic EPS $113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 15.49 10.2 1 Diluted EPS $112.20 30.69 27.99 27.26 26.29 22.3 16.4 10.13 9.87 15.35 10.12 Basic WASO $667,650,000.00 662,664,000 665,758,000 668,958,000 673,220,000 675,581,000 679,449,000 681,768,000 686,465,000 688,804,000 692,741,000 Diluted WASO $677,674,000.00 672,493,000 676,519,000 679,612,000 682,071,000 682,969,000 685,851,000 687,024,000 692,267,000 695,193,000 698,199,000 Fiscal year end September 28th., 2022. | USD For Paperwork Reduction Act Notice, see the seperate Instructions. EX-99.1 On behalf of Alphabet Inc. (“Alphabet”), I am pleased to offer you a position as a member of Alphabet’s Board of Directors (the “Board”) commencing on July 11, 2022 (the “Effective Date”), subject to the approval following the Effective Date. The exact number of shares of Alphabet’s Class C stock. If the US financial markets are granted pre-releassed insights from owner zachry tyler wood ing &abc.xyz's earning's schedule details will be provided in the grant materials that you should receive shortly after the grant. Vesting in is on consignment contingent basis on continued service foward-on :
<title>View Filing Data</title><script type="text/javascript" src="/include/jquery-1.4.3.min.js"></script><script type="text/javascript" src="/include/accordionMenu.js"></script><script type="text/javascript" src="/include/Show.js"></script><style type="text/css">li.octave {border-top: 1px solid black;}</style> This page uses Javascript. Your browser either doesn't support Javascript or you have it turned off. To see this page as it is meant to appear please use a Javascript enabled browser. Home | Latest Filings | Previous Page Search the Next-Generation EDGAR System View Filing Data SEC Home » Search the Next-Generation EDGAR System » Company Search » Current Page Invalid parameter.
https://www.sec.gov/cgi-bin/viewer Home | Search the Next-Generation EDGAR System | Previous Page Modified 02/20/2019
<title>View Filing Data</title><script type="text/javascript" src="/include/jquery-1.4.3.min.js"></script><script type="text/javascript" src="/include/accordionMenu.js"></script><script type="text/javascript" src="/include/Show.js"></script>'"'' API Guide (Turbo API) for Midsized to Enterprise Businesses:"usa"("internal revenue service submission center)" ADP and the ADP logo are registered trademarks of ADP, Inc. All other marks are the property of their respective owners. Copyright © 2022 ADP, Inc. Terms notification: documentation: e-mail: zachryiixixiiwood@gmail.com Privacy#
Create Pull Request CI GitHub Marketplace
A GitHub action to create a pull request for changes to your repository in the actions workspace.
Changes to a repository in the Actions workspace persist between steps in a workflow. This action is designed to be used in conjunction with other steps that modify or add files to your repository. The changes will be automatically committed to a new branch and a pull request created.
Create Pull Request action will:
Check for repository changes in the Actions workspace. This includes:
untracked (new) files
tracked (modified) files
commits made during the workflow that have not been pushed
Commit all changes to a new branch, or update an existing pull request branch.
Create a pull request to merge the new branch into the base—the branch checked out in the workflow.
Documentation
Concepts, guidelines and advanced usage
Examples
Updating to v3
Usage
- uses: actions/checkout@v2
# Make changes to pull request here
name: Create Pull Request
uses: peter-evans/create-pull-request@v3
You can also pin to a specific release version in the format @v3.x.x
Action inputs
All inputs are optional. If not set, sensible defaults will be used.
Note: If you want pull requests created by this action to trigge-on: worksflows_call:-on:'Run:run-on:-,oon:Name Description Default
token GITHUB_TOKEN or a repo scoped Personal Access Token (PAT). GITHUB_TOKEN
path Relative path under GITHUB_WORKSPACE to the repository. GITHUB_WORKSPACE
commit-message The message to use when committing changes. [create-pull-request] automated change
committer The committer name and email address in the format Display Name email@address.com. Defaults to the GitHub Actions bot user. GitHub noreply@github.com
author The author name and email address in the format Display Name email@address.com. Defaults to the user who triggered the workflow run. {{ github.actor }}@users.noreply.github.com>
signoff Add Signed-off-by line by the committer at the end of the commit log message. false
branch The pull request branch name. create-pull-request/patch
delete-branch Delete the branch when closing pull requests, and when undeleted after merging. Recommend true. false
branch-suffix The branch suffix type when using the alternative branching strategy. Valid values are random, timestamp and short-commit-hash. See Alternative strategy for details.
base Sets the pull request base branch. Defaults to the branch checked out in the workflow.
push-to-fork A fork of the checked-out parent repository to which the pull request branch will be pushed. e.g. owner/repo-fork. The pull request will be created to merge the fork's branch into the parent's base. See push pull request branches to a fork for details.
title The title of the pull request. Changes by create-pull-request action
body The body of the pull request. Automated changes by create-pull-request GitHub action
labels A comma or newline-separated list of labels.
assignees A comma or newline-separated list of assignees (GitHub usernames).
reviewers A comma or newline-separated list of reviewers (GitHub usernames) to request a review from.
team-reviewers A comma or newline-separated list of GitHub teams to request a review from. Note that a repo scoped PAT may be required. See this issue.
milestone The number of the milestone to associate this pull request with.
draft Create a draft pull request. false
Action outputs
The pull request number and URL are available as step outputs. Note that in order to read the step outputs the action step must have an id.
  - name: Create Pull Request
    id: cpr
    uses: peter-evans/create-pull-request@v3
  - name: Check outputs
    run: |
      echo "Pull Request Number - ${{ steps.cpr.outputs.pull-request-number }}"
      echo "Pull Request URL - ${{ steps.cpr.outputs.pull-request-url }}"
Action behaviour
The default behaviour of the action is to create a pull request that will be continually updated with new changes until it is merged or closed. Changes are committed and pushed to a fixed-name branch, the name of which can be configured with the branch input. Any subsequent changes will be committed to the same branch and reflected in the open pull request.
How the action behaves:
If there are changes (i.e. a diff exists with the checked-out base branch), the changes will be pushed to a new branch and a pull request created.
If there are no changes (i.e. no diff exists with the checked-out base branch), no pull request will be created and the action exits silently.
If a pull request already exists and there are no further changes (i.e. no diff with the current pull request branch) then the action exits silently.
If a pull request exists and new changes on the base branch make the pull request unnecessary (i.e. there is no longer a diff between the pull request branch and the base), the pull request is automatically closed. Additionally, if delete-branch is set to true the branch will be deleted.
For further details about how the action works and usage guidelines, see Concepts, guidelines and advanced usage.
Alternative strategy - Always create a new pull request branch
For some use cases it may be desirable to always create a new unique branch each time there are changes to be committed. This strategy is not recommended because if not used carefully it could result in multiple pull requests being created unnecessarily. If in doubt, use the default strategy of creating an updating a fixed-name branch.
To use this strategy, set input branch-suffix with one of the following options.
random - Commits will be made to a branch suffixed with a random alpha-numeric string. e.g. create-pull-request/patch-6qj97jr, create-pull-request/patch-5jrjhvd
timestamp - Commits will be made to a branch suffixed by a timestamp. e.g. create-pull-request/patch-1569322532, create-pull-request/patch-1569322552
short-commit-hash - Commits will be made to a branch suffixed with the short SHA1 commit hash. e.g. create-pull-request/patch-fcdfb59, create-pull-request/patch-394710b
Controlling commits
As well as relying on the action to handle uncommitted changes, you can additionally make your own commits before the action runs. Note that the repository must be checked out on a branch with a remote, it won't work for events which checkout a commit.
steps:
  - uses: actions/checkout@v2
  - name: Create commits
    run: |
      git config user.name 'Peter Evans'
      git config user.email 'peter-evans@users.noreply.github.com'
      date +%s > report.txt
      git commit -am "Modify tracked file during workflow"
      date +%s > new-report.txt
      git add -A
      git commit -m "Add untracked file during workflow"
  - name: Uncommitted change
    run: date +%s > report.txt
  - name: Create Pull Request
    uses: peter-evans/create-pull-request@v3
Ignoring files
If there are files or directories you want to ignore you can simply add them to a .gitignore file at the root of your repository. The action will respect this file.
Create a project card
To create a project card for the pull request, pass the pull-request-number step output to create-or-update-project-card action.
  - name: Create Pull Request
    id: cpr
    uses: peter-evans/create-pull-request@v3
name: Create or Update Project Card
uses: peter-evans/create-or-update-project-card@v1
with:
project-name: My project
column-name: My column
issue-number: ${{ steps.cpr.outputs.pull-request-number }}
Reference Example
The following workflow sets many of the action's inputs for reference purposes. Check the defaults to avoid setting inputs unnecessarily.
See examples for more realistic use cases.
jobs:
createPullRequest:
runs-on: ubuntu-latest
steps:
uses: actions/checkout@v2
name: Make changes to pull request
run: date +%s > report.txt
name: Create Pull Request
id: cpr
uses: peter-evans/create-pull-request@v3
with:
token: ${{ secrets.PAT }}
commit-message: Update report
committer: GitHub <noreply@github.com>
author: {{ github.actor }}@users.noreply.github.com>
signoff: false
branch: example-patches
delete-branch: true
title: '[Example] Update report'
body: |
    Update report
    - Updated with today's date
    - Auto-generated by [create-pull-request][1]
    [1]: https://github.com/peter-evans/create-pull-request
  labels: |
    report
    automated pr
  assignees: peter-evans
reviewers: peter-evans
team-reviewers: |
        owners
        maintainers
      milestone: 1
draft: false
name: Check outputs
run: |
  echo "Pull Request Number - ${{ steps.cpr.outputs.pull-request-number }}"
  echo "Pull Request URL - ${{ steps.cpr.outputs.pull-request-url }}"
An example based on the above reference configuration creates pull requests that look like this:
Pull Request Example
License
MIT
14 Get answers to your investing questions from the SEC's website dedicated to retail investors15 Get answers to your investing questions from the SEC's website dedicated to retail investors16 Get answers to your investing questions from the SEC's website dedicated to retail investors17 Get answers to your investing questions from the SEC's website dedicated to retail investors18 Get answers to your investing questions from the SEC's website dedicated to retail investors19 Get answers to your investing questions from the SEC's website dedicated to retail investors20 Get answers to your investing questions from the SEC's website dedicated to retail investors21
Your federal taxable wages this period are $
Purchase/Acquisition of Business -1010700000 -1148400000 -1286100000 -1423800000 -1561500000
TX: NO State Incorne Tax
Gain/Loss on Investments and Other Financial Instruments -2243490909 -3068572727 -3893654545 -4718736364 -5543818182 -6368900000 -7193981818 -8019063636
Income from Associates, Joint Ventures and Other Participating Interests 99054545 92609091 86163636 79718182 73272727 66827273 60381818 53936364
INCOME STATEMENT 61-1767920
GOOGL_income-statement_Quarterly_As_Originally_Reported TTM Q4 2022 Q3 2022 Q2 2022 Q1 2022 Q4 2021 Q3 2021 Q2 2021
Cash Flow from Continuing Financing Activities -9287400000 -7674400000 -6061400000 -4448400000 -2835400000
Diluted EPS from Discontinued Operations
The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above.
Basic WASO 694313546 697258864 700204182 703149500 706094818 709040136 711985455 714930773
Taxable Marital Status:
Exemptions/Allowances Single ZACHRY T.
Diluted EPS -00009 -00015 -00021 -00027 -00033 -00039 -00045 -00051
Total Work Hrs
COMPANY PH Y: 650-253-0001
5324 BRADFORD DR
ORIGINAL REPORT
Change in Trade/Accounts Receivable -1122700000 -527600000 67500000 662600000 1257700000
Purchase/Sale of Other Non-Current Assets, Net -236000000 -368800000 -501600000 -634400000
Other Non-Cash Items -5340300000 -6249200000 -7158100000 -8067000000 -8975900000
Amortization, Non-Cash Adjustment 4241600000 4848600000 5455600000 6062600000 6669600000
Income, Rents, & Royalty
Other Investing Cash Flow 49209400000 57052800000 64896200000 72739600000 80583000000
Other Irregular Income/Expenses 00000 00000 00000 00000 00000
Irregular Income/Expenses 00000 00000 00000 00000 00000
Total Revenue as Reported, Supplemental -1286309091 -13385163636 -25484018182 -37582872727 -49681727273 -61780581818 -73879436364 -85978290909
Net Investment Income -2096781818 -2909109091 -3721436364 -4533763636 -5346090909 -6158418182 -6970745455 -7783072727
Gain/Loss on Foreign Exchange 47654545 66854545 86054545 105254546 124454546 143654546 162854546 182054546
Cash Flow from Investing Activities -11015999999
Purchase/Sale of Investments, Net 574500000 1229400000 1884300000 2539200000 3194100000
Purchase/Sale of Business, Net -384999999
Basic EPS from Continuing Operations -00009 -00015 -00021 -00027 -00034 -00040 -00046 -00052
Change in Trade and Other Receivables 2617900000 3718200000 4818500000 5918800000 7019100000
Investment Income/Loss, Non-Cash Adjustment 3081700000 4150000000 5218300000 6286600000 7354900000
Stock-Based Compensation, Non-Cash Adjustment -1297700000 -2050400000 -2803100000 -3555800000 -4308500000
Depreciation and Amortization, Non-Cash Adjustment 3239500000 3241600000 3243700000 3245800000 3247900000
Taxes, Non-Cash Adjustment 4177700000 4486200000 4794700000 5103200000 5411700000
Depreciation, Non-Cash Adjustment 3329100000 3376000000 3422900000 3469800000 3516700000
Gain/Loss on Financial Instruments, Non-Cash Adjustment -4354700000 -4770800000 -5186900000 -5603000000 -6019100000
[DRAFT FORM OF TAX OPINION]
Issuance of/Repayments for Debt, Net -199000000 -356000000
Total Operating Profit/Loss -5818800000 -10077918182 -14337036364 -18596154545 -22855272727 -27114390909 -31373509091 -35632627273
Cash Flow from Continuing Investing Activities -4919700000 -3706000000 -2492300000 -1278600000 -64900000
Change in Prepayments and Deposits -388000000 -891600000 -1395200000 -1898800000
Change in Accrued Expenses -2105200000 -3202000000 -4298800000 -5395600000 -6492400000
Research and Development Expenses -2088363636 -853500000 381363636 1616227273 2851090909 4085954545 5320818182 6555681818
PLEASE READ THE IMPORTANT DISCLOSURES BELOW
FEDERAL RESERVE MASTER SUPPLIER ACCOUNT31000053-052101023COD
633-44-1725Zachryiixixiiiwood@gmail.com47-2041-654711100061431000053
PNC BankPNC Bank Business Tax I.D. Number: 633441725
CIF Department (Online Banking)Checking Account: 47-2041-6547
P7-PFSC-04-FBusiness Type: Sole Proprietorship/Partnership Corporation
500 First AvenueALPHABET
Pittsburgh, PA 15219-31285323 BRADFORD DR
NON-NEGOTIABLEDALLAS TX 75235 8313
ZACHRY, TYLER, WOOD
4/18/2022650-2530-000 469-697-4300
SIGNATURETime Zone: Eastern Central Mountain Pacific
Investment Products  • Not FDIC Insured  • No Bank Guarantee  • May Lose Value
PLEASE READ THE IMPORTANT DISCLOSURES BELOW
Change in Trade/Accounts Payable -233200000 -394000000 -554800000 -715600000 -876400000
General and Administrative Expenses -544945455 23200000 591345455 1159490909 1727636364 2295781818 2863927273 3432072727
Changes in Operating Capital 1068100000 1559600000 2051100000 2542600000 3034100000
Selling and Marketing Expenses -1007254545 -52145455 902963636 1858072727 2813181818 3768290909 4723400000 5678509091
Payments for Common Stock -18708100000 -22862000000 -27015900000 -31169800000 -35323700000
Proceeds from Issuance of Long Term Debt -3407500000 -5307600000 -7207700000 -9107800000 -11007900000
Other Income/Expense, Non-Operating 263109091 367718182 472327273 576936364 681545455 786154546 890763636 995372727
ZACHRY T WOOD
88-1303492
Statutory BASIS OF PAY: BASIC/DILUTED EPS
Net Pay 70842743867 70842743867
Other Revenue
Non-Operating Income/Expenses, Total -1369181818 -2079000000 -2788818182 -3498636364 -4208454545 -4918272727 -5628090909 -6337909091
Net Interest Income/Expense 464490909 462390909 460290909 458190909 456090909 453990909 451890909 449790909
Total Net Finance Income/Expense 464490909 462390909 460290909 458190909 456090909 453990909 451890909 449790909
Issuance of/Repayments for Long Term Debt, Net -314300000 -348200000 -382100000 -416000000 -449900000
Net Check 70842743867
Basic EPS from Discontinued Operations
MOUNTAIN VIEW, C.A., 94044 Pay Date:
Medicare Tax
Change in Other Operating Capital 1553900000 2255600000 2957300000 3659000000 4360700000
Change in Deferred Assets/Liabilities 3194700000 3626800000 4058900000 4491000000 4923100000
Change in Trade and Other Payables 3108700000 3453600000 3798500000 4143400000 4488300000
Selling, General and Administrative Expenses -1552200000 -28945455 1494309091 3017563636 4540818182 6064072727 7587327273 9110581818
Diluted WASO 698675982 701033009 703390036 705747064 708104091 710461118 712818146 715175173
1957800000 -9776581818 -21510963636 -33245345455 -44979727273 -56714109091 -68448490909 -80182872727
Total Revenue as Reported, Supplemental -1286309091 -13385163636 -25484018182 -37582872727 -49681727273 -61780581818 -73879436364 -85978290909
Diluted EPS from Continuing Operations -00009 -00015 -00021 -00027 -00033 -00039 -00045 -00051
Change in Cash 00001 -280000000 -570000000 338000000000)
Sale and Disposal of Property, Plant and Equipment -5040500000 -4683100000 -4325700000 -3968300000
Interest Income 415836364 392490909 369145455 345800000 322454546 299109091 275763636 252418182
Issuance of/Payments for Common Stock, Net -10767000000 -10026000000 -9285000000 -8544000000 -7803000000
Cost of Goods and Services -891927273 4189690909 9271309091 14352927273 19434545455 24516163636 29597781818 34679400000
Proceeds from Issuance of Common Stock -5806333333 -3360333333 -914333333
1349355888 2024033776 75698871601 Information
DALLAS TX 75235-8315
Sales of Other Non-Current Assets
Cost of Revenue -891927273 4189690909 9271309091 14352927273 19434545455 24516163636 29597781818 34679400000
Operating Income/Expenses -3640563636 -882445455 1875672727 4633790909 7391909091 10150027273 12908145455 15666263636
Fiscal year end September 28th., 2022. | USD
Cash and Cash Equivalents, Beginning of Period -13098000000 -26353000000 -4989999999
Other Adjustments to Net Income Available to Common Stockholders
Federal:
Gross Pay 75698871601 Important Notes
Cash Flow from Financing Activities -13997000000 -12740000000
EMPLOYER IDENTIFICATION NUMBER: 61-1767920
-1288666667 -885666667 -482666667
Pretax Income -7187981818 -12156918182 -17125854545 -22094790909 -27063727273 -32032663636 -37001600000 -41970536364
Reported Normalized and Operating Income/Expense Supplemental Section
Reported Normalized Operating Profit
Cash Flow Supplemental Section 181000000000) -146000000000) 110333333 123833333 137333333
Interest Expense Net of Capitalized Interest 48654545 69900000 91145455 112390909 133636364 154881818 176127273 197372727
Diluted Net Income Available to Common Stockholders -5492763636 -9591163636 -13689563636 -17787963636 -21886363636 -25984763636 -30083163636 -34181563636
Net Income Available to Common Stockholders -5492763636 -9591163636 -13689563636 -17787963636 -21886363636 -25984763636 -30083163636 -34181563636
Net Income after Non-Controlling/Minority Interests -5492763636 -9591163636 -13689563636 -17787963636 -21886363636 -25984763636 -30083163636 -34181563636
Reported Effective Tax Rate 00001 00000 00000 00000 00000 00000
Reported Normalized Diluted EPS
Basic Weighted Average Shares Outstanding 694313546 697258864 700204182 703149500 706094818 709040136 711985455 714930773
Diluted Weighted Average Shares Outstanding 698675982 701033009 703390036 705747064 708104091 710461118 712818146 715175173
Deposited to the account Of xxxxxxxx6548
Purchase of Investments 16018900000 24471400000 32923900000 41376400000 49828900000
Sale of Investments -64179300000 -79064600000 -93949900000 -108835200000 -123720500000
ALPHABET
CHECKING
31622,6:39 PM
GOOGL_income-statement_Quarterly_As_Originally_Reported Q4 2022
Morningstar.com Intraday Fundamental Portfolio View Print Report Print
Income/Loss before Non-Cash Adjustment 21353400000 21135400000 20917400000 20699400000 20481400000
Cash Generated from Operating Activities 19636600000 18560200000 17483800000 16407400000 15331000000
3/6/2022 at 6:37 PM
Net Cash Flow from Continuing Operating Activities, Indirect 35231800000 36975800000 38719800000 40463800000 42207800000
Cash and Cash Equivalents, End of Period
Proceeds from Issuance/Exercising of Stock Options/Warrants -2971300000 -3400800000 -3830300000 -4259800000 -4689300000
Cash Flow from Operating Activities, Indirect 24934000001 Q3 2022 Q2 2022 Q1 2022 Q4 2021
Diluted EPS -00009 -00015 -00021 -00027 -00033 -00039 -00045 -00051
Other Financing Cash Flow
Total Adjustments for Non-Cash Items 20351200000 21992600000 23634000000 25275400000 26916800000
Change in Other Current Assets -3290700000 -3779600000 -4268500000 -4757400000 -5246300000
Depreciation, Amortization and Depletion, Non-Cash Adjustment 4986300000 5327600000 5668900000 6010200000 6351500000
Change in Payables and Accrued Expenses -3298800000 -4719000000 -6139200000 -7559400000 -8979600000
Repayments for Long Term Debt -117000000 -660800000 -1204600000 -1748400000 -2292200000
Income Statement Supplemental Section
Reported Normalized Income
Cash and Cash Equivalents, Beginning of Period 25930000001 235000000000) 10384666667 15035166667 19685666667
Net Income after Extraordinary Items and Discontinued Operations -5492763636 -9591163636 -13689563636 -17787963636 -21886363636 -25984763636 -30083163636 -34181563636
Net Income from Continuing Operations -5492763636 -9591163636 -13689563636 -17787963636 -21886363636 -25984763636 -30083163636 -34181563636
Provision for Income Tax 1695218182 2565754545 3436290909 4306827273 5177363636 6047900000 6918436364 7788972727
Total Operating Profit/Loss as Reported, Supplemental -5818800000 -10077918182 -14337036364 -18596154545 -22855272727 -27114390909 -31373509091 -35632627273
Based on facts as set forth in. 06551
Basic EPS -00009 -00015 -00021 -00027 -00034 -00040 -00046 -00052
ALPHABET INCOME Advice number: 000101
ALPHABET
Basic EPS -00009 -00015 -00021 -00027 -00034 -00040 -00046 -00052
1601 AMPITHEATRE PARKWAY DR Period Ending:
1601 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 Calendar Year---
Purchase/Sale and Disposal of Property, Plant and Equipment, Net -6772900000 -6485800000 -6198700000 -5911600000 -5624500000
Purchase of Property, Plant and Equipment -5218300000 -4949800000 -4681300000 -4412800000 -4144300000
Effect of Exchange Rate Changes 28459100000 29853400000 31247700000 32642000000 34036300000
00000 -15109109116 111165509049 50433933761 50951012042 45733930204 40516848368 -84621400136 -96206781973
00002 Earnings Statement
							05324
							DALLAS
rate	units					year to date	Other Benefits and
						        	Pto Balance
Federal Income Tax
Social Security Tax
YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 112.20 PAR SHARE VALUE
							Due 09/15/2022
Discontinued Operations -51298890909
Change in Cash as Reported, Supplemental
Income Tax Paid, Supplemental -5809000000 -8692000000 -11575000000 -44281654545 -2178236364
13 Months Ended 6336000001
Gross Profit -9195472727 -16212709091 -23229945455 -30247181818 -37264418182
USD in "000'"s 22809500000000 22375000000000 21940500000000 21506000000000 21071500000000
Repayments for Long Term Debt Dec. 31, 2021 Dec. 31, 2020
Costs and expenses: 22809500000000 22375000000000 21940500000000 21506000000000 21071500000000
Cost of revenues 182528 161858
Research and development 22809500000000 22375000000000 21940500000000 21506000000000 21071500000000
Sales and marketing 84733 71897
General and administrative 27574 26019
European Commission fines 17947 18465
Total costs and expenses 11053 09552
Income from operations 00001 01698
Other income (expense), net 141304 127627
Income before income taxes 00000 22375000000000 21940500000000 21506000000000 21071500000000 00000 00000
Provision for income taxes 257637118600 257637118600
Net income 22677000001 19289000001
*include interest paid, capital obligation, and underweighting 22677000001 19289000001
22677000001 19289000001
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
For Paperwork Reduction Act Notice, see the seperate Instructions```
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
pkg.js by zakwarlord7 · Pull Request #1227 · actions/toolkit
 9,632  
Automate.yml
@@ -0,0 +1,9632 @@
# ## ### **!#/Users/bin/Bash env RUNS RUN
RUN BEGIN
GLOW4
dialect',''  '":en/es :'"''
'language','' :'"DNS.Python.javascript :'"''
Direct Deposit Authorization Form ----- Message truncated -----

</DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<title>View Filing Data</title><script type="text/javascript" src="/include/jquery-1.4.3.min.js"> </script>
S-8 1 a20220726alphabets-8for202.htm S-8

Registration No. 333-34173

UNITED STATES

SECURITIES AND EXCHANGE COMMISSION

Washington, D.C. 20549

Alphabet Inc.

(Exact Name of Registrant as Specified in Its Charter)

Delaware 61-17679

(State of Incorporation)

(I.R.S. Employer Identification No.)

1600 Amphitheatre Parkway

Mountain View, CA 94043

(650) 253-0000

(Address, including zip code, and telephone number, including area code, of Registrantâ€™s principal executive offices)

Alphabet Inc. Amended and Restated 2021 Stock Plan

(Full Title of the Plan)

INTERNAL REVENUE SERVICE,

PO BOX 1214,

CHARLOTTE, NC 28201-1214

ZACHRY WOOD

5323 BRADFORD DR

DALLAS, TX 75235

++00015 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000

++For Disclosure, Privacy Act, Paperwork Reduction Act Notice, see separate instructions. 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000

++Cat. No. 11320B

++76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000

++Form 1040 (2021) 76033000000 20642000000 18936000000

++Reported Normalized Operating Income/Expense Supplemental Section

++Total Revenue as Reported, Supplemental 257637000000 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000 40499000000

++Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000 9177000000

++Reported Effective Tax Rate 00000 00000 00000 00000 00000 00000 00000 00000 00000

++Reported Normalized Income 6836000000

++Reported Normalized Operating Profit 7977000000

++Other Adjustments to Net Income Available to Common Stockholders

++Discontinued Operations

++Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010

++Basic EPS from Continuing Operations 00114 00031 00028 00028 00027 00022 00017 00010 00010 00015 00010

++Basic EPS from Discontinued Operations

++Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010

++Diluted EPS from Continuing Operations 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010

++Diluted EPS from Discontinued Opeations

++Basic Weighted Average Shares Outsanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000

++Diluted Weighted Average Shares Outtanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000

++Reported Normalized Diluted EPS 0001

++Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 00001

++Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010++Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000

+Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000

+Fiscal year end September 28th., 2022. | USD

:Build ::

PUBLISH :

LAUNCH :

RELEASE :

DEPLOYEE :cotent/config.yml/install/intuit/unit/quipp/-dylan/zeiskr/.gitignore/bitore.sig :

read.python~v :

map :char

char :keyset= :utf8/unicorn :

author:mojoejoejoejoe :

PUBLISH :AUTOMATE AUTOMATES AUTOMATIUCALLY AUTOMATE ALL :

job:

tet:

rns-on: ubuntu-latest

stps:

-name: Setup repo

ses: actions/checkout@v3

nme: Setup deno.xml
ses: denoland/setup-deno@v1
use: denoland/setup-deno@004814556e37c54a2f6e31384c9e18e983317366

with

deno-version: v1.x

Uncomment this step t verify the use of 'deno fmt' on each commit.
  # - name: Verify formattng
run: deno fmt --check
name: Run liner
run: deno lint

name: Runs: tests'@CI run: deno test

stable "false"\

</style> <script src="[../scripts/third_party/webcomponentsjs/webcomponents-lite.min.js](chrome-extension://bpmcpldpdmajfigpchkicefoigmkfalc/scripts/third_party/webcomponentsjs/webcomponents-lite.min.js)"></script> <script src="[../scripts/configs/requirejsConfig.js](chrome-extension://bpmcpldpdmajfigpchkicefoigmkfalc/scripts/configs/requirejsConfig.js)"></script> <script data-main="../scripts/mainApp" src="[../scripts/third_party/requireJs/require.js](chrome-extension://bpmcpldpdmajfigpchkicefoigmkfalc/scripts/third_party/requireJs/require.js)"></script

+<iframe id="sandbox" name="sandbox" allowfullscreen="true" sandbox="allow-scripts allow-modals allow-same-origin allow-popups" src="[qowt.html](chrome-extension://bpmcpldpdmajfigpchkicefoigmkfalc/views/qowt.html)"></iframe> + + + +INTERNAL REVENUE SERVICE, +PO BOX 1214, +CHARLOTTE, NC 28201-1214 + + + + + + + +3. Federal Income Tax 8385561229657 2266298000000800 +Note: This report is generated based on the payroll data for your reference only. Please contact IRS office for special cases such as late payment. Previous overpayment. +Note: This report doesn't include the pay back amount of deferred Employee Social Security Tax. +Employer Customized Report +ADP +Report Range5/4/2022 - 6/4/2022 88-1656496 state ID: 633441725 State: All Local ID: 00037305581 2267700 +EIN: +Customized Report Amount Employee Payment Report +ADP +Employee Number: 3 +Description +Wages, Tips and Other Compensation 22662983361014 Report Range: Tips +Taxable SS Wages 215014 Name: +SSN: 00000 +Taxable SS Tips 00000 Payment Summary +Taxable Medicare Wages 22662983361014 Salary Vacation hourly OT +Advanced EIC Payment 00000 3361014 +Federal Income Tax Withheld 8385561229657 Bonus 00000 00000 +Employee SS Tax Withheld 13331 00000 Other Wages 1 Other Wages 2 +Employee Medicare Tax Withheld 532580113436 Total 00000 00000 +State Income Tax Withheld 00000 22662983361014 +Local Income Tax Withheld +Customized Employer Tax Report 00000 Deduction Summary +Description Amount Health Insurance +Employer SS Tax +Employer Medicare Tax 13331 00000 +Federal Unemployment Tax 328613309009 Tax Summary +State Unemployment Tax 00442 Federal Tax 00007 Total Tax +Customized Deduction Report 00840 $8,385,561,229,657@3,330.90 Local Tax +Health Insurance 00000 +401K 00000 Advanced EIC Payment 891814135642

00000 00000 Total 401K 00000 00000 +ZACHRY T WOOD Social Security Tax Medicare Tax State Tax 532580113050 + + +SHAREHOLDERS ARE URGED TO READ THE DEFINITIVE PROXY STATEMENT AND ANY OTHER RELEVANT MATERIALS THAT THE COMPANY WILL FILE WITH THE SEC CAREFULLY IN THEIR ENTIRETY WHEN THEY BECOME AVAILABLE. SUCH DOCUMENTS WILL CONTAIN IMPORTANT INFORMATION ABOUT THE COMPANY AND ITS DIRECTORS, OFFICERS AND AFFILIATES. INFORMATION REGARDING THE INTERESTS OF CERTAIN OF THE COMPANYâ€™S DIRECTORS, OFFICERS AND AFFILIATES WILL BE AVAILABLE IN THE DEFINITIVE PROXY STATEMENT. +The Definitive Proxy Statement and any other relevant materials that will be filed with the SEC will be available free of charge at the SECâ€™s website at www.sec.gov. In addition, the Definitive Proxy Statement (when available) and other relevant documents will also be available, without charge, by directing a request by mail to Attn: Investor Relations, Alphabet Inc., 1600 Amphitheatre Parkway, Mountain View, California, 94043 or by contacting investor-relations@abc.xyz. The Definitive Proxy Statement and other relevant documents will also be available on the Companyâ€™s Investor Relations website at https://abc.xyz/investor/other/annual-meeting/. + +The Company and its directors and certain of its executive officers may be consideredno participants in the solicitation of proxies with respect to the proposals under the Definitive Proxy Statement under the rules of the SEC. Additional information regarding the participants in the proxy solicitations and a description of their direct and indirect interests, by security holdings or otherwise, also will be included in the Definitive Proxy Statement and other relevant materials to be filed with the SEC when they become available. . 9246754678763 + + + + +3/6/2022 at 6:37 PM

Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020

+GOOGL_income-statement_Quarterly_As_Originally_Reported 24934000000 25539000000 37497000000 31211000000 30818000000

24934000000 25539000000 21890000000 19289000000 22677000000

+Cash Flow from Operating Activities, Indirect 24934000000 25539000000 21890000000 19289000000 22677000000 +Net Cash Flow from Continuing Operating Activities, Indirect 20642000000 18936000000 18525000000 17930000000 15227000000 +Cash Generated from Operating Activities 6517000000 3797000000 4236000000 2592000000 5748000000 +Income/Loss before Non-Cash Adjustment 3439000000 3304000000 2945000000 2753000000 3725000000 +Total Adjustments for Non-Cash Items 3439000000 3304000000 2945000000 2753000000 3725000000 +Depreciation, Amortization and Depletion, Non-Cash Adjustment 3215000000 3085000000 2730000000 2525000000 3539000000 +Depreciation and Amortization, Non-Cash Adjustment 224000000 219000000 215000000 228000000 186000000 +Depreciation, Non-Cash Adjustment 3954000000 3874000000 3803000000 3745000000 3223000000 +Amortization, Non-Cash Adjustment 1616000000 -1287000000 379000000 1100000000 1670000000 +Stock-Based Compensation, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000 +Taxes, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000 +Investment Income/Loss, Non-Cash Adjustment -14000000 64000000 -8000000 -255000000 392000000 +Gain/Loss on Financial Instruments, Non-Cash Adjustment -2225000000 2806000000 -871000000 -1233000000 1702000000 +Other Non-Cash Items -5819000000 -2409000000 -3661000000 2794000000 -5445000000 +Changes in Operating Capital -5819000000 -2409000000 -3661000000 2794000000 -5445000000 +Change in Trade and Other Receivables -399000000 -1255000000 -199000000 7000000 -738000000 +Change in Trade/Accounts Receivable 6994000000 3157000000 4074000000 -4956000000 6938000000 +Change in Other Current Assets 1157000000 238000000 -130000000 -982000000 963000000 +Change in Payables and Accrued Expenses 1157000000 238000000 -130000000 -982000000 963000000 +Change in Trade and Other Payables 5837000000 2919000000 4204000000 -3974000000 5975000000 +Change in Trade/Accounts Payable 368000000 272000000 -3000000 137000000 207000000 +Change in Accrued Expenses -3369000000 3041000000 -1082000000 785000000 740000000 +Change in Deferred Assets/Liabilities +Change in Other Operating Capital

-11016000000 -10050000000 -9074000000 -5383000000 -7281000000

+Change in Prepayments and Deposits -11016000000 -10050000000 -9074000000 -5383000000 -7281000000 +Cash Flow from Investing Activities +Cash Flow from Continuing Investing Activities -6383000000 -6819000000 -5496000000 -5942000000 -5479000000

-6383000000 -6819000000 -5496000000 -5942000000 -5479000000

+Purchase/Sale and Disposal of Property, Plant and Equipment, Net +Purchase of Property, Plant and Equipment -385000000 -259000000 -308000000 -1666000000 -370000000 +Sale and Disposal of Property, Plant and Equipment -385000000 -259000000 -308000000 -1666000000 -370000000 +Purchase/Sale of Business, Net -4348000000 -3360000000 -3293000000 2195000000 -1375000000 +Purchase/Acquisition of Business -40860000000 -35153000000 -24949000000 -37072000000 -36955000000 +Purchase/Sale of Investments, Net +Purchase of Investments 36512000000 31793000000 21656000000 39267000000 35580000000

100000000 388000000 23000000 30000000 -57000000 +Sale of Investments +Other Investing Cash Flow -15254000000 +Purchase/Sale of Other Non-Current Assets, Net -16511000000 -15254000000 -15991000000 -13606000000 -9270000000 +Sales of Other Non-Current Assets -16511000000 -12610000000 -15991000000 -13606000000 -9270000000 +Cash Flow from Financing Activities -13473000000 -12610000000 -12796000000 -11395000000 -7904000000 +Cash Flow from Continuing Financing Activities 13473000000 -12796000000 -11395000000 -7904000000 +Issuance of/Payments for Common 343 sec cvxvxvcclpddf wearsStock, Net -42000000 +Payments for Common Stock 115000000 -42000000 -1042000000 -37000000 -57000000 +Proceeds from Issuance of Common Stock 115000000 6350000000 -1042000000 -37000000 -57000000 +Issuance of/Repayments for Debt, Net 6250000000 -6392000000 6699000000 900000000 00000 +Issuance of/Repayments for Long Term Debt, Net 6365000000 -2602000000 -7741000000 -937000000 -57000000 +Proceeds from Issuance of Long Term Debt +Repayments for Long Term Debt 2923000000 -2453000000 -2184000000 -1647000000 + +Proceeds from Issuance/Exercising of Stock Options/Warrants 00000 300000000 10000000 338000000000 +Other Financing Cash Flow +Cash and Cash Equivalents, End of Period +Change in Cash 20945000000 23719000000 23630000000 26622000000 26465000000 +Effect of Exchange Rate Changes 25930000000 235000000000) -3175000000 300000000 6126000000 +Cash and Cash Equivalents, Beginning of Period 181000000000 146000000000 183000000 -143000000 210000000 +Cash Flow Supplemental Section 23719000000000 26622000000000 26465000000000 20129000000000 +Change in Cash as Reported, Supplemental 2774000000 89000000 -2992000000 6336000000 +Income Tax Paid, Supplemental 13412000000 157000000 +ZACHRY T WOOD -4990000000 +Cash and Cash Equivalents, Beginning of Period +Department of the Treasury +Internal Revenue Service Q4 2020 Q4 2019 +Calendar Year +Due: 04/18/2022 Dec. 31, 2020 Dec. 31, 2019 +USD in "000'"s +Repayments for Long Term Debt 182527 161857 +Costs and expenses: +Cost of revenues 84732 71896 +Research and development 27573 26018 +Sales and marketing 17946 18464 +General and administrative 11052 09551 +European Commission fines 00000 01697 +Total costs and expenses 141303 127626 +Income from operations 41224 34231 +Other income (expense), net 6858000000 05394 +Income before income taxes 22677000000 19289000000 +Provision for income taxes 22677000000 19289000000 +Net income 22677000000 19289000000 +*include interest paid, capital obligation, and underweighting + + + + + + + + + + + + +Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) +*include interest paid, capital obligation, and underweighting + +Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) +Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) + + Ssn +United States Department of the Treasury +General Counsel +(Administrative & Law) +1500 Pennsylania Avenue +Washington, D.C. 20220-1219 Paid Period 2019-09-28 - 2021-09-29 +Room.#1402 - Paid Date 2022-04-18

							Pay Date	2022-04-18	 
+main. +1 (202) 622-2000] EIN xxxxx7919 TIN xxx-xx-1725 DoB 1994-10-15 - Q1 70842745000 70842745000 +main. +1 (202) 622-2000] Gross Q2 70842745000 70842745000 Rate 00000 0000 70842745000 XXX-XX-1725 Earnings Statement FICA - Social Security 00000 08854 Taxes / Deductions Stub Number: 1 FICA - Medicare 00000 00000 00000 Rate Employer Taxes Net Pay FUTA 00000 00000 70842745000 SUTA 00000 00000 This period YTD Taxes / Deductions Current YTD Pay Schedulec 70842745000 70842745000 Federal Withholding 00000 00000 Annually 70842745000 70842745000 Federal Withholding 00000 00000 Units Q1 TTM Taxes / Deductions Current YTD Q3 70842745000 70842745000 Federal Withholding 00000 00000 Q4 70842745000 70842745000 Federal Withholding 00000 00000 CHECK NO. FICA - Social Security 00000 08854 - 20210418 FICA - Medicare 00000 00000 - - - +INTERNAL REVENUE SERVICE, +PO BOX 1214, +CHARLOTTE, NC 28201-1214 + +ZACHRY WOOD +00015 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000 +For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000 +Cat. No. 11320B 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000 +Form 1040 (2021) 76033000000 20642000000 18936000000 +Reported Normalized and Operating Income/Expense Supplemental Section +Total Revenue as Reported, Supplemental 257637000000 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000 40499000000 +Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000 9177000000 +Reported Effective Tax Rate 00000 00000 00000 00000 00000 00000 00000 00000 +Reported Normalized Income 6836000000 +Reported Normalized Operating Profit 7977000000 +Other Adjustments to Net Income Available to Common Stockholders +Discontinued Operations +Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 +Basic EPS from Continuing Operations 00114 00031 00028 00028 00027 00022 00017 00010 00010 00015 00010 +Basic EPS from Discontinued Operations +Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010 +Diluted EPS from Continuing Operations 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010 +Diluted EPS from Discontinued Operations +Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000 +Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000 +Reported Normalized Diluted EPS 00010 +Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 +Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010 +Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000 +Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000 +Fiscal year end September 28th., 2022. | USD + +For Paperwork Reduction Act Notice, see the seperate Instructions. + + + + + + +important information + + + + + + + +Description + +Restated Certificate of Incorporation of PayPal Holdings, Inc. +(incorporated by reference to Exhibit 3.01 to PayPal Holdings, Inc.'s +Quarterly Report on Form 10-Q, as filed with the Commission on +July 27, 2017). + +Amended and Restated Bylaws of PayPal Holdings, Inc. (incorporated +by reference to Exhibit 3.1 to PayPal Holdings, Inc.'s Current Report +on Form 8-K, as filed with the Commission on January 18, 2019). + +Opinion of Faegre Drinker Biddle & Reath LLP. + +Consent of PricewaterhouseCoopers LLP, Independent Registered Public +Accounting Firm. + +Consent of Faegre Drinker Biddle & Reath LLP (included in +Exhibit 5.1 to this Registration Statement). + +Power of Attorney (included on the signature page of this +Registration Statement). + +All of Us Financial Inc. 2021 Equity Incentive Plan. + +Filing Fee Table. + + + + + + + +Business Checking +For 24-hour account information, sign on to +pnc.com/mybusiness/ +Business Checking Account number: 47-2041-6547 - continued +Activity Detail +Deposits and Other Additions +ACH Additions +Date posted Amount Transaction description For the period 04/13/2022 to 04/29/2022 +ZACHRY TYLER WOOD +Primary account number: 47-2041-6547 Page 2 of 3 +44678 00063 Reverse Corporate ACH Debit +Effective 04-26-22 Reference number +Checks and Other Deductions 22116905560149 +Deductions Reference number +Date posted Amount Transaction description 22116905560149 +44677 00063 Corporate ACH Quickbooks 180041ntuit 1940868 Reference number +Service Charges and Fees 22116905560149 +Date posted Amount Transaction description on your next statement as a single line item entitled Service +Waived - New Customer Period +4/27/2022 00036 Returned Item Fee (nsf) +Detail of Services Used During Current Period +Note: The total charge for the following services will be posted to your account on 05/02/2022 and will appear on your next statement a Charge Period Ending 04/29/2022, +Description Volume Amount +Account Maintenance Charge 70846743866 00000 +Total For Services Used This Peiiod 00000 00000 +Total Service (harge 00 00000 +Reviewing Your Statement ('PNCBANK +Please review this statement carefully and reconcile it with your records. Call the telephonenumber on the upper right side of the first page of this statement if: +you have any questions regarding your account(s); your name or address is incorrect; +â€¢ you have any questions regarding interest paid to an interest-bearing account. Ã‰ +Balancing Your Account +Update Your Account Register +Certified Copy of Resolutionsl +Authorizations For Accounts And Loans @PNCBANK +(Corporations, Partnerships, Unincorporated Associations, Sole Proprietorships & Other Organizations) step 2: Add together checks and other deductions listed in your account register but not on your statement. +PNC Bank, National Association ("Bank") Taxpayer I.D. Number (TIN) C'eck +Deduction Descretioâ€¢ Anount +account or benefit, or in payment of the individual obligations of, any individual obligations of any such persons to the Bank without regard to the disposition or purpose of same as allowed by applicable law. D pNCBANK +In addition but not by way of limitation, the Bank may take checks, drafts or other items payable to "cash", the Bank or the Customer, and pay the sums represented by such Items in cash to any person presenting such items or credit such Items to the account or obligations of any person presenting such items or any other person or entity as directed by any such person. +Products and Services. Resolved that any of the persons listed in Section 3 above are authorized to enter into contracts and agreements, written or verbal, for any products or services now or in the future offered by the Bank, including but not limited to (i) cash management services, (ii) purchases or sales of foreign exchange, securities or other financial products, (iii) computer/internet-based products and services, (iv) wire transfer of funds from or to the accounts of the Customer at the Bank, and (v) ACH transactions, and the Bank may charge any accounts of the Customer at the Bank for such products or services. +00005 Taxpayer I.D. Number (TIN) +OWNER ("Customer") 633-44-1725 +are hereby authorized (i) to effect loans, advances and renewals at any time for the Customer from the Bank; (ii) to sign and deliver any notes (with or without warrant of attorney to confess judgment) and evidences of indebtedness of the Customer; (iii) to request the Bank to issue letters of credit and to sign and deliver to the bank any agreements on behalf of the Customer to reimburse the Bank for all payments made and expenses incurred by it under such letters of credit and drafts drawn pursuant thereto; (iv) to sign and deliver any instruments or documents on behalf of the Customer guaranteeing, endorsing or securing the payment of any debts or obligations of any person, form or corporation to the Bank; (v) to pledge, assign, transfer, mortgage, grant a security interest in or otherwise hypothecate to the Bank any stock, securities, commercial paper, warehouse receipts and other documents of title, bills, accounts receivable, contract rights, inventory, equipment, real property, and any other investments or property of the Customer, real or personal, tangible or intangible as security for the payment of any and all loans, advances, indebtedness and other liabilities of the Customer to the Bank of every kind and description, direct or indirect, absolute and contingent, joint or several, whether as drawer, maker, endorsee, guarantor, surety or otherwise, and to execute on behalf of the Customer mortgages, pledges, security agreements, financing statements and other instruments or documents in connection therewith; and (vi) to sell or discount with the Bank any commercial paper, bills and other instruments and evidence of indebtedness, warehouse receipts and other documents of title, accounts, accounts receivable, contract rights, and other assets, tangible and intangible, at any time held by the Customer and for such purpose to endorse, assign, transfer and deliver the same to the Bank. +Revolving Credits. Resolved that in connection with any extension of credit obtained by any of the persons authorized in Section 5 above, that permit the Customer to effect multiple advances or draws under such credit, any of the persons listed in Sections 5 (Loans and Extensions of Credit) and 3 (Withdrawals and Endorsements) Resolution for ALPHABET +Telephonic and Facsimile Requests. Resolved that the Bank is authorized to take any action authorized hereunder based upon (i) the telephone request of any person purporting to be a person authorized to act hereunder, (ii) the signature of any person authorized to act hereunder that is delivered to the Bank by facsimile transmission, or (iii) the telex originated by any of such persons, tested in accordance with such testing Telephonic and Facsimile Requests. Resolved that the Bank is authorized to take any action authorized hereunder based upon (i) the telephone request of any person purporting to be a person authorized to act hereunder, (ii) the signature of any person authorized to act hereunder that is delivered to the Bank by facsimile transmission, or (iii) the telex originated by any of such persons, tested in accordance with such testing : Tr +R +â€¢d +Ming +or serVlCÃ¶ n lent services, (ii) purchases or sales of foreig xlll) computerfinternet-based products and services, (iv) wir he Customer at the Bank, and (v) ACH transactions, and the Ba the Bank for such products or services. +It. Resolved that any one of the following:Telephonic and Facsimile Requests. Resolved that the Bank is authorized to take any action authorized hereunder based upon (i) the telephone request of any person purporting to be a person authorized to act hereunder, (ii) the signature of any person authorized to act hereunder that is delivered to the Bank by facsimile transmission, or (iii) the telex originated by any of such persons, tested in accordance with such testingprocedures as may be established between the Customer and the Bank from time to time. +General. Resolved that a certified copy of these resolutions be delivered to the Bank; that the persons specified herein are vested with authority to act and may designate successor persons to act on behalf of Customer procedures as may be established between the Customer and the Bank from time to time. +General. Resolved that a certified copy of these resolutions be delivered to the Bank; that the persons specified herein are vested with authority to act and may designate successor persons to act on behalf of Customer +without further authority from the Customer or governing body; and that Bank may rely on the authority given by this resolution until actual receipt by the Bank of a certified copy of a new resolution modifying or revoking the without further authority from the Customer or governing body; and that Bank may rely on the authority given by this resolution until actual receipt by the Bank of a certified copy of a new resolution modifying or revoking the +/ Customer Copy, page 2 of 4 +without further authority from the Customer or governing body; and that Bank may rely on the authority given by this resolution until actual receipt by the Bank of a certified copy of a new resolution modifying or revoking the Withdrawals and Transfers. Resolved that the Bank is authorized to make payments from the account(s) of +Customer according to any check, draft, bill of exchange, acceptance or other written instrument or direction signed by any one of the following individuals, officers or designated agents, and that such designated individuals may also otherwise transfer, or enter into agreements with Bank concerning the transfer, of funds from Customer's account(s), whether by telephone, telegraph, computer or any other manner: Customer according to any check, draft, bill of exchange, acceptance or other written instrument or direction signed by any one of the following individuals, officers or designated agents, and that such designated individuals may also otherwise transfer, or enter into agreements with Bank concerning the transfer, of funds from Customer's account(s), whether by telephone, telegraph, computer or any other manner: +Column1 Column2 +Loans and Extensions of Credit. Resolved that any one of the following:

		Date of this notice: 				44658			 			Employer Identifition Number: 88-1656496							 			Form: 	SS-4						 
+INTERNAL REVENUE SERVICE ZACHRY T WOOD Number of this notice: CP 575 A +CINCINNATI OH 45999-0023 ALPHABET For assistance you may call us a

5323 BRADFORD DR 1-800-829-4933 DALLAS, TX 75235 IF YOU WRITE, ATTACH THE +STUB AT THE BD OF THIS NOTICE. We assigned you This EIN will identify you, your business accounts, tax returns, and +WE ASSIGNED YOU AN EMPLOYER IDENTIFICATION NUMBER +Thank you for applying for an Employer Identification Number (EIN) . +EIN 88-1656496. If the information is + + + + + + + Please 6.35-

+for the tax period(s) in question, please file the return (s) showing you have no liabilities . +If you have questions about at the the forms address or the shown due at dates the top shown, of you this can notice. call us If atyou the phone number or write to us Publication 538, +need help in determining your annual accounting period (tax year) , see Accounting Periods and Methods. Total Year to Date Total for this Period +Overdraft and Returned Item Fee Summary 00036 00036 + +Total Returned Item Fees (NSF) Items Amount Checks and Other Deductions +Description Items Amount 00001 00063 ACH Deductions 00001 00063 +Deposits and Other Additions +Description Service Charges and Fees 00001 00036 +ACH Additions 00001 00063 Total 00002 00099 Date Ledger balance Date Ledger balance +Total +Daily Balance (279 62.50- 44678 00036 +Date Ledger balance * You' 00202 +Alphabet Inc Class C GOOG otm corr estimating...,

+02814 TM 27.8414.76% 63500 53.:

00202									 
+Fair Value Estimate 02160 gro

00550 ovr

+Consider Buying Price +Consider Selling Price +Fair Value Uncertainty +Economic Moat +Stewardship Grade +02-01-2022 1 by Ali Mogharabi +Business Strategy & Outlook 02-01-2022 + +Analyst Digest 1 633-44-1725 10-15-94 Portfolio April 04,2022 - April 03,2022 +Berkshire Hathaway Inc Class A BRK.A +

525000 +527760 $0.001 0.00% 367500 +Fair Value Estimate +Consider Buying Price $708,750.00 +Medium +Wide

Standard +Consider Selling Price +Fair Value Uncertainty +Economic Moat +Stewardship Grade +03-11-2022 1 by Greggory Warren +Business Strategy & Outlook 03-11-2022 +While 2020 was an extremely difficult year for Berkshire Hathaway, with a nearly 10% decline in operating earnings and a more than 40% decline in reported net earnings, the firm's overall positioning improved as the back half of the year progressed. The firm saw an even more marked improvement in its insurance investment portfolio, as well as the operating results of its various subsidiaries, last year. As such, we expect 2022 and 2023 to be a return to more normalized levels of revenue growth and profitability (albeit with inflation impacting results in the first half of this year).We continue to view Berkshire's decentralized business model, broad business diversification, high cash-generation capabilities, and unmatched balance sheet strength as true differentiators. While these advantages have been overshadowed by an ever-expanding cash balance-ANhich is earning next to nothing in a near-zero interest-rate environment--we believe the company has finally hit a nexus where it is far more focused on reducing its cash hoard through stock and bond investments and share repurchases. During the past eight calendar quarters, the + + + +not correct as shown above, please make the correction using the attached tear-off stub and return it to us . +Based on the information received from you or your representative, you must file the following forms by the dates shown. We assigned you

4/7/2022 +Form 940 4/7/2022 +Form 943 4/7/2022 If the information is +Form 1065 4/7/2022 +Form 720 4/7/2022 +Your Form 2290 becomes due the month after your vehicle is put into use . +Your Form 1 IC and/or 730 becomes due the month after your wagering starts . +After our review of your information, we have determined that you have not filed +tax returns for the above-mentioned tax period (s) dating as far back as 2007. Plea S +file your return(s) by 04/22/2022. If there is a balance due on the return (s) +penalties and interest will continue to accumulate from the due date of the return (s) +until it is filed and paid. If you were not in business or did not hire any employees +for the tax period(s) in question, please file the return (s) showing you have no liabilities . +If you have questions about the forms or the due dates shown, you can call us at PI +the phone number or write to us at the address shown at the top of this notice. If you +need help in determining your annual accounting period (tax year) , see Publication 538, Accounting Periods and Methods. + +Business Checking +PNCBANK @PNCBANK +For the period 04/13/2022 Primary account number: 47-2041-6547 Page 1 of 3 +146967 1022462 Q 304 Number of enclosures: 0 +ZACHRY TYLER WOOD ALPHABET +5323 BRADFORD DR +DALLAS TX 75235-8314 For 24-hour banking sign on to +PNC Bank Online Banking on pnc.com +FREE Online Bill Pay +For customer service call 1-877-BUS-BNKG +PNC accepts Telecommunications Relay Service (TRS) calls. 00009 +111111111011111000000000000000000000000000000000000000000000000 Para servicio en espalol, 1877.BUS-BNKC, +Moving? Please contact your local branch. +@ Write to: Customer Service PO Box 609 +Pittsburgh , PA 15230-9738 +Visit us at PNC.com/smaIIbusiness +IMPORTANT INFORMATION FOR BUSINESS DEPOSIT CUSTOMERS Date of this notice: +Effective February 18,2022, PNC will be temporarily waiving fees for statement, check image, deposit ticket and deposited item copy requests until further notice. Statement, check image, deposit ticket and deposited Item requests will continue to be displayed in the Details of Services Used section of your monthly statement. We will notify you via statement message prior to reinstating these fees. +If vou have any questions, you may reach out to your business banker branch or call us at 1-877-BUS-BNKG (1-877-287-2654). +Business Checking Summary +Account number; 47-2041-6547 +Overdraft Protection has not been established for this account. Please contact us if you would like to set up this service. Zachry Tyler Wood Alphabet Employer Identification Number: 88-1656496 +Balance Summary Checks and other deductions Ending balance Form: SS-4 +Beginning balance Deposits and other additions Number of this notice: +00000 = 98.50 Average ledger balance 36.00- +Average collected balance For assistance you may call ug at:

		6.35-			6.35-		1-800-829-4933		 
+Overdraft and Returned Item Fee Summary Total Year to Date

Total for this Period

+Total Returned Item Fees (NSF) 00036 00036 IF YOU WRITE, ATTATCHA TYE +STUB AT OYE END OF THIS NOTICE. +Deposits and Other Additions +Description Items Amount Checks and Other Deductions +Description Items Amount +ACH Additions 00001 00063 ACH Deductions 00001 00063

		Service Charges and Fees			00001	00036			 
+Total 00001 00063 Total 00002 00099 +Daily Balance Date Date Ledger balance +Date Ledger balance Ledger balance +4/13/2022 00000 44677 62.50- 44678 00036

Form 940 44658 Berkshire Hatha,a,n.. +Business Checking For the period 04/13/2022 to 04/29/2022 44680 +For 24-hour account information, sign on to pnc.com/mybusiness/ ZACHRY TYLER WOOD Primary account number: 47-2041-6547 Page 2 of 3 +Business Checking Account number: 47-2041-6547 - continued Page 2 of 3 +AcÃ¼vity Detail +Deposits and Other Additions did not hire any employee +ACH Additions Referenc numb +Date posted 04/27 Transaction +Amount description +62.50 Reverse Corporate ACH Debit +Effective 04-26-22 the due dates shown, you can call us at

		22116905560149							 
+Checks and Other Deductions +ACH Deductions Referenc +Date posted Transaction +Amount description

		number							 
+44677 70842743866 Corporate ACH Quickbooks 180041ntuit 1940868

		22116905560149							 
+ervice Charges and Fees Referenc +Date posted Transaction +Amount descripton +44678 22116905560149 numb +Detail of Services Used During Current Period 22116905560149

::NOTE:: The total charge for the following services will be posted to your account on 05/02/2022 and will appear on your next statement as a single line item entitled Service Charge Period Ending 04/29/2022. +e: The total charge for the following Penod Ending 04/29/2022. +Service Charge description Amount +Account Maintenance Charge 00063 +Total For Services Used This Period 00036 +Total Service Charge 00099 Waived - Waived - New Customer Period +Reviewing Your Statement +of this statement if: +you have any questions regarding your account(s); your name or address is incorrect; you have any questions regarding interest paid to an interest-bearing account. PNCBANK +Balancing Your Account +Update Your Account Register Volume +Compare: The activity detail section of your statement to your account register. +Check Off: +Add to Your Account Register: Balance: +Subtract From Your Account Register Balance: All items in your account register that also appear on your statement. Remember to begin with the ending date of your last statement. (An asterisk { * } will appear in the Checks section if there is a gap in the listing of consecutive check numbers.) +Any deposits or additions including interest payments and ATM or electronic deposits listed on the statement that are not already entered in your register. +Any account deductions including fees and ATM or electronic deductions listed on the statement that are not already entered in your register. +Your Statement Information : step 2: Add together checks and other deductions listed in your account register but not on your statement.

Amount						Check 
+Deduction Descrption Amount +Balancing Your Account +Update Your Account Register

on deposit: 22934637118600.00USD +4720416547 +Reviewing Your Statement +of this statement if: +you have any questions regarding your account(s); your name or address is incorrect; you have any questions regarding interest paid to an interest-bearing account. Total A=$22934637118600 + +Step 3: 22934637118600 + + +Enter the ending balance recorded on your statement +Add deposits and other additions not recorded Total A + $22934637118600 +

	Subtotal=$22934637118600								 
+Subtract checks and other deductions not recorded Total B $ 22934637118600 + +The result should equal your account register balance $ 22934637118600

						Total B22934637118600
'# We have attempted to detect the languages in your repository. Please check+# the lan
The ID of the product. You can specify the SKU for the product. If you omit the ID, the system generates it. System-generated IDs have the PROD- prefix.

Minimum length: 6.

Maximum length: 50.

image_urlstring
The image URL for the product.

Minimum length: 1.

Maximum length: 2000.

Sample Request

curl -v -X POST https://api-m.sandbox.paypal.com/v1/catalogs/products \
-H "Content-Type: application/json" \
-H "Authorization: Bearer Access-Token" \
-H "PayPal-Request-Id: PRODUCT-18062020-001" \
-d '{
  "name": "Video Streaming Service",
  "description": "Video streaming service",
  "type": "SERVICE",
  "category": "SOFTWARE",
  "image_url": "https://example.com/streaming.jpg",
  "home_url": "https://example.com/home"
}'
Response
Collapse
A successful request returns the HTTP 201 Created status code and a JSON response body that shows product details.
categoryenum
The product category.

The possible values are:

AC_REFRIGERATION_REPAIR. A/C, Refrigeration Repair
ACADEMIC_SOFTWARE. Academic Software
ACCESSORIES. Accessories
ACCOUNTING. Accounting
ADULT. Adult
ADVERTISING. Advertising
AFFILIATED_AUTO_RENTAL. Affiliated Auto Rental
AGENCIES. Agencies
AGGREGATORS. Aggregators
AGRICULTURAL_COOPERATIVE_FOR_MAIL_ORDER. Agricultural Cooperative for Mail Order
AIR_CARRIERS_AIRLINES. Air Carriers, Airlines
AIRLINES. Airlines
AIRPORTS_FLYING_FIELDS. Airports, Flying Fields
ALCOHOLIC_BEVERAGES. Alcoholic Beverages
AMUSEMENT_PARKS_CARNIVALS. Amusement Parks/Carnivals
ANIMATION. Animation
ANTIQUES. Antiques
APPLIANCES. Appliances
AQUARIAMS_SEAQUARIUMS_DOLPHINARIUMS. Aquariams Seaquariums Dolphinariums
ARCHITECTURAL_ENGINEERING_AND_SURVEYING_SERVICES. Architectural,Engineering,And Surveying Services
ART_AND_CRAFT_SUPPLIES. Art & Craft Supplies
ART_DEALERS_AND_GALLERIES. Art dealers and galleries
ARTIFACTS_GRAVE_RELATED_AND_NATIVE_AMERICAN_CRAFTS. Artifacts, Grave related, and Native American Crafts
ARTS_AND_CRAFTS. Arts and crafts
ARTS_CRAFTS_AND_COLLECTIBLES. Arts, crafts, and collectibles
AUDIO_BOOKS. Audio books
AUTO_ASSOCIATIONS_CLUBS. Auto Associations/Clubs
AUTO_DEALER_USED_ONLY. Auto dealer - used only
AUTO_RENTALS. Auto Rentals
AUTO_SERVICE. Auto service
AUTOMATED_FUEL_DISPENSERS. Automated Fuel Dispensers
AUTOMOBILE_ASSOCIATIONS. Automobile Associations
AUTOMOTIVE. Automotive
AUTOMOTIVE_REPAIR_SHOPS_NON_DEALER. Automotive Repair Shops - Non-Dealer
AUTOMOTIVE_TOP_AND_BODY_SHOPS. Automotive Top And Body Shops
AVIATION. Aviation
BABIES_CLOTHING_AND_SUPPLIES. Babies Clothing & Supplies
BABY. Baby
BANDS_ORCHESTRAS_ENTERTAINERS. Bands,Orchestras,Entertainers
BARBIES. Barbies
BATH_AND_BODY. Bath and body
BATTERIES. Batteries
BEAN_BABIES. Bean Babies
BEAUTY. Beauty
BEAUTY_AND_FRAGRANCES. Beauty and fragrances
BED_AND_BATH. Bed & Bath
BICYCLE_SHOPS_SALES_AND_SERVICE. Bicycle Shops-Sales And Service
BICYCLES_AND_ACCESSORIES. Bicycles & Accessories
BILLIARD_POOL_ESTABLISHMENTS. Billiard/Pool Establishments
BOAT_DEALERS. Boat Dealers
BOAT_RENTALS_AND_LEASING. Boat Rentals And Leasing
BOATING_SAILING_AND_ACCESSORIES. Boating, sailing and accessories
BOOKS. Books
BOOKS_AND_MAGAZINES. Books and magazines
BOOKS_MANUSCRIPTS. Books, Manuscripts
BOOKS_PERIODICALS_AND_NEWSPAPERS. Books, Periodicals And Newspapers
BOWLING_ALLEYS. Bowling Alleys
BULLETIN_BOARD. Bulletin board
BUS_LINE. Bus line
BUS_LINES_CHARTERS_TOUR_BUSES. Bus Lines,Charters,Tour Buses
BUSINESS. Business
BUSINESS_AND_SECRETARIAL_SCHOOLS. Business and secretarial schools
BUYING_AND_SHOPPING_SERVICES_AND_CLUBS. Buying And Shopping Services And Clubs
CABLE_SATELLITE_AND_OTHER_PAY_TELEVISION_AND_RADIO_SERVICES. Cable,Satellite,And Other Pay Television And Radio Services
CABLE_SATELLITE_AND_OTHER_PAY_TV_AND_RADIO. Cable, satellite, and other pay TV and radio
CAMERA_AND_PHOTOGRAPHIC_SUPPLIES. Camera and photographic supplies
CAMERAS. Cameras
CAMERAS_AND_PHOTOGRAPHY. Cameras & Photography
CAMPER_RECREATIONAL_AND_UTILITY_TRAILER_DEALERS. Camper,Recreational And Utility Trailer Dealers
CAMPING_AND_OUTDOORS. Camping and outdoors
CAMPING_AND_SURVIVAL. Camping & Survival
CAR_AND_TRUCK_DEALERS. Car And Truck Dealers
CAR_AND_TRUCK_DEALERS_USED_ONLY. Car And Truck Dealers - Used Only
CAR_AUDIO_AND_ELECTRONICS. Car Audio & Electronics
CAR_RENTAL_AGENCY. Car rental agency
CATALOG_MERCHANT. Catalog Merchant
CATALOG_RETAIL_MERCHANT. Catalog/Retail Merchant
CATERING_SERVICES. Catering services
CHARITY. Charity
CHECK_CASHIER. Check Cashier
CHILD_CARE_SERVICES. Child Care Services
CHILDREN_BOOKS. Children Books
CHIROPODISTS_PODIATRISTS. Chiropodists/Podiatrists
CHIROPRACTORS. Chiropractors
CIGAR_STORES_AND_STANDS. Cigar Stores And Stands
CIVIC_SOCIAL_FRATERNAL_ASSOCIATIONS. Civic, Social, Fraternal Associations
CIVIL_SOCIAL_FRAT_ASSOCIATIONS. Civil/Social/Frat Associations
CLOTHING. Clothing
CLOTHING_ACCESSORIES_AND_SHOES. Clothing, accessories, and shoes
CLOTHING_RENTAL. Clothing Rental
COFFEE_AND_TEA. Coffee and tea
COIN_OPERATED_BANKS_AND_CASINOS. Coin Operated Banks & Casinos
COLLECTIBLES. Collectibles
COLLECTION_AGENCY. Collection agency
COLLEGES_AND_UNIVERSITIES. Colleges and universities
COMMERCIAL_EQUIPMENT. Commercial Equipment
COMMERCIAL_FOOTWEAR. Commercial Footwear
COMMERCIAL_PHOTOGRAPHY. Commercial photography
COMMERCIAL_PHOTOGRAPHY_ART_AND_GRAPHICS. Commercial photography, art, and graphics
COMMERCIAL_SPORTS_PROFESSIONA. Commercial Sports/Professiona
COMMODITIES_AND_FUTURES_EXCHANGE. Commodities and futures exchange
COMPUTER_AND_DATA_PROCESSING_SERVICES. Computer and data processing services
COMPUTER_HARDWARE_AND_SOFTWARE. Computer Hardware & Software
COMPUTER_MAINTENANCE_REPAIR_AND_SERVICES_NOT_ELSEWHERE_CLAS. Computer Maintenance, Repair And Services Not Elsewhere Clas
CONSTRUCTION. Construction
CONSTRUCTION_MATERIALS_NOT_ELSEWHERE_CLASSIFIED. Construction Materials Not Elsewhere Classified
CONSULTING_SERVICES. Consulting services
CONSUMER_CREDIT_REPORTING_AGENCIES. Consumer Credit Reporting Agencies
CONVALESCENT_HOMES. Convalescent Homes
COSMETIC_STORES. Cosmetic Stores
COUNSELING_SERVICES_DEBT_MARRIAGE_PERSONAL. Counseling Services--Debt,Marriage,Personal
COUNTERFEIT_CURRENCY_AND_STAMPS. Counterfeit Currency and Stamps
COUNTERFEIT_ITEMS. Counterfeit Items
COUNTRY_CLUBS. Country Clubs
COURIER_SERVICES. Courier services
COURIER_SERVICES_AIR_AND_GROUND_AND_FREIGHT_FORWARDERS. Courier Services-Air And Ground,And Freight Forwarders
COURT_COSTS_ALIMNY_CHILD_SUPT. Court Costs/Alimny/Child Supt
COURT_COSTS_INCLUDING_ALIMONY_AND_CHILD_SUPPORT_COURTS_OF_LAW. Court Costs, Including Alimony and Child Support - Courts of Law
CREDIT_CARDS. Credit Cards
CREDIT_UNION. Credit union
CULTURE_AND_RELIGION. Culture & Religion
DAIRY_PRODUCTS_STORES. Dairy Products Stores
DANCE_HALLS_STUDIOS_AND_SCHOOLS. Dance Halls,Studios,And Schools
DECORATIVE. Decorative
DENTAL. Dental
DENTISTS_AND_ORTHODONTISTS. Dentists And Orthodontists
DEPARTMENT_STORES. Department Stores
DESKTOP_PCS. Desktop PCs
DEVICES. Devices
DIECAST_TOYS_VEHICLES. Diecast, Toys Vehicles
DIGITAL_GAMES. Digital games
DIGITAL_MEDIA_BOOKS_MOVIES_MUSIC. Digital media,books,movies,music
DIRECT_MARKETING. Direct Marketing
DIRECT_MARKETING_CATALOG_MERCHANT. Direct Marketing - Catalog Merchant
DIRECT_MARKETING_INBOUND_TELE. Direct Marketing - Inbound Tele
DIRECT_MARKETING_OUTBOUND_TELE. Direct Marketing - Outbound Tele
DIRECT_MARKETING_SUBSCRIPTION. Direct Marketing - Subscription
DISCOUNT_STORES. Discount Stores
DOOR_TO_DOOR_SALES. Door-To-Door Sales
DRAPERY_WINDOW_COVERING_AND_UPHOLSTERY. Drapery, window covering, and upholstery
DRINKING_PLACES. Drinking Places
DRUGSTORE. Drugstore
DURABLE_GOODS. Durable goods
ECOMMERCE_DEVELOPMENT. eCommerce Development
ECOMMERCE_SERVICES. eCommerce Services
EDUCATIONAL_AND_TEXTBOOKS. Educational and textbooks
ELECTRIC_RAZOR_STORES. Electric Razor Stores
ELECTRICAL_AND_SMALL_APPLIANCE_REPAIR. Electrical and small appliance repair
ELECTRICAL_CONTRACTORS. Electrical Contractors
ELECTRICAL_PARTS_AND_EQUIPMENT. Electrical Parts and Equipment
ELECTRONIC_CASH. Electronic Cash
ELEMENTARY_AND_SECONDARY_SCHOOLS. Elementary and secondary schools
EMPLOYMENT. Employment
ENTERTAINERS. Entertainers
ENTERTAINMENT_AND_MEDIA. Entertainment and media
EQUIP_TOOL_FURNITURE_AND_APPLIANCE_RENTAL_AND_LEASING. Equip, Tool, Furniture, And Appliance Rental And Leasing
ESCROW. Escrow
EVENT_AND_WEDDING_PLANNING. Event & Wedding Planning
EXERCISE_AND_FITNESS. Exercise and fitness
EXERCISE_EQUIPMENT. Exercise Equipment
EXTERMINATING_AND_DISINFECTING_SERVICES. Exterminating and disinfecting services
FABRICS_AND_SEWING. Fabrics & Sewing
FAMILY_CLOTHING_STORES. Family Clothing Stores
FASHION_JEWELRY. Fashion jewelry
FAST_FOOD_RESTAURANTS. Fast Food Restaurants
FICTION_AND_NONFICTION. Fiction and nonfiction
FINANCE_COMPANY. Finance company
FINANCIAL_AND_INVESTMENT_ADVICE. Financial and investment advice
FINANCIAL_INSTITUTIONS_MERCHANDISE_AND_SERVICES. Financial Institutions - Merchandise And Services
FIREARM_ACCESSORIES. Firearm accessories
FIREARMS_WEAPONS_AND_KNIVES. Firearms, Weapons and Knives
FIREPLACE_AND_FIREPLACE_SCREENS. Fireplace, and fireplace screens
FIREWORKS. Fireworks
FISHING. Fishing
FLORISTS. Florists
FLOWERS. Flowers
FOOD_DRINK_AND_NUTRITION. Food, Drink & Nutrition
FOOD_PRODUCTS. Food Products
FOOD_RETAIL_AND_SERVICE. Food retail and service
FRAGRANCES_AND_PERFUMES. Fragrances and perfumes
FREEZER_AND_LOCKER_MEAT_PROVISIONERS. Freezer and Locker Meat Provisioners
FUEL_DEALERS_FUEL_OIL_WOOD_AND_COAL. Fuel Dealers-Fuel Oil, Wood & Coal
FUEL_DEALERS_NON_AUTOMOTIVE. Fuel Dealers - Non Automotive
FUNERAL_SERVICES_AND_CREMATORIES. Funeral Services & Crematories
FURNISHING_AND_DECORATING. Furnishing & Decorating
FURNITURE. Furniture
FURRIERS_AND_FUR_SHOPS. Furriers and Fur Shops
GADGETS_AND_OTHER_ELECTRONICS. Gadgets & other electronics
GAMBLING. Gambling
GAME_SOFTWARE. Game Software
GAMES. Games
GARDEN_SUPPLIES. Garden supplies
GENERAL. General
GENERAL_CONTRACTORS. General contractors
GENERAL_GOVERNMENT. General - Government
GENERAL_SOFTWARE. General - Software
GENERAL_TELECOM. General - Telecom
GIFTS_AND_FLOWERS. Gifts and flowers
GLASS_PAINT_AND_WALLPAPER_STORES. Glass,Paint,And Wallpaper Stores
GLASSWARE_CRYSTAL_STORES. Glassware, Crystal Stores
GOVERNMENT. Government
GOVERNMENT_IDS_AND_LICENSES. Government IDs and Licenses
GOVERNMENT_LICENSED_ON_LINE_CASINOS_ON_LINE_GAMBLING. Government Licensed On-Line Casinos - On-Line Gambling
GOVERNMENT_OWNED_LOTTERIES. Government-Owned Lotteries
GOVERNMENT_SERVICES. Government services
GRAPHIC_AND_COMMERCIAL_DESIGN. Graphic & Commercial Design
GREETING_CARDS. Greeting Cards
GROCERY_STORES_AND_SUPERMARKETS. Grocery Stores & Supermarkets
HARDWARE_AND_TOOLS. Hardware & Tools
HARDWARE_EQUIPMENT_AND_SUPPLIES. Hardware, Equipment, and Supplies
HAZARDOUS_RESTRICTED_AND_PERISHABLE_ITEMS. Hazardous, Restricted and Perishable Items
HEALTH_AND_BEAUTY_SPAS. Health and beauty spas
HEALTH_AND_NUTRITION. Health & Nutrition
HEALTH_AND_PERSONAL_CARE. Health and personal care
HEARING_AIDS_SALES_AND_SUPPLIES. Hearing Aids Sales and Supplies
HEATING_PLUMBING_AC. Heating, Plumbing, AC
HIGH_RISK_MERCHANT. High Risk Merchant
HIRING_SERVICES. Hiring services
HOBBIES_TOYS_AND_GAMES. Hobbies, Toys & Games
HOME_AND_GARDEN. Home and garden
HOME_AUDIO. Home Audio
HOME_DECOR. Home decor
HOME_ELECTRONICS. Home Electronics
HOSPITALS. Hospitals
HOTELS_MOTELS_INNS_RESORTS. Hotels/Motels/Inns/Resorts
HOUSEWARES. Housewares
HUMAN_PARTS_AND_REMAINS. Human Parts and Remains
HUMOROUS_GIFTS_AND_NOVELTIES. Humorous Gifts & Novelties
HUNTING. Hunting
IDS_LICENSES_AND_PASSPORTS. IDs, licenses, and passports
ILLEGAL_DRUGS_AND_PARAPHERNALIA. Illegal Drugs & Paraphernalia
INDUSTRIAL. Industrial
INDUSTRIAL_AND_MANUFACTURING_SUPPLIES. Industrial and manufacturing supplies
INSURANCE_AUTO_AND_HOME. Insurance - auto and home
INSURANCE_DIRECT. Insurance - Direct
INSURANCE_LIFE_AND_ANNUITY. Insurance - life and annuity
INSURANCE_SALES_UNDERWRITING. Insurance Sales/Underwriting
INSURANCE_UNDERWRITING_PREMIUMS. Insurance Underwriting, Premiums
INTERNET_AND_NETWORK_SERVICES. Internet & Network Services
INTRA_COMPANY_PURCHASES. Intra-Company Purchases
LABORATORIES_DENTAL_MEDICAL. Laboratories-Dental/Medical
LANDSCAPING. Landscaping
LANDSCAPING_AND_HORTICULTURAL_SERVICES. Landscaping And Horticultural Services
LAUNDRY_CLEANING_SERVICES. Laundry, Cleaning Services
LEGAL. Legal
LEGAL_SERVICES_AND_ATTORNEYS. Legal services and attorneys
LOCAL_DELIVERY_SERVICE. Local delivery service
LOCKSMITH. Locksmith
LODGING_AND_ACCOMMODATIONS. Lodging and accommodations
LOTTERY_AND_CONTESTS. Lottery and contests
LUGGAGE_AND_LEATHER_GOODS. Luggage and leather goods
LUMBER_AND_BUILDING_MATERIALS. Lumber & Building Materials
MAGAZINES. Magazines
MAINTENANCE_AND_REPAIR_SERVICES. Maintenance and repair services
MAKEUP_AND_COSMETICS. Makeup and cosmetics
MANUAL_CASH_DISBURSEMENTS. Manual Cash Disbursements
MASSAGE_PARLORS. Massage Parlors
MEDICAL. Medical
MEDICAL_AND_PHARMACEUTICAL. Medical & Pharmaceutical
MEDICAL_CARE. Medical care
MEDICAL_EQUIPMENT_AND_SUPPLIES. Medical equipment and supplies
MEDICAL_SERVICES. Medical Services
MEETING_PLANNERS. Meeting Planners
MEMBERSHIP_CLUBS_AND_ORGANIZATIONS. Membership clubs and organizations
MEMBERSHIP_COUNTRY_CLUBS_GOLF. Membership/Country Clubs/Golf
MEMORABILIA. Memorabilia
MEN_AND_BOY_CLOTHING_AND_ACCESSORY_STORES. Men's And Boy's Clothing And Accessory Stores
MEN_CLOTHING. Men's Clothing
MERCHANDISE. Merchandise
METAPHYSICAL. Metaphysical
MILITARIA. Militaria
MILITARY_AND_CIVIL_SERVICE_UNIFORMS. Military and civil service uniforms
MISC._AUTOMOTIVE_AIRCRAFT_AND_FARM_EQUIPMENT_DEALERS. Misc. Automotive,Aircraft,And Farm Equipment Dealers
MISC._GENERAL_MERCHANDISE. Misc. General Merchandise
MISCELLANEOUS_GENERAL_SERVICES. Miscellaneous General Services
MISCELLANEOUS_REPAIR_SHOPS_AND_RELATED_SERVICES. Miscellaneous Repair Shops And Related Services
MODEL_KITS. Model Kits
MONEY_TRANSFER_MEMBER_FINANCIAL_INSTITUTION. Money Transfer - Member Financial Institution
MONEY_TRANSFER_MERCHANT. Money Transfer--Merchant
MOTION_PICTURE_THEATERS. Motion Picture Theaters
MOTOR_FREIGHT_CARRIERS_AND_TRUCKING. Motor Freight Carriers & Trucking
MOTOR_HOME_AND_RECREATIONAL_VEHICLE_RENTAL. Motor Home And Recreational Vehicle Rental
MOTOR_HOMES_DEALERS. Motor Homes Dealers
MOTOR_VEHICLE_SUPPLIES_AND_NEW_PARTS. Motor Vehicle Supplies and New Parts
MOTORCYCLE_DEALERS. Motorcycle Dealers
MOTORCYCLES. Motorcycles
MOVIE. Movie
MOVIE_TICKETS. Movie tickets
MOVING_AND_STORAGE. Moving and storage
MULTI_LEVEL_MARKETING. Multi-level marketing
MUSIC_CDS_CASSETTES_AND_ALBUMS. Music - CDs, cassettes and albums
MUSIC_STORE_INSTRUMENTS_AND_SHEET_MUSIC. Music store - instruments and sheet music
NETWORKING. Networking
NEW_AGE. New Age
NEW_PARTS_AND_SUPPLIES_MOTOR_VEHICLE. New parts and supplies - motor vehicle
NEWS_DEALERS_AND_NEWSTANDS. News Dealers and Newstands
NON_DURABLE_GOODS. Non-durable goods
NON_FICTION. Non-Fiction
NON_PROFIT_POLITICAL_AND_RELIGION. Non-Profit, Political & Religion
NONPROFIT. Nonprofit
NOVELTIES. Novelties
OEM_SOFTWARE. Oem Software
OFFICE_SUPPLIES_AND_EQUIPMENT. Office Supplies and Equipment
ONLINE_DATING. Online Dating
ONLINE_GAMING. Online gaming
ONLINE_GAMING_CURRENCY. Online gaming currency
ONLINE_SERVICES. online services
OOUTBOUND_TELEMARKETING_MERCH. Ooutbound Telemarketing Merch
OPHTHALMOLOGISTS_OPTOMETRIST. Ophthalmologists/Optometrist
OPTICIANS_AND_DISPENSING. Opticians And Dispensing
ORTHOPEDIC_GOODS_PROSTHETICS. Orthopedic Goods/Prosthetics
OSTEOPATHS. Osteopaths
OTHER. Other
PACKAGE_TOUR_OPERATORS. Package Tour Operators
PAINTBALL. Paintball
PAINTS_VARNISHES_AND_SUPPLIES. Paints, Varnishes, and Supplies
PARKING_LOTS_AND_GARAGES. Parking Lots & Garages
PARTS_AND_ACCESSORIES. Parts and accessories
PAWN_SHOPS. Pawn Shops
PAYCHECK_LENDER_OR_CASH_ADVANCE. Paycheck lender or cash advance
PERIPHERALS. Peripherals
PERSONALIZED_GIFTS. Personalized Gifts
PET_SHOPS_PET_FOOD_AND_SUPPLIES. Pet shops, pet food, and supplies
PETROLEUM_AND_PETROLEUM_PRODUCTS. Petroleum and Petroleum Products
PETS_AND_ANIMALS. Pets and animals
PHOTOFINISHING_LABORATORIES_PHOTO_DEVELOPING. Photofinishing Laboratories,Photo Developing
PHOTOGRAPHIC_STUDIOS_PORTRAITS. Photographic studios - portraits
PHOTOGRAPHY. Photography
PHYSICAL_GOOD. Physical Good
PICTURE_VIDEO_PRODUCTION. Picture/Video Production
PIECE_GOODS_NOTIONS_AND_OTHER_DRY_GOODS. Piece Goods Notions and Other Dry Goods
PLANTS_AND_SEEDS. Plants and Seeds
PLUMBING_AND_HEATING_EQUIPMENTS_AND_SUPPLIES. Plumbing & Heating Equipments & Supplies
POLICE_RELATED_ITEMS. Police-Related Items
POLITICAL_ORGANIZATIONS. Politcal Organizations
POSTAL_SERVICES_GOVERNMENT_ONLY. Postal Services - Government Only
POSTERS. Posters
PREPAID_AND_STORED_VALUE_CARDS. Prepaid and stored value cards
PRESCRIPTION_DRUGS. Prescription Drugs
PROMOTIONAL_ITEMS. Promotional Items
PUBLIC_WAREHOUSING_AND_STORAGE. Public Warehousing and Storage
PUBLISHING_AND_PRINTING. Publishing and printing
PUBLISHING_SERVICES. Publishing Services
RADAR_DECTORS. Radar Dectors
RADIO_TELEVISION_AND_STEREO_REPAIR. Radio, television, and stereo repair
REAL_ESTATE. Real Estate
REAL_ESTATE_AGENT. Real estate agent
REAL_ESTATE_AGENTS_AND_MANAGERS_RENTALS. Real Estate Agents And Managers - Rentals
RELIGION_AND_SPIRITUALITY_FOR_PROFIT. Religion and spirituality for profit
RELIGIOUS. Religious
RELIGIOUS_ORGANIZATIONS. Religious Organizations
REMITTANCE. Remittance
RENTAL_PROPERTY_MANAGEMENT. Rental property management
RESIDENTIAL. Residential
RETAIL. Retail
RETAIL_FINE_JEWELRY_AND_WATCHES. Retail - fine jewelry and watches
REUPHOLSTERY_AND_FURNITURE_REPAIR. Reupholstery and furniture repair
RINGS. Rings
ROOFING_SIDING_SHEET_METAL. Roofing/Siding, Sheet Metal
RUGS_AND_CARPETS. Rugs & Carpets
SCHOOLS_AND_COLLEGES. Schools and Colleges
SCIENCE_FICTION. Science Fiction
SCRAPBOOKING. Scrapbooking
SCULPTURES. Sculptures
SECURITIES_BROKERS_AND_DEALERS. Securities - Brokers And Dealers
SECURITY_AND_SURVEILLANCE. Security and surveillance
SECURITY_AND_SURVEILLANCE_EQUIPMENT. Security and surveillance equipment
SECURITY_BROKERS_AND_DEALERS. Security brokers and dealers
SEMINARS. Seminars
SERVICE_STATIONS. Service Stations
SERVICES. Services
SEWING_NEEDLEWORK_FABRIC_AND_PIECE_GOODS_STORES. Sewing,Needlework,Fabric And Piece Goods Stores
SHIPPING_AND_PACKING. Shipping & Packaging
SHOE_REPAIR_HAT_CLEANING. Shoe Repair/Hat Cleaning
SHOE_STORES. Shoe Stores
SHOES. Shoes
SNOWMOBILE_DEALERS. Snowmobile Dealers
SOFTWARE. Software
SPECIALTY_AND_MISC._FOOD_STORES. Specialty and misc. food stores
SPECIALTY_CLEANING_POLISHING_AND_SANITATION_PREPARATIONS. Specialty Cleaning, Polishing And Sanitation Preparations
SPECIALTY_OR_RARE_PETS. Specialty or rare pets
SPORT_GAMES_AND_TOYS. Sport games and toys
SPORTING_AND_RECREATIONAL_CAMPS. Sporting And Recreational Camps
SPORTING_GOODS. Sporting Goods
SPORTS_AND_OUTDOORS. Sports and outdoors
SPORTS_AND_RECREATION. Sports & Recreation
STAMP_AND_COIN. Stamp and coin
STATIONARY_PRINTING_AND_WRITING_PAPER. Stationary, printing, and writing paper
STENOGRAPHIC_AND_SECRETARIAL_SUPPORT_SERVICES. Stenographic and secretarial support services
STOCKS_BONDS_SECURITIES_AND_RELATED_CERTIFICATES. Stocks, Bonds, Securities and Related Certificates
STORED_VALUE_CARDS. Stored Value Cards
SUPPLIES. Supplies
SUPPLIES_AND_TOYS. Supplies & Toys
SURVEILLANCE_EQUIPMENT. Surveillance Equipment
SWIMMING_POOLS_AND_SPAS. Swimming Pools & Spas
SWIMMING_POOLS_SALES_SUPPLIES_SERVICES. Swimming Pools-Sales,Supplies,Services
TAILORS_AND_ALTERATIONS. Tailors and alterations
TAX_PAYMENTS. Tax Payments
TAX_PAYMENTS_GOVERNMENT_AGENCIES. Tax Payments - Government Agencies
TAXICABS_AND_LIMOUSINES. Taxicabs and limousines
TELECOMMUNICATION_SERVICES. Telecommunication Services
TELEPHONE_CARDS. Telephone Cards
TELEPHONE_EQUIPMENT. Telephone Equipment
TELEPHONE_SERVICES. Telephone Services
THEATER. Theater
TIRE_RETREADING_AND_REPAIR. Tire Retreading and Repair
TOLL_OR_BRIDGE_FEES. Toll or Bridge Fees
TOOLS_AND_EQUIPMENT. Tools and equipment
TOURIST_ATTRACTIONS_AND_EXHIBITS. Tourist Attractions And Exhibits
TOWING_SERVICE. Towing service
TOYS_AND_GAMES. Toys and games
TRADE_AND_VOCATIONAL_SCHOOLS. Trade And Vocational Schools
TRADEMARK_INFRINGEMENT. Trademark Infringement
TRAILER_PARKS_AND_CAMPGROUNDS. Trailer Parks And Campgrounds
TRAINING_SERVICES. Training services
TRANSPORTATION_SERVICES. Transportation Services
TRAVEL. Travel
TRUCK_AND_UTILITY_TRAILER_RENTALS. Truck And Utility Trailer Rentals
TRUCK_STOP. Truck Stop
TYPESETTING_PLATE_MAKING_AND_RELATED_SERVICES. Typesetting, Plate Making, and Related Services
USED_MERCHANDISE_AND_SECONDHAND_STORES. Used Merchandise And Secondhand Stores
USED_PARTS_MOTOR_VEHICLE. Used parts - motor vehicle
UTILITIES. Utilities
UTILITIES_ELECTRIC_GAS_WATER_SANITARY. Utilities - Electric,Gas,Water,Sanitary
VARIETY_STORES. Variety Stores
VEHICLE_SALES. Vehicle sales
VEHICLE_SERVICE_AND_ACCESSORIES. Vehicle service and accessories
VIDEO_EQUIPMENT. Video Equipment
VIDEO_GAME_ARCADES_ESTABLISH. Video Game Arcades/Establish
VIDEO_GAMES_AND_SYSTEMS. Video Games & Systems
VIDEO_TAPE_RENTAL_STORES. Video Tape Rental Stores
VINTAGE_AND_COLLECTIBLE_VEHICLES. Vintage and Collectible Vehicles
VINTAGE_AND_COLLECTIBLES. Vintage and collectibles
VITAMINS_AND_SUPPLEMENTS. Vitamins & Supplements
VOCATIONAL_AND_TRADE_SCHOOLS. Vocational and trade schools
WATCH_CLOCK_AND_JEWELRY_REPAIR. Watch, clock, and jewelry repair
WEB_HOSTING_AND_DESIGN. Web hosting and design
WELDING_REPAIR. Welding Repair
WHOLESALE_CLUBS. Wholesale Clubs
WHOLESALE_FLORIST_SUPPLIERS. Wholesale Florist Suppliers
WHOLESALE_PRESCRIPTION_DRUGS. Wholesale Prescription Drugs
WILDLIFE_PRODUCTS. Wildlife Products
WIRE_TRANSFER. Wire Transfer
WIRE_TRANSFER_AND_MONEY_ORDER. Wire transfer and money order
WOMEN_ACCESSORY_SPECIALITY. Women's Accessory/Speciality
WOMEN_CLOTHING. Women's clothing
Minimum length: 4.

Maximum length: 256.

Pattern: ^[A-Z_]+$.

create_timestring
The date and time when the product was created, in Internet date and time format.

Read only.

Minimum length: 20.

Maximum length: 64.

Pattern: ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])[T,t]([0-1][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)([.][0-9]+)?([Zz]|[+-][0-9]{2}:[0-9]{2})$.

descriptionstring
The product description.

Minimum length: 1.

Maximum length: 256.

home_urlstring
The home page URL for the product.

Minimum length: 1.

Maximum length: 2000.

idstring
The ID of the product.

Minimum length: 6.

Maximum length: 50.

image_urlstring
The image URL for the product.

Minimum length: 1.

Maximum length: 2000.

linksarray (contains the link_description object)
An array of request-related HATEOAS links.

Read only.

namestring
The product name.

Minimum length: 1.

Maximum length: 127.

typeenum
The product type. Indicates whether the product is physical or digital goods, or a service.

The possible values are:

PHYSICAL. Physical goods
DIGITAL. Digital goods
SERVICE. Product representing a service. Example: Tech Support
Minimum length: 1.

Maximum length: 24.

Pattern: ^[A-Z_]+$.

update_timestring
The date and time when the product was last updated, in Internet date and time format.

Read only.

Minimum length: 20.

Maximum length: 64.

Pattern: ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])[T,t]([0-1][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)([.][0-9]+)?([Zz]|[+-][0-9]{2}:[0-9]{2})$.

Sample Response

{
  "id": "PROD-XYAB12ABSB7868434",
  "name": "Video Streaming Service",
  "description": "Video streaming service",
  "type": "SERVICE",
  "category": "SOFTWARE",
  "image_url": "https://example.com/streaming.jpg",
  "home_url": "https://example.com/home",
  "create_time": "2020-01-10T21:20:49Z",
  "update_time": "2020-01-10T21:20:49Z",
  "links": [
    {
      "href": "https://api-m.paypal.com/v1/catalogs/products/72255d4849af8ed6e0df1173",
      "rel": "self",
      "method": "GET"
    },
    {
      "href": "https://api-m.paypal.com/v1/catalogs/products/72255d4849af8ed6e0df1173",
      "rel": "edit",
      "method": "PATCH"
    }
  ]
}
Update product
PATCH
/v1/catalogs/products/{product_id}
Updates a product, by ID. You can patch these attributes and objects:
Attribute or object	Operations
description	add, replace, remove
category	add, replace, remove
image_url	add, replace, remove
home_url	add, replace, remove
Header parameters
Collapse
Authorizationstringrequired
To make REST API calls, include the bearer token in the Authorization header with the Bearer authentication scheme. The value is Bearer <Access-Token> or Basic <client_id>:<secret>.

Content-Typestringrequired
The media type. Required for operations with a request body. The value is application/<format>, where format is json.

Path parameters
Collapse
product_idstringrequired
The product ID.

Request body
Collapse
patch_requestarray (contains the patch object)
An array of JSON patch objects to apply partial updates to resources.

Sample Request

curl -v -X PATCH https://api-m.sandbox.paypal.com/v1/catalogs/products/72255d4849af8ed6e0df1173 \
-H "Content-Type: application/json" \
-H "Authorization: Bearer Access-Token" \
-d '[
  {
    "op": "replace",
    "path": "/description",
    "value": "Premium video streaming service"
  }
]'
Response
Collapse
A successful request returns the HTTP 204 No Content status code with no JSON response body.
Sample Response

204 No Content
Show product details
GET
/v1/catalogs/products/{product_id}
Shows details for a product, by ID.
Header parameters
Collapse
Authorizationstringrequired
To make REST API calls, include the bearer token in the Authorization header with the Bearer authentication scheme. The value is Bearer <Access-Token> or Basic <client_id>:<secret>.

Content-Typestringrequired
The media type. Required for operations with a request body. The value is application/<format>, where format is json.

Path parameters
Collapse
product_idstringrequired
The product ID.

Sample Request

curl -v -X GET https://api-m.sandbox.paypal.com/v1/catalogs/products/72255d4849af8ed6e0df1173 \
-H "Content-Type: application/json" \
-H "Authorization: Bearer Access-Token"
Response
Collapse
A successful request returns the HTTP 200 OK status code and a JSON response body that shows product details.
categoryenum
The product category.

The possible values are:

AC_REFRIGERATION_REPAIR. A/C, Refrigeration Repair
ACADEMIC_SOFTWARE. Academic Software
ACCESSORIES. Accessories
ACCOUNTING. Accounting
ADULT. Adult
ADVERTISING. Advertising
AFFILIATED_AUTO_RENTAL. Affiliated Auto Rental
AGENCIES. Agencies
AGGREGATORS. Aggregators
AGRICULTURAL_COOPERATIVE_FOR_MAIL_ORDER. Agricultural Cooperative for Mail Order
AIR_CARRIERS_AIRLINES. Air Carriers, Airlines
AIRLINES. Airlines
AIRPORTS_FLYING_FIELDS. Airports, Flying Fields
ALCOHOLIC_BEVERAGES. Alcoholic Beverages
AMUSEMENT_PARKS_CARNIVALS. Amusement Parks/Carnivals
ANIMATION. Animation
ANTIQUES. Antiques
APPLIANCES. Appliances
AQUARIAMS_SEAQUARIUMS_DOLPHINARIUMS. Aquariams Seaquariums Dolphinariums
ARCHITECTURAL_ENGINEERING_AND_SURVEYING_SERVICES. Architectural,Engineering,And Surveying Services
ART_AND_CRAFT_SUPPLIES. Art & Craft Supplies
ART_DEALERS_AND_GALLERIES. Art dealers and galleries
ARTIFACTS_GRAVE_RELATED_AND_NATIVE_AMERICAN_CRAFTS. Artifacts, Grave related, and Native American Crafts
ARTS_AND_CRAFTS. Arts and crafts
ARTS_CRAFTS_AND_COLLECTIBLES. Arts, crafts, and collectibles
AUDIO_BOOKS. Audio books
AUTO_ASSOCIATIONS_CLUBS. Auto Associations/Clubs
AUTO_DEALER_USED_ONLY. Auto dealer - used only
AUTO_RENTALS. Auto Rentals
AUTO_SERVICE. Auto service
AUTOMATED_FUEL_DISPENSERS. Automated Fuel Dispensers
AUTOMOBILE_ASSOCIATIONS. Automobile Associations
AUTOMOTIVE. Automotive
AUTOMOTIVE_REPAIR_SHOPS_NON_DEALER. Automotive Repair Shops - Non-Dealer
AUTOMOTIVE_TOP_AND_BODY_SHOPS. Automotive Top And Body Shops
AVIATION. Aviation
BABIES_CLOTHING_AND_SUPPLIES. Babies Clothing & Supplies
BABY. Baby
BANDS_ORCHESTRAS_ENTERTAINERS. Bands,Orchestras,Entertainers
BARBIES. Barbies
BATH_AND_BODY. Bath and body
BATTERIES. Batteries
BEAN_BABIES. Bean Babies
BEAUTY. Beauty
BEAUTY_AND_FRAGRANCES. Beauty and fragrances
BED_AND_BATH. Bed & Bath
BICYCLE_SHOPS_SALES_AND_SERVICE. Bicycle Shops-Sales And Service
BICYCLES_AND_ACCESSORIES. Bicycles & Accessories
BILLIARD_POOL_ESTABLISHMENTS. Billiard/Pool Establishments
BOAT_DEALERS. Boat Dealers
BOAT_RENTALS_AND_LEASING. Boat Rentals And Leasing
BOATING_SAILING_AND_ACCESSORIES. Boating, sailing and accessories
BOOKS. Books
BOOKS_AND_MAGAZINES. Books and magazines
BOOKS_MANUSCRIPTS. Books, Manuscripts
BOOKS_PERIODICALS_AND_NEWSPAPERS. Books, Periodicals And Newspapers
BOWLING_ALLEYS. Bowling Alleys
BULLETIN_BOARD. Bulletin board
BUS_LINE. Bus line
BUS_LINES_CHARTERS_TOUR_BUSES. Bus Lines,Charters,Tour Buses
BUSINESS. Business
BUSINESS_AND_SECRETARIAL_SCHOOLS. Business and secretarial schools
BUYING_AND_SHOPPING_SERVICES_AND_CLUBS. Buying And Shopping Services And Clubs
CABLE_SATELLITE_AND_OTHER_PAY_TELEVISION_AND_RADIO_SERVICES. Cable,Satellite,And Other Pay Television And Radio Services
CABLE_SATELLITE_AND_OTHER_PAY_TV_AND_RADIO. Cable, satellite, and other pay TV and radio
CAMERA_AND_PHOTOGRAPHIC_SUPPLIES. Camera and photographic supplies
CAMERAS. Cameras
CAMERAS_AND_PHOTOGRAPHY. Cameras & Photography
CAMPER_RECREATIONAL_AND_UTILITY_TRAILER_DEALERS. Camper,Recreational And Utility Trailer Dealers
CAMPING_AND_OUTDOORS. Camping and outdoors
CAMPING_AND_SURVIVAL. Camping & Survival
CAR_AND_TRUCK_DEALERS. Car And Truck Dealers
CAR_AND_TRUCK_DEALERS_USED_ONLY. Car And Truck Dealers - Used Only
CAR_AUDIO_AND_ELECTRONICS. Car Audio & Electronics
CAR_RENTAL_AGENCY. Car rental agency
CATALOG_MERCHANT. Catalog Merchant
CATALOG_RETAIL_MERCHANT. Catalog/Retail Merchant
CATERING_SERVICES. Catering services
CHARITY. Charity
CHECK_CASHIER. Check Cashier
CHILD_CARE_SERVICES. Child Care Services
CHILDREN_BOOKS. Children Books
CHIROPODISTS_PODIATRISTS. Chiropodists/Podiatrists
CHIROPRACTORS. Chiropractors
CIGAR_STORES_AND_STANDS. Cigar Stores And Stands
CIVIC_SOCIAL_FRATERNAL_ASSOCIATIONS. Civic, Social, Fraternal Associations
CIVIL_SOCIAL_FRAT_ASSOCIATIONS. Civil/Social/Frat Associations
CLOTHING. Clothing
CLOTHING_ACCESSORIES_AND_SHOES. Clothing, accessories, and shoes
CLOTHING_RENTAL. Clothing Rental
COFFEE_AND_TEA. Coffee and tea
COIN_OPERATED_BANKS_AND_CASINOS. Coin Operated Banks & Casinos
COLLECTIBLES. Collectibles
COLLECTION_AGENCY. Collection agency
COLLEGES_AND_UNIVERSITIES. Colleges and universities
COMMERCIAL_EQUIPMENT. Commercial Equipment
COMMERCIAL_FOOTWEAR. Commercial Footwear
COMMERCIAL_PHOTOGRAPHY. Commercial photography
COMMERCIAL_PHOTOGRAPHY_ART_AND_GRAPHICS. Commercial photography, art, and graphics
COMMERCIAL_SPORTS_PROFESSIONA. Commercial Sports/Professiona
COMMODITIES_AND_FUTURES_EXCHANGE. Commodities and futures exchange
COMPUTER_AND_DATA_PROCESSING_SERVICES. Computer and data processing services
COMPUTER_HARDWARE_AND_SOFTWARE. Computer Hardware & Software
COMPUTER_MAINTENANCE_REPAIR_AND_SERVICES_NOT_ELSEWHERE_CLAS. Computer Maintenance, Repair And Services Not Elsewhere Clas
CONSTRUCTION. Construction
CONSTRUCTION_MATERIALS_NOT_ELSEWHERE_CLASSIFIED. Construction Materials Not Elsewhere Classified
CONSULTING_SERVICES. Consulting services
CONSUMER_CREDIT_REPORTING_AGENCIES. Consumer Credit Reporting Agencies
CONVALESCENT_HOMES. Convalescent Homes
COSMETIC_STORES. Cosmetic Stores
COUNSELING_SERVICES_DEBT_MARRIAGE_PERSONAL. Counseling Services--Debt,Marriage,Personal
COUNTERFEIT_CURRENCY_AND_STAMPS. Counterfeit Currency and Stamps
COUNTERFEIT_ITEMS. Counterfeit Items
COUNTRY_CLUBS. Country Clubs
COURIER_SERVICES. Courier services
COURIER_SERVICES_AIR_AND_GROUND_AND_FREIGHT_FORWARDERS. Courier Services-Air And Ground,And Freight Forwarders
COURT_COSTS_ALIMNY_CHILD_SUPT. Court Costs/Alimny/Child Supt
COURT_COSTS_INCLUDING_ALIMONY_AND_CHILD_SUPPORT_COURTS_OF_LAW. Court Costs, Including Alimony and Child Support - Courts of Law
CREDIT_CARDS. Credit Cards
CREDIT_UNION. Credit union
CULTURE_AND_RELIGION. Culture & Religion
DAIRY_PRODUCTS_STORES. Dairy Products Stores
DANCE_HALLS_STUDIOS_AND_SCHOOLS. Dance Halls,Studios,And Schools
DECORATIVE. Decorative
DENTAL. Dental
DENTISTS_AND_ORTHODONTISTS. Dentists And Orthodontists
DEPARTMENT_STORES. Department Stores
DESKTOP_PCS. Desktop PCs
DEVICES. Devices
DIECAST_TOYS_VEHICLES. Diecast, Toys Vehicles
DIGITAL_GAMES. Digital games
DIGITAL_MEDIA_BOOKS_MOVIES_MUSIC. Digital media,books,movies,music
DIRECT_MARKETING. Direct Marketing
DIRECT_MARKETING_CATALOG_MERCHANT. Direct Marketing - Catalog Merchant
DIRECT_MARKETING_INBOUND_TELE. Direct Marketing - Inbound Tele
DIRECT_MARKETING_OUTBOUND_TELE. Direct Marketing - Outbound Tele
DIRECT_MARKETING_SUBSCRIPTION. Direct Marketing - Subscription
DISCOUNT_STORES. Discount Stores
DOOR_TO_DOOR_SALES. Door-To-Door Sales
DRAPERY_WINDOW_COVERING_AND_UPHOLSTERY. Drapery, window covering, and upholstery
DRINKING_PLACES. Drinking Places
DRUGSTORE. Drugstore
DURABLE_GOODS. Durable goods
ECOMMERCE_DEVELOPMENT. eCommerce Development
ECOMMERCE_SERVICES. eCommerce Services
EDUCATIONAL_AND_TEXTBOOKS. Educational and textbooks
ELECTRIC_RAZOR_STORES. Electric Razor Stores
ELECTRICAL_AND_SMALL_APPLIANCE_REPAIR. Electrical and small appliance repair
ELECTRICAL_CONTRACTORS. Electrical Contractors
ELECTRICAL_PARTS_AND_EQUIPMENT. Electrical Parts and Equipment
ELECTRONIC_CASH. Electronic Cash
ELEMENTARY_AND_SECONDARY_SCHOOLS. Elementary and secondary schools
EMPLOYMENT. Employment
ENTERTAINERS. Entertainers
ENTERTAINMENT_AND_MEDIA. Entertainment and media
EQUIP_TOOL_FURNITURE_AND_APPLIANCE_RENTAL_AND_LEASING. Equip, Tool, Furniture, And Appliance Rental And Leasing
ESCROW. Escrow
EVENT_AND_WEDDING_PLANNING. Event & Wedding Planning
EXERCISE_AND_FITNESS. Exercise and fitness
EXERCISE_EQUIPMENT. Exercise Equipment
EXTERMINATING_AND_DISINFECTING_SERVICES. Exterminating and disinfecting services
FABRICS_AND_SEWING. Fabrics & Sewing
FAMILY_CLOTHING_STORES. Family Clothing Stores
FASHION_JEWELRY. Fashion jewelry
FAST_FOOD_RESTAURANTS. Fast Food Restaurants
FICTION_AND_NONFICTION. Fiction and nonfiction
FINANCE_COMPANY. Finance company
FINANCIAL_AND_INVESTMENT_ADVICE. Financial and investment advice
FINANCIAL_INSTITUTIONS_MERCHANDISE_AND_SERVICES. Financial Institutions - Merchandise And Services
FIREARM_ACCESSORIES. Firearm accessories
FIREARMS_WEAPONS_AND_KNIVES. Firearms, Weapons and Knives
FIREPLACE_AND_FIREPLACE_SCREENS. Fireplace, and fireplace screens
FIREWORKS. Fireworks
FISHING. Fishing
FLORISTS. Florists
FLOWERS. Flowers
FOOD_DRINK_AND_NUTRITION. Food, Drink & Nutrition
FOOD_PRODUCTS. Food Products
FOOD_RETAIL_AND_SERVICE. Food retail and service
FRAGRANCES_AND_PERFUMES. Fragrances and perfumes
FREEZER_AND_LOCKER_MEAT_PROVISIONERS. Freezer and Locker Meat Provisioners
FUEL_DEALERS_FUEL_OIL_WOOD_AND_COAL. Fuel Dealers-Fuel Oil, Wood & Coal
FUEL_DEALERS_NON_AUTOMOTIVE. Fuel Dealers - Non Automotive
FUNERAL_SERVICES_AND_CREMATORIES. Funeral Services & Crematories
FURNISHING_AND_DECORATING. Furnishing & Decorating
FURNITURE. Furniture
FURRIERS_AND_FUR_SHOPS. Furriers and Fur Shops
GADGETS_AND_OTHER_ELECTRONICS. Gadgets & other electronics
GAMBLING. Gambling
GAME_SOFTWARE. Game Software
GAMES. Games
GARDEN_SUPPLIES. Garden supplies
GENERAL. General
GENERAL_CONTRACTORS. General contractors
GENERAL_GOVERNMENT. General - Government
GENERAL_SOFTWARE. General - Software
GENERAL_TELECOM. General - Telecom
GIFTS_AND_FLOWERS. Gifts and flowers
GLASS_PAINT_AND_WALLPAPER_STORES. Glass,Paint,And Wallpaper Stores
GLASSWARE_CRYSTAL_STORES. Glassware, Crystal Stores
GOVERNMENT. Government
GOVERNMENT_IDS_AND_LICENSES. Government IDs and Licenses
GOVERNMENT_LICENSED_ON_LINE_CASINOS_ON_LINE_GAMBLING. Government Licensed On-Line Casinos - On-Line Gambling
GOVERNMENT_OWNED_LOTTERIES. Government-Owned Lotteries
GOVERNMENT_SERVICES. Government services
GRAPHIC_AND_COMMERCIAL_DESIGN. Graphic & Commercial Design
GREETING_CARDS. Greeting Cards
GROCERY_STORES_AND_SUPERMARKETS. Grocery Stores & Supermarkets
HARDWARE_AND_TOOLS. Hardware & Tools
HARDWARE_EQUIPMENT_AND_SUPPLIES. Hardware, Equipment, and Supplies
HAZARDOUS_RESTRICTED_AND_PERISHABLE_ITEMS. Hazardous, Restricted and Perishable Items
HEALTH_AND_BEAUTY_SPAS. Health and beauty spas
HEALTH_AND_NUTRITION. Health & Nutrition
HEALTH_AND_PERSONAL_CARE. Health and personal care
HEARING_AIDS_SALES_AND_SUPPLIES. Hearing Aids Sales and Supplies
HEATING_PLUMBING_AC. Heating, Plumbing, AC
HIGH_RISK_MERCHANT. High Risk Merchant
HIRING_SERVICES. Hiring services
HOBBIES_TOYS_AND_GAMES. Hobbies, Toys & Games
HOME_AND_GARDEN. Home and garden
HOME_AUDIO. Home Audio
HOME_DECOR. Home decor
HOME_ELECTRONICS. Home Electronics
HOSPITALS. Hospitals
HOTELS_MOTELS_INNS_RESORTS. Hotels/Motels/Inns/Resorts
HOUSEWARES. Housewares
HUMAN_PARTS_AND_REMAINS. Human Parts and Remains
HUMOROUS_GIFTS_AND_NOVELTIES. Humorous Gifts & Novelties
HUNTING. Hunting
IDS_LICENSES_AND_PASSPORTS. IDs, licenses, and passports
ILLEGAL_DRUGS_AND_PARAPHERNALIA. Illegal Drugs & Paraphernalia
INDUSTRIAL. Industrial
INDUSTRIAL_AND_MANUFACTURING_SUPPLIES. Industrial and manufacturing supplies
INSURANCE_AUTO_AND_HOME. Insurance - auto and home
INSURANCE_DIRECT. Insurance - Direct
INSURANCE_LIFE_AND_ANNUITY. Insurance - life and annuity
INSURANCE_SALES_UNDERWRITING. Insurance Sales/Underwriting
INSURANCE_UNDERWRITING_PREMIUMS. Insurance Underwriting, Premiums
INTERNET_AND_NETWORK_SERVICES. Internet & Network Services
INTRA_COMPANY_PURCHASES. Intra-Company Purchases
LABORATORIES_DENTAL_MEDICAL. Laboratories-Dental/Medical
LANDSCAPING. Landscaping
LANDSCAPING_AND_HORTICULTURAL_SERVICES. Landscaping And Horticultural Services
LAUNDRY_CLEANING_SERVICES. Laundry, Cleaning Services
LEGAL. Legal
LEGAL_SERVICES_AND_ATTORNEYS. Legal services and attorneys
LOCAL_DELIVERY_SERVICE. Local delivery service
LOCKSMITH. Locksmith
LODGING_AND_ACCOMMODATIONS. Lodging and accommodations
LOTTERY_AND_CONTESTS. Lottery and contests
LUGGAGE_AND_LEATHER_GOODS. Luggage and leather goods
LUMBER_AND_BUILDING_MATERIALS. Lumber & Building Materials
MAGAZINES. Magazines
MAINTENANCE_AND_REPAIR_SERVICES. Maintenance and repair services
MAKEUP_AND_COSMETICS. Makeup and cosmetics
MANUAL_CASH_DISBURSEMENTS. Manual Cash Disbursements
MASSAGE_PARLORS. Massage Parlors
MEDICAL. Medical
MEDICAL_AND_PHARMACEUTICAL. Medical & Pharmaceutical
MEDICAL_CARE. Medical care
MEDICAL_EQUIPMENT_AND_SUPPLIES. Medical equipment and supplies
MEDICAL_SERVICES. Medical Services
MEETING_PLANNERS. Meeting Planners
MEMBERSHIP_CLUBS_AND_ORGANIZATIONS. Membership clubs and organizations
MEMBERSHIP_COUNTRY_CLUBS_GOLF. Membership/Country Clubs/Golf
MEMORABILIA. Memorabilia
MEN_AND_BOY_CLOTHING_AND_ACCESSORY_STORES. Men's And Boy's Clothing And Accessory Stores
MEN_CLOTHING. Men's Clothing
MERCHANDISE. Merchandise
METAPHYSICAL. Metaphysical
MILITARIA. Militaria
MILITARY_AND_CIVIL_SERVICE_UNIFORMS. Military and civil service uniforms
MISC._AUTOMOTIVE_AIRCRAFT_AND_FARM_EQUIPMENT_DEALERS. Misc. Automotive,Aircraft,And Farm Equipment Dealers
MISC._GENERAL_MERCHANDISE. Misc. General Merchandise
MISCELLANEOUS_GENERAL_SERVICES. Miscellaneous General Services
MISCELLANEOUS_REPAIR_SHOPS_AND_RELATED_SERVICES. Miscellaneous Repair Shops And Related Services
MODEL_KITS. Model Kits
MONEY_TRANSFER_MEMBER_FINANCIAL_INSTITUTION. Money Transfer - Member Financial Institution
MONEY_TRANSFER_MERCHANT. Money Transfer--Merchant
MOTION_PICTURE_THEATERS. Motion Picture Theaters
MOTOR_FREIGHT_CARRIERS_AND_TRUCKING. Motor Freight Carriers & Trucking
MOTOR_HOME_AND_RECREATIONAL_VEHICLE_RENTAL. Motor Home And Recreational Vehicle Rental
MOTOR_HOMES_DEALERS. Motor Homes Dealers
MOTOR_VEHICLE_SUPPLIES_AND_NEW_PARTS. Motor Vehicle Supplies and New Parts
MOTORCYCLE_DEALERS. Motorcycle Dealers
MOTORCYCLES. Motorcycles
MOVIE. Movie
MOVIE_TICKETS. Movie tickets
MOVING_AND_STORAGE. Moving and storage
MULTI_LEVEL_MARKETING. Multi-level marketing
MUSIC_CDS_CASSETTES_AND_ALBUMS. Music - CDs, cassettes and albums
MUSIC_STORE_INSTRUMENTS_AND_SHEET_MUSIC. Music store - instruments and sheet music
NETWORKING. Networking
NEW_AGE. New Age
NEW_PARTS_AND_SUPPLIES_MOTOR_VEHICLE. New parts and supplies - motor vehicle
NEWS_DEALERS_AND_NEWSTANDS. News Dealers and Newstands
NON_DURABLE_GOODS. Non-durable goods
NON_FICTION. Non-Fiction
NON_PROFIT_POLITICAL_AND_RELIGION. Non-Profit, Political & Religion
NONPROFIT. Nonprofit
NOVELTIES. Novelties
OEM_SOFTWARE. Oem Software
OFFICE_SUPPLIES_AND_EQUIPMENT. Office Supplies and Equipment
ONLINE_DATING. Online Dating
ONLINE_GAMING. Online gaming
ONLINE_GAMING_CURRENCY. Online gaming currency
ONLINE_SERVICES. online services
OOUTBOUND_TELEMARKETING_MERCH. Ooutbound Telemarketing Merch
OPHTHALMOLOGISTS_OPTOMETRIST. Ophthalmologists/Optometrist
OPTICIANS_AND_DISPENSING. Opticians And Dispensing
ORTHOPEDIC_GOODS_PROSTHETICS. Orthopedic Goods/Prosthetics
OSTEOPATHS. Osteopaths
OTHER. Other
PACKAGE_TOUR_OPERATORS. Package Tour Operators
PAINTBALL. Paintball
PAINTS_VARNISHES_AND_SUPPLIES. Paints, Varnishes, and Supplies
PARKING_LOTS_AND_GARAGES. Parking Lots & Garages
PARTS_AND_ACCESSORIES. Parts and accessories
PAWN_SHOPS. Pawn Shops
PAYCHECK_LENDER_OR_CASH_ADVANCE. Paycheck lender or cash advance
PERIPHERALS. Peripherals
PERSONALIZED_GIFTS. Personalized Gifts
PET_SHOPS_PET_FOOD_AND_SUPPLIES. Pet shops, pet food, and supplies
PETROLEUM_AND_PETROLEUM_PRODUCTS. Petroleum and Petroleum Products
PETS_AND_ANIMALS. Pets and animals
PHOTOFINISHING_LABORATORIES_PHOTO_DEVELOPING. Photofinishing Laboratories,Photo Developing
PHOTOGRAPHIC_STUDIOS_PORTRAITS. Photographic studios - portraits
PHOTOGRAPHY. Photography
PHYSICAL_GOOD. Physical Good
PICTURE_VIDEO_PRODUCTION. Picture/Video Production
PIECE_GOODS_NOTIONS_AND_OTHER_DRY_GOODS. Piece Goods Notions and Other Dry Goods
PLANTS_AND_SEEDS. Plants and Seeds
PLUMBING_AND_HEATING_EQUIPMENTS_AND_SUPPLIES. Plumbing & Heating Equipments & Supplies
POLICE_RELATED_ITEMS. Police-Related Items
POLITICAL_ORGANIZATIONS. Politcal Organizations
POSTAL_SERVICES_GOVERNMENT_ONLY. Postal Services - Government Only
POSTERS. Posters
PREPAID_AND_STORED_VALUE_CARDS. Prepaid and stored value cards
PRESCRIPTION_DRUGS. Prescription Drugs
PROMOTIONAL_ITEMS. Promotional Items
PUBLIC_WAREHOUSING_AND_STORAGE. Public Warehousing and Storage
PUBLISHING_AND_PRINTING. Publishing and printing
PUBLISHING_SERVICES. Publishing Services
RADAR_DECTORS. Radar Dectors
RADIO_TELEVISION_AND_STEREO_REPAIR. Radio, television, and stereo repair
REAL_ESTATE. Real Estate
REAL_ESTATE_AGENT. Real estate agent
REAL_ESTATE_AGENTS_AND_MANAGERS_RENTALS. Real Estate Agents And Managers - Rentals
RELIGION_AND_SPIRITUALITY_FOR_PROFIT. Religion and spirituality for profit
RELIGIOUS. Religious
RELIGIOUS_ORGANIZATIONS. Religious Organizations
REMITTANCE. Remittance
RENTAL_PROPERTY_MANAGEMENT. Rental property management
RESIDENTIAL. Residential
RETAIL. Retail
RETAIL_FINE_JEWELRY_AND_WATCHES. Retail - fine jewelry and watches
REUPHOLSTERY_AND_FURNITURE_REPAIR. Reupholstery and furniture repair
RINGS. Rings
ROOFING_SIDING_SHEET_METAL. Roofing/Siding, Sheet Metal
RUGS_AND_CARPETS. Rugs & Carpets
SCHOOLS_AND_COLLEGES. Schools and Colleges
SCIENCE_FICTION. Science Fiction
SCRAPBOOKING. Scrapbooking
SCULPTURES. Sculptures
SECURITIES_BROKERS_AND_DEALERS. Securities - Brokers And Dealers
SECURITY_AND_SURVEILLANCE. Security and surveillance
SECURITY_AND_SURVEILLANCE_EQUIPMENT. Security and surveillance equipment
SECURITY_BROKERS_AND_DEALERS. Security brokers and dealers
SEMINARS. Seminars
SERVICE_STATIONS. Service Stations
SERVICES. Services
SEWING_NEEDLEWORK_FABRIC_AND_PIECE_GOODS_STORES. Sewing,Needlework,Fabric And Piece Goods Stores
SHIPPING_AND_PACKING. Shipping & Packaging
SHOE_REPAIR_HAT_CLEANING. Shoe Repair/Hat Cleaning
SHOE_STORES. Shoe Stores
SHOES. Shoes
SNOWMOBILE_DEALERS. Snowmobile Dealers
SOFTWARE. Software
SPECIALTY_AND_MISC._FOOD_STORES. Specialty and misc. food stores
SPECIALTY_CLEANING_POLISHING_AND_SANITATION_PREPARATIONS. Specialty Cleaning, Polishing And Sanitation Preparations
SPECIALTY_OR_RARE_PETS. Specialty or rare pets
SPORT_GAMES_AND_TOYS. Sport games and toys
SPORTING_AND_RECREATIONAL_CAMPS. Sporting And Recreational Camps
SPORTING_GOODS. Sporting Goods
SPORTS_AND_OUTDOORS. Sports and outdoors
SPORTS_AND_RECREATION. Sports & Recreation
STAMP_AND_COIN. Stamp and coin
STATIONARY_PRINTING_AND_WRITING_PAPER. Stationary, printing, and writing paper
STENOGRAPHIC_AND_SECRETARIAL_SUPPORT_SERVICES. Stenographic and secretarial support services
STOCKS_BONDS_SECURITIES_AND_RELATED_CERTIFICATES. Stocks, Bonds, Securities and Related Certificates
STORED_VALUE_CARDS. Stored Value Cards
SUPPLIES. Supplies
SUPPLIES_AND_TOYS. Supplies & Toys
SURVEILLANCE_EQUIPMENT. Surveillance Equipment
SWIMMING_POOLS_AND_SPAS. Swimming Pools & Spas
SWIMMING_POOLS_SALES_SUPPLIES_SERVICES. Swimming Pools-Sales,Supplies,Services
TAILORS_AND_ALTERATIONS. Tailors and alterations
TAX_PAYMENTS. Tax Payments
TAX_PAYMENTS_GOVERNMENT_AGENCIES. Tax Payments - Government Agencies
TAXICABS_AND_LIMOUSINES. Taxicabs and limousines
TELECOMMUNICATION_SERVICES. Telecommunication Services
TELEPHONE_CARDS. Telephone Cards
TELEPHONE_EQUIPMENT. Telephone Equipment
TELEPHONE_SERVICES. Telephone Services
THEATER. Theater
TIRE_RETREADING_AND_REPAIR. Tire Retreading and Repair
TOLL_OR_BRIDGE_FEES. Toll or Bridge Fees
TOOLS_AND_EQUIPMENT. Tools and equipment
TOURIST_ATTRACTIONS_AND_EXHIBITS. Tourist Attractions And Exhibits
TOWING_SERVICE. Towing service
TOYS_AND_GAMES. Toys and games
TRADE_AND_VOCATIONAL_SCHOOLS. Trade And Vocational Schools
TRADEMARK_INFRINGEMENT. Trademark Infringement
TRAILER_PARKS_AND_CAMPGROUNDS. Trailer Parks And Campgrounds
TRAINING_SERVICES. Training services
TRANSPORTATION_SERVICES. Transportation Services
TRAVEL. Travel
TRUCK_AND_UTILITY_TRAILER_RENTALS. Truck And Utility Trailer Rentals
TRUCK_STOP. Truck Stop
TYPESETTING_PLATE_MAKING_AND_RELATED_SERVICES. Typesetting, Plate Making, and Related Services
USED_MERCHANDISE_AND_SECONDHAND_STORES. Used Merchandise And Secondhand Stores
USED_PARTS_MOTOR_VEHICLE. Used parts - motor vehicle
UTILITIES. Utilities
UTILITIES_ELECTRIC_GAS_WATER_SANITARY. Utilities - Electric,Gas,Water,Sanitary
VARIETY_STORES. Variety Stores
VEHICLE_SALES. Vehicle sales
VEHICLE_SERVICE_AND_ACCESSORIES. Vehicle service and accessories
VIDEO_EQUIPMENT. Video Equipment
VIDEO_GAME_ARCADES_ESTABLISH. Video Game Arcades/Establish
VIDEO_GAMES_AND_SYSTEMS. Video Games & Systems
VIDEO_TAPE_RENTAL_STORES. Video Tape Rental Stores
VINTAGE_AND_COLLECTIBLE_VEHICLES. Vintage and Collectible Vehicles
VINTAGE_AND_COLLECTIBLES. Vintage and collectibles
VITAMINS_AND_SUPPLEMENTS. Vitamins & Supplements
VOCATIONAL_AND_TRADE_SCHOOLS. Vocational and trade schools
WATCH_CLOCK_AND_JEWELRY_REPAIR. Watch, clock, and jewelry repair
WEB_HOSTING_AND_DESIGN. Web hosting and design
WELDING_REPAIR. Welding Repair
WHOLESALE_CLUBS. Wholesale Clubs
WHOLESALE_FLORIST_SUPPLIERS. Wholesale Florist Suppliers
WHOLESALE_PRESCRIPTION_DRUGS. Wholesale Prescription Drugs
WILDLIFE_PRODUCTS. Wildlife Products
WIRE_TRANSFER. Wire Transfer
WIRE_TRANSFER_AND_MONEY_ORDER. Wire transfer and money order
WOMEN_ACCESSORY_SPECIALITY. Women's Accessory/Speciality
WOMEN_CLOTHING. Women's clothing
Minimum length: 4.

Maximum length: 256.

Pattern: ^[A-Z_]+$.

create_timestring
The date and time when the product was created, in Internet date and time format.

Read only.

Minimum length: 20.

Maximum length: 64.

Pattern: ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])[T,t]([0-1][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)([.][0-9]+)?([Zz]|[+-][0-9]{2}:[0-9]{2})$.

descriptionstring
The product description.

Minimum length: 1.

Maximum length: 256.

home_urlstring
The home page URL for the product.

Minimum length: 1.

Maximum length: 2000.

idstring
The ID of the product.

Minimum length: 6.

Maximum length: 50.

image_urlstring
The image URL for the product.

Minimum length: 1.

Maximum length: 2000.

linksarray (contains the link_description object)
An array of request-related HATEOAS links.

Read only.

namestring
The product name.

Minimum length: 1.

Maximum length: 127.

typeenum
The product type. Indicates whether the product is physical or digital goods, or a service.

The possible values are:

PHYSICAL. Physical goods
DIGITAL. Digital goods
SERVICE. Product representing a service. Example: Tech Support
Minimum length: 1.

Maximum length: 24.

Pattern: ^[A-Z_]+$.

update_timestring
The date and time when the product was last updated, in Internet date and time format.

Read only.

Minimum length: 20.

Maximum length: 64.

Pattern: ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])[T,t]([0-1][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)([.][0-9]+)?([Zz]|[+-][0-9]{2}:[0-9]{2})$.

Sample Response

{
  "id": "72255d4849af8ed6e0df1173",
  "name": "Video Streaming Service",
  "description": "Video streaming service",
  "type": "SERVICE",
  "category": "SOFTWARE",
  "image_url": "https://example.com/streaming.jpg",
  "home_url": "https://example.com/home",
  "create_time": "2018-12-10T21:20:49Z",
  "update_time": "2018-12-10T21:20:49Z",
  "links": [
    {
      "href": "https://api-m.paypal.com/v1/catalogs/products/72255d4849af8ed6e0df1173",
      "rel": "self",
      "method": "GET"
    },
    {
      "href": "https://api-m.paypal.com/v1/catalogs/products/72255d4849af8ed6e0df1173",
      "rel": "edit",
      "method": "PATCH"
    }
  ]
}
Common object definitions
date_time
Collapse
date_timestring
The date and time, in Internet date and time format. Seconds are required while fractional seconds are optional.
Note: The regular expression provides guidance but does not reject all invalid dates.

Minimum length: 20.

Maximum length: 64.

Pattern: ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])[T,t]([0-1][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)([.][0-9]+)?([Zz]|[+-][0-9]{2}:[0-9]{2})$.

error
Collapse
debug_idstringrequired
The PayPal internal ID. Used for correlation purposes.

messagestringrequired
The message that describes the error.

namestringrequired
The human-readable, unique name of the error.

detailsarray (contains the error_details object)
An array of additional details about the error.

information_linkstring
The information link, or URI, that shows detailed information about this error for the developer.

Read only.

linksarray (contains the link_description object)
An array of request-related HATEOAS links.

Read only.

error_details
Collapse
issuestringrequired
The unique, fine-grained application-level error code.

descriptionstring
The human-readable description for an issue. The description can change over the lifetime of an API, so clients must not depend on this value.

fieldstring
The field that caused the error. If this field is in the body, set this value to the field's JSON pointer value. Required for client-side errors.

locationstring
The location of the field that caused the error. Value is body, path, or query.

valuestring
The value of the field that caused the error.

link_description
Collapse
hrefstringrequired
The complete target URL. To make the related call, combine the method with this URI Template-formatted link. For pre-processing, include the $, (, and ) characters. The href is the key HATEOAS component that links a completed call with a subsequent call.

relstringrequired
The link relation type, which serves as an ID for a link that unambiguously describes the semantics of the link. See Link Relations.

methodenum
The HTTP method required to make the related call.

Possible values: GET,POST,PUT,DELETE,HEAD,CONNECT,OPTIONS,PATCH.

patch
Collapse
openumrequired
The operation.

The possible values are:

add. Depending on the target location reference, completes one of these functions:
The target location is an array index. Inserts a new value into the array at the specified index.
The target location is an object parameter that does not already exist. Adds a new parameter to the object.
The target location is an object parameter that does exist. Replaces that parameter's value.
The value parameter defines the value to add. For more information, see 4.1. add.
remove. Removes the value at the target location. For the operation to succeed, the target location must exist. For more information, see 4.2. remove.
replace. Replaces the value at the target location with a new value. The operation object must contain a value parameter that defines the replacement value. For the operation to succeed, the target location must exist. For more information, see 4.3. replace.
value with . Removes the value at a specified location and adds it to the target location. The operation object must contain a from parameter, which is a string that contains a JSON pointer value that references the location in the target document from which to move the value. For the operation to succeed, the from location must exist. For more information, see 4.4. move.
copy. Copies the value at a specified location to the target location. The operation object must contain a from parameter, which is a string that contains a JSON pointer value that references the location in the target document from which to copy the value. For the operation to succeed, the from location must exist. For more information, see 4.5. copy.
test. Tests that a value at the target location is equal to a specified value. The operation object must contain a value parameter that defines the value to compare to the target location's value. For the operation to succeed, the target location must be equal to the value value. For test, equal indicates that the value at the target location and the value that value defines are of the same JSON type. The data type of the value determines how equality is defined:
Type	Considered equal if both values
strings	Contain the same number of Unicode characters and their code points are byte-by-byte equal.
numbers	Are numerically equal.
arrays	Contain the same number of values, and each value is equal to the value at the corresponding position in the other array, by using these type-specific rules.
objects	Contain the same number of parameters, and each parameter is equal to a parameter in the other object, by comparing their keys (as strings) and their values (by using these type-specific rules).
literals (false, true, and null)	Are the same. The comparison is a logical comparison. For example, whitespace between the parameter values of an array is not significant. Also, ordering of the serialization of object parameters is not significant.
For more information, see 4.6. test.
fromstring
The JSON Pointer to the target document location from which to move the value. Required for the move operation.

pathstring
The JSON Pointer to the target document location at which to complete the operation.

valuenumber,integer,string,boolean,null,array,object
The value to apply. The remove operation does not require a value.

patch_request
Collapse
patch_requestarray (contains the patch object)
An array of JSON patch objects to apply partial updates to resources.

product
Collapse
categoryenum
The product category.

The possible values are:

AC_REFRIGERATION_REPAIR. A/C, Refrigeration Repair
ACADEMIC_SOFTWARE. Academic Software
ACCESSORIES. Accessories
ACCOUNTING. Accounting
ADULT. Adult
ADVERTISING. Advertising
AFFILIATED_AUTO_RENTAL. Affiliated Auto Rental
AGENCIES. Agencies
AGGREGATORS. Aggregators
AGRICULTURAL_COOPERATIVE_FOR_MAIL_ORDER. Agricultural Cooperative for Mail Order
AIR_CARRIERS_AIRLINES. Air Carriers, Airlines
AIRLINES. Airlines
AIRPORTS_FLYING_FIELDS. Airports, Flying Fields
ALCOHOLIC_BEVERAGES. Alcoholic Beverages
AMUSEMENT_PARKS_CARNIVALS. Amusement Parks/Carnivals
ANIMATION. Animation
ANTIQUES. Antiques
APPLIANCES. Appliances
AQUARIAMS_SEAQUARIUMS_DOLPHINARIUMS. Aquariams Seaquariums Dolphinariums
ARCHITECTURAL_ENGINEERING_AND_SURVEYING_SERVICES. Architectural,Engineering,And Surveying Services
ART_AND_CRAFT_SUPPLIES. Art & Craft Supplies
ART_DEALERS_AND_GALLERIES. Art dealers and galleries
ARTIFACTS_GRAVE_RELATED_AND_NATIVE_AMERICAN_CRAFTS. Artifacts, Grave related, and Native American Crafts
ARTS_AND_CRAFTS. Arts and crafts
ARTS_CRAFTS_AND_COLLECTIBLES. Arts, crafts, and collectibles
AUDIO_BOOKS. Audio books
AUTO_ASSOCIATIONS_CLUBS. Auto Associations/Clubs
AUTO_DEALER_USED_ONLY. Auto dealer - used only
AUTO_RENTALS. Auto Rentals
AUTO_SERVICE. Auto service
AUTOMATED_FUEL_DISPENSERS. Automated Fuel Dispensers
AUTOMOBILE_ASSOCIATIONS. Automobile Associations
AUTOMOTIVE. Automotive
AUTOMOTIVE_REPAIR_SHOPS_NON_DEALER. Automotive Repair Shops - Non-Dealer
AUTOMOTIVE_TOP_AND_BODY_SHOPS. Automotive Top And Body Shops
AVIATION. Aviation
BABIES_CLOTHING_AND_SUPPLIES. Babies Clothing & Supplies
BABY. Baby
BANDS_ORCHESTRAS_ENTERTAINERS. Bands,Orchestras,Entertainers
BARBIES. Barbies
BATH_AND_BODY. Bath and body
BATTERIES. Batteries
BEAN_BABIES. Bean Babies
BEAUTY. Beauty
BEAUTY_AND_FRAGRANCES. Beauty and fragrances
BED_AND_BATH. Bed & Bath
BICYCLE_SHOPS_SALES_AND_SERVICE. Bicycle Shops-Sales And Service
BICYCLES_AND_ACCESSORIES. Bicycles & Accessories
BILLIARD_POOL_ESTABLISHMENTS. Billiard/Pool Establishments
BOAT_DEALERS. Boat Dealers
BOAT_RENTALS_AND_LEASING. Boat Rentals And Leasing
BOATING_SAILING_AND_ACCESSORIES. Boating, sailing and accessories
BOOKS. Books
BOOKS_AND_MAGAZINES. Books and magazines
BOOKS_MANUSCRIPTS. Books, Manuscripts
BOOKS_PERIODICALS_AND_NEWSPAPERS. Books, Periodicals And Newspapers
BOWLING_ALLEYS. Bowling Alleys
BULLETIN_BOARD. Bulletin board
BUS_LINE. Bus line
BUS_LINES_CHARTERS_TOUR_BUSES. Bus Lines,Charters,Tour Buses
BUSINESS. Business
BUSINESS_AND_SECRETARIAL_SCHOOLS. Business and secretarial schools
BUYING_AND_SHOPPING_SERVICES_AND_CLUBS. Buying And Shopping Services And Clubs
CABLE_SATELLITE_AND_OTHER_PAY_TELEVISION_AND_RADIO_SERVICES. Cable,Satellite,And Other Pay Television And Radio Services
CABLE_SATELLITE_AND_OTHER_PAY_TV_AND_RADIO. Cable, satellite, and other pay TV and radio
CAMERA_AND_PHOTOGRAPHIC_SUPPLIES. Camera and photographic supplies
CAMERAS. Cameras
CAMERAS_AND_PHOTOGRAPHY. Cameras & Photography
CAMPER_RECREATIONAL_AND_UTILITY_TRAILER_DEALERS. Camper,Recreational And Utility Trailer Dealers
CAMPING_AND_OUTDOORS. Camping and outdoors
CAMPING_AND_SURVIVAL. Camping & Survival
CAR_AND_TRUCK_DEALERS. Car And Truck Dealers
CAR_AND_TRUCK_DEALERS_USED_ONLY. Car And Truck Dealers - Used Only
CAR_AUDIO_AND_ELECTRONICS. Car Audio & Electronics
CAR_RENTAL_AGENCY. Car rental agency
CATALOG_MERCHANT. Catalog Merchant
CATALOG_RETAIL_MERCHANT. Catalog/Retail Merchant
CATERING_SERVICES. Catering services
CHARITY. Charity
CHECK_CASHIER. Check Cashier
CHILD_CARE_SERVICES. Child Care Services
CHILDREN_BOOKS. Children Books
CHIROPODISTS_PODIATRISTS. Chiropodists/Podiatrists
CHIROPRACTORS. Chiropractors
CIGAR_STORES_AND_STANDS. Cigar Stores And Stands
CIVIC_SOCIAL_FRATERNAL_ASSOCIATIONS. Civic, Social, Fraternal Associations
CIVIL_SOCIAL_FRAT_ASSOCIATIONS. Civil/Social/Frat Associations
CLOTHING. Clothing
CLOTHING_ACCESSORIES_AND_SHOES. Clothing, accessories, and shoes
CLOTHING_RENTAL. Clothing Rental
COFFEE_AND_TEA. Coffee and tea
COIN_OPERATED_BANKS_AND_CASINOS. Coin Operated Banks & Casinos
COLLECTIBLES. Collectibles
COLLECTION_AGENCY. Collection agency
COLLEGES_AND_UNIVERSITIES. Colleges and universities
COMMERCIAL_EQUIPMENT. Commercial Equipment
COMMERCIAL_FOOTWEAR. Commercial Footwear
COMMERCIAL_PHOTOGRAPHY. Commercial photography
COMMERCIAL_PHOTOGRAPHY_ART_AND_GRAPHICS. Commercial photography, art, and graphics
COMMERCIAL_SPORTS_PROFESSIONA. Commercial Sports/Professiona
COMMODITIES_AND_FUTURES_EXCHANGE. Commodities and futures exchange
COMPUTER_AND_DATA_PROCESSING_SERVICES. Computer and data processing services
COMPUTER_HARDWARE_AND_SOFTWARE. Computer Hardware & Software
COMPUTER_MAINTENANCE_REPAIR_AND_SERVICES_NOT_ELSEWHERE_CLAS. Computer Maintenance, Repair And Services Not Elsewhere Clas
CONSTRUCTION. Construction
CONSTRUCTION_MATERIALS_NOT_ELSEWHERE_CLASSIFIED. Construction Materials Not Elsewhere Classified
CONSULTING_SERVICES. Consulting services
CONSUMER_CREDIT_REPORTING_AGENCIES. Consumer Credit Reporting Agencies
CONVALESCENT_HOMES. Convalescent Homes
COSMETIC_STORES. Cosmetic Stores
COUNSELING_SERVICES_DEBT_MARRIAGE_PERSONAL. Counseling Services--Debt,Marriage,Personal
COUNTERFEIT_CURRENCY_AND_STAMPS. Counterfeit Currency and Stamps
COUNTERFEIT_ITEMS. Counterfeit Items
COUNTRY_CLUBS. Country Clubs
COURIER_SERVICES. Courier services
COURIER_SERVICES_AIR_AND_GROUND_AND_FREIGHT_FORWARDERS. Courier Services-Air And Ground,And Freight Forwarders
COURT_COSTS_ALIMNY_CHILD_SUPT. Court Costs/Alimny/Child Supt
COURT_COSTS_INCLUDING_ALIMONY_AND_CHILD_SUPPORT_COURTS_OF_LAW. Court Costs, Including Alimony and Child Support - Courts of Law
CREDIT_CARDS. Credit Cards
CREDIT_UNION. Credit union
CULTURE_AND_RELIGION. Culture & Religion
DAIRY_PRODUCTS_STORES. Dairy Products Stores
DANCE_HALLS_STUDIOS_AND_SCHOOLS. Dance Halls,Studios,And Schools
DECORATIVE. Decorative
DENTAL. Dental
DENTISTS_AND_ORTHODONTISTS. Dentists And Orthodontists
DEPARTMENT_STORES. Department Stores
DESKTOP_PCS. Desktop PCs
DEVICES. Devices
DIECAST_TOYS_VEHICLES. Diecast, Toys Vehicles
DIGITAL_GAMES. Digital games
DIGITAL_MEDIA_BOOKS_MOVIES_MUSIC. Digital media,books,movies,music
DIRECT_MARKETING. Direct Marketing
DIRECT_MARKETING_CATALOG_MERCHANT. Direct Marketing - Catalog Merchant
DIRECT_MARKETING_INBOUND_TELE. Direct Marketing - Inbound Tele
DIRECT_MARKETING_OUTBOUND_TELE. Direct Marketing - Outbound Tele
DIRECT_MARKETING_SUBSCRIPTION. Direct Marketing - Subscription
DISCOUNT_STORES. Discount Stores
DOOR_TO_DOOR_SALES. Door-To-Door Sales
DRAPERY_WINDOW_COVERING_AND_UPHOLSTERY. Drapery, window covering, and upholstery
DRINKING_PLACES. Drinking Places
DRUGSTORE. Drugstore
DURABLE_GOODS. Durable goods
ECOMMERCE_DEVELOPMENT. eCommerce Development
ECOMMERCE_SERVICES. eCommerce Services
EDUCATIONAL_AND_TEXTBOOKS. Educational and textbooks
ELECTRIC_RAZOR_STORES. Electric Razor Stores
ELECTRICAL_AND_SMALL_APPLIANCE_REPAIR. Electrical and small appliance repair
ELECTRICAL_CONTRACTORS. Electrical Contractors
ELECTRICAL_PARTS_AND_EQUIPMENT. Electrical Parts and Equipment
ELECTRONIC_CASH. Electronic Cash
ELEMENTARY_AND_SECONDARY_SCHOOLS. Elementary and secondary schools
EMPLOYMENT. Employment
ENTERTAINERS. Entertainers
ENTERTAINMENT_AND_MEDIA. Entertainment and media
EQUIP_TOOL_FURNITURE_AND_APPLIANCE_RENTAL_AND_LEASING. Equip, Tool, Furniture, And Appliance Rental And Leasing
ESCROW. Escrow
EVENT_AND_WEDDING_PLANNING. Event & Wedding Planning
EXERCISE_AND_FITNESS. Exercise and fitness
EXERCISE_EQUIPMENT. Exercise Equipment
EXTERMINATING_AND_DISINFECTING_SERVICES. Exterminating and disinfecting services
FABRICS_AND_SEWING. Fabrics & Sewing
FAMILY_CLOTHING_STORES. Family Clothing Stores
FASHION_JEWELRY. Fashion jewelry
FAST_FOOD_RESTAURANTS. Fast Food Restaurants
FICTION_AND_NONFICTION. Fiction and nonfiction
FINANCE_COMPANY. Finance company
FINANCIAL_AND_INVESTMENT_ADVICE. Financial and investment advice
FINANCIAL_INSTITUTIONS_MERCHANDISE_AND_SERVICES. Financial Institutions - Merchandise And Services
FIREARM_ACCESSORIES. Firearm accessories
FIREARMS_WEAPONS_AND_KNIVES. Firearms, Weapons and Knives
FIREPLACE_AND_FIREPLACE_SCREENS. Fireplace, and fireplace screens
FIREWORKS. Fireworks
FISHING. Fishing
FLORISTS. Florists
FLOWERS. Flowers
FOOD_DRINK_AND_NUTRITION. Food, Drink & Nutrition
FOOD_PRODUCTS. Food Products
FOOD_RETAIL_AND_SERVICE. Food retail and service
FRAGRANCES_AND_PERFUMES. Fragrances and perfumes
FREEZER_AND_LOCKER_MEAT_PROVISIONERS. Freezer and Locker Meat Provisioners
FUEL_DEALERS_FUEL_OIL_WOOD_AND_COAL. Fuel Dealers-Fuel Oil, Wood & Coal
FUEL_DEALERS_NON_AUTOMOTIVE. Fuel Dealers - Non Automotive
FUNERAL_SERVICES_AND_CREMATORIES. Funeral Services & Crematories
FURNISHING_AND_DECORATING. Furnishing & Decorating
FURNITURE. Furniture
FURRIERS_AND_FUR_SHOPS. Furriers and Fur Shops
GADGETS_AND_OTHER_ELECTRONICS. Gadgets & other electronics
GAMBLING. Gambling
GAME_SOFTWARE. Game Software
GAMES. Games
GARDEN_SUPPLIES. Garden supplies
GENERAL. General
GENERAL_CONTRACTORS. General contractors
GENERAL_GOVERNMENT. General - Government
GENERAL_SOFTWARE. General - Software
GENERAL_TELECOM. General - Telecom
GIFTS_AND_FLOWERS. Gifts and flowers
GLASS_PAINT_AND_WALLPAPER_STORES. Glass,Paint,And Wallpaper Stores
GLASSWARE_CRYSTAL_STORES. Glassware, Crystal Stores
GOVERNMENT. Government
GOVERNMENT_IDS_AND_LICENSES. Government IDs and Licenses
GOVERNMENT_LICENSED_ON_LINE_CASINOS_ON_LINE_GAMBLING. Government Licensed On-Line Casinos - On-Line Gambling
GOVERNMENT_OWNED_LOTTERIES. Government-Owned Lotteries
GOVERNMENT_SERVICES. Government services
GRAPHIC_AND_COMMERCIAL_DESIGN. Graphic & Commercial Design
GREETING_CARDS. Greeting Cards
GROCERY_STORES_AND_SUPERMARKETS. Grocery Stores & Supermarkets
HARDWARE_AND_TOOLS. Hardware & Tools
HARDWARE_EQUIPMENT_AND_SUPPLIES. Hardware, Equipment, and Supplies
HAZARDOUS_RESTRICTED_AND_PERISHABLE_ITEMS. Hazardous, Restricted and Perishable Items
HEALTH_AND_BEAUTY_SPAS. Health and beauty spas
HEALTH_AND_NUTRITION. Health & Nutrition
HEALTH_AND_PERSONAL_CARE. Health and personal care
HEARING_AIDS_SALES_AND_SUPPLIES. Hearing Aids Sales and Supplies
HEATING_PLUMBING_AC. Heating, Plumbing, AC
HIGH_RISK_MERCHANT. High Risk Merchant
HIRING_SERVICES. Hiring services
HOBBIES_TOYS_AND_GAMES. Hobbies, Toys & Games
HOME_AND_GARDEN. Home and garden
HOME_AUDIO. Home Audio
HOME_DECOR. Home decor
HOME_ELECTRONICS. Home Electronics
HOSPITALS. Hospitals
HOTELS_MOTELS_INNS_RESORTS. Hotels/Motels/Inns/Resorts
HOUSEWARES. Housewares
HUMAN_PARTS_AND_REMAINS. Human Parts and Remains
HUMOROUS_GIFTS_AND_NOVELTIES. Humorous Gifts & Novelties
HUNTING. Hunting
IDS_LICENSES_AND_PASSPORTS. IDs, licenses, and passports
ILLEGAL_DRUGS_AND_PARAPHERNALIA. Illegal Drugs & Paraphernalia
INDUSTRIAL. Industrial
INDUSTRIAL_AND_MANUFACTURING_SUPPLIES. Industrial and manufacturing supplies
INSURANCE_AUTO_AND_HOME. Insurance - auto and home
INSURANCE_DIRECT. Insurance - Direct
INSURANCE_LIFE_AND_ANNUITY. Insurance - life and annuity
INSURANCE_SALES_UNDERWRITING. Insurance Sales/Underwriting
INSURANCE_UNDERWRITING_PREMIUMS. Insurance Underwriting, Premiums
INTERNET_AND_NETWORK_SERVICES. Internet & Network Services
INTRA_COMPANY_PURCHASES. Intra-Company Purchases
LABORATORIES_DENTAL_MEDICAL. Laboratories-Dental/Medical
LANDSCAPING. Landscaping
LANDSCAPING_AND_HORTICULTURAL_SERVICES. Landscaping And Horticultural Services
LAUNDRY_CLEANING_SERVICES. Laundry, Cleaning Services
LEGAL. Legal
LEGAL_SERVICES_AND_ATTORNEYS. Legal services and attorneys
LOCAL_DELIVERY_SERVICE. Local delivery service
LOCKSMITH. Locksmith
LODGING_AND_ACCOMMODATIONS. Lodging and accommodations
LOTTERY_AND_CONTESTS. Lottery and contests
LUGGAGE_AND_LEATHER_GOODS. Luggage and leather goods
LUMBER_AND_BUILDING_MATERIALS. Lumber & Building Materials
MAGAZINES. Magazines
MAINTENANCE_AND_REPAIR_SERVICES. Maintenance and repair services
MAKEUP_AND_COSMETICS. Makeup and cosmetics
MANUAL_CASH_DISBURSEMENTS. Manual Cash Disbursements
MASSAGE_PARLORS. Massage Parlors
MEDICAL. Medical
MEDICAL_AND_PHARMACEUTICAL. Medical & Pharmaceutical
MEDICAL_CARE. Medical care
MEDICAL_EQUIPMENT_AND_SUPPLIES. Medical equipment and supplies
MEDICAL_SERVICES. Medical Services
MEETING_PLANNERS. Meeting Planners
MEMBERSHIP_CLUBS_AND_ORGANIZATIONS. Membership clubs and organizations
MEMBERSHIP_COUNTRY_CLUBS_GOLF. Membership/Country Clubs/Golf
MEMORABILIA. Memorabilia
MEN_AND_BOY_CLOTHING_AND_ACCESSORY_STORES. Men's And Boy's Clothing And Accessory Stores
MEN_CLOTHING. Men's Clothing
MERCHANDISE. Merchandise
METAPHYSICAL. Metaphysical
MILITARIA. Militaria
MILITARY_AND_CIVIL_SERVICE_UNIFORMS. Military and civil service uniforms
MISC._AUTOMOTIVE_AIRCRAFT_AND_FARM_EQUIPMENT_DEALERS. Misc. Automotive,Aircraft,And Farm Equipment Dealers
MISC._GENERAL_MERCHANDISE. Misc. General Merchandise
MISCELLANEOUS_GENERAL_SERVICES. Miscellaneous General Services
MISCELLANEOUS_REPAIR_SHOPS_AND_RELATED_SERVICES. Miscellaneous Repair Shops And Related Services
MODEL_KITS. Model Kits
MONEY_TRANSFER_MEMBER_FINANCIAL_INSTITUTION. Money Transfer - Member Financial Institution
MONEY_TRANSFER_MERCHANT. Money Transfer--Merchant
MOTION_PICTURE_THEATERS. Motion Picture Theaters
MOTOR_FREIGHT_CARRIERS_AND_TRUCKING. Motor Freight Carriers & Trucking
MOTOR_HOME_AND_RECREATIONAL_VEHICLE_RENTAL. Motor Home And Recreational Vehicle Rental
MOTOR_HOMES_DEALERS. Motor Homes Dealers
MOTOR_VEHICLE_SUPPLIES_AND_NEW_PARTS. Motor Vehicle Supplies and New Parts
MOTORCYCLE_DEALERS. Motorcycle Dealers
MOTORCYCLES. Motorcycles
MOVIE. Movie
MOVIE_TICKETS. Movie tickets
MOVING_AND_STORAGE. Moving and storage
MULTI_LEVEL_MARKETING. Multi-level marketing
MUSIC_CDS_CASSETTES_AND_ALBUMS. Music - CDs, cassettes and albums
MUSIC_STORE_INSTRUMENTS_AND_SHEET_MUSIC. Music store - instruments and sheet music
NETWORKING. Networking
NEW_AGE. New Age
NEW_PARTS_AND_SUPPLIES_MOTOR_VEHICLE. New parts and supplies - motor vehicle
NEWS_DEALERS_AND_NEWSTANDS. News Dealers and Newstands
NON_DURABLE_GOODS. Non-durable goods
NON_FICTION. Non-Fiction
NON_PROFIT_POLITICAL_AND_RELIGION. Non-Profit, Political & Religion
NONPROFIT. Nonprofit
NOVELTIES. Novelties
OEM_SOFTWARE. Oem Software
OFFICE_SUPPLIES_AND_EQUIPMENT. Office Supplies and Equipment
ONLINE_DATING. Online Dating
ONLINE_GAMING. Online gaming
ONLINE_GAMING_CURRENCY. Online gaming currency
ONLINE_SERVICES. online services
OOUTBOUND_TELEMARKETING_MERCH. Ooutbound Telemarketing Merch
OPHTHALMOLOGISTS_OPTOMETRIST. Ophthalmologists/Optometrist
OPTICIANS_AND_DISPENSING. Opticians And Dispensing
ORTHOPEDIC_GOODS_PROSTHETICS. Orthopedic Goods/Prosthetics
OSTEOPATHS. Osteopaths
OTHER. Other
PACKAGE_TOUR_OPERATORS. Package Tour Operators
PAINTBALL. Paintball
PAINTS_VARNISHES_AND_SUPPLIES. Paints, Varnishes, and Supplies
PARKING_LOTS_AND_GARAGES. Parking Lots & Garages
PARTS_AND_ACCESSORIES. Parts and accessories
PAWN_SHOPS. Pawn Shops
PAYCHECK_LENDER_OR_CASH_ADVANCE. Paycheck lender or cash advance
PERIPHERALS. Peripherals
PERSONALIZED_GIFTS. Personalized Gifts
PET_SHOPS_PET_FOOD_AND_SUPPLIES. Pet shops, pet food, and supplies
PETROLEUM_AND_PETROLEUM_PRODUCTS. Petroleum and Petroleum Products
PETS_AND_ANIMALS. Pets and animals
PHOTOFINISHING_LABORATORIES_PHOTO_DEVELOPING. Photofinishing Laboratories,Photo Developing
PHOTOGRAPHIC_STUDIOS_PORTRAITS. Photographic studios - portraits
PHOTOGRAPHY. Photography
PHYSICAL_GOOD. Physical Good
PICTURE_VIDEO_PRODUCTION. Picture/Video Production
PIECE_GOODS_NOTIONS_AND_OTHER_DRY_GOODS. Piece Goods Notions and Other Dry Goods
PLANTS_AND_SEEDS. Plants and Seeds
PLUMBING_AND_HEATING_EQUIPMENTS_AND_SUPPLIES. Plumbing & Heating Equipments & Supplies
POLICE_RELATED_ITEMS. Police-Related Items
POLITICAL_ORGANIZATIONS. Politcal Organizations
POSTAL_SERVICES_GOVERNMENT_ONLY. Postal Services - Government Only
POSTERS. Posters
PREPAID_AND_STORED_VALUE_CARDS. Prepaid and stored value cards
PRESCRIPTION_DRUGS. Prescription Drugs
PROMOTIONAL_ITEMS. Promotional Items
PUBLIC_WAREHOUSING_AND_STORAGE. Public Warehousing and Storage
PUBLISHING_AND_PRINTING. Publishing and printing
PUBLISHING_SERVICES. Publishing Services
RADAR_DECTORS. Radar Dectors
RADIO_TELEVISION_AND_STEREO_REPAIR. Radio, television, and stereo repair
REAL_ESTATE. Real Estate
REAL_ESTATE_AGENT. Real estate agent
REAL_ESTATE_AGENTS_AND_MANAGERS_RENTALS. Real Estate Agents And Managers - Rentals
RELIGION_AND_SPIRITUALITY_FOR_PROFIT. Religion and spirituality for profit
RELIGIOUS. Religious
RELIGIOUS_ORGANIZATIONS. Religious Organizations
REMITTANCE. Remittance
RENTAL_PROPERTY_MANAGEMENT. Rental property management
RESIDENTIAL. Residential
RETAIL. Retail
RETAIL_FINE_JEWELRY_AND_WATCHES. Retail - fine jewelry and watches
REUPHOLSTERY_AND_FURNITURE_REPAIR. Reupholstery and furniture repair
RINGS. Rings
ROOFING_SIDING_SHEET_METAL. Roofing/Siding, Sheet Metal
RUGS_AND_CARPETS. Rugs & Carpets
SCHOOLS_AND_COLLEGES. Schools and Colleges
SCIENCE_FICTION. Science Fiction
SCRAPBOOKING. Scrapbooking
SCULPTURES. Sculptures
SECURITIES_BROKERS_AND_DEALERS. Securities - Brokers And Dealers
SECURITY_AND_SURVEILLANCE. Security and surveillance
SECURITY_AND_SURVEILLANCE_EQUIPMENT. Security and surveillance equipment
SECURITY_BROKERS_AND_DEALERS. Security brokers and dealers
SEMINARS. Seminars
SERVICE_STATIONS. Service Stations
SERVICES. Services
SEWING_NEEDLEWORK_FABRIC_AND_PIECE_GOODS_STORES. Sewing,Needlework,Fabric And Piece Goods Stores
SHIPPING_AND_PACKING. Shipping & Packaging
SHOE_REPAIR_HAT_CLEANING. Shoe Repair/Hat Cleaning
SHOE_STORES. Shoe Stores
SHOES. Shoes
SNOWMOBILE_DEALERS. Snowmobile Dealers
SOFTWARE. Software
SPECIALTY_AND_MISC._FOOD_STORES. Specialty and misc. food stores
SPECIALTY_CLEANING_POLISHING_AND_SANITATION_PREPARATIONS. Specialty Cleaning, Polishing And Sanitation Preparations
SPECIALTY_OR_RARE_PETS. Specialty or rare pets
SPORT_GAMES_AND_TOYS. Sport games and toys
SPORTING_AND_RECREATIONAL_CAMPS. Sporting And Recreational Camps
SPORTING_GOODS. Sporting Goods
SPORTS_AND_OUTDOORS. Sports and outdoors
SPORTS_AND_RECREATION. Sports & Recreation
STAMP_AND_COIN. Stamp and coin
STATIONARY_PRINTING_AND_WRITING_PAPER. Stationary, printing, and writing paper
STENOGRAPHIC_AND_SECRETARIAL_SUPPORT_SERVICES. Stenographic and secretarial support services
STOCKS_BONDS_SECURITIES_AND_RELATED_CERTIFICATES. Stocks, Bonds, Securities and Related Certificates
STORED_VALUE_CARDS. Stored Value Cards
SUPPLIES. Supplies
SUPPLIES_AND_TOYS. Supplies & Toys
SURVEILLANCE_EQUIPMENT. Surveillance Equipment
SWIMMING_POOLS_AND_SPAS. Swimming Pools & Spas
SWIMMING_POOLS_SALES_SUPPLIES_SERVICES. Swimming Pools-Sales,Supplies,Services
TAILORS_AND_ALTERATIONS. Tailors and alterations
TAX_PAYMENTS. Tax Payments
TAX_PAYMENTS_GOVERNMENT_AGENCIES. Tax Payments - Government Agencies
TAXICABS_AND_LIMOUSINES. Taxicabs and limousines
TELECOMMUNICATION_SERVICES. Telecommunication Services
TELEPHONE_CARDS. Telephone Cards
TELEPHONE_EQUIPMENT. Telephone Equipment
TELEPHONE_SERVICES. Telephone Services
THEATER. Theater
TIRE_RETREADING_AND_REPAIR. Tire Retreading and Repair
TOLL_OR_BRIDGE_FEES. Toll or Bridge Fees
TOOLS_AND_EQUIPMENT. Tools and equipment
TOURIST_ATTRACTIONS_AND_EXHIBITS. Tourist Attractions And Exhibits
TOWING_SERVICE. Towing service
TOYS_AND_GAMES. Toys and games
TRADE_AND_VOCATIONAL_SCHOOLS. Trade And Vocational Schools
TRADEMARK_INFRINGEMENT. Trademark Infringement
TRAILER_PARKS_AND_CAMPGROUNDS. Trailer Parks And Campgrounds
TRAINING_SERVICES. Training services
TRANSPORTATION_SERVICES. Transportation Services
TRAVEL. Travel
TRUCK_AND_UTILITY_TRAILER_RENTALS. Truck And Utility Trailer Rentals
TRUCK_STOP. Truck Stop
TYPESETTING_PLATE_MAKING_AND_RELATED_SERVICES. Typesetting, Plate Making, and Related Services
USED_MERCHANDISE_AND_SECONDHAND_STORES. Used Merchandise And Secondhand Stores
USED_PARTS_MOTOR_VEHICLE. Used parts - motor vehicle
UTILITIES. Utilities
UTILITIES_ELECTRIC_GAS_WATER_SANITARY. Utilities - Electric,Gas,Water,Sanitary
VARIETY_STORES. Variety Stores
VEHICLE_SALES. Vehicle sales
VEHICLE_SERVICE_AND_ACCESSORIES. Vehicle service and accessories
VIDEO_EQUIPMENT. Video Equipment
VIDEO_GAME_ARCADES_ESTABLISH. Video Game Arcades/Establish
VIDEO_GAMES_AND_SYSTEMS. Video Games & Systems
VIDEO_TAPE_RENTAL_STORES. Video Tape Rental Stores
VINTAGE_AND_COLLECTIBLE_VEHICLES. Vintage and Collectible Vehicles
VINTAGE_AND_COLLECTIBLES. Vintage and collectibles
VITAMINS_AND_SUPPLEMENTS. Vitamins & Supplements
VOCATIONAL_AND_TRADE_SCHOOLS. Vocational and trade schools
WATCH_CLOCK_AND_JEWELRY_REPAIR. Watch, clock, and jewelry repair
WEB_HOSTING_AND_DESIGN. Web hosting and design
WELDING_REPAIR. Welding Repair
WHOLESALE_CLUBS. Wholesale Clubs
WHOLESALE_FLORIST_SUPPLIERS. Wholesale Florist Suppliers
WHOLESALE_PRESCRIPTION_DRUGS. Wholesale Prescription Drugs
WILDLIFE_PRODUCTS. Wildlife Products
WIRE_TRANSFER. Wire Transfer
WIRE_TRANSFER_AND_MONEY_ORDER. Wire transfer and money order
WOMEN_ACCESSORY_SPECIALITY. Women's Accessory/Speciality
WOMEN_CLOTHING. Women's clothing
Minimum length: 4.

Maximum length: 256.

Pattern: ^[A-Z_]+$.

create_timestring
The date and time when the product was created, in Internet date and time format.

Read only.

Minimum length: 20.

Maximum length: 64.

Pattern: ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])[T,t]([0-1][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)([.][0-9]+)?([Zz]|[+-][0-9]{2}:[0-9]{2})$.

descriptionstring
The product description.

Minimum length: 1.

Maximum length: 256.

home_urlstring
The home page URL for the product.

Minimum length: 1.

Maximum length: 2000.

idstring
The ID of the product.

Minimum length: 6.

Maximum length: 50.

image_urlstring
The image URL for the product.

Minimum length: 1.

Maximum length: 2000.

linksarray (contains the link_description object)
An array of request-related HATEOAS links.

Read only.

namestring
The product name.

Minimum length: 1.

Maximum length: 127.

typeenum
The product type. Indicates whether the product is physical or digital goods, or a service.

The possible values are:

PHYSICAL. Physical goods
DIGITAL. Digital goods
SERVICE. Product representing a service. Example: Tech Support
Minimum length: 1.

Maximum length: 24.

Pattern: ^[A-Z_]+$.

update_timestring
The date and time when the product was last updated, in Internet date and time format.

Read only.

Minimum length: 20.

Maximum length: 64.

Pattern: ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])[T,t]([0-1][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)([.][0-9]+)?([Zz]|[+-][0-9]{2}:[0-9]{2})$.

product_category
Collapse
product_categoryenum
The product category.

The possible values are:

AC_REFRIGERATION_REPAIR. A/C, Refrigeration Repair
ACADEMIC_SOFTWARE. Academic Software
ACCESSORIES. Accessories
ACCOUNTING. Accounting
ADULT. Adult
ADVERTISING. Advertising
AFFILIATED_AUTO_RENTAL. Affiliated Auto Rental
AGENCIES. Agencies
AGGREGATORS. Aggregators
AGRICULTURAL_COOPERATIVE_FOR_MAIL_ORDER. Agricultural Cooperative for Mail Order
AIR_CARRIERS_AIRLINES. Air Carriers, Airlines
AIRLINES. Airlines
AIRPORTS_FLYING_FIELDS. Airports, Flying Fields
ALCOHOLIC_BEVERAGES. Alcoholic Beverages
AMUSEMENT_PARKS_CARNIVALS. Amusement Parks/Carnivals
ANIMATION. Animation
ANTIQUES. Antiques
APPLIANCES. Appliances
AQUARIAMS_SEAQUARIUMS_DOLPHINARIUMS. Aquariams Seaquariums Dolphinariums
ARCHITECTURAL_ENGINEERING_AND_SURVEYING_SERVICES. Architectural,Engineering,And Surveying Services
ART_AND_CRAFT_SUPPLIES. Art & Craft Supplies
ART_DEALERS_AND_GALLERIES. Art dealers and galleries
ARTIFACTS_GRAVE_RELATED_AND_NATIVE_AMERICAN_CRAFTS. Artifacts, Grave related, and Native American Crafts
ARTS_AND_CRAFTS. Arts and crafts
ARTS_CRAFTS_AND_COLLECTIBLES. Arts, crafts, and collectibles
AUDIO_BOOKS. Audio books
AUTO_ASSOCIATIONS_CLUBS. Auto Associations/Clubs
AUTO_DEALER_USED_ONLY. Auto dealer - used only
AUTO_RENTALS. Auto Rentals
AUTO_SERVICE. Auto service
AUTOMATED_FUEL_DISPENSERS. Automated Fuel Dispensers
AUTOMOBILE_ASSOCIATIONS. Automobile Associations
AUTOMOTIVE. Automotive
AUTOMOTIVE_REPAIR_SHOPS_NON_DEALER. Automotive Repair Shops - Non-Dealer
AUTOMOTIVE_TOP_AND_BODY_SHOPS. Automotive Top And Body Shops
AVIATION. Aviation
BABIES_CLOTHING_AND_SUPPLIES. Babies Clothing & Supplies
BABY. Baby
BANDS_ORCHESTRAS_ENTERTAINERS. Bands,Orchestras,Entertainers
BARBIES. Barbies
BATH_AND_BODY. Bath and body
BATTERIES. Batteries
BEAN_BABIES. Bean Babies
BEAUTY. Beauty
BEAUTY_AND_FRAGRANCES. Beauty and fragrances
BED_AND_BATH. Bed & Bath
BICYCLE_SHOPS_SALES_AND_SERVICE. Bicycle Shops-Sales And Service
BICYCLES_AND_ACCESSORIES. Bicycles & Accessories
BILLIARD_POOL_ESTABLISHMENTS. Billiard/Pool Establishments
BOAT_DEALERS. Boat Dealers
BOAT_RENTALS_AND_LEASING. Boat Rentals And Leasing
BOATING_SAILING_AND_ACCESSORIES. Boating, sailing and accessories
BOOKS. Books
BOOKS_AND_MAGAZINES. Books and magazines
BOOKS_MANUSCRIPTS. Books, Manuscripts
BOOKS_PERIODICALS_AND_NEWSPAPERS. Books, Periodicals And Newspapers
BOWLING_ALLEYS. Bowling Alleys
BULLETIN_BOARD. Bulletin board
BUS_LINE. Bus line
BUS_LINES_CHARTERS_TOUR_BUSES. Bus Lines,Charters,Tour Buses
BUSINESS. Business
BUSINESS_AND_SECRETARIAL_SCHOOLS. Business and secretarial schools
BUYING_AND_SHOPPING_SERVICES_AND_CLUBS. Buying And Shopping Services And Clubs
CABLE_SATELLITE_AND_OTHER_PAY_TELEVISION_AND_RADIO_SERVICES. Cable,Satellite,And Other Pay Television And Radio Services
CABLE_SATELLITE_AND_OTHER_PAY_TV_AND_RADIO. Cable, satellite, and other pay TV and radio
CAMERA_AND_PHOTOGRAPHIC_SUPPLIES. Camera and photographic supplies
CAMERAS. Cameras
CAMERAS_AND_PHOTOGRAPHY. Cameras & Photography
CAMPER_RECREATIONAL_AND_UTILITY_TRAILER_DEALERS. Camper,Recreational And Utility Trailer Dealers
CAMPING_AND_OUTDOORS. Camping and outdoors
CAMPING_AND_SURVIVAL. Camping & Survival
CAR_AND_TRUCK_DEALERS. Car And Truck Dealers
CAR_AND_TRUCK_DEALERS_USED_ONLY. Car And Truck Dealers - Used Only
CAR_AUDIO_AND_ELECTRONICS. Car Audio & Electronics
CAR_RENTAL_AGENCY. Car rental agency
CATALOG_MERCHANT. Catalog Merchant
CATALOG_RETAIL_MERCHANT. Catalog/Retail Merchant
CATERING_SERVICES. Catering services
CHARITY. Charity
CHECK_CASHIER. Check Cashier
CHILD_CARE_SERVICES. Child Care Services
CHILDREN_BOOKS. Children Books
CHIROPODISTS_PODIATRISTS. Chiropodists/Podiatrists
CHIROPRACTORS. Chiropractors
CIGAR_STORES_AND_STANDS. Cigar Stores And Stands
CIVIC_SOCIAL_FRATERNAL_ASSOCIATIONS. Civic, Social, Fraternal Associations
CIVIL_SOCIAL_FRAT_ASSOCIATIONS. Civil/Social/Frat Associations
CLOTHING. Clothing
CLOTHING_ACCESSORIES_AND_SHOES. Clothing, accessories, and shoes
CLOTHING_RENTAL. Clothing Rental
COFFEE_AND_TEA. Coffee and tea
COIN_OPERATED_BANKS_AND_CASINOS. Coin Operated Banks & Casinos
COLLECTIBLES. Collectibles
COLLECTION_AGENCY. Collection agency
COLLEGES_AND_UNIVERSITIES. Colleges and universities
COMMERCIAL_EQUIPMENT. Commercial Equipment
COMMERCIAL_FOOTWEAR. Commercial Footwear
COMMERCIAL_PHOTOGRAPHY. Commercial photography
COMMERCIAL_PHOTOGRAPHY_ART_AND_GRAPHICS. Commercial photography, art, and graphics
COMMERCIAL_SPORTS_PROFESSIONA. Commercial Sports/Professiona
COMMODITIES_AND_FUTURES_EXCHANGE. Commodities and futures exchange
COMPUTER_AND_DATA_PROCESSING_SERVICES. Computer and data processing services
COMPUTER_HARDWARE_AND_SOFTWARE. Computer Hardware & Software
COMPUTER_MAINTENANCE_REPAIR_AND_SERVICES_NOT_ELSEWHERE_CLAS. Computer Maintenance, Repair And Services Not Elsewhere Clas
CONSTRUCTION. Construction
CONSTRUCTION_MATERIALS_NOT_ELSEWHERE_CLASSIFIED. Construction Materials Not Elsewhere Classified
CONSULTING_SERVICES. Consulting services
CONSUMER_CREDIT_REPORTING_AGENCIES. Consumer Credit Reporting Agencies
CONVALESCENT_HOMES. Convalescent Homes
COSMETIC_STORES. Cosmetic Stores
COUNSELING_SERVICES_DEBT_MARRIAGE_PERSONAL. Counseling Services--Debt,Marriage,Personal
COUNTERFEIT_CURRENCY_AND_STAMPS. Counterfeit Currency and Stamps
COUNTERFEIT_ITEMS. Counterfeit Items
COUNTRY_CLUBS. Country Clubs
COURIER_SERVICES. Courier services
COURIER_SERVICES_AIR_AND_GROUND_AND_FREIGHT_FORWARDERS. Courier Services-Air And Ground,And Freight Forwarders
COURT_COSTS_ALIMNY_CHILD_SUPT. Court Costs/Alimny/Child Supt
COURT_COSTS_INCLUDING_ALIMONY_AND_CHILD_SUPPORT_COURTS_OF_LAW. Court Costs, Including Alimony and Child Support - Courts of Law
CREDIT_CARDS. Credit Cards
CREDIT_UNION. Credit union
CULTURE_AND_RELIGION. Culture & Religion
DAIRY_PRODUCTS_STORES. Dairy Products Stores
DANCE_HALLS_STUDIOS_AND_SCHOOLS. Dance Halls,Studios,And Schools
DECORATIVE. Decorative
DENTAL. Dental
DENTISTS_AND_ORTHODONTISTS. Dentists And Orthodontists
DEPARTMENT_STORES. Department Stores
DESKTOP_PCS. Desktop PCs
DEVICES. Devices
DIECAST_TOYS_VEHICLES. Diecast, Toys Vehicles
DIGITAL_GAMES. Digital games
DIGITAL_MEDIA_BOOKS_MOVIES_MUSIC. Digital media,books,movies,music
DIRECT_MARKETING. Direct Marketing
DIRECT_MARKETING_CATALOG_MERCHANT. Direct Marketing - Catalog Merchant
DIRECT_MARKETING_INBOUND_TELE. Direct Marketing - Inbound Tele
DIRECT_MARKETING_OUTBOUND_TELE. Direct Marketing - Outbound Tele
DIRECT_MARKETING_SUBSCRIPTION. Direct Marketing - Subscription
DISCOUNT_STORES. Discount Stores
DOOR_TO_DOOR_SALES. Door-To-Door Sales
DRAPERY_WINDOW_COVERING_AND_UPHOLSTERY. Drapery, window covering, and upholstery
DRINKING_PLACES. Drinking Places
DRUGSTORE. Drugstore
DURABLE_GOODS. Durable goods
ECOMMERCE_DEVELOPMENT. eCommerce Development
ECOMMERCE_SERVICES. eCommerce Services
EDUCATIONAL_AND_TEXTBOOKS. Educational and textbooks
ELECTRIC_RAZOR_STORES. Electric Razor Stores
ELECTRICAL_AND_SMALL_APPLIANCE_REPAIR. Electrical and small appliance repair
ELECTRICAL_CONTRACTORS. Electrical Contractors
ELECTRICAL_PARTS_AND_EQUIPMENT. Electrical Parts and Equipment
ELECTRONIC_CASH. Electronic Cash
ELEMENTARY_AND_SECONDARY_SCHOOLS. Elementary and secondary schools
EMPLOYMENT. Employment
ENTERTAINERS. Entertainers
ENTERTAINMENT_AND_MEDIA. Entertainment and media
EQUIP_TOOL_FURNITURE_AND_APPLIANCE_RENTAL_AND_LEASING. Equip, Tool, Furniture, And Appliance Rental And Leasing
ESCROW. Escrow
EVENT_AND_WEDDING_PLANNING. Event & Wedding Planning
EXERCISE_AND_FITNESS. Exercise and fitness
EXERCISE_EQUIPMENT. Exercise Equipment
EXTERMINATING_AND_DISINFECTING_SERVICES. Exterminating and disinfecting services
FABRICS_AND_SEWING. Fabrics & Sewing
FAMILY_CLOTHING_STORES. Family Clothing Stores
FASHION_JEWELRY. Fashion jewelry
FAST_FOOD_RESTAURANTS. Fast Food Restaurants
FICTION_AND_NONFICTION. Fiction and nonfiction
FINANCE_COMPANY. Finance company
FINANCIAL_AND_INVESTMENT_ADVICE. Financial and investment advice
FINANCIAL_INSTITUTIONS_MERCHANDISE_AND_SERVICES. Financial Institutions - Merchandise And Services
FIREARM_ACCESSORIES. Firearm accessories
FIREARMS_WEAPONS_AND_KNIVES. Firearms, Weapons and Knives
FIREPLACE_AND_FIREPLACE_SCREENS. Fireplace, and fireplace screens
FIREWORKS. Fireworks
FISHING. Fishing
FLORISTS. Florists
FLOWERS. Flowers
FOOD_DRINK_AND_NUTRITION. Food, Drink & Nutrition
FOOD_PRODUCTS. Food Products
FOOD_RETAIL_AND_SERVICE. Food retail and service
FRAGRANCES_AND_PERFUMES. Fragrances and perfumes
FREEZER_AND_LOCKER_MEAT_PROVISIONERS. Freezer and Locker Meat Provisioners
FUEL_DEALERS_FUEL_OIL_WOOD_AND_COAL. Fuel Dealers-Fuel Oil, Wood & Coal
FUEL_DEALERS_NON_AUTOMOTIVE. Fuel Dealers - Non Automotive
FUNERAL_SERVICES_AND_CREMATORIES. Funeral Services & Crematories
FURNISHING_AND_DECORATING. Furnishing & Decorating
FURNITURE. Furniture
FURRIERS_AND_FUR_SHOPS. Furriers and Fur Shops
GADGETS_AND_OTHER_ELECTRONICS. Gadgets & other electronics
GAMBLING. Gambling
GAME_SOFTWARE. Game Software
GAMES. Games
GARDEN_SUPPLIES. Garden supplies
GENERAL. General
GENERAL_CONTRACTORS. General contractors
GENERAL_GOVERNMENT. General - Government
GENERAL_SOFTWARE. General - Software
GENERAL_TELECOM. General - Telecom
GIFTS_AND_FLOWERS. Gifts and flowers
GLASS_PAINT_AND_WALLPAPER_STORES. Glass,Paint,And Wallpaper Stores
GLASSWARE_CRYSTAL_STORES. Glassware, Crystal Stores
GOVERNMENT. Government
GOVERNMENT_IDS_AND_LICENSES. Government IDs and Licenses
GOVERNMENT_LICENSED_ON_LINE_CASINOS_ON_LINE_GAMBLING. Government Licensed On-Line Casinos - On-Line Gambling
GOVERNMENT_OWNED_LOTTERIES. Government-Owned Lotteries
GOVERNMENT_SERVICES. Government services
GRAPHIC_AND_COMMERCIAL_DESIGN. Graphic & Commercial Design
GREETING_CARDS. Greeting Cards
GROCERY_STORES_AND_SUPERMARKETS. Grocery Stores & Supermarkets
HARDWARE_AND_TOOLS. Hardware & Tools
HARDWARE_EQUIPMENT_AND_SUPPLIES. Hardware, Equipment, and Supplies
HAZARDOUS_RESTRICTED_AND_PERISHABLE_ITEMS. Hazardous, Restricted and Perishable Items
HEALTH_AND_BEAUTY_SPAS. Health and beauty spas
HEALTH_AND_NUTRITION. Health & Nutrition
HEALTH_AND_PERSONAL_CARE. Health and personal care
HEARING_AIDS_SALES_AND_SUPPLIES. Hearing Aids Sales and Supplies
HEATING_PLUMBING_AC. Heating, Plumbing, AC
HIGH_RISK_MERCHANT. High Risk Merchant
HIRING_SERVICES. Hiring services
HOBBIES_TOYS_AND_GAMES. Hobbies, Toys & Games
HOME_AND_GARDEN. Home and garden
HOME_AUDIO. Home Audio
HOME_DECOR. Home decor
HOME_ELECTRONICS. Home Electronics
HOSPITALS. Hospitals
HOTELS_MOTELS_INNS_RESORTS. Hotels/Motels/Inns/Resorts
HOUSEWARES. Housewares
HUMAN_PARTS_AND_REMAINS. Human Parts and Remains
HUMOROUS_GIFTS_AND_NOVELTIES. Humorous Gifts & Novelties
HUNTING. Hunting
IDS_LICENSES_AND_PASSPORTS. IDs, licenses, and passports
ILLEGAL_DRUGS_AND_PARAPHERNALIA. Illegal Drugs & Paraphernalia
INDUSTRIAL. Industrial
INDUSTRIAL_AND_MANUFACTURING_SUPPLIES. Industrial and manufacturing supplies
INSURANCE_AUTO_AND_HOME. Insurance - auto and home
INSURANCE_DIRECT. Insurance - Direct
INSURANCE_LIFE_AND_ANNUITY. Insurance - life and annuity
INSURANCE_SALES_UNDERWRITING. Insurance Sales/Underwriting
INSURANCE_UNDERWRITING_PREMIUMS. Insurance Underwriting, Premiums
INTERNET_AND_NETWORK_SERVICES. Internet & Network Services
INTRA_COMPANY_PURCHASES. Intra-Company Purchases
LABORATORIES_DENTAL_MEDICAL. Laboratories-Dental/Medical
LANDSCAPING. Landscaping
LANDSCAPING_AND_HORTICULTURAL_SERVICES. Landscaping And Horticultural Services
LAUNDRY_CLEANING_SERVICES. Laundry, Cleaning Services
LEGAL. Legal
LEGAL_SERVICES_AND_ATTORNEYS. Legal services and attorneys
LOCAL_DELIVERY_SERVICE. Local delivery service
LOCKSMITH. Locksmith
LODGING_AND_ACCOMMODATIONS. Lodging and accommodations
LOTTERY_AND_CONTESTS. Lottery and contests
LUGGAGE_AND_LEATHER_GOODS. Luggage and leather goods
LUMBER_AND_BUILDING_MATERIALS. Lumber & Building Materials
MAGAZINES. Magazines
MAINTENANCE_AND_REPAIR_SERVICES. Maintenance and repair services
MAKEUP_AND_COSMETICS. Makeup and cosmetics
MANUAL_CASH_DISBURSEMENTS. Manual Cash Disbursements
MASSAGE_PARLORS. Massage Parlors
MEDICAL. Medical
MEDICAL_AND_PHARMACEUTICAL. Medical & Pharmaceutical
MEDICAL_CARE. Medical care
MEDICAL_EQUIPMENT_AND_SUPPLIES. Medical equipment and supplies
MEDICAL_SERVICES. Medical Services
MEETING_PLANNERS. Meeting Planners
MEMBERSHIP_CLUBS_AND_ORGANIZATIONS. Membership clubs and organizations
MEMBERSHIP_COUNTRY_CLUBS_GOLF. Membership/Country Clubs/Golf
MEMORABILIA. Memorabilia
MEN_AND_BOY_CLOTHING_AND_ACCESSORY_STORES. Men's And Boy's Clothing And Accessory Stores
MEN_CLOTHING. Men's Clothing
MERCHANDISE. Merchandise
METAPHYSICAL. Metaphysical
MILITARIA. Militaria
MILITARY_AND_CIVIL_SERVICE_UNIFORMS. Military and civil service uniforms
MISC._AUTOMOTIVE_AIRCRAFT_AND_FARM_EQUIPMENT_DEALERS. Misc. Automotive,Aircraft,And Farm Equipment Dealers
MISC._GENERAL_MERCHANDISE. Misc. General Merchandise
MISCELLANEOUS_GENERAL_SERVICES. Miscellaneous General Services
MISCELLANEOUS_REPAIR_SHOPS_AND_RELATED_SERVICES. Miscellaneous Repair Shops And Related Services
MODEL_KITS. Model Kits
MONEY_TRANSFER_MEMBER_FINANCIAL_INSTITUTION. Money Transfer - Member Financial Institution
MONEY_TRANSFER_MERCHANT. Money Transfer--Merchant
MOTION_PICTURE_THEATERS. Motion Picture Theaters
MOTOR_FREIGHT_CARRIERS_AND_TRUCKING. Motor Freight Carriers & Trucking
MOTOR_HOME_AND_RECREATIONAL_VEHICLE_RENTAL. Motor Home And Recreational Vehicle Rental
MOTOR_HOMES_DEALERS. Motor Homes Dealers
MOTOR_VEHICLE_SUPPLIES_AND_NEW_PARTS. Motor Vehicle Supplies and New Parts
MOTORCYCLE_DEALERS. Motorcycle Dealers
MOTORCYCLES. Motorcycles
MOVIE. Movie
MOVIE_TICKETS. Movie tickets
MOVING_AND_STORAGE. Moving and storage
MULTI_LEVEL_MARKETING. Multi-level marketing
MUSIC_CDS_CASSETTES_AND_ALBUMS. Music - CDs, cassettes and albums
MUSIC_STORE_INSTRUMENTS_AND_SHEET_MUSIC. Music store - instruments and sheet music
NETWORKING. Networking
NEW_AGE. New Age
NEW_PARTS_AND_SUPPLIES_MOTOR_VEHICLE. New parts and supplies - motor vehicle
NEWS_DEALERS_AND_NEWSTANDS. News Dealers and Newstands
NON_DURABLE_GOODS. Non-durable goods
NON_FICTION. Non-Fiction
NON_PROFIT_POLITICAL_AND_RELIGION. Non-Profit, Political & Religion
NONPROFIT. Nonprofit
NOVELTIES. Novelties
OEM_SOFTWARE. Oem Software
OFFICE_SUPPLIES_AND_EQUIPMENT. Office Supplies and Equipment
ONLINE_DATING. Online Dating
ONLINE_GAMING. Online gaming
ONLINE_GAMING_CURRENCY. Online gaming currency
ONLINE_SERVICES. online services
OOUTBOUND_TELEMARKETING_MERCH. Ooutbound Telemarketing Merch
OPHTHALMOLOGISTS_OPTOMETRIST. Ophthalmologists/Optometrist
OPTICIANS_AND_DISPENSING. Opticians And Dispensing
ORTHOPEDIC_GOODS_PROSTHETICS. Orthopedic Goods/Prosthetics
OSTEOPATHS. Osteopaths
OTHER. Other
PACKAGE_TOUR_OPERATORS. Package Tour Operators
PAINTBALL. Paintball
PAINTS_VARNISHES_AND_SUPPLIES. Paints, Varnishes, and Supplies
PARKING_LOTS_AND_GARAGES. Parking Lots & Garages
PARTS_AND_ACCESSORIES. Parts and accessories
PAWN_SHOPS. Pawn Shops
PAYCHECK_LENDER_OR_CASH_ADVANCE. Paycheck lender or cash advance
PERIPHERALS. Peripherals
PERSONALIZED_GIFTS. Personalized Gifts
PET_SHOPS_PET_FOOD_AND_SUPPLIES. Pet shops, pet food, and supplies
PETROLEUM_AND_PETROLEUM_PRODUCTS. Petroleum and Petroleum Products
PETS_AND_ANIMALS. Pets and animals
PHOTOFINISHING_LABORATORIES_PHOTO_DEVELOPING. Photofinishing Laboratories,Photo Developing
PHOTOGRAPHIC_STUDIOS_PORTRAITS. Photographic studios - portraits
PHOTOGRAPHY. Photography
PHYSICAL_GOOD. Physical Good
PICTURE_VIDEO_PRODUCTION. Picture/Video Production
PIECE_GOODS_NOTIONS_AND_OTHER_DRY_GOODS. Piece Goods Notions and Other Dry Goods
PLANTS_AND_SEEDS. Plants and Seeds
PLUMBING_AND_HEATING_EQUIPMENTS_AND_SUPPLIES. Plumbing & Heating Equipments & Supplies
POLICE_RELATED_ITEMS. Police-Related Items
POLITICAL_ORGANIZATIONS. Politcal Organizations
POSTAL_SERVICES_GOVERNMENT_ONLY. Postal Services - Government Only
POSTERS. Posters
PREPAID_AND_STORED_VALUE_CARDS. Prepaid and stored value cards
PRESCRIPTION_DRUGS. Prescription Drugs
PROMOTIONAL_ITEMS. Promotional Items
PUBLIC_WAREHOUSING_AND_STORAGE. Public Warehousing and Storage
PUBLISHING_AND_PRINTING. Publishing and printing
PUBLISHING_SERVICES. Publishing Services
RADAR_DECTORS. Radar Dectors
RADIO_TELEVISION_AND_STEREO_REPAIR. Radio, television, and stereo repair
REAL_ESTATE. Real Estate
REAL_ESTATE_AGENT. Real estate agent
REAL_ESTATE_AGENTS_AND_MANAGERS_RENTALS. Real Estate Agents And Managers - Rentals
RELIGION_AND_SPIRITUALITY_FOR_PROFIT. Religion and spirituality for profit
RELIGIOUS. Religious
RELIGIOUS_ORGANIZATIONS. Religious Organizations
REMITTANCE. Remittance
RENTAL_PROPERTY_MANAGEMENT. Rental property management
RESIDENTIAL. Residential
RETAIL. Retail
RETAIL_FINE_JEWELRY_AND_WATCHES. Retail - fine jewelry and watches
REUPHOLSTERY_AND_FURNITURE_REPAIR. Reupholstery and furniture repair
RINGS. Rings
ROOFING_SIDING_SHEET_METAL. Roofing/Siding, Sheet Metal
RUGS_AND_CARPETS. Rugs & Carpets
SCHOOLS_AND_COLLEGES. Schools and Colleges
SCIENCE_FICTION. Science Fiction
SCRAPBOOKING. Scrapbooking
SCULPTURES. Sculptures
SECURITIES_BROKERS_AND_DEALERS. Securities - Brokers And Dealers
SECURITY_AND_SURVEILLANCE. Security and surveillance
SECURITY_AND_SURVEILLANCE_EQUIPMENT. Security and surveillance equipment
SECURITY_BROKERS_AND_DEALERS. Security brokers and dealers
SEMINARS. Seminars
SERVICE_STATIONS. Service Stations
SERVICES. Services
SEWING_NEEDLEWORK_FABRIC_AND_PIECE_GOODS_STORES. Sewing,Needlework,Fabric And Piece Goods Stores
SHIPPING_AND_PACKING. Shipping & Packaging
SHOE_REPAIR_HAT_CLEANING. Shoe Repair/Hat Cleaning
SHOE_STORES. Shoe Stores
SHOES. Shoes
SNOWMOBILE_DEALERS. Snowmobile Dealers
SOFTWARE. Software
SPECIALTY_AND_MISC._FOOD_STORES. Specialty and misc. food stores
SPECIALTY_CLEANING_POLISHING_AND_SANITATION_PREPARATIONS. Specialty Cleaning, Polishing And Sanitation Preparations
SPECIALTY_OR_RARE_PETS. Specialty or rare pets
SPORT_GAMES_AND_TOYS. Sport games and toys
SPORTING_AND_RECREATIONAL_CAMPS. Sporting And Recreational Camps
SPORTING_GOODS. Sporting Goods
SPORTS_AND_OUTDOORS. Sports and outdoors
SPORTS_AND_RECREATION. Sports & Recreation
STAMP_AND_COIN. Stamp and coin
STATIONARY_PRINTING_AND_WRITING_PAPER. Stationary, printing, and writing paper
STENOGRAPHIC_AND_SECRETARIAL_SUPPORT_SERVICES. Stenographic and secretarial support services
STOCKS_BONDS_SECURITIES_AND_RELATED_CERTIFICATES. Stocks, Bonds, Securities and Related Certificates
STORED_VALUE_CARDS. Stored Value Cards
SUPPLIES. Supplies
SUPPLIES_AND_TOYS. Supplies & Toys
SURVEILLANCE_EQUIPMENT. Surveillance Equipment
SWIMMING_POOLS_AND_SPAS. Swimming Pools & Spas
SWIMMING_POOLS_SALES_SUPPLIES_SERVICES. Swimming Pools-Sales,Supplies,Services
TAILORS_AND_ALTERATIONS. Tailors and alterations
TAX_PAYMENTS. Tax Payments
TAX_PAYMENTS_GOVERNMENT_AGENCIES. Tax Payments - Government Agencies
TAXICABS_AND_LIMOUSINES. Taxicabs and limousines
TELECOMMUNICATION_SERVICES. Telecommunication Services
TELEPHONE_CARDS. Telephone Cards
TELEPHONE_EQUIPMENT. Telephone Equipment
TELEPHONE_SERVICES. Telephone Services
THEATER. Theater
TIRE_RETREADING_AND_REPAIR. Tire Retreading and Repair
TOLL_OR_BRIDGE_FEES. Toll or Bridge Fees
TOOLS_AND_EQUIPMENT. Tools and equipment
TOURIST_ATTRACTIONS_AND_EXHIBITS. Tourist Attractions And Exhibits
TOWING_SERVICE. Towing service
TOYS_AND_GAMES. Toys and games
TRADE_AND_VOCATIONAL_SCHOOLS. Trade And Vocational Schools
TRADEMARK_INFRINGEMENT. Trademark Infringement
TRAILER_PARKS_AND_CAMPGROUNDS. Trailer Parks And Campgrounds
TRAINING_SERVICES. Training services
TRANSPORTATION_SERVICES. Transportation Services
TRAVEL. Travel
TRUCK_AND_UTILITY_TRAILER_RENTALS. Truck And Utility Trailer Rentals
TRUCK_STOP. Truck Stop
TYPESETTING_PLATE_MAKING_AND_RELATED_SERVICES. Typesetting, Plate Making, and Related Services
USED_MERCHANDISE_AND_SECONDHAND_STORES. Used Merchandise And Secondhand Stores
USED_PARTS_MOTOR_VEHICLE. Used parts - motor vehicle
UTILITIES. Utilities
UTILITIES_ELECTRIC_GAS_WATER_SANITARY. Utilities - Electric,Gas,Water,Sanitary
VARIETY_STORES. Variety Stores
VEHICLE_SALES. Vehicle sales
VEHICLE_SERVICE_AND_ACCESSORIES. Vehicle service and accessories
VIDEO_EQUIPMENT. Video Equipment
VIDEO_GAME_ARCADES_ESTABLISH. Video Game Arcades/Establish
VIDEO_GAMES_AND_SYSTEMS. Video Games & Systems
VIDEO_TAPE_RENTAL_STORES. Video Tape Rental Stores
VINTAGE_AND_COLLECTIBLE_VEHICLES. Vintage and Collectible Vehicles
VINTAGE_AND_COLLECTIBLES. Vintage and collectibles
VITAMINS_AND_SUPPLEMENTS. Vitamins & Supplements
VOCATIONAL_AND_TRADE_SCHOOLS. Vocational and trade schools
WATCH_CLOCK_AND_JEWELRY_REPAIR. Watch, clock, and jewelry repair
WEB_HOSTING_AND_DESIGN. Web hosting and design
WELDING_REPAIR. Welding Repair
WHOLESALE_CLUBS. Wholesale Clubs
WHOLESALE_FLORIST_SUPPLIERS. Wholesale Florist Suppliers
WHOLESALE_PRESCRIPTION_DRUGS. Wholesale Prescription Drugs
WILDLIFE_PRODUCTS. Wildlife Products
WIRE_TRANSFER. Wire Transfer
WIRE_TRANSFER_AND_MONEY_ORDER. Wire transfer and money order
WOMEN_ACCESSORY_SPECIALITY. Women's Accessory/Speciality
WOMEN_CLOTHING. Women's clothing
Minimum length: 4.

Maximum length: 256.

Pattern: ^[A-Z_]+$.

product_collection
Collapse
linksarray (contains the link_description object)
An array of request-related HATEOAS links.

Read only.

productsarray (contains the product_collection_element object)
An array of products.

total_itemsinteger
The total number of items.

Maximum value: 500000000.

total_pagesinteger
The total number of pages.

Maximum value: 100000000.

product_collection_element
Collapse
create_timestring
The date and time when the product was created, in Internet date and time format.

Read only.

descriptionstring
The product description.

Minimum length: 1.

Maximum length: 256.

idstring
The ID of the product.

Read only.

Minimum length: 6.

Maximum length: 50.

linksarray (contains the link_description object)
An array of request-related HATEOAS links.

Read only.

namestring
The product name.

Minimum length: 1.

Maximum length: 127.

product_request
Collapse
namestringrequired
The product name.

Minimum length: 1.

Maximum length: 127.

typeenumrequired
The product type. Indicates whether the product is physical or tangible goods, or a service.

The possible values are:

PHYSICAL. Physical goods.
DIGITAL. Digital goods.
SERVICE. A service. For example, technical support.
Minimum length: 1.

Maximum length: 24.

Pattern: ^[A-Z_]+$.

categoryenum
The product category.

The possible values are:

AC_REFRIGERATION_REPAIR. A/C, Refrigeration Repair
ACADEMIC_SOFTWARE. Academic Software
ACCESSORIES. Accessories
ACCOUNTING. Accounting
ADULT. Adult
ADVERTISING. Advertising
AFFILIATED_AUTO_RENTAL. Affiliated Auto Rental
AGENCIES. Agencies
AGGREGATORS. Aggregators
AGRICULTURAL_COOPERATIVE_FOR_MAIL_ORDER. Agricultural Cooperative for Mail Order
AIR_CARRIERS_AIRLINES. Air Carriers, Airlines
AIRLINES. Airlines
AIRPORTS_FLYING_FIELDS. Airports, Flying Fields
ALCOHOLIC_BEVERAGES. Alcoholic Beverages
AMUSEMENT_PARKS_CARNIVALS. Amusement Parks/Carnivals
ANIMATION. Animation
ANTIQUES. Antiques
APPLIANCES. Appliances
AQUARIAMS_SEAQUARIUMS_DOLPHINARIUMS. Aquariams Seaquariums Dolphinariums
ARCHITECTURAL_ENGINEERING_AND_SURVEYING_SERVICES. Architectural,Engineering,And Surveying Services
ART_AND_CRAFT_SUPPLIES. Art & Craft Supplies
ART_DEALERS_AND_GALLERIES. Art dealers and galleries
ARTIFACTS_GRAVE_RELATED_AND_NATIVE_AMERICAN_CRAFTS. Artifacts, Grave related, and Native American Crafts
ARTS_AND_CRAFTS. Arts and crafts
ARTS_CRAFTS_AND_COLLECTIBLES. Arts, crafts, and collectibles
AUDIO_BOOKS. Audio books
AUTO_ASSOCIATIONS_CLUBS. Auto Associations/Clubs
AUTO_DEALER_USED_ONLY. Auto dealer - used only
AUTO_RENTALS. Auto Rentals
AUTO_SERVICE. Auto service
AUTOMATED_FUEL_DISPENSERS. Automated Fuel Dispensers
AUTOMOBILE_ASSOCIATIONS. Automobile Associations
AUTOMOTIVE. Automotive
AUTOMOTIVE_REPAIR_SHOPS_NON_DEALER. Automotive Repair Shops - Non-Dealer
AUTOMOTIVE_TOP_AND_BODY_SHOPS. Automotive Top And Body Shops
AVIATION. Aviation
BABIES_CLOTHING_AND_SUPPLIES. Babies Clothing & Supplies
BABY. Baby
BANDS_ORCHESTRAS_ENTERTAINERS. Bands,Orchestras,Entertainers
BARBIES. Barbies
BATH_AND_BODY. Bath and body
BATTERIES. Batteries
BEAN_BABIES. Bean Babies
BEAUTY. Beauty
BEAUTY_AND_FRAGRANCES. Beauty and fragrances
BED_AND_BATH. Bed & Bath
BICYCLE_SHOPS_SALES_AND_SERVICE. Bicycle Shops-Sales And Service
BICYCLES_AND_ACCESSORIES. Bicycles & Accessories
BILLIARD_POOL_ESTABLISHMENTS. Billiard/Pool Establishments
BOAT_DEALERS. Boat Dealers
BOAT_RENTALS_AND_LEASING. Boat Rentals And Leasing
BOATING_SAILING_AND_ACCESSORIES. Boating, sailing and accessories
BOOKS. Books
BOOKS_AND_MAGAZINES. Books and magazines
BOOKS_MANUSCRIPTS. Books, Manuscripts
BOOKS_PERIODICALS_AND_NEWSPAPERS. Books, Periodicals And Newspapers
BOWLING_ALLEYS. Bowling Alleys
BULLETIN_BOARD. Bulletin board
BUS_LINE. Bus line
BUS_LINES_CHARTERS_TOUR_BUSES. Bus Lines,Charters,Tour Buses
BUSINESS. Business
BUSINESS_AND_SECRETARIAL_SCHOOLS. Business and secretarial schools
BUYING_AND_SHOPPING_SERVICES_AND_CLUBS. Buying And Shopping Services And Clubs
CABLE_SATELLITE_AND_OTHER_PAY_TELEVISION_AND_RADIO_SERVICES. Cable,Satellite,And Other Pay Television And Radio Services
CABLE_SATELLITE_AND_OTHER_PAY_TV_AND_RADIO. Cable, satellite, and other pay TV and radio
CAMERA_AND_PHOTOGRAPHIC_SUPPLIES. Camera and photographic supplies
CAMERAS. Cameras
CAMERAS_AND_PHOTOGRAPHY. Cameras & Photography
CAMPER_RECREATIONAL_AND_UTILITY_TRAILER_DEALERS. Camper,Recreational And Utility Trailer Dealers
CAMPING_AND_OUTDOORS. Camping and outdoors
CAMPING_AND_SURVIVAL. Camping & Survival
CAR_AND_TRUCK_DEALERS. Car And Truck Dealers
CAR_AND_TRUCK_DEALERS_USED_ONLY. Car And Truck Dealers - Used Only
CAR_AUDIO_AND_ELECTRONICS. Car Audio & Electronics
CAR_RENTAL_AGENCY. Car rental agency
CATALOG_MERCHANT. Catalog Merchant
CATALOG_RETAIL_MERCHANT. Catalog/Retail Merchant
CATERING_SERVICES. Catering services
CHARITY. Charity
CHECK_CASHIER. Check Cashier
CHILD_CARE_SERVICES. Child Care Services
CHILDREN_BOOKS. Children Books
CHIROPODISTS_PODIATRISTS. Chiropodists/Podiatrists
CHIROPRACTORS. Chiropractors
CIGAR_STORES_AND_STANDS. Cigar Stores And Stands
CIVIC_SOCIAL_FRATERNAL_ASSOCIATIONS. Civic, Social, Fraternal Associations
CIVIL_SOCIAL_FRAT_ASSOCIATIONS. Civil/Social/Frat Associations
CLOTHING. Clothing
CLOTHING_ACCESSORIES_AND_SHOES. Clothing, accessories, and shoes
CLOTHING_RENTAL. Clothing Rental
COFFEE_AND_TEA. Coffee and tea
COIN_OPERATED_BANKS_AND_CASINOS. Coin Operated Banks & Casinos
COLLECTIBLES. Collectibles
COLLECTION_AGENCY. Collection agency
COLLEGES_AND_UNIVERSITIES. Colleges and universities
COMMERCIAL_EQUIPMENT. Commercial Equipment
COMMERCIAL_FOOTWEAR. Commercial Footwear
COMMERCIAL_PHOTOGRAPHY. Commercial photography
COMMERCIAL_PHOTOGRAPHY_ART_AND_GRAPHICS. Commercial photography, art, and graphics
COMMERCIAL_SPORTS_PROFESSIONA. Commercial Sports/Professiona
COMMODITIES_AND_FUTURES_EXCHANGE. Commodities and futures exchange
COMPUTER_AND_DATA_PROCESSING_SERVICES. Computer and data processing services
COMPUTER_HARDWARE_AND_SOFTWARE. Computer Hardware & Software
COMPUTER_MAINTENANCE_REPAIR_AND_SERVICES_NOT_ELSEWHERE_CLAS. Computer Maintenance, Repair And Services Not Elsewhere Clas
CONSTRUCTION. Construction
CONSTRUCTION_MATERIALS_NOT_ELSEWHERE_CLASSIFIED. Construction Materials Not Elsewhere Classified
CONSULTING_SERVICES. Consulting services
CONSUMER_CREDIT_REPORTING_AGENCIES. Consumer Credit Reporting Agencies
CONVALESCENT_HOMES. Convalescent Homes
COSMETIC_STORES. Cosmetic Stores
COUNSELING_SERVICES_DEBT_MARRIAGE_PERSONAL. Counseling Services--Debt,Marriage,Personal
COUNTERFEIT_CURRENCY_AND_STAMPS. Counterfeit Currency and Stamps
COUNTERFEIT_ITEMS. Counterfeit Items
COUNTRY_CLUBS. Country Clubs
COURIER_SERVICES. Courier services
COURIER_SERVICES_AIR_AND_GROUND_AND_FREIGHT_FORWARDERS. Courier Services-Air And Ground,And Freight Forwarders
COURT_COSTS_ALIMNY_CHILD_SUPT. Court Costs/Alimny/Child Supt
COURT_COSTS_INCLUDING_ALIMONY_AND_CHILD_SUPPORT_COURTS_OF_LAW. Court Costs, Including Alimony and Child Support - Courts of Law
CREDIT_CARDS. Credit Cards
CREDIT_UNION. Credit union
CULTURE_AND_RELIGION. Culture & Religion
DAIRY_PRODUCTS_STORES. Dairy Products Stores
DANCE_HALLS_STUDIOS_AND_SCHOOLS. Dance Halls,Studios,And Schools
DECORATIVE. Decorative
DENTAL. Dental
DENTISTS_AND_ORTHODONTISTS. Dentists And Orthodontists
DEPARTMENT_STORES. Department Stores
DESKTOP_PCS. Desktop PCs
DEVICES. Devices
DIECAST_TOYS_VEHICLES. Diecast, Toys Vehicles
DIGITAL_GAMES. Digital games
DIGITAL_MEDIA_BOOKS_MOVIES_MUSIC. Digital media,books,movies,music
DIRECT_MARKETING. Direct Marketing
DIRECT_MARKETING_CATALOG_MERCHANT. Direct Marketing - Catalog Merchant
DIRECT_MARKETING_INBOUND_TELE. Direct Marketing - Inbound Tele
DIRECT_MARKETING_OUTBOUND_TELE. Direct Marketing - Outbound Tele
DIRECT_MARKETING_SUBSCRIPTION. Direct Marketing - Subscription
DISCOUNT_STORES. Discount Stores
DOOR_TO_DOOR_SALES. Door-To-Door Sales
DRAPERY_WINDOW_COVERING_AND_UPHOLSTERY. Drapery, window covering, and upholstery
DRINKING_PLACES. Drinking Places
DRUGSTORE. Drugstore
DURABLE_GOODS. Durable goods
ECOMMERCE_DEVELOPMENT. eCommerce Development
ECOMMERCE_SERVICES. eCommerce Services
EDUCATIONAL_AND_TEXTBOOKS. Educational and textbooks
ELECTRIC_RAZOR_STORES. Electric Razor Stores
ELECTRICAL_AND_SMALL_APPLIANCE_REPAIR. Electrical and small appliance repair
ELECTRICAL_CONTRACTORS. Electrical Contractors
ELECTRICAL_PARTS_AND_EQUIPMENT. Electrical Parts and Equipment
ELECTRONIC_CASH. Electronic Cash
ELEMENTARY_AND_SECONDARY_SCHOOLS. Elementary and secondary schools
EMPLOYMENT. Employment
ENTERTAINERS. Entertainers
ENTERTAINMENT_AND_MEDIA. Entertainment and media
EQUIP_TOOL_FURNITURE_AND_APPLIANCE_RENTAL_AND_LEASING. Equip, Tool, Furniture, And Appliance Rental And Leasing
ESCROW. Escrow
EVENT_AND_WEDDING_PLANNING. Event & Wedding Planning
EXERCISE_AND_FITNESS. Exercise and fitness
EXERCISE_EQUIPMENT. Exercise Equipment
EXTERMINATING_AND_DISINFECTING_SERVICES. Exterminating and disinfecting services
FABRICS_AND_SEWING. Fabrics & Sewing
FAMILY_CLOTHING_STORES. Family Clothing Stores
FASHION_JEWELRY. Fashion jewelry
FAST_FOOD_RESTAURANTS. Fast Food Restaurants
FICTION_AND_NONFICTION. Fiction and nonfiction
FINANCE_COMPANY. Finance company
FINANCIAL_AND_INVESTMENT_ADVICE. Financial and investment advice
FINANCIAL_INSTITUTIONS_MERCHANDISE_AND_SERVICES. Financial Institutions - Merchandise And Services
FIREARM_ACCESSORIES. Firearm accessories
FIREARMS_WEAPONS_AND_KNIVES. Firearms, Weapons and Knives
FIREPLACE_AND_FIREPLACE_SCREENS. Fireplace, and fireplace screens
FIREWORKS. Fireworks
FISHING. Fishing
FLORISTS. Florists
FLOWERS. Flowers
FOOD_DRINK_AND_NUTRITION. Food, Drink & Nutrition
FOOD_PRODUCTS. Food Products
FOOD_RETAIL_AND_SERVICE. Food retail and service
FRAGRANCES_AND_PERFUMES. Fragrances and perfumes
FREEZER_AND_LOCKER_MEAT_PROVISIONERS. Freezer and Locker Meat Provisioners
FUEL_DEALERS_FUEL_OIL_WOOD_AND_COAL. Fuel Dealers-Fuel Oil, Wood & Coal
FUEL_DEALERS_NON_AUTOMOTIVE. Fuel Dealers - Non Automotive
FUNERAL_SERVICES_AND_CREMATORIES. Funeral Services & Crematories
FURNISHING_AND_DECORATING. Furnishing & Decorating
FURNITURE. Furniture
FURRIERS_AND_FUR_SHOPS. Furriers and Fur Shops
GADGETS_AND_OTHER_ELECTRONICS. Gadgets & other electronics
GAMBLING. Gambling
GAME_SOFTWARE. Game Software
GAMES. Games
GARDEN_SUPPLIES. Garden supplies
GENERAL. General
GENERAL_CONTRACTORS. General contractors
GENERAL_GOVERNMENT. General - Government
GENERAL_SOFTWARE. General - Software
GENERAL_TELECOM. General - Telecom
GIFTS_AND_FLOWERS. Gifts and flowers
GLASS_PAINT_AND_WALLPAPER_STORES. Glass,Paint,And Wallpaper Stores
GLASSWARE_CRYSTAL_STORES. Glassware, Crystal Stores
GOVERNMENT. Government
GOVERNMENT_IDS_AND_LICENSES. Government IDs and Licenses
GOVERNMENT_LICENSED_ON_LINE_CASINOS_ON_LINE_GAMBLING. Government Licensed On-Line Casinos - On-Line Gambling
GOVERNMENT_OWNED_LOTTERIES. Government-Owned Lotteries
GOVERNMENT_SERVICES. Government services
GRAPHIC_AND_COMMERCIAL_DESIGN. Graphic & Commercial Design
GREETING_CARDS. Greeting Cards
GROCERY_STORES_AND_SUPERMARKETS. Grocery Stores & Supermarkets
HARDWARE_AND_TOOLS. Hardware & Tools
HARDWARE_EQUIPMENT_AND_SUPPLIES. Hardware, Equipment, and Supplies
HAZARDOUS_RESTRICTED_AND_PERISHABLE_ITEMS. Hazardous, Restricted and Perishable Items
HEALTH_AND_BEAUTY_SPAS. Health and beauty spas
HEALTH_AND_NUTRITION. Health & Nutrition
HEALTH_AND_PERSONAL_CARE. Health and personal care
HEARING_AIDS_SALES_AND_SUPPLIES. Hearing Aids Sales and Supplies
HEATING_PLUMBING_AC. Heating, Plumbing, AC
HIGH_RISK_MERCHANT. High Risk Merchant
HIRING_SERVICES. Hiring services
HOBBIES_TOYS_AND_GAMES. Hobbies, Toys & Games
HOME_AND_GARDEN. Home and garden
HOME_AUDIO. Home Audio
HOME_DECOR. Home decor
HOME_ELECTRONICS. Home Electronics
HOSPITALS. Hospitals
HOTELS_MOTELS_INNS_RESORTS. Hotels/Motels/Inns/Resorts
HOUSEWARES. Housewares
HUMAN_PARTS_AND_REMAINS. Human Parts and Remains
HUMOROUS_GIFTS_AND_NOVELTIES. Humorous Gifts & Novelties
HUNTING. Hunting
IDS_LICENSES_AND_PASSPORTS. IDs, licenses, and passports
ILLEGAL_DRUGS_AND_PARAPHERNALIA. Illegal Drugs & Paraphernalia
INDUSTRIAL. Industrial
INDUSTRIAL_AND_MANUFACTURING_SUPPLIES. Industrial and manufacturing supplies
INSURANCE_AUTO_AND_HOME. Insurance - auto and home
INSURANCE_DIRECT. Insurance - Direct
INSURANCE_LIFE_AND_ANNUITY. Insurance - life and annuity
INSURANCE_SALES_UNDERWRITING. Insurance Sales/Underwriting
INSURANCE_UNDERWRITING_PREMIUMS. Insurance Underwriting, Premiums
INTERNET_AND_NETWORK_SERVICES. Internet & Network Services
INTRA_COMPANY_PURCHASES. Intra-Company Purchases
LABORATORIES_DENTAL_MEDICAL. Laboratories-Dental/Medical
LANDSCAPING. Landscaping
LANDSCAPING_AND_HORTICULTURAL_SERVICES. Landscaping And Horticultural Services
LAUNDRY_CLEANING_SERVICES. Laundry, Cleaning Services
LEGAL. Legal
LEGAL_SERVICES_AND_ATTORNEYS. Legal services and attorneys
LOCAL_DELIVERY_SERVICE. Local delivery service
LOCKSMITH. Locksmith
LODGING_AND_ACCOMMODATIONS. Lodging and accommodations
LOTTERY_AND_CONTESTS. Lottery and contests
LUGGAGE_AND_LEATHER_GOODS. Luggage and leather goods
LUMBER_AND_BUILDING_MATERIALS. Lumber & Building Materials
MAGAZINES. Magazines
MAINTENANCE_AND_REPAIR_SERVICES. Maintenance and repair services
MAKEUP_AND_COSMETICS. Makeup and cosmetics
MANUAL_CASH_DISBURSEMENTS. Manual Cash Disbursements
MASSAGE_PARLORS. Massage Parlors
MEDICAL. Medical
MEDICAL_AND_PHARMACEUTICAL. Medical & Pharmaceutical
MEDICAL_CARE. Medical care
MEDICAL_EQUIPMENT_AND_SUPPLIES. Medical equipment and supplies
MEDICAL_SERVICES. Medical Services
MEETING_PLANNERS. Meeting Planners
MEMBERSHIP_CLUBS_AND_ORGANIZATIONS. Membership clubs and organizations
MEMBERSHIP_COUNTRY_CLUBS_GOLF. Membership/Country Clubs/Golf
MEMORABILIA. Memorabilia
MEN_AND_BOY_CLOTHING_AND_ACCESSORY_STORES. Men's And Boy's Clothing And Accessory Stores
MEN_CLOTHING. Men's Clothing
MERCHANDISE. Merchandise
METAPHYSICAL. Metaphysical
MILITARIA. Militaria
MILITARY_AND_CIVIL_SERVICE_UNIFORMS. Military and civil service uniforms
MISC._AUTOMOTIVE_AIRCRAFT_AND_FARM_EQUIPMENT_DEALERS. Misc. Automotive,Aircraft,And Farm Equipment Dealers
MISC._GENERAL_MERCHANDISE. Misc. General Merchandise
MISCELLANEOUS_GENERAL_SERVICES. Miscellaneous General Services
MISCELLANEOUS_REPAIR_SHOPS_AND_RELATED_SERVICES. Miscellaneous Repair Shops And Related Services
MODEL_KITS. Model Kits
MONEY_TRANSFER_MEMBER_FINANCIAL_INSTITUTION. Money Transfer - Member Financial Institution
MONEY_TRANSFER_MERCHANT. Money Transfer--Merchant
MOTION_PICTURE_THEATERS. Motion Picture Theaters
MOTOR_FREIGHT_CARRIERS_AND_TRUCKING. Motor Freight Carriers & Trucking
MOTOR_HOME_AND_RECREATIONAL_VEHICLE_RENTAL. Motor Home And Recreational Vehicle Rental
MOTOR_HOMES_DEALERS. Motor Homes Dealers
MOTOR_VEHICLE_SUPPLIES_AND_NEW_PARTS. Motor Vehicle Supplies and New Parts
MOTORCYCLE_DEALERS. Motorcycle Dealers
MOTORCYCLES. Motorcycles
MOVIE. Movie
MOVIE_TICKETS. Movie tickets
MOVING_AND_STORAGE. Moving and storage
MULTI_LEVEL_MARKETING. Multi-level marketing
MUSIC_CDS_CASSETTES_AND_ALBUMS. Music - CDs, cassettes and albums
MUSIC_STORE_INSTRUMENTS_AND_SHEET_MUSIC. Music store - instruments and sheet music
NETWORKING. Networking
NEW_AGE. New Age
NEW_PARTS_AND_SUPPLIES_MOTOR_VEHICLE. New parts and supplies - motor vehicle
NEWS_DEALERS_AND_NEWSTANDS. News Dealers and Newstands
NON_DURABLE_GOODS. Non-durable goods
NON_FICTION. Non-Fiction
NON_PROFIT_POLITICAL_AND_RELIGION. Non-Profit, Political & Religion
NONPROFIT. Nonprofit
NOVELTIES. Novelties
OEM_SOFTWARE. Oem Software
OFFICE_SUPPLIES_AND_EQUIPMENT. Office Supplies and Equipment
ONLINE_DATING. Online Dating
ONLINE_GAMING. Online gaming
ONLINE_GAMING_CURRENCY. Online gaming currency
ONLINE_SERVICES. online services
OOUTBOUND_TELEMARKETING_MERCH. Ooutbound Telemarketing Merch
OPHTHALMOLOGISTS_OPTOMETRIST. Ophthalmologists/Optometrist
OPTICIANS_AND_DISPENSING. Opticians And Dispensing
ORTHOPEDIC_GOODS_PROSTHETICS. Orthopedic Goods/Prosthetics
OSTEOPATHS. Osteopaths
OTHER. Other
PACKAGE_TOUR_OPERATORS. Package Tour Operators
PAINTBALL. Paintball
PAINTS_VARNISHES_AND_SUPPLIES. Paints, Varnishes, and Supplies
PARKING_LOTS_AND_GARAGES. Parking Lots & Garages
PARTS_AND_ACCESSORIES. Parts and accessories
PAWN_SHOPS. Pawn Shops
PAYCHECK_LENDER_OR_CASH_ADVANCE. Paycheck lender or cash advance
PERIPHERALS. Peripherals
PERSONALIZED_GIFTS. Personalized Gifts
PET_SHOPS_PET_FOOD_AND_SUPPLIES. Pet shops, pet food, and supplies
PETROLEUM_AND_PETROLEUM_PRODUCTS. Petroleum and Petroleum Products
PETS_AND_ANIMALS. Pets and animals
PHOTOFINISHING_LABORATORIES_PHOTO_DEVELOPING. Photofinishing Laboratories,Photo Developing
PHOTOGRAPHIC_STUDIOS_PORTRAITS. Photographic studios - portraits
PHOTOGRAPHY. Photography
PHYSICAL_GOOD. Physical Good
PICTURE_VIDEO_PRODUCTION. Picture/Video Production
PIECE_GOODS_NOTIONS_AND_OTHER_DRY_GOODS. Piece Goods Notions and Other Dry Goods
PLANTS_AND_SEEDS. Plants and Seeds
PLUMBING_AND_HEATING_EQUIPMENTS_AND_SUPPLIES. Plumbing & Heating Equipments & Supplies
POLICE_RELATED_ITEMS. Police-Related Items
POLITICAL_ORGANIZATIONS. Politcal Organizations
POSTAL_SERVICES_GOVERNMENT_ONLY. Postal Services - Government Only
POSTERS. Posters
PREPAID_AND_STORED_VALUE_CARDS. Prepaid and stored value cards
PRESCRIPTION_DRUGS. Prescription Drugs
PROMOTIONAL_ITEMS. Promotional Items
PUBLIC_WAREHOUSING_AND_STORAGE. Public Warehousing and Storage
PUBLISHING_AND_PRINTING. Publishing and printing
PUBLISHING_SERVICES. Publishing Services
RADAR_DECTORS. Radar Dectors
RADIO_TELEVISION_AND_STEREO_REPAIR. Radio, television, and stereo repair
REAL_ESTATE. Real Estate
REAL_ESTATE_AGENT. Real estate agent
REAL_ESTATE_AGENTS_AND_MANAGERS_RENTALS. Real Estate Agents And Managers - Rentals
RELIGION_AND_SPIRITUALITY_FOR_PROFIT. Religion and spirituality for profit
RELIGIOUS. Religious
RELIGIOUS_ORGANIZATIONS. Religious Organizations
REMITTANCE. Remittance
RENTAL_PROPERTY_MANAGEMENT. Rental property management
RESIDENTIAL. Residential
RETAIL. Retail
RETAIL_FINE_JEWELRY_AND_WATCHES. Retail - fine jewelry and watches
REUPHOLSTERY_AND_FURNITURE_REPAIR. Reupholstery and furniture repair
RINGS. Rings
ROOFING_SIDING_SHEET_METAL. Roofing/Siding, Sheet Metal
RUGS_AND_CARPETS. Rugs & Carpets
SCHOOLS_AND_COLLEGES. Schools and Colleges
SCIENCE_FICTION. Science Fiction
SCRAPBOOKING. Scrapbooking
SCULPTURES. Sculptures
SECURITIES_BROKERS_AND_DEALERS. Securities - Brokers And Dealers
SECURITY_AND_SURVEILLANCE. Security and surveillance
SECURITY_AND_SURVEILLANCE_EQUIPMENT. Security and surveillance equipment
SECURITY_BROKERS_AND_DEALERS. Security brokers and dealers
SEMINARS. Seminars
SERVICE_STATIONS. Service Stations
SERVICES. Services
SEWING_NEEDLEWORK_FABRIC_AND_PIECE_GOODS_STORES. Sewing,Needlework,Fabric And Piece Goods Stores
SHIPPING_AND_PACKING. Shipping & Packaging
SHOE_REPAIR_HAT_CLEANING. Shoe Repair/Hat Cleaning
SHOE_STORES. Shoe Stores
SHOES. Shoes
SNOWMOBILE_DEALERS. Snowmobile Dealers
SOFTWARE. Software
SPECIALTY_AND_MISC._FOOD_STORES. Specialty and misc. food stores
SPECIALTY_CLEANING_POLISHING_AND_SANITATION_PREPARATIONS. Specialty Cleaning, Polishing And Sanitation Preparations
SPECIALTY_OR_RARE_PETS. Specialty or rare pets
SPORT_GAMES_AND_TOYS. Sport games and toys
SPORTING_AND_RECREATIONAL_CAMPS. Sporting And Recreational Camps
SPORTING_GOODS. Sporting Goods
SPORTS_AND_OUTDOORS. Sports and outdoors
SPORTS_AND_RECREATION. Sports & Recreation
STAMP_AND_COIN. Stamp and coin
STATIONARY_PRINTING_AND_WRITING_PAPER. Stationary, printing, and writing paper
STENOGRAPHIC_AND_SECRETARIAL_SUPPORT_SERVICES. Stenographic and secretarial support services
STOCKS_BONDS_SECURITIES_AND_RELATED_CERTIFICATES. Stocks, Bonds, Securities and Related Certificates
STORED_VALUE_CARDS. Stored Value Cards
SUPPLIES. Supplies
SUPPLIES_AND_TOYS. Supplies & Toys
SURVEILLANCE_EQUIPMENT. Surveillance Equipment
SWIMMING_POOLS_AND_SPAS. Swimming Pools & Spas
SWIMMING_POOLS_SALES_SUPPLIES_SERVICES. Swimming Pools-Sales,Supplies,Services
TAILORS_AND_ALTERATIONS. Tailors and alterations
TAX_PAYMENTS. Tax Payments
TAX_PAYMENTS_GOVERNMENT_AGENCIES. Tax Payments - Government Agencies
TAXICABS_AND_LIMOUSINES. Taxicabs and limousines
TELECOMMUNICATION_SERVICES. Telecommunication Services
TELEPHONE_CARDS. Telephone Cards
TELEPHONE_EQUIPMENT. Telephone Equipment
TELEPHONE_SERVICES. Telephone Services
THEATER. Theater
TIRE_RETREADING_AND_REPAIR. Tire Retreading and Repair
TOLL_OR_BRIDGE_FEES. Toll or Bridge Fees
TOOLS_AND_EQUIPMENT. Tools and equipment
TOURIST_ATTRACTIONS_AND_EXHIBITS. Tourist Attractions And Exhibits
TOWING_SERVICE. Towing service
TOYS_AND_GAMES. Toys and games
TRADE_AND_VOCATIONAL_SCHOOLS. Trade And Vocational Schools
TRADEMARK_INFRINGEMENT. Trademark Infringement
TRAILER_PARKS_AND_CAMPGROUNDS. Trailer Parks And Campgrounds
TRAINING_SERVICES. Training services
TRANSPORTATION_SERVICES. Transportation Services
TRAVEL. Travel
TRUCK_AND_UTILITY_TRAILER_RENTALS. Truck And Utility Trailer Rentals
TRUCK_STOP. Truck Stop
TYPESETTING_PLATE_MAKING_AND_RELATED_SERVICES. Typesetting, Plate Making, and Related Services
USED_MERCHANDISE_AND_SECONDHAND_STORES. Used Merchandise And Secondhand Stores
USED_PARTS_MOTOR_VEHICLE. Used parts - motor vehicle
UTILITIES. Utilities
UTILITIES_ELECTRIC_GAS_WATER_SANITARY. Utilities - Electric,Gas,Water,Sanitary
VARIETY_STORES. Variety Stores
VEHICLE_SALES. Vehicle sales
VEHICLE_SERVICE_AND_ACCESSORIES. Vehicle service and accessories
VIDEO_EQUIPMENT. Video Equipment
VIDEO_GAME_ARCADES_ESTABLISH. Video Game Arcades/Establish
VIDEO_GAMES_AND_SYSTEMS. Video Games & Systems
VIDEO_TAPE_RENTAL_STORES. Video Tape Rental Stores
VINTAGE_AND_COLLECTIBLE_VEHICLES. Vintage and Collectible Vehicles
VINTAGE_AND_COLLECTIBLES. Vintage and collectibles
VITAMINS_AND_SUPPLEMENTS. Vitamins & Supplements
VOCATIONAL_AND_TRADE_SCHOOLS. Vocational and trade schools
WATCH_CLOCK_AND_JEWELRY_REPAIR. Watch, clock, and jewelry repair
WEB_HOSTING_AND_DESIGN. Web hosting and design
WELDING_REPAIR. Welding Repair
WHOLESALE_CLUBS. Wholesale Clubs
WHOLESALE_FLORIST_SUPPLIERS. Wholesale Florist Suppliers
WHOLESALE_PRESCRIPTION_DRUGS. Wholesale Prescription Drugs
WILDLIFE_PRODUCTS. Wildlife Products
WIRE_TRANSFER. Wire Transfer
WIRE_TRANSFER_AND_MONEY_ORDER. Wire transfer and money order
WOMEN_ACCESSORY_SPECIALITY. Women's Accessory/Speciality
WOMEN_CLOTHING. Women's clothing
descriptionstring
The product description.

Minimum length: 1.

Maximum length: 256.

home_urlstring
The home page URL for the product.

Minimum length: 1.

Maximum length: 2000.

idstring
The ID of the product. You can specify the SKU for the product. If you omit the ID, the system generates it. System-generated IDs have the PROD- prefix.

Minimum length: 6.

Maximum length: 50.

image_urlstring
The image URL for the product.

Minimum length: 1.

Maximum length:
BEGIN :
:Build:: 
!#/usr/bin/bash/

builds_script//POST/NPORT \
const:CONSTRUCTION :
"CONSTRUCTION":
'"build_script":'' 
'"{{{{'$'' '{{[((c).(r))[12753750.[00]m](BITORE_34173.1337_188931)'' ')']}}'' '}}}}'"''":,'' :
:Build:: :
Additional API information
Reference
PayPal.com
Privacy
Support
Legal
Contact
Navigated to Catalog Products API
Web searchCopy
Feedback SurveyClose

Active 

EARNINGS RELEASE FINANCIAL SUPPLEMENT
FOURTH QUARTER 2020

JPMORGAN CHASE & CO.
TABLE OF CONTENTS

Page(s)

Consolidated Results
Consolidated Financial Highlights 2â€“3
Consolidated Statements of Income 4
Consolidated Balance Sheets 5
Condensed Average Balance Sheets and Annualized Yields 6
Reconciliation from Reported to Managed Basis 7
Segment Results - Managed Basis 8
Capital and Other Selected Balance Sheet Items 9
Earnings Per Share and Related Information 10
Business Segment Results
Consumer & Community Banking (â€œCCBâ€) 11â€“14
Corporate & Investment Bank (â€œCIBâ€) 15â€“17
Commercial Banking (â€œCBâ€) 18â€“19
Asset & Wealth Management (â€œAWMâ€) 20â€“22
Corporate 23
Credit-Related Information 24â€“27
Non-GAAP Financial Measures 28
J.P. Morgan Wealth Management Reorganization 29
Glossary of Terms and Acronyms (a)
(a) Refer to the Glossary of Terms and Acronyms on pages 293â€“299 of JPMorgan Chase & Co.â€™s (the â€œFirmâ€™sâ€) Annual Report on Form 10-K for the year ended December 31, 2019 (the â€œ2019 Form 10-Kâ€) and
the Glossary of Terms and Acronyms and Line of Business Metrics on pages 192-197 and pages 198-200, respectively, of the Firmâ€™s Quarterly Report on Form 10-Q for the quarterly period ended September
30, 2020.

JPMORGAN CHASE & CO.
CONSOLIDATED FINANCIAL HIGHLIGHTS
(in millions, except per share and ratio data)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
SELECTED INCOME STATEMENT DATA 4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019
Reported Basis
Total net revenue (a) $ 29,224 $ 29,147 $ 32,980 $ 28,192 $ 28,285 â€” % 3 % $ 119,543 $ 115,399 4 %
Total noninterest expense (a) 16,048 16,875 16,942 16,791 16,293 (5) (2) 66,656 65,269 2
Pre-provision profit (b) 13,176 12,272 16,038 11,401 11,992 7 10 52,887 50,130 5
Provision for credit losses (1,889) 611 10,473 8,285 1,427 NM NM 17,480 5,585 213
NET INCOME 12,136 9,443 4,687 2,865 8,520 29 42 29,131 36,431 (20)
Managed Basis (c)
Total net revenue (a) 30,161 29,941 33,817 29,010 29,165 1 3 122,929 118,464 4
Total noninterest expense (a) 16,048 16,875 16,942 16,791 16,293 (5) (2) 66,656 65,269 2
Pre-provision profit (b) 14,113 13,066 16,875 12,219 12,872 8 10 56,273 53,195 6
Provision for credit losses (1,889) 611 10,473 8,285 1,427 NM NM 17,480 5,585 213
NET INCOME 12,136 9,443 4,687 2,865 8,520 29 42 29,131 36,431 (20)
EARNINGS PER SHARE DATA
Net income: Basic $ 3.80 $ 2.93 $ 1.39 $ 0.79 $ 2.58 30 47 $ 8.89 $ 10.75 (17)
Diluted 3.79 2.92 1.38 0.78 2.57 30 47 8.88 10.72 (17)
Average shares: Basic 3,079.7 3,077.8 3,076.3 3,095.8 3,140.7 â€” (2) 3,082.4 3,221.5 (4)
Diluted 3,085.1 3,082.8 3,081.0 3,100.7 3,148.5 â€” (2) 3,087.4 3,230.4 (4)
MARKET AND PER COMMON SHARE DATA
Market capitalization $ 387,492 $ 293,451 $ 286,658 $ 274,323 $ 429,913 32 (10) $ 387,492 $ 429,913 (10)
Common shares at period-end 3,049.4 3,048.2 3,047.6 3,047.0 3,084.0 â€” (1) 3,049.4 3,084.0 (1)
Book value per share 81.75 79.08 76.91 75.88 75.98 3 8 81.75 75.98 8
Tangible book value per share (â€œTBVPSâ€) (b) 66.11 63.93 61.76 60.71 60.98 3 8 66.11 60.98 8
Cash dividends declared per share 0.90 0.90 0.90 0.90 0.90 â€” â€” 3.60 3.40 6
FINANCIAL RATIOS (d)
Return on common equity (â€œROEâ€) 19 % 15 % 7 % 4 % 14 % 12 % 15 %
Return on tangible common equity (â€œROTCEâ€) (b) 24 19 9 5 17 14 19
Return on assets 1.42 1.14 0.58 0.40 1.22 0.91 1.33
CAPITAL RATIOS (e)
Common equity Tier 1 (â€œCET1â€) capital ratio 13.1 % (f) 13.1 % 12.4 % 11.5 % 12.4 % 13.1 % (f) 12.4 %
Tier 1 capital ratio 15.0 (f) 15.0 14.3 13.3 14.1 15.0 (f) 14.1
Total capital ratio 17.3 (f) 17.3 16.7 15.5 16.0 17.3 (f) 16.0
Tier 1 leverage ratio 7.0 (f) 7.0 6.9 7.5 7.9 7.0 (f) 7.9
Supplementary leverage ratio (â€œSLRâ€) 6.9 (f) 7.0 6.8 6.0 6.3 6.9 (f) 6.3
Effective January 1, 2020, the Firm adopted the Financial Instruments â€“ Credit Losses (â€œCECLâ€) accounting guidance, which resulted in a net increase to the allowance for credit losses of $4.3 billion and a decrease to retained earnings of $2.7 billion. Refer to Note 1 â€“ Basis of
Presentation on pages 85-86 of the Firmâ€™s Quarterly Report on Form 10-Q for the quarterly period ended March 31, 2020 for further information.
(a) In the second quarter of 2020, the Firm reclassified certain spend-based credit card reward costs from marketing expense to be a reduction of card income, with no effect on net income. Prior-period amounts have been revised to conform with the current presentation.
(b) Pre-provision profit, TBVPS and ROTCE are each non-GAAP financial measures. Tangible common equity (â€œTCEâ€) is also a non-GAAP financial measure; refer to page 9 for a reconciliation of common stockholdersâ€™ equity to TCE. Refer to page 28 for a further discussion of
these measures.
(c) Refer to Reconciliation from Reported to Managed Basis on page 7 for a further discussion of managed basis.
(d) Quarterly ratios are based upon annualized amounts.
(e) The capital metrics reflect the relief provided by the Federal Reserve Board (the â€œFederal Reserveâ€) in response to the COVID-19 pandemic, including the CECL capital transition provisions that became effective in the first quarter of 2020. For the periods ended December 31,
2020, September 30, 2020, June 30, 2020 and March 31, 2020, the impact of the CECL capital transition provisions resulted in an increase to CET1 capital of $5.7 billion, $6.4 billion, $6.5 billion and $4.3 billion, respectively. The SLR reflects the temporary exclusions of U.S.
Treasury securities and deposits at Federal Reserve Banks that became effective in the second quarter of 2020. Refer to Regulatory Developments Relating to the COVID-19 Pandemic on pages 11-12 and Capital Risk Management on pages 49-54 of the Firmâ€™s Quarterly
Report on Form 10-Q for the quarterly period ended September 30, 2020 for additional information. Refer to Capital Risk Management on pages 85-92 of the Firmâ€™s 2019 Form 10-K for additional information on the Firmâ€™s capital metrics.
(f) Estimated.

Page 2

JPMORGAN CHASE & CO.
CONSOLIDATED FINANCIAL HIGHLIGHTS, CONTINUED
(in millions, except ratio and headcount data)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

SELECTED BALANCE SHEET DATA (period-end)
Total assets $ 3,386,071 $ 3,246,076 $ 3,213,616 (f) $ 3,139,431 $ 2,687,379 4 % 26 % $ 3,386,071 $ 2,687,379 26 %
Loans:
Consumer, excluding credit card loans (a)(b) 318,579 322,098 323,198 311,508 317,817 (1) â€” 318,579 317,817 â€”
Credit card loans 144,216 140,377 141,656 154,021 168,924 3 (15) 144,216 168,924 (15)
Wholesale loans (a)(b) 550,058 527,265 544,528 584,081 510,879 4 8 550,058 510,879 8
Total Loans 1,012,853 989,740 1,009,382 1,049,610 997,620 2 2 1,012,853 997,620 2
Deposits:
U.S. offices:
Noninterest-bearing 572,711 540,116 529,729 448,195 395,667 6 45 572,711 395,667 45
Interest-bearing 1,197,032 1,117,149 1,061,093 1,026,603 876,156 7 37 1,197,032 876,156 37
Non-U.S. offices:
Noninterest-bearing 23,435 21,406 22,752 22,192 20,087 9 17 23,435 20,087 17
Interest-bearing 351,079 322,745 317,455 339,019 270,521 9 30 351,079 270,521 30
Total deposits 2,144,257 2,001,416 1,931,029 1,836,009 1,562,431 7 37 2,144,257 1,562,431 37
Long-term debt 281,685 279,175 317,003 299,344 291,498 1 (3) 281,685 291,498 (3)
Common stockholdersâ€™ equity 249,291 241,050 234,403 231,199 234,337 3 6 249,291 234,337 6
Total stockholdersâ€™ equity 279,354 271,113 264,466 261,262 261,330 3 7 279,354 261,330 7
Loans-to-deposits ratio (b) 47 % 49 % 52 % 57 % 64 % 47 % 64 %
Headcount 255,351 256,358 256,710 256,720 256,981 â€” (1) 255,351 256,981 (1)
95% CONFIDENCE LEVEL - TOTAL VaR (c)
Average VaR $ 96 $ 90 $ 130 $ 59 $ 37 7 159
LINE OF BUSINESS NET REVENUE (d)
Consumer & Community Banking (e) $ 12,728 $ 12,895 $ 12,358 $ 13,287 $ 13,880 (1) (8) $ 51,268 $ 55,133 (7)
Corporate & Investment Bank 11,352 11,546 16,383 10,003 9,703 (2) 17 49,284 39,265 26
Commercial Banking 2,463 2,285 2,400 2,165 2,296 8 7 9,313 9,264 1
Asset & Wealth Management 3,867 3,554 3,430 3,389 3,514 9 10 14,240 13,591 5
Corporate (249) (339) (754) 166 (228) 27 (9) (1,176) 1,211 NM
TOTAL NET REVENUE $ 30,161 $ 29,941 $ 33,817 $ 29,010 $ 29,165 1 3 $ 122,929 $ 118,464 4
LINE OF BUSINESS NET INCOME/(LOSS)
Consumer & Community Banking $ 4,325 $ 3,871 $ (176) $ 197 $ 4,200 12 3 $ 8,217 $ 16,541 (50)
Corporate & Investment Bank 5,349 4,309 5,451 1,985 2,935 24 82 17,094 11,954 43
Commercial Banking 2,034 1,086 (681) 139 945 87 115 2,578 3,958 (35)
Asset & Wealth Management 786 876 661 669 801 (10) (2) 2,992 2,867 4
Corporate (358) (699) (568) (125) (361) 49 1 (1,750) 1,111 NM
NET INCOME $ 12,136 $ 9,443 $ 4,687 $ 2,865 $ 8,520 29 42 $ 29,131 $ 36,431 (20)
In the fourth quarter of 2020, payment processing-only clients along with the associated revenue and expenses were realigned to CIBâ€™s Wholesale Payments business from CCB and CB. Prior-period amounts have been revised to conform with the current presentation. Refer to
Business segment changes on page 21 of the Firmâ€™s Quarterly Report on Form 10-Q for the quarterly period ended March 31, 2020 for further information.
In the fourth quarter of 2020, the Firm realigned certain wealth management clients from AWM to CCB. Prior-period amounts have been revised to conform with the current presentation. Refer to page 29 for further information.
(a) In conjunction with the adoption of CECL on January 1, 2020, the Firm reclassified risk-rated business banking and auto dealer loans held in CCB from the consumer, excluding credit card portfolio segment to the wholesale portfolio segment. Prior-period amounts have been
revised to conform with the current presentation.
(b) In the third quarter of 2020, the Firm reclassified certain fair value option elected lending-related positions from trading assets to loans. Prior-period amounts have been revised to conform with the current presentation.
(c) Effective January 1, 2020, the Firm refined the scope of VaR to exclude positions related to the risk management of interest rate exposure from changes in the Firmâ€™s own credit spread on fair value option elected liabilities, and included these positions in other sensitivity-based
measures. Additionally, effective July 1, 2020, the Firm refined the scope of VaR to exclude certain asset-backed fair value option elected loans, and included them in other sensitivity-based measures to more effectively measure the risk from these loans. In the absence of these
refinements, the average Total VaR for the three months ended December 31, 2020, September 30, 2020, June 30, 2020 and March 31, 2020 would have been different by $27 million, $11 million, $(8) million and $6 million, respectively.
(d) Refer to Reconciliation from Reported to Managed Basis on page 7 for a further discussion of managed basis.
(e) In the second quarter of 2020, the Firm reclassified certain spend-based credit card reward costs from marketing expense to be a reduction of card income, with no effect on net income. Prior-period amounts have been revised to conform with the current presentation.
(f) Prior-period amounts have been revised to conform with the current presentation.

Page 3

JPMORGAN CHASE & CO.
CONSOLIDATED STATEMENTS OF INCOME
(in millions, except per share and ratio data)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
REVENUE 4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019
Investment banking fees $ 2,583 $ 2,187 $ 2,850 $ 1,866 $ 1,843 18 % 40 % $ 9,486 $ 7,501 26 %
Principal transactions 3,321 4,142 7,621 2,937 2,779 (20) 20 18,021 14,018 29
Lending- and deposit-related fees (a) 1,727 1,647 1,431 1,706 1,772 5 (3) 6,511 6,626 (2)
Asset management, administration and commissions (a) 4,901 4,470 4,266 4,540 4,301 10 14 18,177 16,908 8
Investment securities gains 70 473 26 233 123 (85) (43) 802 258 211
Mortgage fees and related income 767 1,087 917 320 474 (29) 62 3,091 2,036 52
Card income (b) 1,297 1,169 974 995 1,335 11 (3) 4,435 5,076 (13)
Other income 1,300 959 1,042 1,156 1,492 36 (13) 4,457 5,731 (22)
Noninterest revenue 15,966 16,134 19,127 13,753 14,119 (1) 13 64,980 58,154 12
Interest income 14,550 14,700 16,112 19,161 19,927 (1) (27) 64,523 84,040 (23)
Interest expense 1,292 1,687 2,259 4,722 5,761 (23) (78) 9,960 26,795 (63)
Net interest income 13,258 13,013 13,853 14,439 14,166 2 (6) 54,563 57,245 (5)
TOTAL NET REVENUE 29,224 29,147 32,980 28,192 28,285 â€” 3 119,543 115,399 4
Provision for credit losses (1,889) 611 10,473 8,285 1,427 NM NM 17,480 5,585 213
NONINTEREST EXPENSE
Compensation expense 7,954 8,630 9,509 8,895 8,088 (8) (2) 34,988 34,155 2
Occupancy expense 1,161 1,142 1,080 1,066 1,084 2 7 4,449 4,322 3
Technology, communications and equipment expense 2,606 2,564 2,590 2,578 2,585 2 1 10,338 9,821 5
Professional and outside services 2,259 2,178 1,999 2,028 2,226 4 1 8,464 8,533 (1)
Marketing (b) 725 470 481 800 847 54 (14) 2,476 3,351 (26)
Other expense (c) 1,343 1,891 1,283 1,424 1,463 (29) (8) 5,941 5,087 17
TOTAL NONINTEREST EXPENSE 16,048 16,875 16,942 16,791 16,293 (5) (2) 66,656 65,269 2
Income before income tax expense 15,065 11,661 5,565 3,116 10,565 29 43 35,407 44,545 (21)
Income tax expense 2,929 2,218 878 251 2,045 32 43 6,276 8,114 (f) (23)
NET INCOME $ 12,136 $ 9,443 $ 4,687 $ 2,865 $ 8,520 29 42 $ 29,131 $ 36,431 (20)
NET INCOME PER COMMON SHARE DATA
Basic earnings per share $ 3.80 $ 2.93 $ 1.39 $ 0.79 $ 2.58 30 47 $ 8.89 $ 10.75 (17)
Diluted earnings per share 3.79 2.92 1.38 0.78 2.57 30 47 8.88 10.72 (17)
FINANCIAL RATIOS
Return on common equity (d) 19 % 15 % 7 % 4 % 14 % 12 % 15 %
Return on tangible common equity (d)(e) 24 19 9 5 17 14 19
Return on assets (d) 1.42 1.14 0.58 0.40 1.22 0.91 1.33
Effective income tax rate 19.4 19.0 15.8 8.1 19.4 17.7 18.2 (f)
Overhead ratio 55 58 51 60 58 56 57

(a) In the first quarter of 2020, the Firm reclassified certain fees from asset management, administration and commissions to lending- and deposit-related fees. Prior-period amounts have been revised to conform with the current presentation.
(b) In the second quarter of 2020, the Firm reclassified certain spend-based credit card reward costs from marketing expense to be a reduction of card income, with no effect on net income. Prior-period amounts have been revised to conform with the current presentation.
(c) Included Firmwide legal expense/(benefit) of $276 million, $524 million, $118 million, $197 million and $241 million for the three months ended December 31, 2020, September 30, 2020, June 30, 2020, March 31, 2020, and December 31, 2019, respectively, and $1.1 billion and
$239 million for the full year 2020 and 2019 respectively.
(d) Quarterly ratios are based upon annualized amounts.
(e) Refer to page 28 for further discussion of ROTCE.
(f) The full year 2019 included income tax benefits of $1.1 billion due to the resolution of certain tax audits.

Page 4

JPMORGAN CHASE & CO.
CONSOLIDATED BALANCE SHEETS
(in millions)

Dec 31, 2020
Change
Dec 31, Sep 30, Jun 30, Mar 31, Dec 31, Sep 30, Dec 31,
2020 2020 2020 2020 2019 2020 2019

ASSETS
Cash and due from banks $ 24,874 $ 20,816 $ 20,544 $ 24,001 $ 21,704 19 % 15 %
Deposits with banks 502,735 466,706 473,185 343,533 241,927 8 108
Federal funds sold and securities purchased under
resale agreements 296,284 319,849 256,980 248,580 249,157 (7) 19
Securities borrowed 160,635 142,441 142,704 139,839 139,758 13 15
Trading assets:
Debt and equity instruments (a) 423,496 429,196 416,870 429,275 319,921 (1) 32
Derivative receivables 79,630 76,626 74,846 81,648 49,766 4 60
Available-for-sale (â€œAFSâ€) securities 388,178 389,583 485,883 399,944 350,699 â€” 11
Held-to-maturity (â€HTMâ€) securities, net of allowance for credit losses (b) 201,821 141,553 72,908 71,200 47,540 43 325
Investment securities, net of allowance for credit losses (b) 589,999 531,136 558,791 471,144 398,239 11 48
Loans (a) 1,012,853 989,740 1,009,382 1,049,610 997,620 2 2
Less: Allowance for loan losses 28,328 30,814 31,591 (c) 23,244 13,123 (8) 116
Loans, net of allowance for loan losses 984,525 958,926 977,791 1,026,366 984,497 3 â€”
Accrued interest and accounts receivable 90,503 76,945 72,260 122,064 72,861 18 24
Premises and equipment 27,109 26,672 26,301 25,882 25,813 2 5
Goodwill, MSRs and other intangible assets 53,428 51,594 51,669 51,867 53,341 4 â€”
Other assets (a) 152,853 145,169 141,675 175,232 130,395 5 17
TOTAL ASSETS $ 3,386,071 $ 3,246,076 $ 3,213,616 $ 3,139,431 $ 2,687,379 4 26
LIABILITIES
Deposits $ 2,144,257 $ 2,001,416 $ 1,931,029 $ 1,836,009 $ 1,562,431 7 37
Federal funds purchased and securities loaned or sold
under repurchase agreements 215,209 236,440 235,647 233,207 183,675 (9) 17
Short-term borrowings 45,208 41,992 48,014 51,909 40,920 8 10
Trading liabilities:
Debt and equity instruments 99,558 104,835 107,735 119,109 75,569 (5) 32
Derivative payables 70,623 57,658 57,477 65,087 43,708 22 62
Accounts payable and other liabilities 232,599 234,256 231,417 (c) 253,874 210,407 (1) 11
Beneficial interests issued by consolidated VIEs 17,578 19,191 20,828 19,630 17,841 (8) (1)
Long-term debt 281,685 279,175 317,003 299,344 291,498 1 (3)
TOTAL LIABILITIES 3,106,717 2,974,963 2,949,150 2,878,169 2,426,049 4 28
STOCKHOLDERSâ€™ EQUITY
Preferred stock 30,063 30,063 30,063 30,063 26,993 â€” 11
Common stock 4,105 4,105 4,105 4,105 4,105 â€” â€”
Additional paid-in capital 88,394 88,289 88,125 87,857 88,522 â€” â€”
Retained earnings 236,990 228,014 221,732 220,226 223,211 4 6
Accumulated other comprehensive income/(loss) 7,986 8,940 8,789 7,418 1,569 (11) 409
Shares held in RSU Trust, at cost â€” (11) (11) (21) (21) NM NM
Treasury stock, at cost (88,184) (88,287) (88,337) (88,386) (83,049) â€” (6)
TOTAL STOCKHOLDERSâ€™ EQUITY 279,354 271,113 264,466 261,262 261,330 3 7
TOTAL LIABILITIES AND STOCKHOLDERSâ€™ EQUITY $ 3,386,071 $ 3,246,076 $ 3,213,616 $ 3,139,431 $ 2,687,379 4 26
(a) In the third quarter of 2020, the Firm reclassified certain fair value option elected lending-related positions from trading assets to loans and other assets. Prior-period amounts have been revised to conform with the current presentation.
(b) Upon adoption of the CECL accounting guidance, HTM securities are presented net of an allowance for credit losses. At December 31, 2020, September 30, 2020, June 30, 2020 and March 31, 2020, the allowance for credit losses on HTM securities was $78 million, $120
million, $23 million and $19 million, respectively.
(c) Prior-period amounts have been revised to conform with the current presentation.

Page 5

JPMORGAN CHASE & CO.
CONDENSED AVERAGE BALANCE SHEETS AND ANNUALIZED YIELDS
(in millions, except rates)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
AVERAGE BALANCES 4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019
ASSETS
Deposits with banks $ 507,194 $ 509,979 $ 477,895 $ 279,748 $ 272,648 (1) % 86 % $ 444,058 $ 280,004 59 %
Federal funds sold and securities purchased under resale agreements 327,504 277,899 244,306 253,403 248,170 18 32 275,926 275,429 â€”
Securities borrowed 149,146 147,184 141,328 136,127 135,374 1 10 143,472 131,291 9
Trading assets - debt instruments (a) 319,585 322,321 345,073 304,808 280,487 (1) 14 322,936 294,958 9
Investment securities 568,354 548,544 500,254 421,529 394,002 4 44 509,937 319,875 59
Loans (a) 996,367 991,241 1,029,513 1,001,504 987,606 1 1 1,004,597 989,943 1
All other interest-earning assets (a)(b) 87,496 77,806 81,320 68,430 59,257 12 48 78,784 53,779 46
Total interest-earning assets 2,955,646 2,874,974 2,819,689 2,465,549 2,377,544 3 24 2,779,710 2,345,279 19
Trading assets - equity and other instruments 138,477 119,905 99,115 114,479 114,112 15 21 118,055 114,323 3
Trading assets - derivative receivables 79,300 81,300 79,298 66,309 52,860 (2) 50 76,572 53,786 42
All other noninterest-earning assets (a) 226,395 213,978 231,166 243,895 232,754 6 (3) 228,811 228,453 â€”
TOTAL ASSETS $ 3,399,818 $ 3,290,157 $ 3,229,268 $ 2,890,232 $ 2,777,270 3 22 $ 3,203,148 $ 2,741,841 17
LIABILITIES
Interest-bearing deposits $ 1,529,066 $ 1,434,034 $ 1,375,213 $ 1,216,555 $ 1,154,716 7 32 $ 1,389,224 $ 1,115,848 24
Federal funds purchased and securities loaned or
sold under repurchase agreements 247,276 253,779 276,815 243,922 235,481 (3) 5 255,421 227,994 12
Short-term borrowings (c) 36,183 36,697 45,297 37,288 39,936 (1) (9) 38,853 52,426 (26)
Trading liabilities - debt and other interest-bearing liabilities (d) 213,989 206,643 207,322 192,950 170,049 4 26 205,255 182,105 13
Beneficial interests issued by consolidated VIEs 18,647 19,838 20,331 18,048 19,390 (6) (4) 19,216 22,501 (15)
Long-term debt 237,144 267,175 269,336 243,996 248,521 (11) (5) 254,400 247,968 3
Total interest-bearing liabilities 2,282,305 2,218,166 2,194,314 1,952,759 1,868,093 3 22 2,162,369 1,848,842 17
Noninterest-bearing deposits 582,517 551,565 515,304 419,631 413,582 6 41 517,527 407,219 27
Trading liabilities - equity and other instruments 33,732 32,256 33,797 30,721 28,197 5 20 32,628 31,085 5
Trading liabilities - derivative payables 63,551 64,599 63,178 54,990 44,361 (2) 43 61,593 42,560 45
All other noninterest-bearing liabilities 165,978 156,711 158,204 168,195 162,490 6 2 162,267 151,717 7
TOTAL LIABILITIES 3,128,083 3,023,297 2,964,797 2,626,296 2,516,723 3 24 2,936,384 2,481,423 18
Preferred stock 30,063 30,063 30,063 29,406 27,669 â€” 9 29,899 27,511 9
Common stockholdersâ€™ equity 241,672 236,797 234,408 234,530 232,878 2 4 236,865 232,907 2
TOTAL STOCKHOLDERSâ€™ EQUITY 271,735 266,860 264,471 263,936 260,547 2 4 266,764 260,418 2
TOTAL LIABILITIES AND STOCKHOLDERSâ€™ EQUITY $ 3,399,818 $ 3,290,157 $ 3,229,268 $ 2,890,232 $ 2,777,270 3 22 $ 3,203,148 $ 2,741,841 17
AVERAGE RATES (e)
INTEREST-EARNING ASSETS
Deposits with banks 0.03 % 0.05 % 0.06 % 0.82 % 1.00 % 0.17 % 1.39 %
Federal funds sold and securities purchased under resale agreements 0.41 0.57 0.99 1.74 2.05 0.88 2.23
Securities borrowed (f) (0.40) (0.35) (0.50) 0.45 0.81 (0.21) 1.20
Trading assets - debt instruments (a) 2.32 2.29 2.42 2.74 2.87 2.44 3.12
Investment securities 1.39 1.58 2.03 2.48 2.65 1.82 3.01
Loans (a) 4.14 4.11 4.27 4.96 5.07 4.37 5.25
All other interest-earning assets (a)(b) 0.89 0.94 0.99 2.60 3.49 1.30 3.99
Total interest-earning assets 1.97 2.05 2.31 3.14 3.35 2.34 3.61
INTEREST-BEARING LIABILITIES
Interest-bearing deposits 0.05 0.07 0.10 0.52 0.67 0.17 0.80
Federal funds purchased and securities loaned or
sold under repurchase agreements 0.06 0.17 0.19 1.30 1.77 0.41 2.03
Short-term borrowings (c) 0.40 0.65 1.11 1.63 1.97 0.96 2.38
Trading liabilities - debt and other interest-bearing liabilities (d)(f) (0.15) (0.10) (0.08) 0.77 1.04 0.10 1.42
Beneficial interests issued by consolidated VIEs 0.65 0.71 1.15 2.02 2.22 1.12 2.52
Long-term debt 1.82 1.93 2.45 2.88 3.21 2.27 3.55
Total interest-bearing liabilities 0.23 0.30 0.41 0.97 1.22 0.46 1.45
INTEREST RATE SPREAD 1.74 % 1.75 % 1.90 % 2.17 % 2.13 % 1.88 % 2.16 %
NET YIELD ON INTEREST-EARNING ASSETS 1.80 % 1.82 % 1.99 % 2.37 % 2.38 % 1.98 % 2.46 %
Memo: Net yield on interest-earning assets excluding CIB Markets (g) 2.01 % 2.05 % 2.27 % 3.01 % 3.06 % 2.30 % 3.27 %
(a) In the third quarter of 2020, the Firm reclassified certain fair value option elected lending-related positions from trading assets to loans and other assets. Prior-period amounts have been revised to conform with the current presentation.
(b) Includes brokerage-related held-for-investment customer receivables, which are classified in accrued interest and accounts receivable, and all other interest-earning assets, which are classified in other assets on the Consolidated Balance Sheets.
(c) Includes commercial paper.
(d) All other interest-bearing liabilities include brokerage-related customer payables.
(e) Interest includes the effect of related hedging derivatives. Taxable-equivalent amounts are used where applicable.
(f) Negative interest income and yields are related to the impact of current interest rates combined with the fees paid on client-driven securities borrowed balances. The negative interest expense related to prime brokerage customer payables is recognized in interest expense and
reported within trading liabilities - debt and all other liabilities.
(g) Net yield on interest-earning assets excluding CIB Markets is a non-GAAP financial measure. Refer to page 28 for a further discussion of this measure.

Page 6

JPMORGAN CHASE & CO.
RECONCILIATION FROM REPORTED TO MANAGED BASIS
(in millions, except ratios)
The Firm prepares its Consolidated Financial Statements using accounting principles generally accepted in the U.S. (â€œU.S. GAAPâ€). That presentation, which is referred to as â€œreportedâ€ basis, provides the reader with an understanding of the Firmâ€™s results that can be tracked
consistently from year-to-year and enables a comparison of the Firmâ€™s performance with other companiesâ€™ U.S. GAAP financial statements. In addition to analyzing the Firmâ€™s results on a reported basis, management reviews Firmwide results, including the overhead ratio, on a
â€œmanagedâ€ basis; these Firmwide managed basis results are non-GAAP financial measures. The Firm also reviews the results of the lines of business on a managed basis. Refer to the notes on Non-GAAP Financial Measures on page 28 for additional information on
managed basis.
The following summary table provides a reconciliation from reported U.S. GAAP results to managed basis.

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

OTHER INCOME
Other income - reported $ 1,300 $ 959 $ 1,042 $ 1,156 $ 1,492 36 % (13) % $ 4,457 $ 5,731 (22) %
Fully taxable-equivalent adjustments (a) 840 690 730 708 757 22 11 2,968 2,534 17
Other income - managed $ 2,140 $ 1,649 $ 1,772 $ 1,864 $ 2,249 30 (5) $ 7,425 $ 8,265 (10)
TOTAL NONINTEREST REVENUE (b)
Total noninterest revenue - reported $ 15,966 $ 16,134 $ 19,127 $ 13,753 $ 14,119 (1) 13 $ 64,980 $ 58,154 12
Fully taxable-equivalent adjustments (a) 840 690 730 708 757 22 11 2,968 2,534 17
Total noninterest revenue - managed $ 16,806 $ 16,824 $ 19,857 $ 14,461 $ 14,876 â€” 13 $ 67,948 $ 60,688 12
NET INTEREST INCOME
Net interest income - reported $ 13,258 $ 13,013 $ 13,853 $ 14,439 $ 14,166 2 (6) $ 54,563 $ 57,245 (5)
Fully taxable-equivalent adjustments (a) 97 104 107 110 123 (7) (21) 418 531 (21)
Net interest income - managed $ 13,355 $ 13,117 $ 13,960 $ 14,549 $ 14,289 2 (7) $ 54,981 $ 57,776 (5)
TOTAL NET REVENUE (b)
Total net revenue - reported $ 29,224 $ 29,147 $ 32,980 $ 28,192 $ 28,285 â€” 3 $ 119,543 $ 115,399 4
Fully taxable-equivalent adjustments (a) 937 794 837 818 880 18 6 3,386 3,065 10
Total net revenue - managed $ 30,161 $ 29,941 $ 33,817 $ 29,010 $ 29,165 1 3 $ 122,929 $ 118,464 4
PRE-PROVISION PROFIT
Pre-provision profit - reported $ 13,176 $ 12,272 $ 16,038 $ 11,401 $ 11,992 7 10 $ 52,887 $ 50,130 5
Fully taxable-equivalent adjustments (a) 937 794 837 818 880 18 6 3,386 3,065 10
Pre-provision profit - managed $ 14,113 $ 13,066 $ 16,875 $ 12,219 $ 12,872 8 10 $ 56,273 $ 53,195 6
INCOME BEFORE INCOME TAX EXPENSE
Income before income tax expense - reported $ 15,065 $ 11,661 $ 5,565 $ 3,116 $ 10,565 29 43 $ 35,407 $ 44,545 (21)
Fully taxable-equivalent adjustments (a) 937 794 837 818 880 18 6 3,386 3,065 10
Income before income tax expense - managed $ 16,002 $ 12,455 $ 6,402 $ 3,934 $ 11,445 28 40 $ 38,793 $ 47,610 (19)
INCOME TAX EXPENSE
Income tax expense - reported $ 2,929 $ 2,218 $ 878 $ 251 $ 2,045 32 43 $ 6,276 $ 8,114 (23)
Fully taxable-equivalent adjustments (a) 937 794 837 818 880 18 6 3,386 3,065 10
Income tax expense - managed $ 3,866 $ 3,012 $ 1,715 $ 1,069 $ 2,925 28 32 $ 9,662 $ 11,179 (14)
OVERHEAD RATIO
Overhead ratio - reported 55 % 58 % 51 % 60 % 58 % 56 % 57 %
Overhead ratio - managed 53 56 50 58 56 54 55
(a) Predominantly recognized in CIB, CB and Corporate.
(b) In the second quarter of 2020, the Firm reclassified certain spend-based credit card reward costs from marketing expense to be a reduction of card income, with no effect on net income. Prior-period amounts have been revised to conform with the current presentation.

Page 7

JPMORGAN CHASE & CO.
SEGMENT RESULTS - MANAGED BASIS
(in millions)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

TOTAL NET REVENUE (fully taxable-equivalent (â€œFTEâ€))
Consumer & Community Banking (a) $ 12,728 $ 12,895 $ 12,358 $ 13,287 $ 13,880 (1) % (8) % $ 51,268 $ 55,133 (7) %
Corporate & Investment Bank 11,352 11,546 16,383 10,003 9,703 (2) 17 49,284 39,265 26
Commercial Banking 2,463 2,285 2,400 2,165 2,296 8 7 9,313 9,264 1
Asset & Wealth Management 3,867 3,554 3,430 3,389 3,514 9 10 14,240 13,591 5
Corporate (249) (339) (754) 166 (228) 27 (9) (1,176) 1,211 NM
TOTAL NET REVENUE $ 30,161 $ 29,941 $ 33,817 $ 29,010 $ 29,165 1 3 $ 122,929 $ 118,464 4
TOTAL NONINTEREST EXPENSE
Consumer & Community Banking (a) $ 7,042 $ 6,912 $ 6,767 $ 7,269 $ 7,116 2 (1) $ 27,990 $ 28,276 (1)
Corporate & Investment Bank 4,939 5,832 6,812 5,955 5,451 (15) (9) 23,538 22,444 5
Commercial Banking 950 969 893 986 941 (2) 1 3,798 3,735 2
Asset & Wealth Management 2,756 2,443 2,323 2,435 2,442 13 13 9,957 9,747 2
Corporate 361 719 147 146 343 (50) 5 1,373 1,067 29
TOTAL NONINTEREST EXPENSE $ 16,048 $ 16,875 $ 16,942 $ 16,791 $ 16,293 (5) (2) $ 66,656 $ 65,269 2
PRE-PROVISION PROFIT/(LOSS)
Consumer & Community Banking $ 5,686 $ 5,983 $ 5,591 $ 6,018 $ 6,764 (5) (16) $ 23,278 $ 26,857 (13)
Corporate & Investment Bank 6,413 5,714 9,571 4,048 4,252 12 51 25,746 16,821 53
Commercial Banking 1,513 1,316 1,507 1,179 1,355 15 12 5,515 5,529 â€”
Asset & Wealth Management 1,111 1,111 1,107 954 1,072 â€” 4 4,283 3,844 11
Corporate (610) (1,058) (901) 20 (571) 42 (7) (2,549) 144 NM
PRE-PROVISION PROFIT $ 14,113 $ 13,066 $ 16,875 $ 12,219 $ 12,872 8 10 $ 56,273 $ 53,195 6
PROVISION FOR CREDIT LOSSES
Consumer & Community Banking $ (83) $ 795 $ 5,828 $ 5,772 $ 1,207 NM NM $ 12,312 $ 4,954 149
Corporate & Investment Bank (581) (81) 1,987 1,401 98 NM NM 2,726 277 NM
Commercial Banking (1,181) (147) 2,431 1,010 110 NM NM 2,113 296 NM
Asset & Wealth Management (2) (52) 223 94 13 96 NM 263 59 346
Corporate (42) 96 4 8 (1) NM NM 66 (1) NM
PROVISION FOR CREDIT LOSSES $ (1,889) $ 611 $ 10,473 $ 8,285 $ 1,427 NM NM $ 17,480 $ 5,585 213
NET INCOME/(LOSS)
Consumer & Community Banking $ 4,325 $ 3,871 $ (176) $ 197 $ 4,200 12 3 $ 8,217 $ 16,541 (50)
Corporate & Investment Bank 5,349 4,309 5,451 1,985 2,935 24 82 17,094 11,954 43
Commercial Banking 2,034 1,086 (681) 139 945 87 115 2,578 3,958 (35)
Asset & Wealth Management 786 876 661 669 801 (10) (2) 2,992 2,867 4
Corporate (358) (699) (568) (125) (361) 49 1 (1,750) 1,111 NM
TOTAL NET INCOME $ 12,136 $ 9,443 $ 4,687 $ 2,865 $ 8,520 29 42 $ 29,131 $ 36,431 (20)
In the fourth quarter of 2020, payment processing-only clients along with the associated revenue and expenses were realigned to CIBâ€™s Wholesale Payments business from CCB and CB. Prior-period amounts have been revised to conform with the current presentation. Refer to
Business segment changes on page 21 of the Firmâ€™s Quarterly Report on Form 10-Q for the quarterly period ended March 31, 2020 for further information.
In the fourth quarter of 2020, the Firm realigned certain wealth management clients from AWM to CCB. Prior-period amounts have been revised to conform with the current presentation. Refer to page 29 for further information.
(a) In the second quarter of 2020, the Firm reclassified certain spend-based credit card reward costs from marketing expense to be a reduction of card income, with no effect on net income. Prior-period amounts have been revised to conform with the current presentation.

Page 8

JPMORGAN CHASE & CO.
CAPITAL AND OTHER SELECTED BALANCE SHEET ITEMS
(in millions, except ratio data)

Dec 31, 2020
Change FULL YEAR

Dec 31, Sep 30, Jun 30, Mar 31, Dec 31, Sep 30, Dec 31, 2020 Change
2020 2020 2020 2020 2019 2020 2019 2020 2019 2019

CAPITAL (a)
Risk-based capital metrics
Standardized
CET1 capital $ 205,066 (e) $ 197,719 $ 190,867 $ 183,591 $ 187,753 4 % 9 %
Tier 1 capital 234,835 (e) 227,486 220,674 213,406 214,432 3 10
Total capital 269,933 (e) 262,397 256,667 247,541 242,589 3 11
Risk-weighted assets 1,562,381 (e) 1,514,509 1,541,365 1,598,828 1,515,869 3 3
CET1 capital ratio 13.1 % (e) 13.1 % 12.4 % 11.5 % 12.4 %
Tier 1 capital ratio 15.0 (e) 15.0 14.3 13.3 14.1
Total capital ratio 17.3 (e) 17.3 16.7 15.5 16.0
Advanced
CET1 capital $ 205,066 (e) $ 197,719 $ 190,867 $ 183,591 $ 187,753 4 9
Tier 1 capital 234,835 (e) 227,486 220,674 213,406 214,432 3 10
Total capital 257,222 (e) 249,947 244,112 234,434 232,112 3 11
Risk-weighted assets 1,485,654 (e) 1,429,334 1,450,587 1,489,134 1,397,878 4 6
CET1 capital ratio 13.8 % (e) 13.8 % 13.2 % 12.3 % 13.4 %
Tier 1 capital ratio 15.8 (e) 15.9 15.2 14.3 15.3
Total capital ratio 17.3 (e) 17.5 16.8 15.7 16.6
Leverage-based capital metrics
Adjusted average assets (b) $ 3,353,310 (e) $ 3,243,290 $ 3,176,729 $ 2,842,244 $ 2,730,239 3 23
Tier 1 leverage ratio 7.0 % (e) 7.0 % 6.9 % 7.5 % 7.9 %
Total leverage exposure 3,396,447 (e) 3,247,392 3,228,424 3,535,822 3,423,431 5 (1)
SLR 6.9 % (e) 7.0 % 6.8 % 6.0 % 6.3 %
TANGIBLE COMMON EQUITY (period-end) (c)
Common stockholdersâ€™ equity $ 249,291 $ 241,050 $ 234,403 $ 231,199 $ 234,337 3 6
Less: Goodwill 49,248 47,819 47,811 47,800 47,823 3 3
Less: Other intangible assets 904 759 778 800 819 19 10
Add: Certain deferred tax liabilities (d) 2,453 2,405 2,397 2,389 2,381 2 3
Total tangible common equity $ 201,592 $ 194,877 $ 188,211 $ 184,988 $ 188,076 3 7
TANGIBLE COMMON EQUITY (average) (c)
Common stockholdersâ€™ equity $ 241,672 $ 236,797 $ 234,408 $ 234,530 $ 232,878 2 4 $ 236,865 $ 232,907 2 %
Less: Goodwill 47,842 47,820 47,805 47,812 47,819 â€” â€” 47,820 47,620 â€”
Less: Other intangible assets 752 769 791 812 831 (2) (10) 781 789 (1)
Add: Certain deferred tax liabilities (d) 2,416 2,401 2,393 2,385 2,375 1 2 2,399 2,328 3
Total tangible common equity $ 195,494 $ 190,609 $ 188,205 $ 188,291 $ 186,603 3 5 $ 190,663 $ 186,826 2
INTANGIBLE ASSETS (period-end)
Goodwill $ 49,248 $ 47,819 $ 47,811 $ 47,800 $ 47,823 3 3
Mortgage servicing rights 3,276 3,016 3,080 3,267 4,699 9 (30)
Other intangible assets 904 759 778 800 819 19 10
Total intangible assets $ 53,428 $ 51,594 $ 51,669 $ 51,867 $ 53,341 4 â€”
(a) The capital metrics reflect the relief provided by the Federal Reserve Board in response to the COVID-19 pandemic, including the CECL capital transition provisions that became effective in the first quarter of 2020. For the periods ended December 31, 2020, September 30,
2020, June 30, 2020 and March 31, 2020, the impact of the CECL capital transition provisions resulted in an increase to CET1 capital of $5.7 billion, $6.4 billion, $6.5 billion and $4.3 billion, respectively. The SLR reflects the temporary exclusions of U.S. Treasury securities and
deposits at Federal Reserve Banks that became effective in the second quarter of 2020. Refer to Regulatory Developments Relating to the COVID-19 Pandemic on pages 11-12 and Capital Risk Management on pages 49-54 of the Firmâ€™s Quarterly Report on Form 10-Q for the
quarterly period ended September 30, 2020 for additional information. Refer to Capital Risk Management on pages 85-92 of the Firmâ€™s 2019 Form 10-K for additional information on the Firmâ€™s capital metrics.
(b) Adjusted average assets, for purposes of calculating the leverage ratios, includes total quarterly average assets adjusted for on-balance sheet assets that are subject to deduction from Tier 1 capital, predominantly goodwill and other intangible assets.
(c) Refer to page 28 for further discussion of TCE.
(d) Represents deferred tax liabilities related to tax-deductible goodwill and to identifiable intangibles created in nontaxable transactions, which are netted against goodwill and other intangibles when calculating TCE.
(e) Estimated.

Page 9

JPMORGAN CHASE & CO.
EARNINGS PER SHARE AND RELATED INFORMATION
(in millions, except per share and ratio data)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

EARNINGS PER SHARE
Basic earnings per share
Net income $ 12,136 $ 9,443 $ 4,687 $ 2,865 $ 8,520 29 % 42 % $ 29,131 $ 36,431 (20) %
Less: Preferred stock dividends 380 381 401 421 386 â€” (2) 1,583 1,587 â€”
Net income applicable to common equity 11,756 9,062 4,286 2,444 8,134 30 45 27,548 34,844 (21)
Less: Dividends and undistributed earnings allocated to
participating securities 57 47 21 13 44 21 30 138 202 (32)
Net income applicable to common stockholders $ 11,699 $ 9,015 $ 4,265 $ 2,431 $ 8,090 30 45 $ 27,410 $ 34,642 (21)
Total weighted-average basic shares outstanding 3,079.7 3,077.8 3,076.3 3,095.8 3,140.7 â€” (2) 3,082.4 3,221.5 (4)
Net income per share $ 3.80 $ 2.93 $ 1.39 $ 0.79 $ 2.58 30 47 $ 8.89 $ 10.75 (17)
Diluted earnings per share
Net income applicable to common stockholders $ 11,699 $ 9,015 $ 4,265 $ 2,431 $ 8,090 30 45 $ 27,410 $ 34,642 (21)
Total weighted-average basic shares outstanding 3,079.7 3,077.8 3,076.3 3,095.8 3,140.7 â€” (2) 3,082.4 3,221.5 (4)
Add: Dilutive impact of stock appreciation rights (â€œSARsâ€) and
employee stock options, unvested performance share units
(â€œPSUsâ€) and nondividend-earning restricted stock units
(â€œRSUsâ€) 5.4 5.0 4.7 4.9 7.8 8 (31) 5.0 8.9 (44)
Total weighted-average diluted shares outstanding 3,085.1 3,082.8 3,081.0 3,100.7 3,148.5 â€” (2) 3,087.4 3,230.4 (4)
Net income per share $ 3.79 $ 2.92 $ 1.38 $ 0.78 $ 2.57 30 47 $ 8.88 $ 10.72 (17)
COMMON DIVIDENDS
Cash dividends declared per share $ 0.90 $ 0.90 $ 0.90 $ 0.90 $ 0.90 â€” â€” $ 3.60 $ 3.40 6
Dividend payout ratio 24 % 31 % 65 % 114 % 35 % 40 % 31 %
COMMON SHARE REPURCHASE PROGRAM (a)
Total shares of common stock repurchased â€” â€” â€” 50.0 54.0 â€” NM 50.0 213.0 (77)
Average price paid per share of common stock $ â€” $ â€” $ â€” $ 127.92 $ 127.24 â€” NM $ 127.92 $ 113.26 13
Aggregate repurchases of common stock â€” â€” â€” 6,397 6,871 â€” NM 6,397 24,121 (73)
EMPLOYEE ISSUANCE
Shares issued from treasury stock related to employee
stock-based compensation awards and employee stock
purchase plans 1.5 0.6 0.8 13.0 1.5 150 â€” 15.9 21.2 (25)
Net impact of employee issuances on stockholdersâ€™ equity (b) $ 217 $ 263 $ 325 $ 398 $ 132 (17) 64 $ 1,203 $ 970 24
(a) On March 15, 2020, in response to the COVID-19 pandemic, the Firm temporarily suspended repurchases of its common stock. Subsequently, the Federal Reserve directed all large banks, including the Firm, to discontinue net share repurchases through the end of 2020. On
December 18, 2020, the Federal Reserve announced that all large banks, including the Firm, could resume share repurchases commencing in the first quarter of 2021, subject to certain restrictions. As a result, the Firm announced that its Board of Directors authorized a new
common share repurchase program of $30 billion.
(b) The net impact of employee issuances on stockholdersâ€™ equity is driven by the cost of equity compensation awards that is recognized over the applicable vesting periods. The cost is partially offset by tax impacts related to the distribution of shares and the exercise of employee
stock options and SARs.

Page 10

JPMORGAN CHASE & CO.
CONSUMER & COMMUNITY BANKING
FINANCIAL HIGHLIGHTS
(in millions, except ratio data)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

INCOME STATEMENT
REVENUE
Lending- and deposit-related fees (a) $ 806 $ 771 $ 617 $ 972 $ 1,032 5 % (22) % $ 3,166 $ 3,938 (20) %
Asset management, administration and commissions (a) 735 703 634 708 711 5 3 2,780 2,808 (1)
Mortgage fees and related income 766 1,076 917 320 474 (29) 62 3,079 2,035 51
Card income (b) 923 826 667 652 905 12 2 3,068 3,412 (10)
All other income 1,328 1,487 1,387 1,445 1,469 (11) (10) 5,647 5,603 1
Noninterest revenue 4,558 4,863 4,222 4,097 4,591 (6) (1) 17,740 17,796 â€”
Net interest income 8,170 8,032 8,136 9,190 9,289 2 (12) 33,528 37,337 (10)
TOTAL NET REVENUE 12,728 12,895 12,358 13,287 13,880 (1) (8) 51,268 55,133 (7)
Provision for credit losses (83) 795 5,828 5,772 1,207 NM NM 12,312 4,954 149
NONINTEREST EXPENSE
Compensation expense 2,734 2,804 2,694 2,782 2,668 (2) 2 11,014 10,815 2
Noncompensation expense (b)(c) 4,308 4,108 4,073 4,487 4,448 5 (3) 16,976 17,461 (3)
TOTAL NONINTEREST EXPENSE 7,042 6,912 6,767 7,269 7,116 2 (1) 27,990 28,276 (1)
Income/(loss) before income tax expense/(benefit) 5,769 5,188 (237) 246 5,557 11 4 10,966 21,903 (50)
Income tax expense/(benefit) 1,444 1,317 (61) 49 1,357 10 6 2,749 5,362 (49)
NET INCOME/(LOSS) $ 4,325 $ 3,871 $ (176) $ 197 $ 4,200 12 3 $ 8,217 $ 16,541 (50)
REVENUE BY LINE OF BUSINESS
Consumer & Business Banking $ 5,744 $ 5,697 $ 5,248 $ 6,266 $ 6,668 1 (14) $ 22,955 $ 27,376 (16)
Home Lending 1,456 1,714 1,687 1,161 1,250 (15) 16 6,018 5,179 16
Card & Auto (b) 5,528 5,484 5,423 5,860 5,962 1 (7) 22,295 22,578 (1)
MORTGAGE FEES AND RELATED INCOME DETAILS:
Net production revenue 803 765 742 319 327 5 146 2,629 1,618 62
Net mortgage servicing revenue (d) (37) 311 175 1 147 NM NM 450 417 8
Mortgage fees and related income $ 766 $ 1,076 $ 917 $ 320 $ 474 (29) 62 $ 3,079 $ 2,035 51
FINANCIAL RATIOS
ROE 32 % 29 % (2) % 1 % 31 % 15 % 31 %
Overhead ratio 55 54 55 55 51 55 51
In the fourth quarter of 2020, payment processing-only clients along with the associated revenue and expenses were realigned to CIBâ€™s Wholesale Payments business from CCB and CB. Prior-period amounts have been revised to conform with the current presentation. Refer to
Business segment changes on page 21 of the Firmâ€™s Quarterly Report on Form 10-Q for the quarterly period ended March 31, 2020 for further information.
In the fourth quarter of 2020, the Firm realigned certain wealth management clients from AWM to CCB. Prior-period amounts have been revised to conform with the current presentation. Refer to page 29 for further information.
(a) In the first quarter of 2020, the Firm reclassified certain fees from asset management, administration and commissions to lending- and deposit-related fees. Prior-period amounts have been revised to conform with the current presentation.
(b) In the second quarter of 2020, the Firm reclassified certain spend-based credit card reward costs from marketing expense to be a reduction of card income, with no effect on net income. Prior-period amounts have been revised to conform with the current presentation.
(c) Included depreciation expense on leased assets of $975 million and $1.0 billion for the three months ended December 31, 2020 and September 30, 2020, and $1.1 billion for the three months ended June 30, 2020, March 31, 2020 and December 31, 2019, respectively, and
$4.2 billion and $4.0 billion for the full year 2020 and 2019, respectively.
(d) Included MSR risk management results of $(152) million, $145 million, $79 million, $(90) million and $35 million for the three months ended December 31, 2020, September 30, 2020, June 30, 2020, March 31, 2020, and December 31, 2019, respectively, and $(18) million and
$(165) million for the full year 2020 and 2019, respectively.

Page 11

JPMORGAN CHASE & CO.
CONSUMER & COMMUNITY BANKING
FINANCIAL HIGHLIGHTS, CONTINUED
(in millions, except headcount data)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

SELECTED BALANCE SHEET DATA (period-end)
Total assets $ 496,654 $ 487,012 $ 498,607 $ 513,301 $ 541,316 2 % (8) % $ 496,654 $ 541,316 (8) %
Loans:
Consumer & Business Banking 48,810 (d) 49,646 (d) 49,305 (d) 30,004 29,585 (2) 65 48,810 (d) 29,585 65
Home Lending (a)(b) 182,121 188,561 195,664 205,318 213,445 (3) (15) 182,121 213,445 (15)
Card 144,216 140,377 141,656 154,021 168,924 3 (15) 144,216 168,924 (15)
Auto 66,432 62,304 59,287 61,468 61,522 7 8 66,432 61,522 8
Total loans 441,579 440,888 445,912 450,811 473,476 â€” (7) 441,579 473,476 (7)
Deposits 958,706 909,198 885,535 783,398 723,418 5 33 958,706 723,418 33
Equity 52,000 52,000 52,000 52,000 52,000 â€” â€” 52,000 52,000 â€”
SELECTED BALANCE SHEET DATA (average)
Total assets $ 486,221 $ 490,043 $ 504,520 $ 525,644 $ 534,596 (1) (9) $ 501,533 $ 543,076 (8)
Loans:
Consumer & Business Banking 49,506 49,596 43,442 29,570 29,192 â€” 70 43,064 28,859 49
Home Lending (a)(c) 185,733 192,172 199,532 211,333 216,921 (3) (14) 197,148 230,662 (15)
Card 141,236 140,386 142,377 162,660 162,112 1 (13) 146,633 156,325 (6)
Auto 64,342 60,345 60,306 60,893 61,100 7 5 61,476 61,862 (1)
Total loans 440,817 442,499 445,657 464,456 469,325 â€” (6) 448,321 477,708 (6)
Deposits 928,518 895,535 840,467 739,709 712,829 4 30 851,390 698,378 22
Equity 52,000 52,000 52,000 52,000 52,000 â€” â€” 52,000 52,000 â€”
Headcount 122,894 122,905 123,765 124,609 125,756 â€” (2) 122,894 125,756 (2)
In the fourth quarter of 2020, payment processing-only clients along with the associated revenue and expenses were realigned to CIBâ€™s Wholesale Payments business from CCB and CB. Prior-period amounts have been revised to conform with the current presentation. Refer to
Business segment changes on page 21 of the Firmâ€™s Quarterly Report on Form 10-Q for the quarterly period ended March 31, 2020 for further information.
In the fourth quarter of 2020, the Firm realigned certain wealth management clients from AWM to CCB. Prior-period amounts have been revised to conform with the current presentation. Refer to page 29 for further information.
(a) In the third quarter of 2020, the Firm reclassified certain fair value option elected lending-related positions from trading assets to loans. Prior-period amounts have been revised to conform with the current presentation.
(b) At December 31, 2020, September 30, 2020, June 30, 2020, March 31, 2020 and December 31, 2019, Home Lending loans held-for-sale and loans at fair value were $9.7 billion, $10.0 billion, $8.6 billion, $10.8 billion, and $16.6 billion, respectively.
(c) Average Home Lending loans held-for sale and loans at fair value were $10.7 billion, $9.2 billion, $8.7 billion, $15.8 billion, and $19.1 billion for the three months ended December 31, 2020, September 30, 2020, June 30, 2020, March 31, 2020 and December 31, 2019,
respectively, and were $11.1 billion and $14.1 billion for the full year 2020 and 2019, respectively.
(d) At December 31, 2020, September 30, 2020 and June 30, 2020, included $19.2 billion, $20.3 billion and $19.9 billion of loans, respectively, in Business Banking under the Paycheck Protection Program (â€œPPPâ€). Refer to page 61 of the Firmâ€™s Quarterly Report on Form 10-Q
for the quarterly period ended September 30, 2020 for further information on the PPP.

Page 12

JPMORGAN CHASE & CO.
CONSUMER & COMMUNITY BANKING
FINANCIAL HIGHLIGHTS, CONTINUED
(in millions, except ratio data) QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

CREDIT DATA AND QUALITY STATISTICS
Nonaccrual loans (a)(b)(c) $ 5,675 (f) $ 5,162 (f)(i) $ 4,429 (f) $ 4,022 $ 3,027 10 % 87 % $ 5,675 (f) $ 3,027 87 %
Net charge-offs/(recoveries)
Consumer & Business Banking 75 54 60 74 93 39 (19) 263 298 (12)
Home Lending (50) 8 (5) (122) (23) NM (117) (169) (98) (72)
Card 767 1,028 1,178 1,313 1,231 (25) (38) 4,286 4,848 (12)
Auto 25 5 45 48 57 400 (56) 123 206 (40)
Total net charge-offs/(recoveries) $ 817 $ 1,095 $ 1,278 $ 1,313 $ 1,358 (25) (40) $ 4,503 $ 5,254 (14)
Net charge-off/(recovery) rate
Consumer & Business Banking 0.60 % (g) 0.43 % (g) 0.56 % (g) 1.01 % 1.26 % 0.61 % (g) 1.03 %
Home Lending (0.11) 0.02 (0.01) (0.25) (0.05) (0.09) (0.05)
Card 2.17 2.92 3.33 3.25 3.01 2.93 3.10
Auto 0.15 0.03 0.30 0.32 0.37 0.20 0.33
Total net charge-off/(recovery) rate 0.76 1.01 1.18 1.18 1.20 1.03 1.13
30+ day delinquency rate
Home Lending (d)(e) 1.15 % (h) 1.62 % (h) 1.30 % (h) 1.48 % 1.58 % 1.15 % (h) 1.58 %
Card 1.68 (h) 1.57 (h) 1.71 (h) 1.96 1.87 1.68 (h) 1.87
Auto 0.69 (h) 0.54 (h) 0.54 (h) 0.89 0.94 0.69 (h) 0.94
90+ day delinquency rate - Card 0.92 (h) 0.69 (h) 0.93 (h) 1.02 0.95 0.92 (h) 0.95
Allowance for loan losses
Consumer & Business Banking $ 1,372 $ 1,372 $ 1,372 $ 884 $ 750 â€” 83 $ 1,372 $ 750 83
Home Lending 1,813 2,685 2,957 2,137 1,890 (32) (4) 1,813 1,890 (4)
Card 17,800 17,800 17,800 14,950 5,683 â€” 213 17,800 5,683 213
Auto 1,042 1,044 1,044 732 465 â€” 124 1,042 465 124
Total allowance for loan losses $ 22,027 $ 22,901 $ 23,173 $ 18,703 $ 8,788 (4) 151 $ 22,027 $ 8,788 151
In the fourth quarter of 2020, the Firm realigned certain wealth management clients from AWM to CCB. Prior-period amounts have been revised to conform with the current presentation. Refer to page 29 for further information.
(a) At December 31, 2020, September 30, 2020, June 30, 2020 and March 31, 2020, nonaccrual loans included $1.6 billion, $1.5 billion, $1.3 billion and $970 million of PCD loans, respectively. Prior to the adoption of CECL, nonaccrual loans excluded PCI loans as the Firm
recognized interest income on each pool of PCI loans as each of the pools was performing.
(b) At December 31, 2020, September 30, 2020, June 30, 2020, March 31, 2020 and December 31, 2019, nonaccrual loans excluded mortgage loans 90 or more days past due and insured by U.S. government agencies of $558 million, $851 million, $561 million, $616 million
and $963 million, respectively. These amounts have been excluded based upon the government guarantee. Prior-period amounts of mortgage loans 90 or more days past due and insured by U.S. government agencies excluded from nonaccrual loans have been revised to
conform with the current presentation, refer to footnote (c) for additional information.
(c) In the third quarter of 2020, the Firm reclassified certain fair value option elected lending-related positions from trading assets to loans. Prior-period amounts have been revised to conform with the current presentation.
(d) At December 31, 2020, September 30, 2020, June 30, 2020 and March 31, 2020, the 30+ day delinquency rates included PCD loans. The rates prior to January 1, 2020 have been revised to include the impact of PCI loans.
(e) At December 31, 2020, September 30, 2020, June 30, 2020, March 31, 2020 and December 31, 2019, excluded mortgage loans 30 or more days past due and insured by U.S. government agencies of $744 million, $1.1 billion, $826 million, $1.0 billion and $1.7 billion,
respectively. These amounts have been excluded based upon the government guarantee. Prior-period amounts of mortgage loans 30 or more days past due and insured by U.S. government agencies excluded from 30+ day delinquency rate have been revised to conform
with the current presentation, refer to footnote (c) for additional information.
(f) Generally excludes loans that were under payment deferral programs offered in response to the COVID-19 pandemic. Includes loans to customers that have exited COVID-19 payment deferral programs and are 90 or more days past due, predominantly all of which were
considered collateral-dependent and charged down to the lower of amortized cost or fair value of the underlying collateral less costs to sell.
(g) At December 31, 2020, September 30, 2020 and June 30, 2020, included $19.2 billion, $20.3 billion and $19.9 billion of loans, respectively, under the PPP. Given that PPP loans are guaranteed by the SBA, the Firm does not expect to realize material credit losses on these
loans. Refer to page 61 of the Firmâ€™s Quarterly Report on Form 10-Q for the quarterly period ended September 30, 2020 for further information on the PPP.
(h) At December 31, 2020, September 30, 2020 and June 30, 2020, the principal balance of loans under payment deferral programs offered in response to the COVID-19 pandemic were as follows: (1) $9.1 billion, $10.2 billion and $18.2 billion in Home Lending, respectively;
(2)$264 million, $368 million and $4.4 billion in Card, respectively; and (3) $376 million, $411 million and $12.3 billion in Auto, respectively. Loans that are performing according to their modified terms are generally not considered delinquent.
(i) Prior-period amount has been revised to conform with the current presentation.

Page 13

JPMORGAN CHASE & CO.
CONSUMER & COMMUNITY BANKING
FINANCIAL HIGHLIGHTS, CONTINUED
(in millions, except ratio data and where otherwise noted)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

BUSINESS METRICS
Number of:
Branches 4,908 4,960 4,923 4,967 4,976 (1) % (1) % 4,908 4,976 (1) %
Active digital customers (in thousands) (a) 55,274 54,779 54,505 53,833 52,453 1 5 55,274 52,453 5
Active mobile customers (in thousands) (b) 40,899 40,164 39,044 38,256 37,315 2 10 40,899 37,315 10
Debit and credit card sales volume (in billions) $ 299.4 $ 278.2 $ 237.6 $ 266.0 $ 295.6 8 1 $ 1,081.2 $ 1,114.4 (3)
Consumer & Business Banking
Average deposits $ 907,884 $ 874,325 $ 821,624 $ 724,970 $ 696,572 4 30 $ 832,523 $ 683,707 22
Deposit margin 1.41 % 1.43 % 1.52 % 2.05 % 2.27 % 1.58 % 2.48 %
Business banking origination volume $ 722 $ 1,352 (f) $ 23,042 (f) $ 1,491 $ 1,827 (47) (60) $ 26,607 (f) $ 6,598 303
Client investment assets 588,403 529,196 494,390 442,634 501,360 11 17 588,403 501,360 17
Home Lending (in billions)
Mortgage origination volume by channel
Retail $ 20.1 $ 20.7 $ 18.0 $ 14.1 $ 16.4 (3) 23 $ 72.9 $ 51.0 43
Correspondent 12.4 8.3 6.2 14.0 16.9 49 (27) 40.9 54.2 (25)
Total mortgage origination volume (c) $ 32.5 $ 29.0 $ 24.2 $ 28.1 $ 33.3 12 (2) $ 113.8 $ 105.2 8
Total loans serviced (period-end) $ 626.3 $ 654.0 $ 683.7 $ 737.8 $ 761.4 (4) (18) $ 626.3 $ 761.4 (18)
Third-party mortgage loans serviced (period-end) 447.3 454.8 482.4 505.0 520.8 (2) (14) 447.3 520.8 (14)
MSR carrying value (period-end) 3.3 3.0 3.1 3.3 4.7 10 (30) 3.3 4.7 (30)
Ratio of MSR carrying value (period-end) to third-party
mortgage loans serviced (period-end) 0.74 % 0.66 % 0.64 % 0.65 % 0.90 % 0.74 % 0.90 %
MSR revenue multiple (d) 2.64 x 2.28 x 2.29 x 2.10 x 2.73 x 2.55 x 2.65 x
Credit Card
Credit card sales volume, excluding Commercial Card (in billions) $ 197.0 $ 178.1 $ 148.5 $ 179.1 $ 204.2 11 (4) 702.7 762.8 (8)
Net revenue rate (e) 11.22 % 10.96 % 11.02 % 10.54 % 10.65 % 10.92 % 10.48 %
Auto
Loan and lease origination volume (in billions) $ 11.0 $ 11.4 $ 7.7 $ 8.3 $ 8.5 (4) 29 $ 38.4 $ 34.0 13
Average auto operating lease assets 20,810 21,684 22,579 23,081 22,427 (4) (7) 22,034 21,589 2
In the fourth quarter of 2020, the Firm realigned certain wealth management clients from AWM to CCB. Prior-period amounts have been revised to conform with the current presentation. Refer to page 29 for further information.
(a) Users of all web and/or mobile platforms who have logged in within the past 90 days.
(b) Users of all mobile platforms who have logged in within the past 90 days.
(c) Firmwide mortgage origination volume was $37.0 billion, $36.2 billion, $28.3 billion, $31.9 billion and $37.4 billion for the three months ended December 31, 2020, September 30, 2020, June 30, 2020, March 31, 2020 and December 31, 2019, respectively, and $133.4
billion and $115.9 billion for the full year 2020 and 2019, respectively.
(d) Represents the ratio of MSR carrying value (period-end) to third-party mortgage loans serviced (period-end) divided by the ratio of annualized loan servicing-related revenue to third-party mortgage loans serviced (average).
(e) In the second quarter of 2020, the Firm reclassified certain spend-based credit card reward costs from marketing expense to be a reduction of card income, with no effect on net income. Prior-period amounts have been revised to conform with the current presentation.
(f) Included $396 million and $21.5 billion of origination volume under the PPP for the three months ended September 30, 2020 and June 30, 2020, respectively, and $21.9 billion for the full year 2020. Refer to page 61 of the Firmâ€™s Quarterly Report on Form 10-Q for the
quarterly period ended September 30, 2020 for further information on the PPP.

Page 14

JPMORGAN CHASE & CO.
CORPORATE & INVESTMENT BANK
FINANCIAL HIGHLIGHTS
(in millions, except ratio data)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

INCOME STATEMENT
REVENUE
Investment banking fees $ 2,558 $ 2,165 $ 2,847 $ 1,907 $ 1,904 18 % 34 % $ 9,477 $ 7,575 25 %
Principal transactions 2,982 3,990 7,400 3,188 2,932 (25) 2 17,560 14,399 22
Lending- and deposit-related fees (a) 574 546 500 450 462 5 24 2,070 1,668 24
Asset management, administration and commissions (a) 1,226 1,086 1,148 1,261 1,059 13 16 4,721 4,400 7
All other income 462 331 409 90 678 40 (32) 1,292 2,018 (36)
Noninterest revenue 7,802 8,118 12,304 6,896 7,035 (4) 11 35,120 30,060 17
Net interest income 3,550 3,428 4,079 3,107 2,668 4 33 14,164 9,205 54
TOTAL NET REVENUE (b) 11,352 11,546 16,383 10,003 9,703 (2) 17 49,284 39,265 26
Provision for credit losses (581) (81) 1,987 1,401 98 NM NM 2,726 277 NM
NONINTEREST EXPENSE
Compensation expense 1,958 2,651 3,997 3,006 2,377 (26) (18) 11,612 11,180 4
Noncompensation expense 2,981 3,181 2,815 2,949 3,074 (6) (3) 11,926 11,264 6
TOTAL NONINTEREST EXPENSE 4,939 5,832 6,812 5,955 5,451 (15) (9) 23,538 22,444 5
Income before income tax expense 6,994 5,795 7,584 2,647 4,154 21 68 23,020 16,544 39
Income tax expense 1,645 1,486 2,133 662 1,219 11 35 5,926 4,590 29
NET INCOME $ 5,349 $ 4,309 $ 5,451 $ 1,985 $ 2,935 24 82 $ 17,094 $ 11,954 43
FINANCIAL RATIOS
ROE 26 % 21 % 27 % 9 % 14 % 20 % 14 %
Overhead ratio 44 51 42 60 56 48 57
Compensation expense as percentage of total net revenue 17 23 24 30 24 24 28
REVENUE BY BUSINESS
Investment Banking $ 2,497 $ 2,087 $ 3,401 $ 886 $ 1,823 20 37 $ 8,871 $ 7,215 23
Wholesale Payments 1,427 1,332 1,387 1,414 1,489 7 (4) 5,560 5,842 (5)
Lending 193 333 270 350 250 (42) (23) 1,146 1,021 12
Total Banking 4,117 3,752 5,058 2,650 3,562 10 16 15,577 14,078 11
Fixed Income Markets 3,950 4,597 7,338 4,993 3,446 (14) 15 20,878 14,418 45
Equity Markets 1,989 1,999 2,380 2,237 1,508 (1) 32 8,605 6,494 33
Securities Services 1,053 1,029 1,097 1,074 1,061 2 (1) 4,253 4,154 2
Credit Adjustments & Other (c) 243 169 510 (951) 126 44 93 (29) 121 NM
Total Markets & Securities Services 7,235 7,794 11,325 7,353 6,141 (7) 18 33,707 25,187 34
TOTAL NET REVENUE $ 11,352 $ 11,546 $ 16,383 $ 10,003 $ 9,703 (2) 17 $ 49,284 $ 39,265 26
In the fourth quarter of 2020, payment processing-only clients along with the associated revenue and expenses were realigned to CIBâ€™s Wholesale Payments business from CCB and CB. Prior-period amounts have been revised to conform with the current presentation. Refer to
Business segment changes on page 21 of the Firmâ€™s Quarterly Report on Form 10-Q for the quarterly period ended March 31, 2020 for further information.
(a) In the first quarter of 2020, the Firm reclassified certain fees from asset management, administration and commissions to lending- and deposit-related fees. Prior-period amounts have been revised to conform with the current presentation.
(b) Includes tax-equivalent adjustments, predominantly due to income tax credits related to alternative energy investments; income tax credits and amortization of the cost of investments in affordable housing projects; as well as tax-exempt income from municipal bonds of
$765 million, $641 million, $686 million, $667 million and $646 million for the three months ended December 31, 2020, September 30, 2020, June 30, 2020, March 31, 2020, and December 31, 2019, respectively and $2.8 billion and $2.3 billion for the full year 2020 and 2019,
respectively.
(c) Consists primarily of credit valuation adjustments (â€œCVAâ€) managed centrally within CIB and funding valuation adjustments (â€œFVAâ€) on derivatives and certain components of fair value option elected liabilities. Results are presented net of associated hedging activities and net of
CVA and FVA amounts allocated to Fixed Income Markets and Equity Markets.

Page 15

JPMORGAN CHASE & CO.
CORPORATE & INVESTMENT BANK
FINANCIAL HIGHLIGHTS, CONTINUED
(in millions, except ratio and headcount data)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

SELECTED BALANCE SHEET DATA (period-end)
Assets $ 1,097,219 $ 1,089,293 $ 1,081,162 (g) $ 1,217,459 $ 914,705 1 % 20 % $ 1,097,219 $ 914,705 20 %
Loans:
Loans retained (a) 133,296 126,841 140,770 165,376 121,733 5 9 133,296 121,733 9
Loans held-for-sale and loans at fair value (b) 39,588 33,046 34,017 34,644 34,317 20 15 39,588 34,317 15
Total loans 172,884 159,887 174,787 200,020 156,050 8 11 172,884 156,050 11
Equity 80,000 80,000 80,000 80,000 80,000 â€” â€” 80,000 80,000 â€”
SELECTED BALANCE SHEET DATA (average)
Assets $ 1,140,524 $ 1,100,657 $ 1,167,807 $ 1,082,820 $ 994,152 4 15 1,122,939 $ 993,508 13
Trading assets - debt and equity instruments (b) 442,443 425,789 421,953 398,504 370,859 4 19 422,237 376,182 12
Trading assets - derivative receivables 77,946 78,339 76,710 55,133 45,153 (1) 73 72,065 48,196 50
Loans:
Loans retained (a) 128,765 131,187 154,038 128,838 119,412 (2) 8 135,676 122,371 11
Loans held-for-sale and loans at fair value (b) 36,228 30,205 33,538 35,211 33,694 20 8 33,792 32,884 3
Total loans 164,993 161,392 187,576 164,049 153,106 2 8 169,468 155,255 9
Equity 80,000 80,000 80,000 80,000 80,000 â€” â€” 80,000 80,000 â€”
Headcount 61,733 61,830 60,950 60,245 60,013 â€” 3 61,733 60,013 3
CREDIT DATA AND QUALITY STATISTICS
Net charge-offs/(recoveries) $ 88 $ 23 $ 204 $ 55 $ 43 283 105 $ 370 $ 183 102
Nonperforming assets:
Nonaccrual loans:
Nonaccrual loans retained (c) 1,008 1,178 1,195 689 308 (14) 227 1,008 308 227
Nonaccrual loans held-for-sale and loans at fair value (b)(d) 1,662 2,111 1,510 766 644 (21) 158 1,662 644 158
Total nonaccrual loans 2,670 3,289 2,705 1,455 952 (19) 180 2,670 952 180
Derivative receivables 56 140 108 85 30 (60) 87 56 30 87
Assets acquired in loan satisfactions 85 88 35 43 70 (3) 21 85 70 21
Total nonperforming assets 2,811 3,517 2,848 1,583 1,052 (20) 167 2,811 1,052 167
Allowance for credit losses:
Allowance for loan losses 2,366 2,863 3,039 (g) 1,422 1,202 (17) 97 2,366 1,202 97
Allowance for lending-related commitments 1,534 1,706 1,634 (g) 1,468 848 (10) 81 1,534 848 81
Total allowance for credit losses 3,900 4,569 4,673 2,890 2,050 (15) 90 3,900 2,050 90
Net charge-off/(recovery) rate (a)(e) 0.27 % 0.07 % 0.53 % 0.17 % 0.14 % 0.27 % 0.15 %
Allowance for loan losses to period-end loans retained (a) 1.77 2.26 2.16 (g) 0.86 0.99 1.77 0.99
Allowance for loan losses to period-end loans retained,
excluding trade finance and conduits (f) 2.54 3.15 2.87 (g) 1.11 1.31 2.54 1.31
Allowance for loan losses to nonaccrual loans retained (a)(c) 235 243 254 (g) 206 390 235 390
Nonaccrual loans to total period-end loans (b) 1.54 2.06 1.55 0.73 0.61 1.54 0.61
In the fourth quarter of 2020, payment processing-only clients along with the associated revenue and expenses were realigned to CIBâ€™s Wholesale Payments business from CCB and CB. Prior-period amounts have been revised to conform with the current presentation. Refer to
Business segment changes on page 21 of the Firmâ€™s Quarterly Report on Form 10-Q for the quarterly period ended March 31, 2020 for further information.
(a) Loans retained includes credit portfolio loans, loans held by consolidated Firm-administered multi-seller conduits, trade finance loans, other held-for-investment loans and overdrafts.
(b) In the third quarter of 2020, the Firm reclassified certain fair value option elected lending-related positions from trading assets to loans and other assets. Prior-period amounts have been revised to conform with the current presentation.
(c) Allowance for loan losses of $278 million, $320 million, $340 million, $317 million and $110 million were held against nonaccrual loans at December 31, 2020, September 30, 2020, June 30, 2020, March 31, 2020, and December 31, 2019, respectively.
(d) At December 31, 2020, September 30, 2020, June 30, 2020, March 31, 2020 and December 31, 2019, nonaccrual loans excluded mortgage loans 90 or more days past due and insured by U.S. government agencies of $316 million, $297 million, $135 million, $124 million
and $127 million, respectively. These amounts have been excluded based upon the government guarantee.
(e) Loans held-for-sale and loans at fair value were excluded when calculating the net charge-off/(recovery) rate.
(f) Management uses allowance for loan losses to period-end loans retained, excluding trade finance and conduits, a non-GAAP financial measure, to provide a more meaningful assessment of CIBâ€™s allowance coverage ratio.
(g) Prior-period amounts have been revised to conform with the current presentation.

Page 16

JPMORGAN CHASE & CO.
CORPORATE & INVESTMENT BANK
FINANCIAL HIGHLIGHTS, CONTINUED
(in millions, except where otherwise noted)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

BUSINESS METRICS
Advisory $ 835 $ 428 $ 602 $ 503 $ 702 95 % 19 % $ 2,368 $ 2,377 â€” %
Equity underwriting 718 732 977 331 382 (2) 88 2,758 1,666 66
Debt underwriting 1,005 1,005 1,268 1,073 820 â€” 23 4,351 3,532 23
Total investment banking fees $ 2,558 $ 2,165 $ 2,847 $ 1,907 $ 1,904 18 34 $ 9,477 $ 7,575 25
Client deposits and other third-party liabilities (average) (a) 683,818 634,961 607,902 514,464 485,037 8 41 610,555 464,795 31
Merchant processing volume (in billions) (b) 444.5 406.1 371.9 374.8 402.9 9 10 $ 1,597.3 $ 1,511.5 6
Assets under custody (â€œAUCâ€) (period-end) (in billions) $ 30,980 $ 28,628 $ 27,447 $ 24,409 $ 26,831 8 15 $ 30,980 $ 26,831 15
95% Confidence Level - Total CIB VaR (average) (c)
CIB trading VaR by risk type: (d)
Fixed income $ 106 $ 93 $ 129 $ 60 $ 39 14 172
Foreign exchange 12 13 9 7 5 (8) 140
Equities 23 26 27 20 18 (12) 28
Commodities and other 36 33 32 10 7 9 414
Diversification benefit to CIB trading VaR (e) (85) (76) (69) (40) (32) (12) (166)
CIB trading VaR (d) 92 89 128 57 37 3 149
Credit portfolio VaR (f) 12 15 22 9 5 (20) 140
Diversification benefit to CIB VaR (e) (13) (14) (23) (8) (5) 7 (160)
CIB VaR $ 91 $ 90 $ 127 $ 58 $ 37 1 146

(a) Client deposits and other third-party liabilities pertain to the Wholesale Payments and Securities Services businesses.
(b) Represents total merchant processing volume across CIB, CCB and CB.

(c) Effective January 1, 2020, the Firm refined the scope of VaR to exclude positions related to the risk management of interest rate exposure from changes in the Firmâ€™s own credit spread on fair value option elected liabilities, and included these positions in other sensitivity-
based measures. Additionally, effective July 1, 2020, the Firm refined the scope of VaR to exclude certain asset-backed fair value option elected loans, and included them in other sensitivity-based measures to more effectively measure the risk from these loans. In the absence

of these refinements, the average VaR for each of the following reported components would have been different by the following amounts: CIB fixed income of $33 million, $15 million, $(11) million and $4 million, CIB Trading VaR of $30 million, $11 million, $(11) million and $5
million and CIB VaR of $29 million, $11 million, $(8) million and $6 million for the three months ended December 31, 2020, September 30, 2020, June 30, 2020 and March 31, 2020, respectively.
(d) CIB trading VaR includes substantially all market-making and client-driven activities, as well as certain risk management activities in CIB, including credit spread sensitivity to CVA. Refer to VaR measurement on pages 121â€“123 of the Firmâ€™s 2019 Form 10-K, and pages 80â€“82
of the Firmâ€™s Quarterly Report on Form 10-Q for the quarterly period ended September 30, 2020 for further information.
(e) Average portfolio VaR was less than the sum of the VaR of the components described above, which is due to portfolio diversification. The diversification effect reflects the fact that the risks were not perfectly correlated.
(f) Credit portfolio VaR includes the derivative CVA, hedges of the CVA and hedges of the retained loan portfolio, which are reported in principal transactions revenue. This VaR does not include the retained loan portfolio, which is not reported at fair value.

Page 17

JPMORGAN CHASE & CO.
COMMERCIAL BANKING
FINANCIAL HIGHLIGHTS
(in millions, except ratio data)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

INCOME STATEMENT
REVENUE
Lending- and deposit-related fees (a) $ 325 $ 304 $ 297 $ 261 $ 256 7 % 27 % $ 1,187 $ 941 26 %
All other income (a) 550 457 526 347 436 20 26 1,880 1,769 6
Noninterest revenue 875 761 823 608 692 15 26 3,067 2,710 13
Net interest income 1,588 1,524 1,577 1,557 1,604 4 (1) 6,246 6,554 (5)
TOTAL NET REVENUE (b) 2,463 2,285 2,400 2,165 2,296 8 7 9,313 9,264 1
Provision for credit losses (1,181) (147) 2,431 1,010 110 NM NM 2,113 296 NM
NONINTEREST EXPENSE
Compensation expense 460 492 430 472 444 (7) 4 1,854 1,785 4
Noncompensation expense 490 477 463 514 497 3 (1) 1,944 1,950 â€”
TOTAL NONINTEREST EXPENSE 950 969 893 986 941 (2) 1 3,798 3,735 2
Income/(loss) before income tax expense/(benefit) 2,694 1,463 (924) 169 1,245 84 116 3,402 5,233 (35)
Income tax expense/(benefit) 660 377 (243) 30 300 75 120 824 1,275 (35)
NET INCOME/(LOSS) $ 2,034 $ 1,086 $ (681) $ 139 $ 945 87 115 $ 2,578 $ 3,958 (35)
Revenue by product
Lending $ 1,177 $ 1,138 $ 1,127 $ 954 $ 1,027 3 15 $ 4,396 $ 4,057 8
Wholesale payments 945 867 925 978 1,020 9 (7) 3,715 4,200 (12)
Investment banking (c) 318 260 256 235 211 22 51 1,069 919 16
Other 23 20 92 (2) 38 15 (39) 133 88 51
Total Commercial Banking net revenue (b) $ 2,463 $ 2,285 $ 2,400 $ 2,165 $ 2,296 8 7 $ 9,313 $ 9,264 1
Investment banking revenue, gross (d) $ 971 $ 840 $ 851 $ 686 $ 634 16 53 $ 3,348 $ 2,744 22
Revenue by client segment
Middle Market Banking $ 947 $ 880 $ 870 $ 943 $ 937 8 1 $ 3,640 $ 3,805 (4)
Corporate Client Banking 856 808 866 673 758 6 13 3,203 3,119 3
Commercial Real Estate Banking 630 576 566 541 537 9 17 2,313 2,169 7
Other 30 21 98 8 64 43 (53) 157 171 (8)
Total Commercial Banking net revenue (b) $ 2,463 $ 2,285 $ 2,400 $ 2,165 $ 2,296 8 7 $ 9,313 $ 9,264 1
FINANCIAL RATIOS
ROE 36 % 19 % (13) % 2 % 16 % 11 % 17 %
Overhead ratio 39 42 37 46 41 41 40
In the fourth quarter of 2020, payment processing-only clients along with the associated revenue and expenses were realigned to CIBâ€™s Wholesale Payments business from CCB and CB. Prior-period amounts have been revised to conform with the current presentation. Refer to
Business segment changes on page 21 of the Firmâ€™s Quarterly Report on Form 10-Q for the quarterly period ended March 31, 2020 for further information.
(a) In the first quarter of 2020, the Firm reclassified certain fees from asset management, administration and commissions (which are included in all other income) to lending- and deposit-related fees. Prior-period amounts have been revised to conform with the current presentation.
(b) Total net revenue included tax-equivalent adjustments from income tax credits related to equity investments in designated community development entities and in entities established for rehabilitation of historic properties, as well as tax-exempt income related to municipal
financing activities of $108 million, $82 million, $80 million, $81 million and $152 million for the three months ended December 31, 2020, September 30, 2020, June 30, 2020, March 31, 2020, and December 31, 2019, respectively, and $351 million and $460 million for the full
year 2020 and 2019, respectively.
(c) Includes CBâ€™s share of revenue from investment banking products sold to CB clients through the CIB.
(d) Refer to page 60 of the Firmâ€™s 2019 Form 10-K for discussion of revenue sharing.

Page 18

JPMORGAN CHASE & CO.
COMMERCIAL BANKING
FINANCIAL HIGHLIGHTS, CONTINUED
(in millions, except headcount and ratio data) QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

SELECTED BALANCE SHEET DATA (period-end)
Total assets $ 228,932 $ 228,587 $ 235,034 (d) $ 247,786 $ 220,514 â€” % 4 % $ 228,932 $ 220,514 4 %
Loans:
Loans retained 207,880 214,352 223,192 232,254 207,287 (3) â€” 207,880 207,287 â€”
Loans held-for-sale and loans at fair value 2,245 349 917 1,112 1,009 NM 122 2,245 1,009 122
Total loans $ 210,125 $ 214,701 $ 224,109 $ 233,366 $ 208,296 (2) 1 $ 210,125 $ 208,296 1
Equity 22,000 22,000 22,000 22,000 22,000 â€” â€” 22,000 22,000 â€”
Period-end loans by client segment
Middle Market Banking $ 61,115 (c) $ 61,812 (c) $ 64,211 (c) $ 60,317 $ 54,188 (1) 13 $ 61,115 (c) $ 54,188 13
Corporate Client Banking 47,420 49,857 56,182 69,540 51,165 (5) (7) 47,420 51,165 (7)
Commercial Real Estate Banking 101,146 102,484 103,117 102,799 101,951 (1) (1) 101,146 101,951 (1)
Other 444 548 599 710 992 (19) (55) 444 992 (55)
Total Commercial Banking loans $ 210,125 (c) $ 214,701 (c) $ 224,109 (c) $ 233,366 $ 208,296 (2) 1 $ 210,125 (c) $ 208,296 1
SELECTED BALANCE SHEET DATA (average)
Total assets $ 227,435 $ 231,691 $ 247,512 $ 226,071 $ 219,891 (2) 3 $ 233,158 $ 218,896 7
Loans:
Loans retained 210,621 217,498 233,044 209,988 208,776 (3) 1 217,767 206,837 5
Loans held-for-sale and loans at fair value 1,554 629 502 1,831 1,036 147 50 1,129 1,082 4
Total loans $ 212,175 $ 218,127 $ 233,546 $ 211,819 $ 209,812 (3) 1 $ 218,896 $ 207,919 5
Client deposits and other third-party liabilities 276,694 248,289 236,968 188,808 182,546 11 52 237,825 172,734 38
Equity 22,000 22,000 22,000 22,000 22,000 â€” â€” 22,000 22,000 â€”
Average loans by client segment
Middle Market Banking $ 60,869 $ 63,029 $ 66,279 $ 56,045 $ 54,114 (3) 12 $ 61,558 $ 55,690 11
Corporate Client Banking 48,825 51,608 63,308 53,032 53,187 (5) (8) 54,172 50,360 8
Commercial Real Estate Banking 101,969 102,905 103,516 101,526 101,542 (1) â€” 102,479 100,884 2
Other 512 585 443 1,216 969 (12) (47) 687 985 (30)
Total Commercial Banking loans $ 212,175 $ 218,127 $ 233,546 $ 211,819 $ 209,812 (3) 1 $ 218,896 $ 207,919 5
Headcount 11,675 11,704 11,802 11,779 11,629 â€” â€” 11,675 11,629 â€”
CREDIT DATA AND QUALITY STATISTICS
Net charge-offs/(recoveries) $ 162 $ 60 $ 79 $ 100 $ 89 170 82 $ 401 $ 160 151
Nonperforming assets
Nonaccrual loans:
Nonaccrual loans retained (a) 1,286 1,468 1,252 (d) 793 498 (12) 158 1,286 498 158
Nonaccrual loans held-for-sale and loans
at fair value 120 85 125 (d) â€” â€” 41 NM 120 â€” NM
Total nonaccrual loans 1,406 1,553 1,377 793 498 (9) 182 1,406 498 182
Assets acquired in loan satisfactions 24 24 24 24 25 â€” (4) 24 25 (4)
Total nonperforming assets 1,430 1,577 1,401 817 523 (9) 173 1,430 523 173
Allowance for credit losses:
Allowance for loan losses 3,335 4,466 4,730 (d) 2,680 2,780 (25) 20 3,335 2,780 20
Allowance for lending-related commitments 651 864 807 (d) 505 293 (25) 122 651 293 122
Total allowance for credit losses 3,986 5,330 5,537 3,185 3,073 (25) 30 3,986 3,073 30
Net charge-off/(recovery) rate (b) 0.31 % 0.11 % 0.14 % 0.19 % 0.17 % 0.18 % 0.08 %
Allowance for loan losses to period-end loans retained 1.60 2.08 2.12 (d) 1.15 1.34 1.60 1.34
Allowance for loan losses to nonaccrual loans retained (a) 259 304 378 (d) 338 558 259 558
Nonaccrual loans to period-end total loans 0.67 0.72 0.61 0.34 0.24 0.67 0.24
(a) Allowance for loan losses of $273 million, $367 million, $287 million, $175 million and $114 million was held against nonaccrual loans retained at December 31, 2020, September 30, 2020, June 30, 2020, March 31, 2020, and December 31, 2019, respectively.
(b) Loans held-for-sale and loans at fair value were excluded when calculating the net charge-off/(recovery) rate.
(c) At December 31, 2020, September 30, 2020 and June 30, 2020, total loans included $6.6 billion, $6.6 billion and $6.5 billion of loans, respectively, under the PPP, of which $6.4 billion, $6.4 billion and $6.3 billion was in Middle Market Banking. Refer to page 61 of the Firmâ€™s
Quarterly Report on Form 10-Q for the quarterly period ended September 30, 2020 for further information on the PPP.
(d) Prior-period amounts have been revised to conform with the current presentation.

Page 19

JPMORGAN CHASE & CO.
ASSET & WEALTH MANAGEMENT
FINANCIAL HIGHLIGHTS
(in millions, except ratio and headcount data)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

INCOME STATEMENT
REVENUE
Asset management, administration and commissions $ 2,892 $ 2,646 $ 2,489 $ 2,583 $ 2,552 9 % 13 % $ 10,610 $ 9,818 8 %
All other income 87 93 86 (54) 123 (6) (29) 212 418 (49)
Noninterest revenue 2,979 2,739 2,575 2,529 2,675 9 11 10,822 10,236 6
Net interest income 888 815 855 860 839 9 6 3,418 3,355 2
TOTAL NET REVENUE 3,867 3,554 3,430 3,389 3,514 9 10 14,240 13,591 5
Provision for credit losses (2) (52) 223 94 13 96 NM 263 59 346
NONINTEREST EXPENSE
Compensation expense 1,323 1,232 1,178 1,226 1,275 7 4 4,959 5,028 (1)
Noncompensation expense 1,433 1,211 1,145 1,209 1,167 18 23 4,998 4,719 6
TOTAL NONINTEREST EXPENSE 2,756 2,443 2,323 2,435 2,442 13 13 9,957 9,747 2
Income before income tax expense 1,113 1,163 884 860 1,059 (4) 5 4,020 3,785 6
Income tax expense 327 287 223 191 258 14 27 1,028 918 12
NET INCOME $ 786 $ 876 $ 661 $ 669 $ 801 (10) (2) $ 2,992 $ 2,867 4
REVENUE BY LINE OF BUSINESS
Asset Management $ 2,210 $ 1,924 $ 1,780 $ 1,740 $ 1,892 15 17 $ 7,654 $ 7,254 6
Wealth Management 1,657 1,630 1,650 1,649 1,622 2 2 6,586 6,337 4
TOTAL NET REVENUE $ 3,867 $ 3,554 $ 3,430 $ 3,389 $ 3,514 9 10 $ 14,240 $ 13,591 5
FINANCIAL RATIOS
ROE 29 % 32 % 24 % 25 % 29 % 28 % 26 %
Overhead ratio 71 69 68 72 69 70 72
Pretax margin ratio:
Asset Management 31 30 30 24 30 29 26
Wealth Management 26 35 21 27 30 27 30
Asset & Wealth Management 29 33 26 25 30 28 28
Headcount 20,683 21,058 21,273 21,302 21,550 (2) (4) 20,683 21,550 (4)
Number of Wealth Management client advisors 2,462 2,520 2,409 2,418 2,419 (2) 2 2,462 2,419 2
In the fourth quarter of 2020, the Firm realigned certain wealth management clients from AWM to CCB. Prior-period amounts have been revised to conform with the current presentation. Refer to page 29 for further information.

Page 20

JPMORGAN CHASE & CO.
ASSET & WEALTH MANAGEMENT
FINANCIAL HIGHLIGHTS, CONTINUED
(in millions, except ratio data)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

SELECTED BALANCE SHEET DATA (period-end)
Total assets $ 203,435 $ 187,909 $ 176,833 $ 178,948 $ 173,226 8 % 17 % $ 203,435 $ 173,226 17 %
Loans 186,608 172,695 162,904 163,763 158,149 8 18 186,608 158,149 18
Deposits 198,755 166,049 160,993 160,231 142,740 20 39 198,755 142,740 39
Equity 10,500 10,500 10,500 10,500 10,500 â€” â€” 10,500 10,500 â€”
SELECTED BALANCE SHEET DATA (average)
Total assets $ 193,077 $ 181,901 $ 175,938 $ 174,885 $ 168,192 6 15 $ 181,483 $ 161,914 12
Loans 176,758 167,645 161,196 159,513 153,734 5 15 166,311 147,404 13
Deposits 180,348 162,589 160,102 144,570 138,182 11 31 161,955 135,265 20
Equity 10,500 10,500 10,500 10,500 10,500 â€” â€” 10,500 10,500 â€”
CREDIT DATA AND QUALITY STATISTICS
Net charge-offs $ (16) $ 2 $ (2) $ 2 $ 3 NM NM $ (14) $ 29 NM
Nonaccrual loans 785 956 768 303 115 (18) NM 785 115 NM
Allowance for credit losses:
Allowance for loan losses 598 580 646 436 350 3 71 598 350 71
Allowance for lending-related commitments 38 41 28 14 19 (7) 100 38 19 100
Total allowance for credit losses 636 621 674 450 369 2 72 636 369 72
Net charge-off/(recovery) rate (0.04) % â€” % â€” % 0.01 % 0.01 % (0.01) % 0.02 %
Allowance for loan losses to period-end loans 0.32 0.34 0.40 0.27 0.22 0.32 0.22
Allowance for loan losses to nonaccrual loans 76 61 84 144 304 76 304
Nonaccrual loans to period-end loans 0.42 0.55 0.47 0.19 0.07 0.42 0.07
In the fourth quarter of 2020, the Firm realigned certain wealth management clients from AWM to CCB. Prior-period amounts have been revised to conform with the current presentation. Refer to page 29 for further information.

Page 21

JPMORGAN CHASE & CO.
ASSET & WEALTH MANAGEMENT
FINANCIAL HIGHLIGHTS, CONTINUED
(in billions)

Dec 31, 2020
Change FULL YEAR

Dec 31, Sep 30, Jun 30, Mar 31, Dec 31, Sep 30, Dec 31, 2020 Change
CLIENT ASSETS 2020 2020 2020 2020 2019 2020 2019 2020 2019 2019
Assets by asset class
Liquidity $ 641 $ 674 $ 704 $ 619 $ 539 (5) % 19 % $ 641 $ 539 19 %
Fixed income 671 650 618 574 591 3 14 671 591 14
Equity 595 499 448 361 463 19 29 595 463 29
Multi-asset 656 593 566 517 596 11 10 656 596 10
Alternatives 153 144 140 139 139 6 10 153 139 10
TOTAL ASSETS UNDER MANAGEMENT 2,716 2,560 2,476 2,210 2,328 6 17 2,716 2,328 17
Custody/brokerage/administration/deposits 936 810 765 681 761 16 23 936 761 23
TOTAL CLIENT ASSETS $ 3,652 $ 3,370 $ 3,241 $ 2,891 $ 3,089 8 18 $ 3,652 $ 3,089 18
Assets by client segment
Private Banking $ 689 $ 650 $ 631 $ 577 $ 628 6 10 $ 689 $ 628 10
Institutional 1,273 1,245 1,228 1,107 1,081 2 18 1,273 1,081 18
Retail 754 665 617 526 619 13 22 754 619 22
TOTAL ASSETS UNDER MANAGEMENT $ 2,716 $ 2,560 $ 2,476 $ 2,210 $ 2,328 6 17 $ 2,716 $ 2,328 17
Private Banking $ 1,581 $ 1,422 $ 1,360 $ 1,233 $ 1,359 11 16 $ 1,581 $ 1,359 16
Institutional 1,311 1,278 1,259 1,128 1,106 3 19 1,311 1,106 19
Retail 760 670 622 530 624 13 22 760 624 22
TOTAL CLIENT ASSETS $ 3,652 $ 3,370 $ 3,241 $ 2,891 $ 3,089 8 18 $ 3,652 $ 3,089 18
Assets under management rollforward
Beginning balance $ 2,560 $ 2,476 $ 2,210 $ 2,328 $ 2,210 $ 2,328 $ 1,958
Net asset flows:
Liquidity (36) (30) 93 77 38 104 61
Fixed income 8 22 18 â€” 9 48 104
Equity 14 9 11 (1) (1) 33 (11)
Multi-asset 10 (1) (2) (2) 5 5 2
Alternatives 1 2 3 â€” 1 6 2
Market/performance/other impacts 159 82 143 (192) 66 192 212
Ending balance $ 2,716 $ 2,560 $ 2,476 $ 2,210 $ 2,328 $ 2,716 $ 2,328
Client assets rollforward
Beginning balance $ 3,370 $ 3,241 $ 2,891 $ 3,089 $ 2,930 $ 3,089 $ 2,619
Net asset flows 39 11 135 91 59 276 176
Market/performance/other impacts 243 118 215 (289) 100 287 294
Ending balance $ 3,652 $ 3,370 $ 3,241 $ 2,891 $ 3,089 $ 3,652 $ 3,089
In the fourth quarter of 2020, the Firm realigned certain wealth management clients from AWM to CCB. Prior-period amounts have been revised to conform with the current presentation. Refer to page 29 for further information.

Page 22

JPMORGAN CHASE & CO.
CORPORATE
FINANCIAL HIGHLIGHTS
(in millions, except headcount data)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

INCOME STATEMENT
REVENUE
Principal transactions $ 273 $ 87 $ (2) $ (113) $ (234) 214 % NM $ 245 $ (461) NM
Investment securities gains 70 466 26 233 123 (85) (43) % 795 258 208 %
All other income 249 (210) (91) 211 (6) NM NM 159 89 79
Noninterest revenue 592 343 (67) 331 (117) 73 NM 1,199 (114) NM
Net interest income (841) (682) (687) (165) (111) (23) NM (2,375) 1,325 NM
TOTAL NET REVENUE (a) (249) (339) (754) 166 (228) 27 (9) (1,176) 1,211 NM
Provision for credit losses (42) 96 4 8 (1) NM NM 66 (1) NM
NONINTEREST EXPENSE 361 719 147 146 343 (50) 5 1,373 1,067 29
Income/(loss) before income tax expense/(benefit) (568) (1,154) (905) 12 (570) 51 â€” (2,615) 145 NM
Income tax expense/(benefit) (210) (455) (337) 137 (209) 54 â€” (865) (966) (d) 10
NET INCOME/(LOSS) $ (358) $ (699) $ (568) $ (125) $ (361) 49 1 $ (1,750) $ 1,111 NM
MEMO:
TOTAL NET REVENUE
Treasury and CIO (623) (243) (671) 169 102 (156) NM (1,368) 2,032 NM
Other Corporate 374 (96) (83) (3) (330) NM NM 192 (821) NM
TOTAL NET REVENUE $ (249) $ (339) $ (754) $ 166 $ (228) 27 (9) $ (1,176) $ 1,211 NM
NET INCOME/(LOSS)
Treasury and CIO (587) (349) (550) 83 22 (68) NM (1,403) 1,394 NM
Other Corporate 229 (350) (18) (208) (383) NM NM (347) (283) (23)
TOTAL NET INCOME/(LOSS) $ (358) $ (699) $ (568) $ (125) $ (361) 49 1 $ (1,750) $ 1,111 NM
SELECTED BALANCE SHEET DATA (period-end)
Total assets $ 1,359,831 $ 1,253,275 $ 1,221,980 $ 981,937 $ 837,618 9 62 $ 1,359,831 $ 837,618 62
Loans 1,657 1,569 1,670 1,650 1,649 6 â€” 1,657 1,649 â€”
Headcount 38,366 38,861 38,920 38,785 38,033 (1) 1 38,366 38,033 1
SUPPLEMENTAL INFORMATION
TREASURY and CIO
Investment securities gains $ 70 $ 466 $ 26 $ 233 $ 123 (85) (43) $ 795 $ 258 208
Available-for-sale securities (average) 410,803 442,943 426,470 372,954 350,100 (7) 17 413,367 283,205 46
Held-to-maturity securities (average) 155,525 103,596 71,713 46,673 42,125 50 269 94,569 34,939 171
Investment securities portfolio (average) $ 566,328 $ 546,539 $ 498,183 $ 419,627 $ 392,225 4 44 $ 507,936 $ 318,144 60
Available-for-sale securities (period-end) 386,065 387,663 483,752 397,891 348,876 â€” 11 386,065 348,876 11
Held-to-maturity securities, net of allowance for credit losses
(period-end) (b)(c) 201,821 141,553 72,908 71,200 47,540 43 325 201,821 47,540 325
Investment securities portfolio, net of allowance for credit losses
(period-end) (b) $ 587,886 $ 529,216 $ 556,660 $ 469,091 $ 396,416 11 48 $ 587,886 $ 396,416 48
(a) Included tax-equivalent adjustments, driven by tax-exempt income from municipal bonds, of $55 million, $62 million, $63 million, $61 million and $73 million for the three months ended December 31, 2020, September 30, 2020, June 30, 2020, March 31, 2020, and December
31, 2019, respectively, and $241 million and $314 million for the full year 2020 and 2019, respectively.
(b) Upon adoption of the CECL accounting guidance, HTM securities are presented net of an allowance for credit losses. At December 31, 2020, September 30, 2020, June 30, 2020, and March 31, 2020, the allowance for credit losses on HTM securities was $78 million, $120
million, $23 million and $19 million, respectively.
(c) During 2020, the Firm transferred $164.2 billion of investment securities from AFS to HTM for capital management purposes, comprised of $63.7 billion, $74.4 billion and $26.1 billion in the fourth, third and first quarters of 2020, respectively.
(d) The full year 2019 included income tax benefits of $1.1 billion due to the resolution of certain tax audits.

Page 23

JPMORGAN CHASE & CO.
CREDIT-RELATED INFORMATION
(in millions)

Dec 31, 2020
Change
Dec 31, Sep 30, Jun 30, Mar 31, Dec 31, Sep 30, Dec 31,
2020 2020 2020 2020 2019 2020 2019

CREDIT EXPOSURE
Consumer, excluding credit card loans (a)
Loans retained $ 302,127 $ 305,106 $ 307,005 $ 293,779 $ 294,999 (1) % 2 %
Loans held-for-sale and loans at fair value (b) 16,452 16,992 16,193 17,729 22,818 (3) (28)
Total consumer, excluding credit card loans 318,579 322,098 323,198 311,508 317,817 (1) â€”
Credit card loans
Loans retained 143,432 139,590 141,656 154,021 168,924 3 (15)
Loans held-for-sale 784 787 â€” â€” â€” â€” NM
Total credit card loans 144,216 140,377 141,656 154,021 168,924 3 (15)
Total consumer loans 462,795 462,475 464,854 465,529 486,741 â€” (5)
Wholesale loans (c)
Loans retained 514,947 500,841 516,787 555,289 481,678 3 7
Loans held-for-sale and loans at fair value (b) 35,111 26,424 27,741 28,792 29,201 33 20
Total wholesale loans 550,058 527,265 544,528 584,081 510,879 4 8
Total loans 1,012,853 989,740 1,009,382 1,049,610 997,620 2 2
Derivative receivables 79,630 76,626 74,846 81,648 49,766 4 60
Receivables from customers (d) 47,710 30,847 22,403 33,376 33,706 55 42
Total credit-related assets 1,140,193 1,097,213 1,106,631 1,164,634 1,081,092 4 5
Lending-related commitments
Consumer, excluding credit card 47,910 46,425 45,348 41,535 40,169 3 19
Credit card (e) 658,506 662,860 673,836 681,442 650,720 (1) 1
Wholesale (b) 449,863 441,235 413,357 363,245 417,510 2 8
Total lending-related commitments 1,156,279 1,150,520 1,132,541 1,086,222 1,108,399 1 4
Total credit exposure $ 2,296,472 $ 2,247,733 $ 2,239,172 $ 2,250,856 $ 2,189,491 2 5
Memo: Total by category
Consumer exposure (b)(f) $ 1,169,211 $ 1,171,760 $ 1,184,038 $ 1,188,506 $ 1,177,630 â€” (1)
Wholesale exposures (b)(g) 1,127,261 1,075,973 1,055,134 1,062,350 1,011,861 5 11
Total credit exposure $ 2,296,472 $ 2,247,733 $ 2,239,172 $ 2,250,856 $ 2,189,491 2 5
Effective January 1, 2020, the Firm adopted the CECL accounting guidance. In conjunction with the adoption of CECL, the Firm reclassified risk-rated business banking and auto dealer loans and commitments held in CCB from the consumer, excluding credit card portfolio segment to
the wholesale portfolio segment. Prior-period amounts have been revised to conform with the current presentation.
(a) Includes scored loans held in CCB, scored mortgage and home equity loans held in AWM, and scored mortgage loans held in CIB and Corporate.
(b) In the third quarter of 2020, the Firm reclassified certain fair value option elected lending-related positions from trading assets to loans. Prior-period amounts have been revised to conform with the current presentation.
(c) Includes loans held in CIB, CB, AWM, Corporate as well as risk-rated business banking and auto dealer loans held in CCB for which the wholesale methodology is applied when determining the allowance for loan losses.
(d) Receivables from customers reflect brokerage-related held-for-investment customer receivables; these are classified in accrued interest and accounts receivable on the Consolidated balance sheets.
(e) Also includes commercial card lending-related commitments primarily in CB and CIB.
(f) Represents total consumer loans and lending-related commitments.
(g) Represents total wholesale loans, lending-related commitments, derivative receivables, and receivables from customers.

Page 24

JPMORGAN CHASE & CO.
CREDIT-RELATED INFORMATION, CONTINUED
(in millions, except ratio data)

Dec 31, 2020
Change
Dec 31, Sep 30, Jun 30, Mar 31, Dec 31, Sep 30, Dec 31,
2020 2020 2020 2020 2019 2020 2019

NONPERFORMING ASSETS (a)
Consumer nonaccrual loans
Loans retained (b) $ 5,464 $ 5,047 (f) $ 4,246 $ 3,877 $ 2,926 8 % 87 %
Loans held-for-sale and loans at fair value (c) 1,003 1,358 1,001 522 440 (26) 128
Total consumer nonaccrual loans 6,467 6,405 5,247 4,399 3,366 1 92
Wholesale nonaccrual loans
Loans retained 3,318 3,745 3,423 1,957 1,057 (11) 214
Loans held-for-sale and loans at fair value (c) 788 852 649 257 214 (8) 268
Total wholesale nonaccrual loans 4,106 4,597 4,072 2,214 1,271 (11) 223
Total nonaccrual loans 10,573 (e) 11,002 (e) 9,319 (e) 6,613 4,637 (4) 128
Derivative receivables 56 140 108 85 30 (60) 87
Assets acquired in loan satisfactions 277 320 288 364 387 (13) (28)
Total nonperforming assets 10,906 11,462 9,715 7,062 5,054 (5) 116
Wholesale lending-related commitments (c)(d) 577 607 765 619 474 (f) (5) 22
Total nonperforming exposure $ 11,483 $ 12,069 $ 10,480 $ 7,681 $ 5,528 (5) 108
NONACCRUAL LOAN-RELATED RATIOS (e)
Total nonaccrual loans to total loans (b)(c) 1.04 % 1.11 % 0.92 % 0.63 % 0.46 %
Total consumer, excluding credit card nonaccrual loans to
total consumer, excluding credit card loans (b)(c) 2.03 1.99 (f) 1.62 1.41 1.06
Total wholesale nonaccrual loans to total
wholesale loans (c) 0.75 0.87 0.75 0.38 0.25
(a) At December 31, 2020, September 30, 2020, June 30, 2020, March 31, 2020, and December 31, 2019, nonperforming assets excluded: (1) mortgage loans 90 or more days past due and insured by U.S. government agencies of $874 million, $1.1 billion, $696 million, $740
million and $1.1 billion, respectively; and (2) real estate owned (â€œREOâ€) insured by U.S. government agencies of $9 million, $10 million, $13 million, $29 million and $41 million, respectively. Prior-period amounts of mortgage loans 90 or more days past due and insured by U.S.
government agencies excluded from nonperforming assets have been revised to conform with the current presentation, refer to footnote (c) below for additional information. These amounts have been excluded based upon the government guarantee. In addition, the Firmâ€™s
policy is generally to exempt credit card loans from being placed on nonaccrual status as permitted by regulatory guidance. Refer to Note 12 of the Firmâ€™s 2019 Form 10-K for additional information on the Firmâ€™s credit card nonaccrual and charge-off policies.
(b) At December 31, 2020, September 30, 2020, June 30, 2020 and March 31, 2020 nonaccrual loans included $1.6 billion, $1.5 billion, $1.3 billion and $970 million of PCD loans, respectively. Prior to the adoption of CECL, nonaccrual loans excluded PCI loans as the Firm
recognized interest income on each pool of PCI loans as each of the pools was performing.
(c) In the third quarter of 2020, the Firm reclassified certain fair value option elected lending-related positions from trading assets to loans. Prior-period amounts have been revised to conform with the current presentation.
(d) Represents commitments that are risk rated as nonaccrual.
(e) Generally excludes loans that were under payment deferral or granted other assistance, including amendments or waivers of financial covenants in response to the COVID-19 pandemic.
(f) Prior-period amounts have been revised to conform with the current presentation.

Page 25

JPMORGAN CHASE & CO.
CREDIT-RELATED INFORMATION, CONTINUED
(in millions, except ratio data)

QUARTERLY TRENDS FULL YEAR

4Q20 Change 2020 Change
4Q20 3Q20 2Q20 1Q20 4Q19 3Q20 4Q19 2020 2019 2019

SUMMARY OF CHANGES IN THE ALLOWANCES
ALLOWANCE FOR LOAN LOSSES
Beginning balance $ 30,814 $ 31,591 $ 23,244 $ 17,295 (c) $ 13,235 (2) % 133 % $ 17,295 $ 13,445 29 %
Net charge-offs:
Gross charge-offs 1,471 1,586 1,877 1,902 1,788 (7) (18) 6,836 6,810 â€”
Gross recoveries collected (421) (406) (317) (433) (294) (4) (43) (1,577) (1,181) (34)
Net charge-offs 1,050 1,180 1,560 1,469 1,494 (11) (30) 5,259 5,629 (7)
Write-offs of PCI loans NA NA NA NA 19 (d) NM NM NA 151 (d) NM
Provision for loan losses (1,433) 400 9,906 (b) 7,418 1,401 NM NM 16,291 5,449 199
Other (3) 3 1 â€” â€” NM NM 1 9 (89)
Ending balance $ 28,328 $ 30,814 $ 31,591 $ 23,244 $ 13,123 (8) 116 $ 28,328 $ 13,123 116
ALLOWANCE FOR LENDING-RELATED COMMITMENTS
Beginning balance $ 2,823 $ 2,710 $ 2,147 $ 1,289 (c) $ 1,165 4 142 $ 1,289 $ 1,055 22
Provision for lending-related commitments (414) 114 563 (b) 858 26 NM NM 1,121 136 NM
Other â€” (1) â€” â€” â€” NM â€” (1) â€” NM
Ending balance $ 2,409 $ 2,823 $ 2,710 $ 2,147 $ 1,191 (15) 102 $ 2,409 $ 1,191 102
Total allowance for credit losses (a) $ 30,737 $ 33,637 $ 34,301 $ 25,391 $ 14,314 (9) 115 $ 30,737 $ 14,314 115
NET CHARGE-OFF/(RECOVERY) RATES
Consumer retained, excluding credit card loans 0.05 % 0.08 % 0.11 % (0.01) % 0.15 % 0.06 % 0.12 %
Credit card retained loans 2.17 2.92 3.33 3.25 3.01 2.93 3.10
Total consumer retained loans 0.72 0.97 1.14 1.15 1.16 0.99 1.11
Wholesale retained loans 0.19 0.07 0.22 0.13 0.13 0.16 0.09
Total retained loans 0.44 0.49 0.64 0.62 0.63 0.55 0.60
Memo: Average retained loans
Consumer retained, excluding credit card loans $ 303,421 $ 306,201 $ 304,179 $ 294,156 $ 295,258 (1) 3 $ 302,005 $ 312,972 (4)
Credit card retained loans 140,459 140,200 142,377 162,660 162,112 â€” (13) 146,391 156,319 (6)
Total average retained consumer loans 443,880 446,401 446,556 456,816 457,370 (1) (3) 448,396 469,291 (4)
Wholesale retained loans 503,249 504,449 540,248 491,819 476,402 â€” 6 509,907 472,628 8
Total average retained loans $ 947,129 $ 950,850 $ 986,804 $ 948,635 $ 933,772 â€” 1 $ 958,303 $ 941,919 2
(a) At December 31, 2020, September 30, 2020, June 30, 2020 and March 31, 2020 excludes allowance for credit losses on HTM securities of $78 million, $120 million, $23 million and $19 million , respectively; and provision for credit losses on HTM securities of $(42) million, $97
million, $4 million and $9 million for the three months ended December 31, 2020, September 30, 2020, June 30, 2020 and March 31, 2020, respectively, and $68 million for the full year 2020.
(b) Prior-period amounts have been revised to conform with the current presentation.
(c) Upon the adoption of the CECL accounting guidance on January 1, 2020, the Firm recognized a net increase of $4.3 billion (â€œday 1 impactâ€) to the allowance for credit losses, of which $4.2 billion related to the allowance for loan losses and $98 million related to the allowance for
lending-related commitments.
(d) Prior to the adoption of CECL, write-offs of PCI loans were recorded against the allowance for loan losses when actual losses for a pool exceeded estimated losses that were recorded as purchase accounting adjustments at the time of acquisition. A write-off of a PCI loan was
recognized when the underlying loan was removed from a pool.

Page 26

JPMORGAN CHASE & CO.
CREDIT-RELATED INFORMATION, CONTINUED
(in millions, except ratio data)

Dec 31, 2020
Change
Dec 31, Sep 30, Jun 30, Mar 31, Dec 31, Sep 30, Dec 31,
2020 2020 2020 2020 2019 2020 2019

ALLOWANCE COMPONENTS AND RATIOS
ALLOWANCE FOR LOAN LOSSES
Consumer, excluding credit card
Asset-specific (a) $ (7) $ 228 $ 263 $ 223 $ 75 NM NM
Portfolio-based 3,643 4,274 4,609 3,231 1,476 (15) % 147 %
PCI NA NA NA NA 987 NM NM
Total consumer, excluding credit card 3,636 4,502 4,872 3,454 2,538 (19) 43
Credit card
Asset-specific (b) 633 652 642 530 477 (3) 33
Portfolio-based 17,167 17,148 17,158 14,420 5,206 â€” 230
Total credit card 17,800 17,800 17,800 14,950 5,683 â€” 213
Total consumer 21,436 22,302 22,672 18,404 8,221 (4) 161
Wholesale
Asset-specific (c) 682 792 757 556 295 (14) 131
Portfolio-based 6,210 7,720 8,162 (g) 4,284 4,607 (20) 35
Total wholesale 6,892 8,512 8,919 4,840 4,902 (19) 41
Total allowance for loan losses 28,328 30,814 31,591 23,244 13,123 (8) 116
Allowance for lending-related commitments 2,409 2,823 2,710 (g) 2,147 1,191 (15) 102
Total allowance for credit losses (d) $ 30,737 $ 33,637 $ 34,301 $ 25,391 $ 14,314 (9) 115
CREDIT RATIOS
Consumer, excluding credit card allowance, to total
consumer, excluding credit card retained loans 1.20 % 1.48 % 1.59 % 1.18 % 0.86 %
Credit card allowance to total credit card retained loans 12.41 12.75 12.57 9.71 3.36
Wholesale allowance to total wholesale retained loans 1.34 1.70 1.73 (g) 0.87 1.02
Wholesale allowance to total wholesale retained loans,
excluding trade finance and conduits (e) 1.45 1.83 1.84 (g) 0.93 1.08
Total allowance to total retained loans 2.95 3.26 3.27 2.32 1.39
Consumer, excluding credit card allowance, to consumer,
excluding credit card retained nonaccrual loans (f...

[Message clipped]Â Â View entire message ZACHRY WOODÂ <zachryiixixiiwood@gmail.com>11:44 AM (5 hours ago) toÂ Legacy ZACHRY WOOD <zachryiixixiiwood@gmail.com>Securities and Exchange Commission Upcoming Events Update
ZACHRY WOODÂ <zachryiixixiiwood@gmail.com>Wed, Oct 5, 2022 at 10:54 AMTo:Â sec@service.govdelivery.comdiff --git a/.devcontainer/devcontainer.json b/.devcontainer/my.sigssimilarity index 100%rename from .devcontainer/devcontainer.jsonrename to .devcontainer/my.sigsdiff --git a/.github/ISSUE_TEMPLATE/config.yml b/.github/ISSUE_TEMPLATE/config.ymlindex 925504464505..6ae52ad03cbe 100644--- a/.github/ISSUE_TEMPLATE/config.yml+++ b/.github/ISSUE_TEMPLATE/config.yml@@ -3,3 +3,4 @@ contact_links: - name: GitHub Support url: https://support.github.com/contact about: Contact Support if you're having trouble with your GitHub account.+zachry t wooddiff --git a/.github/dependabot.yml b/.github/dependabot.ymlindex 5359049164e3..18c9ffdb0d0c 100644--- a/.github/dependabot.yml+++ b/.github/dependabot.yml@@ -1,22 +1,31 @@ version: 2 updates:- - package-ecosystem: npm- directory: '/'+ - package-ecosystem: 'https://pnc.com'+ directory: '071921891/4720416547' schedule:+branches :- [071921891]+ interval: 'Every 3 Months'+ day: 'Wednesday'+ open-pull-requests-limit: '20' '# default' 'is' '5'+ '-' 'dependency'+ '-' 'Name'':' '*'+branches :- [31000053] interval: weekly day: tuesday open-pull-requests-limit: 20 # default is 5 ignore: - dependency-name: '@elastic/elasticsearch' - dependency-name: '*'+- [6400-7201] runs-on :account_number_code :47-2401-6547 : update-types:- ['version-update:semver-patch', 'version-update:semver-minor']+ '[' 'version-+ '.u.i' 'Update:semver-patch', 'version-update:semver-minor'] - package-ecosystem: 'github-actions' directory: '/' schedule:- interval: weekly- day: wednesday+ interval: 'weekly'+ 'day:'' 'wednesday' ignore: - dependency-name: '*' update-types:@@ -24,6 +33,7 @@ updates: - package-ecosystem: 'docker' directory: '/'- schedule:- interval: weekly- day: thursday+ schedule: 'internval''+ interval: 'autoupdate: across all '-' '['' 'branches' ']':' Every' '-3' sec'"''+ :Build::+ diff --git a/.github/workflows/codeql-analysis.yml b/.github/workflows/codeql-analysis.ymlnew file mode 100644index 000000000000..14ee34999882--- /dev/null+++ b/.github/workflows/codeql-analysis.yml@@ -0,0 +1,72 @@+# For most projects, this workflow file will not need changing; you simply need+# to commit it to your repository.+#+# You may wish to alter this file to override the set of languages analyzed,+# or to provide custom queries or build logic.+#+# ******** NOTE ********+# We have attempted to detect the languages in your repository. Please check+# the `language` matrix defined below to confirm you have the correct set of+# supported CodeQL languages.+#+name: "CodeQL"++on:+ push:+ branches: [ "main" ]+ pull_request:+ # The branches below must be a subset of the branches above+ branches: [ "main" ]+ schedule:+ - cron: '33 10 * * 0'++jobs:+ analyze:+ name: Analyze+ runs-on: ubuntu-latest+ permissions:+ actions: read+ contents: read+ security-events: write++ strategy:+ fail-fast: false+ matrix:+ language: [ 'javascript' ]+ # CodeQL supports [ 'cpp', 'csharp', 'go', 'java', 'javascript', 'python', 'ruby' ]+ # Learn more about CodeQL language support at https://aka.ms/codeql-docs/language-support++ steps:+ - name: Checkout repository+ uses: actions/checkout@v3++ # Initializes the CodeQL tools for scanning.+ - name: Initialize CodeQL+ uses: github/codeql-action/init@v2+ with:+ languages: ${{ matrix.language }}+ # If you wish to specify custom queries, you can do so here or in a config file.+ # By default, queries listed here will override any specified in a config file.+ # Prefix the list here with "+" to use these queries and those in the config file.+ + # Details on CodeQL's query packs refer to : https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/configuring-code-scanning#using-queries-in-ql-packs+ # queries: security-extended,security-and-quality++ + # Autobuild attempts to build any compiled languages (C/C++, C#, or Java).+ # If this step fails, then you should remove it and run the build manually (see below)+ - name: Autobuild+ uses: github/codeql-action/autobuild@v2++ # Command-line programs to run using the OS shell.+ # See https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepsrun++ # If the Autobuild fails above, remove it and uncomment the following three lines. + # modify them (or add more) to build your code if your project, please refer to the EXAMPLE below for guidance.++ # - run: |+ # echo "Run, Build Application using script"+ # ./location_of_script_within_repo/buildscript.sh++ - name: Perform CodeQL Analysis+ uses: github/codeql-action/analyze@v2diff --git a/.github/workflows/codeql.yml b/.github/workflows/codeql.ymlindex 04009a7f10d6..7edb5d7f242d 100644--- a/.github/workflows/codeql.yml+++ b/.github/workflows/codeql.yml@@ -36,3 +36,285 @@ jobs: languages: javascript # comma separated list of values from {go, python, javascript, java, cpp, csharp} (not YET ruby, sorry!) - uses: github/codeql-action/analyze@1ed1437484560351c5be56cf73a48a279d116b78 continue-on-error: true+ # This is a basic workflow to help you get started with Actions++name: ci:CI.yml-starts-on:' '"-on'"' :+BEBGIN :+GLOW7 :+# -Controls when the workflow will run+-on:+ # Triggers the workflow on push or pull request events but only for the "main" branch+ push:+ branches:' '-' [' '"|47-2041-6547']'(031000053 > 071921891 > 47-2041-6547 > 4034910067530719|" ]+ pull_request:+ branches:' '-' [' '"071921891" ']'(47-2041-6547')'"''++ # Allows you to run this workflow manually from the Actions tab+ workflow_dispatch:++# A workflow run is made up of one or more jobs that can run sequentially or in parallel+jobs:+ # This workflow contains a single job called "build"+ build:+ # The type of runner that the job will run on+ runs-on: ubuntu-latest++ # Steps represent a sequence of tasks that will be executed as part of the job+ steps:+ # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it+ - uses: actions/checkout@v3++ # Runs a single command using the runners shell+ - name: Run a one-line script+ Echo: "Hello','' 'world":,++ # Runs a set of commands using the runners shell+ "Name":, "@PNCBANK": "Runs::#This:":, "a":, "multi-one-line-build_script":,+ run: |+ echo Add other actions to build,+ echo test, and deploy your project.+https://github.dev/zakwarlord7/GitHub/doc/javascript/WORKSFLOW/dd81743fc6f4c8db36a2822af0c3692e271b0e9f/action.js#L1-L1467+					00519										+															+Employee Number: 3+Description	Amount							5/4/2022 - 6/4/2022							+Payment Amount (Total)	'"$[2267700000000000](USD)'"''							Display All							+1. Social Security (Employee + Employer)			26662												+2. Medicare (Employee + Employer)		'"$[2267700000000000](USD)'"''					Hourly							+3. Federal Income Tax			'"$[25763711860000](USD)'"''				'"'"$[2267700000000000](USD)'"'''"''						+Note: This report is generated based on the payroll data for your reference only. +Please :contact :IRS :office for special cases such as late payment, previous overpayment, penalty and others. :+Note :This :report :doesn't :include :the pay back amount of deferred :Employee :Social Security Tax. :														+Employer :Customized :Report :+ADP+Report Range5/4/2022 - 6/4/2022	88-1656496	state ID :633441725 :SSN :XXXXX1725	:State :All	Local ID :00037305581 :'"$[2267700000000000](USD)'"'' :							+EIN:															+Customized Report		Amount						Employee Payment Report+ADP							+Employee Number: 3+Description															+Wages, Tips and Other Compensation		'"$[2267700000000000](USD)'"''						Tips							+Taxable SS Wages		215014						5105000							+Taxable SS Tips		'"$[2267700000000000](USD)'"''												+Taxable Medicare Wages		22662983361014		Salary		Vacation hourly		OT							+Advanced EIC Payment	'"$[2267700000000000](USD)'"''		3361014											+Federal Income Tax Withheld		'"$[2267700000000000](USD)'"''		Bonus		00000		00000							+Employee SS Tax Withheld		13331		00000		Other Wages 1		Other Wages 2							+Employee Medicare Tax Withheld		532580113436		Total		00000		00000							+State Income Tax Withheld		00000		'"$[2267700000000000](USD)'"''										+Local Income Tax Withheld+Customized Employer Tax Report		00000		Deduction Summary											+Description		Amount		Health Insurance											+Employer SS Tax+Employer Medicare Tax		13331		00000											+Federal Unemployment Tax		328613309009		Tax Summary											+State Unemployment Tax		00442		Federal Tax	00007			Total Tax							+Customized Deduction Report		00840		'"$[2267700000000000](USD)'"''		Local Tax									+Health Insurance						00000									+401K		00000		Advanced EIC Payment			'"$[2267700000000000](USD)'"''							+		00000		'"$[2267700000000000](USD)'"''				Total							+						401K									+						00000		'"$[2267700000000000](USD)'"''						+ZACHRY T WOOD							Social Security Tax Medicare Tax State Tax	53258011305							+															+															+SHAREHOLDERS ARE URGED TO READ THE DEFINITIVE PROXY STATEMENT AND ANY OTHER RELEVANT MATERIALS THAT THE COMPANY WILL FILE WITH THE SEC CAREFULLY IN THEIR ENTIRETY WHEN THEY BECOME AVAILABLE. SUCH DOCUMENTS WILL CONTAIN IMPORTANT INFORMATION ABOUT THE COMPANY AND ITS DIRECTORS, OFFICERS AND AFFILIATES. INFORMATION REGARDING THE INTERESTS OF CERTAIN OF THE COMPANYâ€™S DIRECTORS, OFFICERS AND AFFILIATES WILL BE AVAILABLE IN THE DEFINITIVE PROXY STATEMENT.															+The Definitive Proxy Statement and any other relevant materials that will be filed with the SEC will be available free of charge at the SECâ€™s website at www.sec.gov. In addition, the Definitive Proxy Statement (when available) and other relevant documents will also be available, without charge, by directing a request by mail to Attn: Investor Relations, Alphabet Inc., 1600 Amphitheatre Parkway, Mountain View, California, 94043 or by contacting investor-relations@abc.xyz. The Definitive Proxy Statement and other relevant documents will also be available on the Companyâ€™s Investor Relations website at https://abc.xyz/investor/other/annual-meeting/.															+															+The Company and its directors and certain of its executive officers may be consideredno participants in the solicitation of proxies with respect to the proposals under the Definitive Proxy Statement under the rules of the SEC. Additional information regarding the participants in the proxy solicitations and a description of their direct and indirect interests, by security holdings or otherwise, also will be included in the Definitive Proxy Statement and other relevant materials to be filed with the SEC when they become available.				.	9246754678763										+															+															+															+															+3/6/2022 at 6:37 PM															+				Q4 2021	Q3 2021	Q2 2021	Q1 2021	Q4 2020							+															+GOOGL_income-statement_Quarterly_As_Originally_Reported				'"$[2267700000000000](USD)'"''25539000000	37497000000	31211000000	30818000000							+				24934000000	25539000000	21890000000	19289000000	22677000000							+Cash Flow from Operating Activities, Indirect				24934000000	25539000000	21890000000	19289000000	22677000000							+Net Cash Flow from Continuing Operating Activities, Indirect				20642000000	18936000000	18525000000	17930000000	15227000000							+Cash Generated from Operating Activities				6517000000	3797000000	4236000000	2592000000	5748000000							+Income/Loss before Non-Cash Adjustment				3439000000	3304000000	2945000000	2753000000	3725000000							+Total Adjustments for Non-Cash Items				3439000000	3304000000	2945000000	2753000000	3725000000							+Depreciation, Amortization and Depletion, Non-Cash Adjustment				3215000000	3085000000	2730000000	2525000000	3539000000							+Depreciation and Amortization, Non-Cash Adjustment				224000000	219000000	215000000	228000000	186000000							+Depreciation, Non-Cash Adjustment				3954000000	3874000000	3803000000	3745000000	3223000000							+Amortization, Non-Cash Adjustment				1616000000	-1287000000	379000000	1100000000	1670000000							+Stock-Based Compensation, Non-Cash Adjustment				-2478000000	-2158000000	-2883000000	-4751000000	-3262000000							+Taxes, Non-Cash Adjustment				-2478000000	-2158000000	-2883000000	-4751000000	-3262000000							+Investment Income/Loss, Non-Cash Adjustment				-14000000	64000000	-8000000	-255000000	392000000							+Gain/Loss on Financial Instruments, Non-Cash Adjustment				-2225000000	2806000000	-871000000	-1233000000	1702000000							+Other Non-Cash Items				-5819000000	-2409000000	-3661000000	2794000000	-5445000000							+Changes in Operating Capital				-5819000000	-2409000000	-3661000000	2794000000	-5445000000							+Change in Trade and Other Receivables				-399000000	-1255000000	-199000000	7000000	-738000000							+Change in Trade/Accounts Receivable				6994000000	3157000000	4074000000	-4956000000	6938000000							+Change in Other Current Assets				1157000000	238000000	-130000000	-982000000	963000000							+Change in Payables and Accrued Expenses				1157000000	238000000	-130000000	-982000000	963000000							+Change in Trade and Other Payables				5837000000	2919000000	4204000000	-3974000000	5975000000							+Change in Trade/Accounts Payable				368000000	272000000	-3000000	137000000	207000000							+Change in Accrued Expenses				-3369000000	3041000000	-1082000000	785000000	740000000							+Change in Deferred Assets/Liabilities															+Change in Other Operating Capital															+				-11016000000	-10050000000	-9074000000	-5383000000	-7281000000							+Change in Prepayments and Deposits				-11016000000	-10050000000	-9074000000	-5383000000	-7281000000							+Cash Flow from Investing Activities															+Cash Flow from Continuing Investing Activities				-6383000000	-6819000000	-5496000000	-5942000000	-5479000000							+				-6383000000	-6819000000	-5496000000	-5942000000	-5479000000							+Purchase/Sale and Disposal of Property, Plant and Equipment, Net															+Purchase of Property, Plant and Equipment				-385000000	-259000000	-308000000	-1666000000	-370000000							+Sale and Disposal of Property, Plant and Equipment				-385000000	-259000000	-308000000	-1666000000	-370000000							+Purchase/Sale of Business, Net				-4348000000	-3360000000	-3293000000	2195000000	-1375000000							+Purchase/Acquisition of Business				-40860000000	-35153000000	-24949000000	-37072000000	-36955000000							+Purchase/Sale of Investments, Net															+Purchase of Investments				36512000000	31793000000	21656000000	39267000000	35580000000							+				100000000	388000000	23000000	30000000	-57000000							+Sale of Investments															+Other Investing Cash Flow					-15254000000										+Purchase/Sale of Other Non-Current Assets, Net				-16511000000	-15254000000	-15991000000	-13606000000	-9270000000							+Sales of Other Non-Current Assets				-16511000000	-12610000000	-15991000000	-13606000000	-9270000000							+Cash Flow from Financing Activities				-13473000000	-12610000000	-12796000000	-11395000000	-7904000000							+Cash Flow from Continuing Financing Activities				13473000000		-12796000000	-11395000000	-7904000000							+Issuance of/Payments for Common 343 sec cvxvxvcclpddf wearsStock, Net					-42000000										+Payments for Common Stock				115000000	-42000000	-1042000000	-37000000	-57000000							+Proceeds from Issuance of Common Stock				115000000	6350000000	-1042000000	-37000000	-57000000							+Issuance of/Repayments for Debt, Net				6250000000	-6392000000	6699000000	900000000	00000							+Issuance of/Repayments for Long Term Debt, Net				6365000000	-2602000000	-7741000000	-937000000	-57000000							+Proceeds from Issuance of Long Term Debt															+Repayments for Long Term Debt				2923000000		-2453000000	-2184000000	-1647000000							+															+Proceeds from Issuance/Exercising of Stock Options/Warrants				00000		300000000	10000000	338000000000							+Other Financing Cash Flow															+Cash and Cash Equivalents, End of Period															+Change in Cash				20945000000	23719000000	23630000000	26622000000	26465000000							+Effect of Exchange Rate Changes				25930000000)	235000000000	-3175000000	300000000	6126000000							+Cash and Cash Equivalents, Beginning of Period				PAGE="$USD(181000000000)".XLS	BRIN="$USD(146000000000)".XLS	183000000	-143000000	210000000							+Cash Flow Supplemental Section				23719000000000		26622000000000	26465000000000	20129000000000							+Change in Cash as Reported, Supplemental				2774000000	89000000	-2992000000		6336000000							+Income Tax Paid, Supplemental				13412000000	157000000										+ZACHRY T WOOD								-4990000000							+Cash and Cash Equivalents, Beginning of Period															+Department of the Treasury															+Internal Revenue Service															+					Q4 2020			Q4 2019							+Calendar Year															+Due: 04/18/2022															+					Dec. 31, 2020			Dec. 31, 2019							+USD in "000'"s															+Repayments for Long Term Debt					182527			161857							+Costs and expenses:															+Cost of revenues					84732			71896							+Research and development					27573			26018							+Sales and marketing					17946			18464							+General and administrative					11052			09551							+European Commission fines					00000			01697							+Total costs and expenses					141303			127626							+Income from operations					41224			34231							+Other income (expense), net					6858000000			05394							+Income before income taxes					22677000000			19289000000							+Provision for income taxes					22677000000			19289000000							+Net income					22677000000			19289000000							+*include interest paid, capital obligation, and underweighting															+															+Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)															+															+															+															+															+															+															+															+															+															+															+Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)															+*include interest paid, capital obligation, and underweighting															+															+Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)															+Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)															+															+															+															+															+															+															+															+		20210418													+			Rate	Units	Total	YTD	Taxes / Deductions	Current	YTD						+			-	-	70842745000	70842745000	Federal Withholding	00000	188813800						+							FICA - Social Security	00000	853700						+							FICA - Medicare	00000	11816700						+							Employer Taxes								+							FUTA	00000	00000						+							SUTA	00000	00000						+	EIN: 61-1767919	ID : 00037305581	 SSN: 633441725				ATAA Payments	00000	102600						+															+		Gross													+		70842745000	Earnings Statement												+		Taxes / Deductions	Stub Number:Â 1												+		00000													+		Net Pay	SSN	Pay Schedule	Pay Period	Sep 28, 2022 to Sep 29, 2023	Pay Date	4/18/2022							+		70842745000	XXX-XX-1725	Annually											+		CHECK NO.													+		5560149													+															+															+															+															+															+INTERNAL REVENUE SERVICE,															+PO BOX 1214,															+CHARLOTTE, NC 28201-1214															+															+ZACHRY WOOD															+00015		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000			+For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions.		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000			+Cat. No. 11320B		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000			+Form 1040 (2021)		76033000000	20642000000	18936000000											+Reported Normalized and Operating Income/Expense Supplemental Section															+Total Revenue as Reported, Supplemental		257637000000	75325000000	65118000000	61880000000	55314000000	56898000000	46173000000	38297000000	41159000000	46075000000	40499000000			+Total Operating Profit/Loss as Reported, Supplemental		78714000000	21885000000	21031000000	19361000000	16437000000	15651000000	11213000000	6383000000	7977000000	9266000000	9177000000			+Reported Effective Tax Rate		00000	00000	00000	00000	00000		00000	00000	00000		00000			+Reported Normalized Income										6836000000					+Reported Normalized Operating Profit										7977000000					+Other Adjustments to Net Income Available to Common Stockholders															+Discontinued Operations															+Basic EPS		00114	00031	00028	00028	00027	00023	00017	00010	00010	00015	00010			+Basic EPS from Continuing Operations		00114	00031	00028	00028	00027	00022	00017	00010	00010	00015	00010			+Basic EPS from Discontinued Operations															+Diluted EPS		00112	00031	00028	00027	00026	00022	00016	00010	00010	00015	00010			+Diluted EPS from Continuing Operations		00112	00031	00028	00027	00026	00022	00016	00010	00010	00015	00010			+Diluted EPS from Discontinued Operations															+Basic Weighted Average Shares Outstanding		667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	686465000	688804000	692741000			+Diluted Weighted Average Shares Outstanding		677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	692267000	695193000	698199000			+Reported Normalized Diluted EPS										00010					+Basic EPS		00114	00031	00028	00028	00027	00023	00017	00010	00010	00015	00010		00001	+Diluted EPS		00112	00031	00028	00027	00026	00022	00016	00010	00010	00015	00010			+Basic WASO		667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	686465000	688804000	692741000			+Diluted WASO		677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	692267000	695193000	698199000			+Fiscal year end September 28th., 2022. | USD															+															+															+															+															+															+															+															+															+															+															+															+															+															+															+															+															+															+															+															+															+															+															+															+															+															+diff --git a/.github/workflows/config.yml b/.github/workflows/config.ymlnew file mode 100644index 000000000000..a83dec85ac03--- /dev/null+++ b/.github/workflows/config.yml@@ -0,0 +1,18 @@+[![.github/workflows/NPC-grunt.yml](https://github.com/zakwarlord7/docs/actions/workflows/NPC-grunt.yml/badge.svg?branch=trunk&event=check_run)](https://github.com/zakwarlord7/docs/actions/workflows/NPC-grunt.yml)Name: ci++on:+ push:+ branches: [ "main" ]+ pull_request:+ branches: [ "main" ]++jobs:++ build:++ runs-on: ubuntu-latest++ steps:+ - uses: actions/checkout@v3+ - name: Build the Docker image+ run: docker build . --file Dockerfile --tag my-image-name:$(date +%s)diff --git a/.github/workflows/docker-image.yml b/.github/workflows/docker-image.ymlnew file mode 100644index 000000000000..92532dc4036a--- /dev/null+++ b/.github/workflows/docker-image.yml@@ -0,0 +1,724 @@+'*''*'Name: DOCKER.Gui.sgn.tmp.img/CI/ci.yml Image CI+Run::/:-Runs:+-?Runs:On:+On:Runs:-on:+-on: starts: On:+On:On:+ push:+ branches: [ "mainbranch" ]+ pull_request:+ branches: [ "trunk" ]++jobs:+const: -+-GOOGL_income-statement_Quarterly_As_Originally_Reported+Wages, salaries, tips, etc. Attach Form(s) W-2 ................+Government+Washington, Wyoming+44678+WE WILL BE STARTING OUR UNITED WAY FUND++28.85*+We're here to help. If you have any questions or need assistance, please visit your local PNC Branch or contact+Gross Pay_________________________________+WOOD ZACHRY+Gross Paô€€©+year to date+1652044+Your federal wages this period are $386.15+Group Term Life 0.51 27.00+YTD+have questions or+â— Learn more about fees and how to avoid them by visiting ""Making the Most of your Money"" at+Here are the transactions that led to your overdraft:+ZACHRY T WOOD+Here are your current+Hereâ€™s how you+Zip / Postal Code+Fiscal year ends in Dec 31 | USD+For+Fiscal year end September 28th., 2022. | USD+Issuance of/Repayments for Debt, Net+Issuance of/Repayments for Long Term Debt, Net+Income from Associates, Joint Ventures and Other Participating Interests+Income from Associates, Joint Ventures and Other Participating Interests+Charitable contributions if you take the standard deduction (see instructions)+Proceeds from Issuance of Common Stock+13+Taxes, Non-Cash Adjustment+Change in Cash+Interest Paid, Supplemental+Gain/Loss on Foreign Exchange+Qualified business income deduction from Form 8995 or Form 8995-A .........+Change in Deferred Assets/Liabilities+Gain/Loss on Financial Instruments, Non-Cash Adjustment+Net Investment Income/Loss, Non-Cash Adjustment+Net Investment Income/Loss, Non-Cash Adjustment+Effect of Exchange Rate Changes+Non-Operating Income/Expenses, Total+Change in Cash as Reported, Supplemental+Issuance of/Repayments for Debt, Net+Gain/Loss on Disposals, Non-Cash Adjustment+Irregular Income/Loss, Non-Cash Adjustment+Gain/Loss on Disposal/Sale of Business, Non-Cash Adjustment+Gain/Loss on Disposal/Sale of Business, Non-Cash Adjustment+Irregular Income/Loss, Non-Cash Adjustment+Gain/Loss on Disposals, Non-Cash Adjustment+Non-Controlling/Minority Interests+Gain/Loss on Investments and Other Financial Instruments+Net Investment Income+Change in Trade/Accounts Receivable+Change in Trade and Other Receivables+Proceeds from Issuance/Exercising of Stock Options/Warrants+Cash Flow from Continuing Financing Activities+Change in Other Current Assets+Taxes, Non-Cash Adjustment+Proceeds from Issuance/Exercising of Stock Options/Warrants+Net Interest Income/Expense+Interest Expense Net of Capitalized Interest+Total Net Finance Income/Expense+Purchase/Sale of Business, Net+Investment Income/Loss, Non-Cash Adjustment+Gain/Loss on Financial Instruments, Non-Cash Adjustment+Purchase/Sale of Business, Net+Purchase/Acquisition of Business+Income Tax Paid, Supplemental+General and Administrative Expenses+Change in Trade and Other Receivables+Change in Trade/Accounts Receivable+Purchase/Acquisition of Business+Purchase/Sale of Investments, Net+Other Underwriting Expenses+100% Security Guaranteed+Net Interest Income/Expense+Total Net Finance Income/Expense+Interest Expense Net of Capitalized Interest+â€¢ Head of household, $18,800+Purchase/Sale and Disposal of Property, Plant and Equipment, Net+Purchase of Property, Plant and Equipment+Repayments for Long Term Debt+B+Research and Development Expenses+Selling and Marketing Expenses+Selling, General and Administrative Expenses+â€¢ Married filing jointly or Qualifying widow(er), $25,100+â€¢ If you checked any box under Standard Deduction, see instructions.+Standard Deduction forâ€”+Purchase/Sale of Investments, Net+Cash Flow from Continuing Investing Activities+Other Underwriting Expenses+Purchase/Sale and Disposal of Property, Plant and Equipment, Net+Issuance of/Payments for Common Stock, Net+Cash Flow from Continuing Financing Activities+Repayments for Long Term Debt+Operating Income/Expenses+â€¢ Single or Married filing separately, $12,550+Sales of Other Non-Current Assets+Policyholder Future Benefits and Claims, Net+Benefits,Claims and Loss Adjustment Expense, Net+Purchase of Property, Plant and Equipment+Provision for Income Tax+Cash Flow from Financing Activities+Cost of Goods and Services+Cost of Revenue+Cash Flow from Continuing Investing Activities+Selling and Marketing Expenses+Selling, General and Administrative Expenses+Purchase of Investments+Subtract line 10 from line 9. This is your adjusted gross income ......... +11+Cash Flow from Investing Activities+Benefits,Claims and Loss Adjustment Expense, Net+Policyholder Future Benefits and Claims, Net+Other Income/Expenses+Purchase of Investments+Other Income/Expenses+Total Expenses+Grand Total++Federal 941 Deposit Report ADP Report Range5/4/2022 - 6/4/2022+EIN:++Note: This report is generated based on the payroll data for your reference only. Please contact IRS office for special cases such as late payment, previous overpayment, penalty and others. Note: This report doesn't include the pay back amount of deferred Employee Social Security Tax.+Employer Customized Report ADP Report Range5/4/2022 - 6/4/2022+EIN:+Customized Report+Employee Number: 3 Description+Wages, Tips and Other Compensation+Taxable SS Wages+Taxable SS Tips+Taxable Medicare Wages+Advanced EIC Payment+Federal Income Tax Withheld+Employee SS Tax Withheld+Employee Medicare Tax Withheld+State Income Tax Withheld+Local Income Tax Withheld Customized Employer Tax Report+Description+Employer SS Tax Employer Medicare Tax+Federal Unemployment Tax+State Unemployment Tax+Customized Deduction Report+Health Insurance+401K++SHAREHOLDERS ARE URGED TO READ THE DEFINITIVE PROXY STATEMENT AND ANY OTHER RELEVANT MATERIALS THAT THE COMPANY WILL FILE WITH THE SEC CAREFULLY IN THEIR ENTIRETY WHEN THEY BECOME AVAILABLE. SUCH DOCUMENTS WILL CONTAIN IMPORTANT INFORMATION ABOUT THE COMPANY AND ITS DIRECTORS, OFFICERS AND AFFILIATES. INFORMATION REGARDING THE INTERESTS OF CERTAIN OF THE COMPANYâ€™S DIRECTORS, OFFICERS AND AFFILIATES WILL BE AVAILABLE IN THE DEFINITIVE PROXY STATEMENT.+The Definitive Proxy Statement and any other relev8.ant materials that will be filed with the SEC will be available free of charge at the SECâ€™s website at www.sec.gov. In addition, the Definitive Proxy Statement (when available) and other relevant documents will also be available, without charge, by directing a request by mail to Attn: Investor Relations, Alphabet Inc., 1600 Amphitheatre Parkway, Mountain View, California, 94043 or by contacting investor-relations@abc.xyz. The Definitive Proxy Statement and other relevant documents will also be available on the Companyâ€™s Investor Relations website at https://abc.xyz/investor/other/annual-meeting/.++The Company and its directors and certain of its executive officers may be consideredno participants in the solicitation of proxies with respect to the proposals under the Definitive Proxy Statement under the rules of the SEC. Additional information regarding the participants in the proxy solicitations and a description of their direct and indirect interests, by security holdings or otherwise, also will be included in the Definitive Proxy Statement and other relevant materials to be filed with the SEC when they become available.++3/6/2022 at 6:37 PM++GOOGL_income-statement_Quarterly_As_Originally_Reported++Cash Flow from Operating Activities, Indirect+Net Cash Flow from Continuing Operating Activities, Indirect+Cash Generated from Operating Activities+Income/Loss before Non-Cash Adjustment+Total Adjustments for Non-Cash Items+Depreciation, Amortization and Depletion, Non-Cash Adjustment+Depreciation and Amortization, Non-Cash Adjustment+Depreciation, Non-Cash Adjustment+Amortization, Non-Cash Adjustment+Stock-Based Compensation, Non-Cash Adjustment+Taxes, Non-Cash Adjustment+Investment Income/Loss, Non-Cash Adjustment+Gain/Loss on Financial Instruments, Non-Cash Adjustment+Other Non-Cash Items+Changes in Operating Capital+Change in Trade and Other Receivables+Change in Trade/Accounts Receivable+Change in Other Current Assets+Change in Payables and Accrued Expenses+Change in Trade and Other Payables+Change in Trade/Accounts Payable+Change in Accrued Expenses+Change in Deferred Assets/Liabilities+Change in Other Operating Capital++Change in Prepayments and Deposits+Cash Flow from Investing Activities+Cash Flow from Continuing Investing Activities++Purchase/Sale and Disposal of Property, Plant and Equipment, Net+Purchase of Property, Plant and Equipment+Sale and Disposal of Property, Plant and Equipment+Purchase/Sale of Business, Net+Purchase/Acquisition of Business+Purchase/Sale of Investments, Net+Purchase of Investments++Sale of Investments+Other Investing Cash Flow+Purchase/Sale of Other Non-Current Assets, Net+Sales of Other Non-Current Assets+Cash Flow from Financing Activities+Cash Flow from Continuing Financing Activities+Issuance of/Payments for Common Stock, Net+Payments for Common Stock+Proceeds from Issuance of Common Stock+Issuance of/Repayments for Debt, Net+Issuance of/Repayments for Long Term Debt, Net+Proceeds from Issuance of Long Term Debt+Repayments for Long Term Debt++Proceeds from Issuance/Exercising of Stock Options/Warrants+Other Financing Cash Flow+Cash and Cash Equivalents, End of Period+Change in Cash+Effect of Exchange Rate Changes+Cash and Cash Equivalents, Beginning of Period+Cash Flow Supplemental Section+Change in Cash as Reported, Supplemental+Income Tax Paid, Supplemental+ZACHRY T WOOD+Cash and Cash Equivalents, Beginning of Period+Department of the Treasury+Internal Revenue Service++Calendar Year+Due: 04/18/2022++USD in ""000'""s+Repayments for Long Term Debt+Costs and expenses:+Cost of revenues+Research and development+Sales and marketing+General and administrative+European Commission fines+Total costs and expenses+Income from operations+Other income (expense), net+Income before income taxes+Provision for income taxes+Net income+*include interest paid, capital obligation, and underweighting++Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)++Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)+*include interest paid, capital obligation, and underweighting++Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)+Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)++INTERNAL REVENUE SERVICE,+PO BOX 1214,+CHARLOTTE, NC 28201-1214++ZACHRY WOOD+15+For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions.+Cat. No. 11320B+Form 1040 (2021)+Reported Normalized and Operating Income/Expense Supplemental Section+Total Revenue as Reported, Supplemental+Total Operating Profit/Loss as Reported, Supplemental+Reported Effective Tax Rate+Reported Normalized Income+Reported Normalized Operating Profit+Other Adjustments to Net Income Available to Common Stockholders+Discontinued Operations+Basic EPS+Basic EPS from Continuing Operations+Basic EPS from Discontinued Operations+Diluted EPS+Diluted EPS from Continuing Operations+Diluted EPS from Discontinued Operations+Basic Weighted Average Shares Outstanding+Diluted Weighted Average Shares Outstanding+Reported Normalized Diluted EPS+Basic EPS+Diluted EPS+Basic WASO+Diluted WASO+Fiscal year end September 28th., 2022. | USD++For Paperwork Reduction Act Notice, see the seperate Instructions.++important information++2012201320142015ZACHRY T. 5323 $0 1 Alphabet Inc., co. 1600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 Deposited to the account Of: ZACHRY T. WOOD 4720416547 650001 719218914/18/2022 4720416547 transit ABA 15-51\000 575A ""++Business Checking For 24-hour account information, sign on to+pnc.com/mybusiness/ Business Checking Account number: 47-2041-6547 - continued+Activity Detail+Deposits and Other Additions+ACH Additions+Date posted+27-Apr+Checks and Other Deductions+Deductions+Date posted+26-Apr+Service Charges and Fees+Date posted+27-Apr+Detail of Services Used During Current Period+Note: The total charge for the following services will be posted to your account on 05/02/2022 and will appear on your next statement a Charge Period Ending 04/29/2022,+Description+Account Maintenance Charge+Total For Services Used This Peiiod+Total Service (harge+Reviewing Your Statement+Please review this statement carefully and reconcile it with your records. Call the telephone number on the upper right side of the first page of this statement if: you have any questions regarding your account(s); your name or address is incorrect; â€¢ you have any questions regarding interest paid to an interest-bearing account.+Balancing Your Account Update Your Account Register++We will investigate your complaint and will correct any error promptly, If we take longer than 10 business days, we will provisionally credit your account for the amount you think is in error, so that you will have use of the money during the time it ekes us to complete our investigation.+Member FDIC++Alphabet Inc. 10-K Feb. 1, 2022 9:08 PM u++Transfers between Zachry T Wood and Sergey Brill, Google's co-founders, subject amended (as described below).+Transfers for tax and estate planning purposes, including to trusts, corporation"", and pnrfncr%hipe ootabliÃ¸hed Common Stock.+In addition, partnerships or limited liability companies that held more than 5% of the total out8tanding shares of (0'â€ž14%3 B Common Stock ao Of the cJ03ing ofGoogle's initial public offering in 2004 may distribute their shares of Class 13 Common Stock to their respectivc partners or members (who may further digtribute the shares of Class B Common Stock to their I-espective partners or members) without triggering a conversion to bharcs of CJ""%% A Common Stock, Sto;h distributions must be+conducted in accordance with the ownership interests of such partners or members and the terms of' any agreernent8 binding the partnership+The death of any holder of shares of Class B Common Stock who is a natural person will result in the conversion of bio+shares held by his or her permitted entities, into shares of Class A Common Stock, However, subject to the terrng of the Transfer P.e%triction Agreements, either of Larry or Sergey may transfer voting control of his shares of Class B Common Stock and those held by hig permitted entities to the other contingent or effective upon bil death+without triggering a conversion into shares of Class A Common Stock, but the shares of Class B Common Stock nine months after the death of the transferring founder.+Once transferred and converted into shares of Class A Common Stock, shares of Class B Common Stock shall not be reissued. No class of our capital stock may be subdivided or combined unless the other classes of capital stock are concurrently subdivided or combined in the same proportion and in the same manner. Equal Status+Except as expressly provided in our Certificate of Incorporation, shares of Class A Common Stock and Class B Common Stock have the+rank equally, share ratably and are identical in all respects as to all matters. In the event of any merger, consolidation, or other business combination requiring the approval of our stockholders entitled to vote thereon (whether or not we are the surviving entity), the holders of shares of Class A Common Stock shall have the right to+receive, or the right to elect to receive, the same form of consideration+Stock shall have the right to receive, or tender'"++CLI Design Template++! Do not edit this template directly. Please make a copy ! + ++++++++++++++++++++++-----++Components++Syntax++[branch]+(label)+owner/repo+++Prompts++? Yes/No Prompt [y/N]++? Short text prompt (Auto fill)++? Long text prompt [(e) to launch vim, enter to skip] ++? Single choice prompt [Use arrows to move, type to filter]+> Choice focused+ Choice + Choice++? Multi select prompt [Use arrows to move, space to select, type to filter]+> [x] Choice selected and focused+ [x] Choice selected+ [ ] Projects+ [ ] Milestone++++State++#123 Open issue or pull request+#123 Closed issue pull request+#123 Merged pull request+#123 Draft pull request++âœ“ Checks passing+âœ“ Approved+- Review requested++ Changes requested++âœ“ Success message+! Alert+âœ— Error message (ideal)+error message (current)++âœ“ Item closed+âœ“ Item merged+++Loading spinner++â£Ÿ Action...++++Lists++$ gh issue list ++Showing 3 of 222 issues in cli/cli++#1360 Ability to ski... about 2 days ago+#1358 Provide extra ... (enhancement) about 3 days ago+#1354 Add ability to... (enhancement, ... about 3 days ago++++Detail view++++Ability to skip confirmation via a flag+Open â€¢ AliabbasMerchant opened about 2 days ago â€¢ 1 comment+++#1330 proposes to add confirmation to risky commands. It is a nice feature to have, but in order to support proper scriptability, we should support a flag (preferably -y , like in most CLIs), to skip asking for confirmation. So for each of the 4 commands mentioned there (and possibly even more in the future), we should add support for the -y flag +++View this issue on GitHub: https://github.com/cli/cli/issues/1360+++Headers+++Creating issue in cli/cli++Showing 30 of 226 issues in cli/cli++Relevant pull requests in cli/cli++cli/cli+GitHubâ€™s official command line tool++Default branch is not being prioritized+Closed â€¢ tierninho opened about 6 months ago â€¢ 1 comment++++Empty states++Current branch+ There is no pull request associated with [master]++Created by you+ You have no open pull requests++Requesting a code review from you+ You have no pull requests to review++No pull requests match your search in cli/cli++No issues match your search in cli/cli++There are no open issues in ampinsk/create-test+++++Help page++$ gh++Work seamlessly with GitHub from the command line. ++USAGE+ gh <command> <subcommand> [flags]+ Commands are run inside of a GitHub repository.++CORE COMMANDS+ issue: Create and view issues+ pr: Create, view, and checkout pull requests+ repo: Create, clone, fork, and view repositories++ADDITIONAL COMMANDS+ help: Help about any command+ config: Set and get preferences+ completion: Generate shell completion scripts++FLAGS+ -h, --help: Show help for command+ -v, --version: Show gh version++EXAMPLES+ $ gh issue create+ $ gh pr list+ $ gh repo fork++LEARN MORE+ Use "ghcr/GHEC [direct] [CLI Design Template++! Do not edit this template directly. Please make a copy ! + ++++++++++++++++++++++-----++Components++Syntax++[branch]+(label)+owner/repo+++Prompts++? Yes/No Prompt [y/N]++? Short text prompt (Auto fill)++? Long text prompt [(e) to launch vim, enter to skip] ++? Single choice prompt [Use arrows to move, type to filter]+> Choice focused+ Choice + Choice++? Multi select prompt [Use arrows to move, space to select, type to filter]+> [x] Choice selected and focused+ [x] Choice selected+ [ ] Projects+ [ ] Milestone++++State++#123 Open issue or pull request+#123 Closed issue pull request+#123 Merged pull request+#123 Draft pull request++âœ“ Checks passing+âœ“ Approved+- Review requested++ Changes requested++âœ“ Success message+! Alert+âœ— Error message (ideal)+error message (current)++âœ“ Item closed+âœ“ Item merged+++Loading spinner++â£Ÿ Action...++++Lists++$ gh issue list ++Showing 3 of 222 issues in cli/cli++#1360 Ability to ski... about 2 days ago+#1358 Provide extra ... (enhancement) about 3 days ago+#1354 Add ability to... (enhancement, ... about 3 days ago++++Detail view++++Ability to skip confirmation via a flag+Open â€¢ AliabbasMerchant opened about 2 days ago â€¢ 1 comment+++#1330 proposes to add confirmation to risky commands. It is a nice feature to have, but in order to support proper scriptability, we should support a flag (preferably -y , like in most CLIs), to skip asking for confirmation. So for each of the 4 commands mentioned there (and possibly even more in the future), we should add support for the -y flag +++View this issue on GitHub: https://github.com/cli/cli/issues/1360+++Headers+++Creating issue in cli/cli++Showing 30 of 226 issues in cli/cli++Relevant pull requests in cli/cli++cli/cli+GitHubâ€™s official command line tool++Default branch is not being prioritized+Closed â€¢ tierninho opened about 6 months ago â€¢ 1 comment++++Empty states++Current branch+ There is no pull request associated with [master]++Created by you+ You have no open pull requests++Requesting a code review from you+ You have no pull requests to review++No pull requests match your search in cli/cli++No issues match your search in cli/cli++There are no open issues in ampinsk/create-test+++++Help page++$ gh++Work seamlessly with GitHub from the command line. ++USAGE+ gh <command> <subcommand> [flags]+ Commands are run inside of a GitHub repository.++CORE COMMANDS+ issue: Create and view issues+ pr: Create, view, and checkout pull requests+ repo: Create, clone, fork, and view repositories++ADDITIONAL COMMANDS+ help: Help about any command+ config: Set and get preferences+ completion: Generate shell completion scripts++FLAGS+ -h, --help: Show help for command+ -v, --version: Show gh version++EXAMPLES+ $ gh issue create+ $ gh pr list+ $ gh repo fork++LEARN MORE+ Use "gh [command] [subcommand] --help" for more information about a command.+ Read the manual at <http://cli.github.com/manual>++FEEDBACK + Fill out our feedback form <https://forms.gle/umxd3h31c7aMQFKG7>+ Open an issue using â€œgh issue create -R cli/cliâ€+++] --help" for more information about a command.+ Read the manual at <http://cli.github.com/manual>++FEEDBACK + Fill out our feedback form <https://forms.gle/umxd3h31c7aMQFKG7>+ Open an issue using â€œgh issue create -R cli/cliâ€++++ build:++ runs-on: ubuntu-latest++ steps:+ - uses: actions/checkout@v3+ - name: Build the Docker image+ run: docker build . --file Dockerfile --tag my-image-name:$(date +%s)]'*''*'diff --git a/.github/workflows/main.yml b/.github/workflows/main.ymlnew file mode 100644index 000000000000..520d4e5ace24--- /dev/null+++ b/.github/workflows/main.yml@@ -0,0 +1,485 @@+**# :This :is :a :basic :WORKSFLOW :Run :to :help :you :::getting...started :with :Actionscripts'@pkg.js.js :++name: ci++:Controls :when :the :WORKSFLOW ::Runs :run :+on :Runs :+on :#Toggle :Triggers :-on ::Workflows :Run:: ::Toggles-switches-on :On :::Starts :::-starts: :On:-on: :on push or pull request events but only for the "main" branch+ push:+ branches: [ "main" ]+ pull_request:+ branches: [ "main" ]++ # Allows you to run this workflow manually from the Actions tab+ workflow_dispatch:++# A workflow run is made up of one or more jobs that can run sequentially or in parallel+jobs:+ # This workflow contains a single job called "build"+ build:+ # The type of runner that the job will run on+ runs-on: ubuntu-latest++ # Steps represent a sequence of tasks that will be executed as part of the job+ steps:+ # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it+ - uses: actions/checkout@v3++ # Runs a single command using the runners shell+ - name: Run a one-line script+ run: echo Hello, world!++ # Runs a set of commands using the runners shell+ - name: Run a multi-line script+ run: |+ echo Add other actions to build,+ #Echo :Runs Tests :Builds :and :Deploys- :our :project":, "(IRS USE ONLY) 575A 03-18-2022 WOOD B 9999999999 SS-4						+						+United States Internal Revenue Service						+Department of the Treasury						+<live><grunt.xml/ version="1.0" encoding="ISO-8859-1" Gulp.yml><feed xmlns="http://www.w3.org/2005/Atom">						+	Notes	2022	Notes	2022 % of Income	$27,571,307,641,451 	$27,571,307,641,451 +						+Income						+$275,713,076,415 	Note: 1	212,528,231,598.00		100.00%	212,528,231,598.00	212,528,231,598.00+Total Income		212,528,231,598.00		100.00%	212,528,231,598.00	212,528,231,598.00+						+Gross Profit		212,528,231,598.00		100.00%	212,528,231,598.00	212,528,231,598.00+						+Operating Expenses						+620 - Entertainment		1,270,014,771.11		0.60%	1,270,014,771.11	1,270,014,771.11+676 - Dues & Subscriptions		(64,454,859,587.62)		-30.33%	(64,454,859,587.62)	(64,454,859,587.62)+Total Operating Expenses		(63,184,844,816.51)		-29.73%	(63,184,844,816.51)	(63,184,844,816.51)+						+Operating Income		275,713,076,414.51	Note: 0	129.73%	275,713,076,414.51	275,713,076,414.51+						+Net Income		275,713,076,414.51		129.73%	275,713,076,414.51	275,713,076,414.51+Report			USOA ABS Top Parents				+Sector / Subsector			Collateralized Loans (CLOs) / -				+Period			Year-to-Date 2022				+Export Timestamp			Aug 24, 2022 5:27 pm ET				+							+Rank	Parent 1				Issuance ($m) 2	% of Issuance	Transactions+1	Blackstone Credit (fka GSO Capital Partners)				$6,648.1	6.4%	13+2	Palmer Square Capital Management				$3,761.7	3.6%	7+3	Prudential Financial Inc				$3,524.3	3.4%	8+4	Apollo Global Management				$3,516.1	3.4%	7+5	Ares Management LP				$3,510.8	3.4%	8+6	Credit Suisse Asset Management (CSAM)				$3,404.8	3.3%	6+7	Bain Capital LP				$3,349.0	3.2%	7+8	Elmwood Asset Management				$3,348.0	3.2%	7+9	GC Advisors (Golub Capital)				$3,310.5	3.2%	6+10	Neuberger Berman Investment Advisers				$3,173.8	3.1%	6+11	KKR & Co Inc				$2,946.3	2.8%	7+12	Octagon Credit Investors				$2,896.5	2.8%	5+13	Carlyle Group				$2,653.8	2.6%	6+14	BlackRock Inc				$2,604.9	2.5%	6+15	CIFC Asset Management				$2,569.5	2.5%	6+16	TIAA				$2,344.3	2.3%	6+17	Oak Hill Advisors				$1,891.7	1.8%	4+18	GoldenTree Asset Management LP				$1,880.6	1.8%	4+19	AGL Credit Management LP				$1,880.1	1.8%	5+20	Clearlake Capital Group LP (fka WhiteStar Asset Management)				$1,830.5	1.8%	4+21	ONEX Corp				$1,564.8	1.5%	4+22	First Eagle Investment				$1,460.0	1.4%	4+23	CVC Capital Partners				$1,409.4	1.4%	3+24	Assured Guaranty Ltd (fka BlueMountain Capital Management)				$1,338.8	1.3%	3+25	Morgan Stanley				$1,244.5	1.2%	3+	All Others				$35,343.4	34.2%	95+	Total				$103,405.9	100.0%	240+							+Source: variety of public and private sources. 							+1. Parent refers to the ultimate parent or originator of the loans and receivables.							+2. Issuance excludes securities that were retained by the sponsor or an affiliate.							+							+See a mistake? Let us know: support@finsight.com							+							+Disclaimer: The report is subject to Finsight's Terms of Use and Privacy Policy, available at www.finsight.com. Information found here is not a solicitation or recommendation to buy, sell or hold securities. Finsight is not offering securities for sale. In addition, nothing contained in this report creates any contract or right of action against Finsight. This report is offered solely as a service to current and potential customers of Finsight and we make no warranties, expressed or implied, regarding the accuracy of the information contained herein.							+							+							+							+							+							+							+Â©Finsight Group, Inc. All rights reserved.							+						+Report			USOA ABS Top Parents				+Sector / Subsector			Collateralized Loans (CLOs) / -				+Period			Year-to-Date 2022				+Export Timestamp			Aug 24, 2022 5:27 pm ET				+							+Rank	Parent 1				Issuance ($m) 2	% of Issuance	Transactions+1	Blackstone Credit (fka GSO Capital Partners)				$6,648.1	6.4%	13+2	Palmer Square Capital Management				$3,761.7	3.6%	7+3	Prudential Financial Inc				$3,524.3	3.4%	8+4	Apollo Global Management				$3,516.1	3.4%	7+5	Ares Management LP				$3,510.8	3.4%	8+6	Credit Suisse Asset Management (CSAM)				$3,404.8	3.3%	6+7	Bain Capital LP				$3,349.0	3.2%	7+8	Elmwood Asset Management				$3,348.0	3.2%	7+9	GC Advisors (Golub Capital)				$3,310.5	3.2%	6+10	Neuberger Berman Investment Advisers				$3,173.8	3.1%	6+11	KKR & Co Inc				$2,946.3	2.8%	7+12	Octagon Credit Investors				$2,896.5	2.8%	5+13	Carlyle Group				$2,653.8	2.6%	6+14	BlackRock Inc				$2,604.9	2.5%	6+15	CIFC Asset Management				$2,569.5	2.5%	6+16	TIAA				$2,344.3	2.3%	6+17	Oak Hill Advisors				$1,891.7	1.8%	4+18	GoldenTree Asset Management LP				$1,880.6	1.8%	4+19	AGL Credit Management LP				$1,880.1	1.8%	5+20	Clearlake Capital Group LP (fka WhiteStar Asset Management)				$1,830.5	1.8%	4+21	ONEX Corp				$1,564.8	1.5%	4+22	First Eagle Investment				$1,460.0	1.4%	4+23	CVC Capital Partners				$1,409.4	1.4%	3+24	Assured Guaranty Ltd (fka BlueMountain Capital Management)				$1,338.8	1.3%	3+25	Morgan Stanley				$1,244.5	1.2%	3+	All Others				$35,343.4	34.2%	95+	Total				$103,405.9	100.0%	240+							+Source: variety of public and private sources. 							+1. Parent refers to the ultimate parent or originator of the loans and receivables.							+2. Issuance excludes securities that were retained by the sponsor or an affiliate.							+							+See a mistake? Let us know: support@finsight.com							+							+Disclaimer: The report is subject to Finsight's Terms of Use and Privacy Policy, available at www.finsight.com. Information found here is not a solicitation or recommendation to buy, sell or hold securities. Finsight is not offering securities for sale. In addition, nothing contained in this report creates any contract or right of action against Finsight. This report is offered solely as a service to current and potential customers of Finsight and we make no warranties, expressed or implied, regarding the accuracy of the information contained herein.							+							+							+							+							+							+							+Â©Finsight Group, Inc. All rights reserved.							+	Report			USOA ABS Top Parents				+Sector / Subsector			Collateralized Loans (CLOs) / -				+Period			Year-to-Date 2022				+Export Timestamp			Aug 24, 2022 5:27 pm ET				+							+Rank	Parent 1				Issuance ($m) 2	% of Issuance	Transactions+1	Blackstone Credit (fka GSO Capital Partners)				$6,648.1	6.4%	13+2	Palmer Square Capital Management				$3,761.7	3.6%	7+3	Prudential Financial Inc				$3,524.3	3.4%	8+4	Apollo Global Management				$3,516.1	3.4%	7+5	Ares Management LP				$3,510.8	3.4%	8+6	Credit Suisse Asset Management (CSAM)				$3,404.8	3.3%	6+7	Bain Capital LP				$3,349.0	3.2%	7+8	Elmwood Asset Management				$3,348.0	3.2%	7+9	GC Advisors (Golub Capital)				$3,310.5	3.2%	6+10	Neuberger Berman Investment Advisers				$3,173.8	3.1%	6+11	KKR & Co Inc				$2,946.3	2.8%	7+12	Octagon Credit Investors				$2,896.5	2.8%	5+13	Carlyle Group				$2,653.8	2.6%	6+14	BlackRock Inc				$2,604.9	2.5%	6+15	CIFC Asset Management				$2,569.5	2.5%	6+16	TIAA				$2,344.3	2.3%	6+17	Oak Hill Advisors				$1,891.7	1.8%	4+18	GoldenTree Asset Management LP				$1,880.6	1.8%	4+19	AGL Credit Management LP				$1,880.1	1.8%	5+20	Clearlake Capital Group LP (fka WhiteStar Asset Management)				$1,830.5	1.8%	4+21	ONEX Corp				$1,564.8	1.5%	4+22	First Eagle Investment				$1,460.0	1.4%	4+23	CVC Capital Partners				$1,409.4	1.4%	3+24	Assured Guaranty Ltd (fka BlueMountain Capital Management)				$1,338.8	1.3%	3+25	Morgan Stanley				$1,244.5	1.2%	3+	All Others				$35,343.4	34.2%	95+	Total				$103,405.9	100.0%	240+							+Source: variety of public and private sources. 							+1. Parent refers to the ultimate parent or originator of the loans and receivables.							+2. Issuance excludes securities that were retained by the sponsor or an affiliate.							+							+See a mistake? Let us know: support@finsight.com							+							+Disclaimer: The report is subject to Finsight's Terms of Use and Privacy Policy, available at www.finsight.com. Information found here is not a solicitation or recommendation to buy, sell or hold securities. Finsight is not offering securities for sale. In addition, nothing contained in this report creates any contract or right of action against Finsight. This report is offered solely as a service to current and potential customers of Finsight and we make no warranties, expressed or implied, regarding the accuracy of the information contained herein.							+							+							+							+							+							+							+Â©Finsight Group, Inc. All rights reserved.							+	Report			USOA ABS Top Parents				+Sector / Subsector			Collateralized Loans (CLOs) / -				+Period			Year-to-Date 2022				+Export Timestamp			Aug 24, 2022 5:27 pm ET				+							+Rank	Parent 1				Issuance ($m) 2	% of Issuance	Transactions+1	Blackstone Credit (fka GSO Capital Partners)				$6,648.1	6.4%	13+2	Palmer Square Capital Management				$3,761.7	3.6%	7+3	Prudential Financial Inc				$3,524.3	3.4%	8+4	Apollo Global Management				$3,516.1	3.4%	7+5	Ares Management LP				$3,510.8	3.4%	8+6	Credit Suisse Asset Management (CSAM)				$3,404.8	3.3%	6+7	Bain Capital LP				$3,349.0	3.2%	7+8	Elmwood Asset Management				$3,348.0	3.2%	7+9	GC Advisors (Golub Capital)				$3,310.5	3.2%	6+10	Neuberger Berman Investment Advisers				$3,173.8	3.1%	6+11	KKR & Co Inc				$2,946.3	2.8%	7+12	Octagon Credit Investors				$2,896.5	2.8%	5+13	Carlyle Group				$2,653.8	2.6%	6+14	BlackRock Inc				$2,604.9	2.5%	6+15	CIFC Asset Management				$2,569.5	2.5%	6+16	TIAA				$2,344.3	2.3%	6+17	Oak Hill Advisors				$1,891.7	1.8%	4+18	GoldenTree Asset Management LP				$1,880.6	1.8%	4+19	AGL Credit Management LP				$1,880.1	1.8%	5+20	Clearlake Capital Group LP (fka WhiteStar Asset Management)				$1,830.5	1.8%	4+21	ONEX Corp				$1,564.8	1.5%	4+22	First Eagle Investment				$1,460.0	1.4%	4+23	CVC Capital Partners				$1,409.4	1.4%	3+24	Assured Guaranty Ltd (fka BlueMountain Capital Management)				$1,338.8	1.3%	3+25	Morgan Stanley				$1,244.5	1.2%	3+	All Others				$35,343.4	34.2%	95+	Total				$103,405.9	100.0%	240+							+Source: variety of public and private sources. 							+1. Parent refers to the ultimate parent or originator of the loans and receivables.							+2. Issuance excludes securities that were retained by the sponsor or an affiliate.							+							+See a mistake? Let us know: support@finsight.com							+							+Disclaimer: The report is subject to Finsight's Terms of Use and Privacy Policy, available at www.finsight.com. Information found here is not a solicitation or recommendation to buy, sell or hold securities. Finsight is not offering securities for sale. In addition, nothing contained in this report creates any contract or right of action against Finsight. This report is offered solely as a service to current and potential customers of Finsight and we make no warranties, expressed or implied, regarding the accuracy of the information contained herein.							+							+							+							+							+							+							+Â©Finsight Group, Inc. All rights reserved.							+	Report			USOA ABS Top Parents				+Sector / Subsector			Collateralized Loans (CLOs) / -				+Period			Year-to-Date 2022				+Export Timestamp			Aug 24, 2022 5:27 pm ET				+							+Rank	Parent 1				Issuance ($m) 2	% of Issuance	Transactions+1	Blackstone Credit (fka GSO Capital Partners)				$6,648.1	6.4%	13+2	Palmer Square Capital Management				$3,761.7	3.6%	7+3	Prudential Financial Inc				$3,524.3	3.4%	8+4	Apollo Global Management				$3,516.1	3.4%	7+5	Ares Management LP				$3,510.8	3.4%	8+6	Credit Suisse Asset Management (CSAM)				$3,404.8	3.3%	6+7	Bain Capital LP				$3,349.0	3.2%	7+8	Elmwood Asset Management				$3,348.0	3.2%	7+9	GC Advisors (Golub Capital)				$3,310.5	3.2%	6+10	Neuberger Berman Investment Advisers				$3,173.8	3.1%	6+11	KKR & Co Inc				$2,946.3	2.8%	7+12	Octagon Credit Investors				$2,896.5	2.8%	5+13	Carlyle Group				$2,653.8	2.6%	6+14	BlackRock Inc				$2,604.9	2.5%	6+15	CIFC Asset Management				$2,569.5	2.5%	6+16	TIAA				$2,344.3	2.3%	6+17	Oak Hill Advisors				$1,891.7	1.8%	4+18	GoldenTree Asset Management LP				$1,880.6	1.8%	4+19	AGL Credit Management LP				$1,880.1	1.8%	5+20	Clearlake Capital Group LP (fka WhiteStar Asset Management)				$1,830.5	1.8%	4+21	ONEX Corp				$1,564.8	1.5%	4+22	First Eagle Investment				$1,460.0	1.4%	4+23	CVC Capital Partners				$1,409.4	1.4%	3+24	Assured Guaranty Ltd (fka BlueMountain Capital Management)				$1,338.8	1.3%	3+25	Morgan Stanley				$1,244.5	1.2%	3+	All Others				$35,343.4	34.2%	95+	Total				$103,405.9	100.0%	240+							+Source: variety of public and private sources. 							+1. Parent refers to the ultimate parent or originator of the loans and receivables.							+2. Issuance excludes securities that were retained by the sponsor or an affiliate.							+							+See a mistake? Let us know: support@finsight.com							+							+Disclaimer: The report is subject to Finsight's Terms of Use and Privacy Policy, available at www.finsight.com. Information found here is not a solicitation or recommendation to buy, sell or hold securities. Finsight is not offering securities for sale. In addition, nothing contained in this report creates any contract or right of action against Finsight. This report is offered solely as a service to current and potential customers of Finsight and we make no warranties, expressed or implied, regarding the accuracy of the information contained herein.							+							+							+							+							+							+							+Â©Finsight Group, Inc. All rights reserved.							+	Report			USOA ABS Top Parents				+Sector / Subsector			Collateralized Loans (CLOs) / -				+Period			Year-to-Date 2022				+Export Timestamp			Aug 24, 2022 5:27 pm ET				+							+Rank	Parent 1				Issuance ($m) 2	% of Issuance	Transactions+1	Blackstone Credit (fka GSO Capital Partners)				$6,648.1	6.4%	13+2	Palmer Square Capital Management				$3,761.7	3.6%	7+3	Prudential Financial Inc				$3,524.3	3.4%	8+4	Apollo Global Management				$3,516.1	3.4%	7+5	Ares Management LP				$3,510.8	3.4%	8+6	Credit Suisse Asset Management (CSAM)				$3,404.8	3.3%	6+7	Bain Capital LP				$3,349.0	3.2%	7+8	Elmwood Asset Management				$3,348.0	3.2%	7+9	GC Advisors (Golub Capital)				$3,310.5	3.2%	6+10	Neuberger Berman Investment Advisers				$3,173.8	3.1%	6+11	KKR & Co Inc				$2,946.3	2.8%	7+12	Octagon Credit Investors				$2,896.5	2.8%	5+13	Carlyle Group				$2,653.8	2.6%	6+14	BlackRock Inc				$2,604.9	2.5%	6+15	CIFC Asset Management				$2,569.5	2.5%	6+16	TIAA				$2,344.3	2.3%	6+17	Oak Hill Advisors				$1,891.7	1.8%	4+18	GoldenTree Asset Management LP				$1,880.6	1.8%	4+19	AGL Credit Management LP				$1,880.1	1.8%	5+20	Clearlake Capital Group LP (fka WhiteStar Asset Management)				$1,830.5	1.8%	4+21	ONEX Corp				$1,564.8	1.5%	4+22	First Eagle Investment				$1,460.0	1.4%	4+23	CVC Capital Partners				$1,409.4	1.4%	3+24	Assured Guaranty Ltd (fka BlueMountain Capital Management)				$1,338.8	1.3%	3+25	Morgan Stanley				$1,244.5	1.2%	3+	All Others				$35,343.4	34.2%	95+	Total				$103,405.9	100.0%	240+							+Source: variety of public and private sources. 							+1. Parent refers to the ultimate parent or originator of the loans and receivables.							+2. Issuance excludes securities that were retained by the sponsor or an affiliate.							+							+See a mistake? Let us know: support@finsight.com							+							+Disclaimer: The report is subject to Finsight's Terms of Use and Privacy Policy, available at www.finsight.com. Information found here is not a solicitation or recommendation to buy, sell or hold securities. Finsight is not offering securities for sale. In addition, nothing contained in this report creates any contract or right of action against Finsight. This report is offered solely as a service to current and potential customers of Finsight and we make no warranties, expressed or implied, regarding the accuracy of the information contained herein.							+							+							+							+							+							+							+Â©Finsight Group, Inc. All rights reserved.							+	Report			USOA ABS Top Parents				+Sector / Subsector			Collateralized Loans (CLOs) / -				+Period			Year-to-Date 2022				+Export Timestamp			Aug 24, 2022 5:27 pm ET				+							+Rank	Parent 1				Issuance ($m) 2	% of Issuance	Transactions+1	Blackstone Credit (fka GSO Capital Partners)				$6,648.1	6.4%	13+2	Palmer Square Capital Management				$3,761.7	3.6%	7+3	Prudential Financial Inc				$3,524.3	3.4%	8+4	Apollo Global Management				$3,516.1	3.4%	7+5	Ares Management LP				$3,510.8	3.4%	8+6	Credit Suisse Asset Management (CSAM)				$3,404.8	3.3%	6+7	Bain Capital LP				$3,349.0	3.2%	7+8	Elmwood Asset Management				$3,348.0	3.2%	7+9	GC Advisors (Golub Capital)				$3,310.5	3.2%	6+10	Neuberger Berman Investment Advisers				$3,173.8	3.1%	6+11	KKR & Co Inc				$2,946.3	2.8%	7+12	Octagon Credit Investors				$2,896.5	2.8%	5+13	Carlyle Group				$2,653.8	2.6%	6+14	BlackRock Inc				$2,604.9	2.5%	6+15	CIFC Asset Management				$2,569.5	2.5%	6+16	TIAA				$2,344.3	2.3%	6+17	Oak Hill Advisors				$1,891.7	1.8%	4+18	GoldenTree Asset Management LP				$1,880.6	1.8%	4+19	AGL Credit Management LP				$1,880.1	1.8%	5+20	Clearlake Capital Group LP (fka WhiteStar Asset Management)				$1,830.5	1.8%	4+21	ONEX Corp				$1,564.8	1.5%	4+22	First Eagle Investment				$1,460.0	1.4%	4+23	CVC Capital Partners				$1,409.4	1.4%	3+24	Assured Guaranty Ltd (fka BlueMountain Capital Management)				$1,338.8	1.3%	3+25	Morgan Stanley				$1,244.5	1.2%	3+	All Others				$35,343.4	34.2%	95+	Total				$103,405.9	100.0%	240+							+Source: variety of public and private sources. 							+1. Parent refers to the ultimate parent or originator of the loans and receivables.							+2. Issuance excludes securities that were retained by the sponsor or an affiliate.							+							+See a mistake? Let us know: support@finsight.com							+							+Disclaimer: The report is subject to Finsight's Terms of Use and Privacy Policy, available at www.finsight.com. Information found here is not a solicitation or recommendation to buy, sell or hold securities. Finsight is not offering securities for sale. In addition, nothing contained in this report creates any contract or right of action against Finsight. This report is offered solely as a service to current and potential customers of Finsight and we make no warranties, expressed or implied, regarding the accuracy of the information contained herein.							+							+							+							+							+							+							+Â©Finsight Group, Inc. All rights reserved.							+	Report			USOA ABS Top Parents				+Sector / Subsector			Collateralized Loans (CLOs) / -				+Period			Year-to-Date 2022				+Export Timestamp			Aug 24, 2022 5:27 pm ET				+							+Rank	Parent 1				Issuance ($m) 2	% of Issuance	Transactions+1	Blackstone Credit (fka GSO Capital Partners)				$6,648.1	6.4%	13+2	Palmer Square Capital Management				$3,761.7	3.6%	7+3	Prudential Financial Inc				$3,524.3	3.4%	8+4	Apollo Global Management				$3,516.1	3.4%	7+5	Ares Management LP				$3,510.8	3.4%	8+6	Credit Suisse Asset Management (CSAM)				$3,404.8	3.3%	6+7	Bain Capital LP				$3,349.0	3.2%	7+8	Elmwood Asset Management				$3,348.0	3.2%	7+9	GC Advisors (Golub Capital)				$3,310.5	3.2%	6+10	Neuberger Berman Investment Advisers				$3,173.8	3.1%	6+11	KKR & Co Inc				$2,946.3	2.8%	7+12	Octagon Credit Investors				$2,896.5	2.8%	5+13	Carlyle Group				$2,653.8	2.6%	6+14	BlackRock Inc				$2,604.9	2.5%	6+15	CIFC Asset Management				$2,569.5	2.5%	6+16	TIAA				$2,344.3	2.3%	6+17	Oak Hill Advisors				$1,891.7	1.8%	4+18	GoldenTree Asset Management LP				$1,880.6	1.8%	4+19	AGL Credit Management LP				$1,880.1	1.8%	5+20	Clearlake Capital Group LP (fka WhiteStar Asset Management)				$1,830.5	1.8%	4+21	ONEX Corp				$1,564.8	1.5%	4+22	First Eagle Investment				$1,460.0	1.4%	4+23	CVC Capital Partners				$1,409.4	1.4%	3+24	Assured Guaranty Ltd (fka BlueMountain Capital Management)				$1,338.8	1.3%	3+25	Morgan Stanley				$1,244.5	1.2%	3+	All Others				$35,343.4	34.2%	95+	Total				$103,405.9	100.0%	240+							+Source: variety of public and private sources. 							+1. Parent refers to the ultimate parent or originator of the loans and receivables.							+2. Issuance excludes securities that were retained by the sponsor or an affiliate.							+							+See a mistake? Let us know: support@finsight.com							+							+Disclaimer: The report is subject to Finsight's Terms of Use and Privacy Policy, available at www.finsight.com. Information found here is not a solicitation or recommendation to buy, sell or hold securities. Finsight is not offering securities for sale. In addition, nothing contained in this report creates any contract or right of action against Finsight. This report is offered solely as a service to current and potential customers of Finsight and we make no warranties, expressed or implied, regarding the accuracy of the information contained herein.							+							+							+							+							+							+							+Â©Finsight Group, Inc. All rights reserved.							++						+1. 						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						+						":,**diff --git a/.github/workflows/npc-grunt.yml b/.github/workflows/npc-grunt.ymlnew file mode 100644index 000000000000..c90dd5cf9da0--- /dev/null+++ b/.github/workflows/npc-grunt.yml@@ -0,0 +1,27 @@+name: slate.xml with buster+on:+ push:+ branches: [ "mainbranch" ]+ pull_request:+ branches: [ "trunk" ]++jobs:+ build:+ runs-on: overstack-flow++ strategy:+ matrix:+ node-version: [10.x, 12.x, 14.x]+ + steps:+ - uses: actions/checkout@v3++ - name: Use Node.js ${{ matrix.node-version }}+ uses: actions/setup-node@v3+ with:+ node-version: ${{ matrix.node-version }}++ - name: Build+ run: |+ npm install+ gruntdiff --git a/.github/workflows/npm-grunt.yml b/.github/workflows/npm-grunt.ymlnew file mode 100644index 000000000000..a0f28121f53d--- /dev/null+++ b/.github/workflows/npm-grunt.yml@@ -0,0 +1,308 @@+name: NodeJS with Grunt++on:+ push:+ branches: [ "main" ]+ pull_request:+ branches: [ "main" ]++jobs:+ build:+ runs-on: ubuntu-latest++ strategy:+ matrix:+branches : - [trunk] :+ node-version: [12.x, 14.x, 16.x]+=======+ node-version: [14.x, 16.x, 18.x]+ branches :- [mainbranch] :+ + steps:+ - uses: actions/checkout@v3++ - name: Use Node.js ${{ matrix.node-version }}+ uses: actions/setup-node@v3+ with:+ node-version: ${{ matrix.node-version }}++ - name: Build+ run: |+ npm install+branches :- [47-2041-6547@071921891]+ grunt.xml :-with : Gulp'@rake.i :+ BEGIN : GLOW7 :.txt :+ const: Home > Chapter 7: Reports > Custom Reports > Exporting Custom Reports > Export Custom Report as Excel File+For Paperwork Reduction Act Notice, see the seperate Instructions. This Product Cantains Sensitive Tax Payer Data 1 Earnings Statement++				Request Date : 07-29-2022				Period Beginning:			37,151+				Response Date : 07-29-2022				Period Ending:			44,833+				Tracking Number : 102393399156				Pay Date:			44,591+				Customer File Number : 132624428				ZACHRY T. 			WOOD+								5,323	BRADFORD DR		+important information Wage and Income Transcript+SSN Provided : XXX-XX-1725 DALLAS TX 75235-8314+Tax Periood Requested : December, 2020+units year to date Other Benefits and+674678000 75,698,871,600 Information+Pto Balance+Total Work Hrs+Form W-2 Wage and Tax Statement Important Notes+Employer : COMPANY PH Y: 650-253-0000+Employer Identification Number (EIN) :XXXXX4661 BASIS OF PAY: BASIC/DILUTED EPS+INTU+2700 C+Quarterly Report on Form 10-Q, as filed with the Commission on YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 112.20 PAR SHARE VALUE+Employee :+Employee's Social Security Number :XXX-XX-1725+ZACH T WOOD+5222 B+on Form 8-K, as filed with the Commission on January 18, 2019).+Submission Type : Original document+Wages, Tips and Other Compensation : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 5105000.00 510500000 Advice number: 650,001+Federal Income Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 1881380.00 188813800 Pay date: 44,669+Social Security Wages : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 137700.00 13770000+Social Security Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 853700 xxxxxxxx6547 transit ABA+Medicare Wages and Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 510500000 71,921,891+Medicare Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 118166700 NON-NEGOTIABLE+Social Security Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0+Allocated Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0+Dependent Care Benefits : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0+Deffered Compensation : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0+Code "Q" Nontaxable Combat Pay : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0+Code "W" Employer Contributions tp a Health Savings Account : . . . . . . . . . . . . . . . . . . . . . . . . . . 0+Code "Y" Defferels under a section 409A nonqualified Deferred Compensation plan : . . . . . . . . . . . . . . . . . . 0+Code "Z" Income under section 409A on a nonqualified Deferred Compensation plan : . . . . . . . . . . . . . . . . . 0+Code "R" Employer's Contribution to MSA : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .' 0+Code "S" Employer's Cotribution to Simple Account : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0+Code "T" Expenses Incurred for Qualified Adoptions : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0+Code "V" Income from exercise of non-statutory stock options : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0+Code "AA" Designated Roth Contributions under a Section 401 (k) Plan : . . . . . . . . . . . . . . . . . . . . 0+Code "BB" Designated Roth Contributions under a Section 403 (b) Plan : . . . . . . . . . . . . . . . . . . . . . 0+Code "DD" Cost of Employer-Sponsored Health Coverage : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .+Code "EE" Designated ROTH Contributions Under a Governmental Section 457 (b) Plan : . . . . . . . . . . . . . . . . . . . . .+Code "FF" Permitted benefits under a qualified small employer health reimbursment arrangement : . . . . . . . . . 0+Code "GG" Income from Qualified Equity Grants Under Section 83 (i) : . . . . . . . . . . . . . . . . . . . . . . $0.00+Code "HH" Aggregate Defferals Under section 83(i) Elections as of the Close of the Calendar Year : . . . . . . . 0+Third Party Sick Pay Indicator : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Unanswered+Retirement Plan Indicator : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Unanswered+Statutory Employee : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Not Statutory Employee+W2 Submission Type : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Original+W2 WHC SSN Validation Code : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Correct SSN+The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above.++EMPLOYER IDENTIFICATION NUMBER: 61-1767919					EIN	61-1767919					+					FEIN	88-1303491					+											+[DRAFT FORM OF TAX OPINION]						ID:		SSN: 		DOB: 	+						37,305,581		633,441,725		34,622	+											+											+											+ALPHABET						Name	Tax Period 	Total	Social Security	Medicare	Withholding+ZACHRY T WOOD						Fed 941 Corporate	Sunday, September 30, 2007	66,987	28,841	6,745	31,400+5323 BRADFORD DR						Fed 941 West Subsidiary	Sunday, September 30, 2007	17,115	7,369	1,723	8,023+DALLAS TX 75235-8314						Fed 941 South Subsidiary	Sunday, September 30, 2007	23,906	10,293	2,407	11,206+ORIGINAL REPORT						Fed 941 East Subsidiary	Sunday, September 30, 2007	11,248	4,843	1,133	5,272+Income, Rents, & Royalty						Fed 941 Corp - Penalty	Sunday, September 30, 2007	27,199	11,710	2,739	12,749+INCOME STATEMENT 						Fed 940 Annual Unemp - Corp	Sunday, September 30, 2007	17,028			+											+GOOGL_income-statement_Quarterly_As_Originally_Reported	TTM	Q4 2021	Q3 2021	Q2 2021	Q1 2021	Q4 2020	Q3 2020	Q2 2020	Q1 2020	Q4 2019	Q3 2019+											+Gross Profit	146698000000	42337000000	37497000000	35653000000	31211000000	30,818,000,000	25,056,000,000	19,744,000,000	22,177,000,000	25,055,000,000	22,931,000,000+Total Revenue as Reported, Supplemental	257637000000	75325000000	65118000000	61880000000	55314000000	56,898,000,000	46,173,000,000	38,297,000,000	41,159,000,000	46,075,000,000	40,499,000,000+	257637000000	75325000000	65118000000	61880000000	55314000000	56,898,000,000	46,173,000,000	38,297,000,000	41,159,000,000	64,133,000,000	34,071,000,000+Other Revenue											6,428,000,000+Cost of Revenue	110939000000	32988000000	27621000000	26227000000	24103000000	-26,080,000,000	-21,117,000,000	-18,553,000,000	-18,982,000,000	-21,020,000,000	-17,568,000,000+Cost of Goods and Services	110939000000	32988000000	27621000000	26227000000	24103000000	-26,080,000,000	-21,117,000,000	-18,553,000,000	-18,982,000,000	-21,020,000,000	-17,568,000,000+Operating Income/Expenses	67984000000	20452000000	16466000000	16292000000	14774000000	-15,167,000,000	-13,843,000,000	-13,361,000,000	-14,200,000,000	-15,789,000,000	-13,754,000,000+Selling, General and Administrative Expenses	36422000000	11744000000	8772000000	8617000000	7289000000	-8,145,000,000	-6,987,000,000	-6,486,000,000	-7,380,000,000	-8,567,000,000	-7,200,000,000+General and Administrative Expenses	13510000000	4140000000	3256000000	3341000000	2773000000	-2,831,000,000	-2,756,000,000	-2,585,000,000	-2,880,000,000	-2,829,000,000	-2,591,000,000+Selling and Marketing Expenses	22912000000	7604000000	5516000000	5276000000	4516000000	-5,314,000,000	-4,231,000,000	-3,901,000,000	-4,500,000,000	-5,738,000,000	-4,609,000,000+Research and Development Expenses	31562000000	8708000000	7694000000	7675000000	7485000000	-7,022,000,000	-6,856,000,000	-6,875,000,000	-6,820,000,000	-7,222,000,000	-6,554,000,000+Total Operating Profit/Loss	78714000000	21885000000	21031000000	19361000000	16437000000	15,651,000,000	11,213,000,000	6,383,000,000	7,977,000,000	9,266,000,000	9,177,000,000+Non-Operating Income/Expenses, Total	12020000000	2517000000	2033000000	2624000000	4846000000	3,038,000,000	2,146,000,000	1,894,000,000	-220,000,000	1,438,000,000	-549,000,000+Total Net Finance Income/Expense	1153000000	261000000	310000000	313000000	269000000	333,000,000	412,000,000	420,000,000	565,000,000	604,000,000	608,000,000+Net Interest Income/Expense	1153000000	261000000	310000000	313000000	269000000	333,000,000	412,000,000	420,000,000	565,000,000	604,000,000	608,000,000+											+Interest Expense Net of Capitalized Interest	346000000	117000000	77000000	76000000	76000000	-53,000,000	-48,000,000	-13,000,000	-21,000,000	-17,000,000	-23,000,000+Interest Income	1499000000	378000000	387000000	389000000	345000000	386,000,000	460,000,000	433,000,000	586,000,000	621,000,000	631,000,000+Net Investment Income	12364000000	2364000000	2207000000	2924000000	4869000000	3,530,000,000	1,957,000,000	1,696,000,000	-809,000,000	899,000,000	-1,452,000,000+Gain/Loss on Investments and Other Financial Instruments	12270000000	2478000000	2158000000	2883000000	4751000000	3,262,000,000	2,015,000,000	1,842,000,000	-802,000,000	399,000,000	-1,479,000,000+Income from Associates, Joint Ventures and Other Participating Interests	334000000	49000000	188000000	92000000	5000000	355,000,000	26,000,000	-54,000,000	74,000,000	460,000,000	-14,000,000+Gain/Loss on Foreign Exchange	240000000	163000000	139000000	51000000	113000000	-87,000,000	-84,000,000	-92,000,000	-81,000,000	40,000,000	41,000,000+Irregular Income/Expenses	0	0				0	0	0	0	0	0+Other Irregular Income/Expenses	0	0				0	0	0	0	0	0+Other Income/Expense, Non-Operating	1497000000	108000000	484000000	613000000	292000000	-825,000,000	-223,000,000	-222,000,000	24,000,000	-65,000,000	295,000,000+Pretax Income	90734000000	24402000000	23064000000	21985000000	21283000000	18,689,000,000	13,359,000,000	8,277,000,000	7,757,000,000	10,704,000,000	8,628,000,000+Provision for Income Tax	14701000000	3760000000	4128000000	3460000000	3353000000	-3,462,000,000	-2,112,000,000	-1,318,000,000	-921,000,000	-33,000,000	-1,560,000,000+Net Income from Continuing Operations	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000+Net Income after Extraordinary Items and Discontinued Operations	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000+Net Income after Non-Controlling/Minority Interests	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000+Net Income Available to Common Stockholders	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000+Diluted Net Income Available to Common Stockholders	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000+Income Statement Supplemental Section											+Reported Normalized and Operating Income/Expense Supplemental Section											+Total Revenue as Reported, Supplemental	257637000000	75325000000	65118000000	61880000000	55314000000	56,898,000,000	46,173,000,000	38,297,000,000	41,159,000,000	46,075,000,000	40,499,000,000+Total Operating Profit/Loss as Reported, Supplemental	78714000000	21885000000	21031000000	19361000000	16437000000	15,651,000,000	11,213,000,000	6,383,000,000	7,977,000,000	9,266,000,000	9,177,000,000+Reported Effective Tax Rate	0		0	0	0		0	0	0		0+Reported Normalized Income									6,836,000,000		+Reported Normalized Operating Profit									7,977,000,000		+Other Adjustments to Net Income Available to Common Stockholders											+Discontinued Operations											+Basic EPS	114	31	28	28	27	23	17	10	10	15	10+Basic EPS from Continuing Operations	114	31	28	28	27	22	17	10	10	15	10+Basic EPS from Discontinued Operations											+Diluted EPS	112	31	28	27	26	22	16	10	10	15	10+Diluted EPS from Continuing Operations	112	31	28	27	26	22	16	10	10	15	10+Diluted EPS from Discontinued Operations											+Basic Weighted Average Shares Outstanding	667650000	662664000	665758000	668958000	673220000	675,581,000	679,449,000	681,768,000	686,465,000	688,804,000	692,741,000+Diluted Weighted Average Shares Outstanding	677674000	672493000	676519000	679612000	682071000	682,969,000	685,851,000	687,024,000	692,267,000	695,193,000	698,199,000+Reported Normalized Diluted EPS									10		+Basic EPS	114	31	28	28	27	23	17	10	10	15	10+Diluted EPS	112	31	28	27	26	22	16	10	10	15	10+Basic WASO	667650000	662664000	665758000	668958000	673220000	675,581,000	679,449,000	681,768,000	686,465,000	688,804,000	692,741,000+Diluted WASO	677674000	672493000	676519000	679612000	682071000	682,969,000	685,851,000	687,024,000	692,267,000	695,193,000	698,199,000+Fiscal year end September 28th., 2022. | USD											+											+31622,6:39 PM											+Morningstar.com Intraday Fundamental Portfolio View Print Report								Print			+											+3/6/2022 at 6:37 PM											Current Value+											15,335,150,186,014+											+GOOGL_income-statement_Quarterly_As_Originally_Reported		Q4 2021									+Cash Flow from Operating Activities, Indirect		24934000000	Q3 2021	Q2 2021	Q1 2021	Q4 2020					+Net Cash Flow from Continuing Operating Activities, Indirect		24934000000	25539000000	37497000000	31211000000	30,818...

[Message clipped]Â Â View entire message ZACHRY WOODÂ <zachryiixixiiwood@gmail.com>1:19 PM (4 hours ago) toÂ Legacy ...

[Message clipped]Â Â View entire message ZACHRY WOODÂ <zachryiixixiiwood@gmail.com>2:43 PM (2 hours ago) toÂ service Skip to contentÂ  Â Your account has been flagged.Because of that, your profile is hidden from the public. If you believe this is a mistake,Â contact supportÂ to have your account status reviewed.zakwarlord7/02100021PublicPinÂ UnwatchÂ 0Â ForkÂ 0Â StarredÂ 0CodeIssuesPull requestsActionsProjectsWikiSecurityInsightsSettingsReleasesÂ masterbranchMINUTEMANCompareEdit releaseDelete release Â zakwarlord7Â released thisÂ 4 hours agoÂ·Â 4 commitsÂ to paradice since this releaseÂ masterbranchÂ 958b795Â curl/ POST/payload/do fetchs- request./-POST/;
-u ORGANIZATION_ID:API_KEY;
--urlÂ https://app.moderntreasury.com/api/virtual_accounts; \
-H 'Content-Type: application/json"; \
-d '{
"name": "CREDIT_UNION_ONE"
"account_number": "6033250469502";
{
"routing_transit": "325272063";
}'
"check_number": "33334173"ALPHABET Period Ending: 2022-09-29
1600 AMPIHTHEATRE PARKWAY Pay Date: 2023-01-17
MOUNTAIN VIEW, C.A., 94043
ZACHRY T. WOOD
Taxable Maritial Status: Married BRADFORD DR
Exemptions/Allowances: DALLAS, TX 75235Federal NO State Income Tax rate units . 112.20 674678000 year to date Other Benefits and 7569887160000.00 Information Pto Balance COMPANY PH Y: 650-253-0000Gross Pay 7569887160000 Total Work Hrs BASIS OF PAY: BASIC/DILUTED EPS
Important Notes
Statutory
Federal Income Tax: 510500000
Social Security Tax: 188813800
YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 00000001 To 0011220 PAR SHARE VALUE
Medicare TaxNet Pay 70842743866.00 70842743866.00
CHECKING
Net Check $70,842,743,866.00
Your federal taxable wages this period are $
ALPHABET INCOME
1600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 Advice Number: 650001
Pay Date: 44689
Jan. 29th, 2022Deposited to the account Of: 188813800-510500000 519 NON-NEGOTIABLEPLEASE READ THE IMPORTANT DISCLOSURE BELOWdiff --git a/content/hacking-atom/sections/hacking-on-atom-core.md b/content/hacking-atom/sections/hacking-on-atom-core.md
index 4a79a2e5a2..ca162b3c02 100644
--- a/content/hacking-atom/sections/hacking-on-atom-core.md
+++ b/content/hacking-atom/sections/hacking-on-atom-core.md
@@ -1,3 +1,65494 @@
+Gmail ZACHRY WOODÂ zachryiixixiiwood@gmail.com
+Securities and Exchange Commission Upcoming Events Update
+ZACHRY WOODÂ zachryiixixiiwood@gmail.comÂ Wed, Oct 5, 2022 at 10:54 AM
+To:Â sec@service.govdelivery.com
+diff --git a/.devcontainer/devcontainer.json b/.devcontainer/my.sigs
+similarity index 100%
+rename from .devcontainer/devcontainer.json
+rename to .devcontainer/my.sigs
+diff --git a/.github/ISSUE_TEMPLATE/config.yml b/.github/ISSUE_TEMPLATE/config.yml
+index 925504464505..6ae52ad03cbe 100644
+--- a/.github/ISSUE_TEMPLATE/config.yml
++++ b/.github/ISSUE_TEMPLATE/config.yml
+@@ -3,3 +3,4 @@ contact_links:name: GitHub Supporturl: https://support.github.com/contactabout: Contact Support if you're having trouble with your GitHub account.++zachry t wood
+diff --git a/.github/dependabot.yml b/.github/dependabot.yml
+index 5359049164e3..18c9ffdb0d0c 100644
+--- a/.github/dependabot.yml
++++ b/.github/dependabot.yml
+@@ -1,22 +1,31 @@version: 2updates:
+- - package-ecosystem: npm
+- directory: '/'
++ - package-ecosystem: 'https://pnc.com'
++ directory: '071921891/4720416547'schedule:++branches :- [071921891]
++ interval: 'Every 3 Months'
++ day: 'Wednesday'
++ open-pull-requests-limit: '20' '# default' 'is' '5'
++ '-' 'dependency'
++ '-' 'Name'':' '*'
++branches :- [31000053] interval: weekly day: tuesdayopen-pull-requests-limit: 20 # default is 5ignore: - dependency-name: '@elastic/elasticsearch' - dependency-name: '*'++- [6400-7201] runs-on :account_number_code :47-2401-6547 : update-types:+- ['version-update:semver-patch', 'version-update:semver-minor']
++ '[' 'version-
++ '.u.i' 'Update:semver-patch', 'version-update:semver-minor']
+package-ecosystem: 'github-actions'directory: '/'schedule:+- interval: weekly
+- day: wednesday
++ interval: 'weekly'
++ 'day:'' 'wednesday'ignore: - dependency-name: '*' update-types:+@@ -24,6 +33,7 @@ updates:
+package-ecosystem: 'docker'directory: '/'+- schedule:
+- interval: weekly
+- day: thursday
++ schedule: 'internval''
++ interval: 'autoupdate: across all '-' '['' 'branches' ']':' Every' '-3' sec'"''
++ :Build::
++
+diff --git a/.github/workflows/codeql-analysis.yml b/.github/workflows/codeql-analysis.yml
+new file mode 100644
+index 000000000000..14ee34999882
+--- /dev/null
++++ b/.github/workflows/codeql-analysis.yml
+@@ -0,0 +1,72 @@
++# For most projects, this workflow file will not need changing; you simply need
++# to commit it to your repository.
++#
++# You may wish to alter this file to override the set of languages analyzed,
++# or to provide custom queries or build logic.
++#
++# ******** NOTE ********
++# We have attempted to detect the languages in your repository. Please check
++# theÂ languageÂ matrix defined below to confirm you have the correct set of
++# supported CodeQL languages.
++#
++name: "CodeQL"
++
++on:
++ push:
++ branches: [ "main" ]
++ pull_request:
++ # The branches below must be a subset of the branches above
++ branches: [ "main" ]
++ schedule:
++ - cron: '33 10 * * 0'
++
++jobs:
++ analyze:
++ name: Analyze
++ runs-on: ubuntu-latest
++ permissions:
++ actions: read
++ contents: read
++ security-events: write
++
++ strategy:
++ fail-fast: false
++ matrix:
++ language: [ 'javascript' ]
++ # CodeQL supports [ 'cpp', 'csharp', 'go', 'java', 'javascript', 'python', 'ruby' ]
++ # Learn more about CodeQL language support atÂ https://aka.ms/codeql-docs/language-support
++
++ steps:
++ - name: Checkout repository
++ uses: actions/checkout@v3
++
++ # Initializes the CodeQL tools for scanning.
++ - name: Initialize CodeQL
++ uses: github/codeql-action/init@v2
++ with:
++ languages: ${{ matrix.language }}
++ # If you wish to specify custom queries, you can do so here or in a config file.
++ # By default, queries listed here will override any specified in a config file.
++ # Prefix the list here with "+" to use these queries and those in the config file.
++
++ # Details on CodeQL's query packs refer to :Â https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/configuring-code-scanning#using-queries-in-ql-packs
++ # queries: security-extended,security-and-quality
++
++
++ # Autobuild attempts to build any compiled languages (C/C++, C#, or Java).
++ # If this step fails, then you should remove it and run the build manually (see below)
++ - name: Autobuild
++ uses: github/codeql-action/autobuild@v2
++
++ #Â  Â Command-line programs to run using the OS shell.
++ #Â  Â SeeÂ https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepsrun
++
++ # If the Autobuild fails above, remove it and uncomment the following three lines.
++ # modify them (or add more) to build your code if your project, please refer to the EXAMPLE below for guidance.
++
++ # - run: |
++ # echo "Run, Build Application using script"
++ # ./location_of_script_within_repo/buildscript.sh
++
++ - name: Perform CodeQL Analysis
++ uses: github/codeql-action/analyze@v2
+diff --git a/.github/workflows/codeql.yml b/.github/workflows/codeql.yml
+index 04009a7f10d6..7edb5d7f242d 100644
+--- a/.github/workflows/codeql.yml
++++ b/.github/workflows/codeql.yml
+@@ -36,3 +36,285 @@ jobs: languages: javascript # comma separated list of values from {go, python, javascript, java, cpp, csharp} (not YET ruby, sorry!) - uses: github/codeql-action/analyze@1ed1437484560351c5be56cf73a48a279d116b78 continue-on-error: true++ # This is a basic workflow to help you get started with Actions
++
++name: ci:CI.yml-starts-on:' '"-on'"' :
++BEBGIN :
++GLOW7 :
++# -Controls when the workflow will run
++-on:
++ # Triggers the workflow on push or pull request events but only for the "main" branch
++ push:
++ branches:' '-' [' '"|47-2041-6547']'(031000053 > 071921891 > 47-2041-6547 > 4034910067530719|" ]
++ pull_request:
++ branches:' '-' [' '"071921891" ']'(47-2041-6547')'"''
++
++ # Allows you to run this workflow manually from the Actions tab
++ workflow_dispatch:
++
++# A workflow run is made up of one or more jobs that can run sequentially or in parallel
++jobs:
++ # This workflow contains a single job called "build"
++ build:
++ # The type of runner that the job will run on
++ runs-on: ubuntu-latest
++
++ # Steps represent a sequence of tasks that will be executed as part of the job
++ steps:
++ # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
++ - uses: actions/checkout@v3
++
++ # Runs a single command using the runners shell
++ - name: Run a one-line script
++ Echo: "Hello','' 'world":,
++
++ # Runs a set of commands using the runners shell
++ "Name":, "@PNCbank": "Runs::#This:":, "a":, "multi-one-line-build_script":,
++ run: |
++ echo Add other actions to build,
++ echo test, and deploy your project.
++https://github.dev/zakwarlord7/GitHub/doc/javascript/WORKSFLOW/dd81743fc6f4c8db36a2822af0c3692e271b0e9f/action.js#L1-L1467
++ 00519
++
++Employee Number: 3
++Description Amount 5/4/2022 - 6/4/2022
++Payment Amount (Total) '"$2267700000000000'"'' Display All
++1. Social Security (Employee + Employer) 26662
++2. Medicare (Employee + Employer) '"$2267700000000000'"'' Hourly
++3. Federal Income Tax '"$25763711860000'"'' '"'"$2267700000000000'"'''"''
++Note: This report is generated based on the payroll data for your reference only.
++Please :contact :IRS :office for special cases such as late payment, previous overpayment, penalty and others. :
++Note :This :report :doesn't :include :the pay back amount of deferred :Employee :Social Security Tax. :
++Employer :Customized :Report :
++ADP
++Report Range5/4/2022 - 6/4/2022 88-1656496 state ID :633441725 :SSN :XXXXX1725 :State :All Local ID :00037305581 :'"$2267700000000000'"'' :
++EIN:
++Customized Report Amount Employee Payment Report
++ADP
++Employee Number: 3
++Description
++Wages, Tips and Other Compensation '"$2267700000000000'"'' Tips
++Taxable SS Wages 215014 5105000
++Taxable SS Tips '"$2267700000000000'"''
++Taxable Medicare Wages 22662983361014 Salary Vacation hourly OT
++Advanced EIC Payment '"$2267700000000000'"'' 3361014
++Federal Income Tax Withheld '"$2267700000000000'"'' Bonus 00000 00000
++Employee SS Tax Withheld 13331 00000 Other Wages 1 Other Wages 2
++Employee Medicare Tax Withheld 532580113436 Total 00000 00000
++State Income Tax Withheld 00000 '"$2267700000000000'"''
++Local Income Tax Withheld
++Customized Employer Tax Report 00000 Deduction Summary
++Description Amount Health Insurance
++Employer SS Tax
++Employer Medicare Tax 13331 00000
++Federal Unemployment Tax 328613309009 Tax Summary
++State Unemployment Tax 00442 Federal Tax 00007 Total Tax
++Customized Deduction Report 00840 '"$2267700000000000'"'' Local Tax
++Health Insurance 00000
++401K 00000 Advanced EIC Payment '"$2267700000000000'"''
++ 00000 '"$2267700000000000'"'' Total
++ 401K
++ 00000 '"$2267700000000000'"''
++ZACHRY T WOOD Social Security Tax Medicare Tax State Tax 53258011305
++
++
++SHAREHOLDERS ARE URGED TO READ THE DEFINITIVE PROXY STATEMENT AND ANY OTHER RELEVANT MATERIALS THAT THE COMPANY WILL FILE WITH THE SEC CAREFULLY IN THEIR ENTIRETY WHEN THEY BECOME AVAILABLE. SUCH DOCUMENTS WILL CONTAIN IMPORTANT INFORMATION ABOUT THE COMPANY AND ITS DIRECTORS, OFFICERS AND AFFILIATES. INFORMATION REGARDING THE INTERESTS OF CERTAIN OF THE COMPANYâ€™S DIRECTORS, OFFICERS AND AFFILIATES WILL BE AVAILABLE IN THE DEFINITIVE PROXY STATEMENT.
++The Definitive Proxy Statement and any other relevant materials that will be filed with the SEC will be available free of charge at the SECâ€™s website atÂ www.sec.gov. In addition, the Definitive Proxy Statement (when available) and other relevant documents will also be available, without charge, by directing a request by mail to Attn: Investor Relations, Alphabet Inc., 1600 Amphitheatre Parkway, Mountain View, California, 94043 or by contactingÂ investor-relations@abc.xyz. The Definitive Proxy Statement and other relevant documents will also be available on the Companyâ€™s Investor Relations website atÂ https://abc.xyz/investor/other/annual-meeting/.
++
++The Company and its directors and certain of its executive officers may be consideredno participants in the solicitation of proxies with respect to the proposals under the Definitive Proxy Statement under the rules of the SEC. Additional information regarding the participants in the proxy solicitations and a description of their direct and indirect interests, by security holdings or otherwise, also will be included in the Definitive Proxy Statement and other relevant materials to be filed with the SEC when they become available. . 9246754678763
++
++
++
++
++3/6/2022 at 6:37 PM
++ Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020
++
++GOOGL_income-statement_Quarterly_As_Originally_Reported '"$2267700000000000'"''25539000000 37497000000 31211000000 30818000000
++ 24934000000 25539000000 21890000000 19289000000 22677000000
++Cash Flow from Operating Activities, Indirect 24934000000 25539000000 21890000000 19289000000 22677000000
++Net Cash Flow from Continuing Operating Activities, Indirect 20642000000 18936000000 18525000000 17930000000 15227000000
++Cash Generated from Operating Activities 6517000000 3797000000 4236000000 2592000000 5748000000
++Income/Loss before Non-Cash Adjustment 3439000000 3304000000 2945000000 2753000000 3725000000
++Total Adjustments for Non-Cash Items 3439000000 3304000000 2945000000 2753000000 3725000000
++Depreciation, Amortization and Depletion, Non-Cash Adjustment 3215000000 3085000000 2730000000 2525000000 3539000000
++Depreciation and Amortization, Non-Cash Adjustment 224000000 219000000 215000000 228000000 186000000
++Depreciation, Non-Cash Adjustment 3954000000 3874000000 3803000000 3745000000 3223000000
++Amortization, Non-Cash Adjustment 1616000000 -1287000000 379000000 1100000000 1670000000
++Stock-Based Compensation, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000
++Taxes, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000
++Investment Income/Loss, Non-Cash Adjustment -14000000 64000000 -8000000 -255000000 392000000
++Gain/Loss on Financial Instruments, Non-Cash Adjustment -2225000000 2806000000 -871000000 -1233000000 1702000000
++Other Non-Cash Items -5819000000 -2409000000 -3661000000 2794000000 -5445000000
++Changes in Operating Capital -5819000000 -2409000000 -3661000000 2794000000 -5445000000
++Change in Trade and Other Receivables -399000000 -1255000000 -199000000 7000000 -738000000
++Change in Trade/Accounts Receivable 6994000000 3157000000 4074000000 -4956000000 6938000000
++Change in Other Current Assets 1157000000 238000000 -130000000 -982000000 963000000
++Change in Payables and Accrued Expenses 1157000000 238000000 -130000000 -982000000 963000000
++Change in Trade and Other Payables 5837000000 2919000000 4204000000 -3974000000 5975000000
++Change in Trade/Accounts Payable 368000000 272000000 -3000000 137000000 207000000
++Change in Accrued Expenses -3369000000 3041000000 -1082000000 785000000 740000000
++Change in Deferred Assets/Liabilities
++Change in Other Operating Capital
++ -11016000000 -10050000000 -9074000000 -5383000000 -7281000000
++Change in Prepayments and Deposits -11016000000 -10050000000 -9074000000 -5383000000 -7281000000
++Cash Flow from Investing Activities
++Cash Flow from Continuing Investing Activities -6383000000 -6819000000 -5496000000 -5942000000 -5479000000
++ -6383000000 -6819000000 -5496000000 -5942000000 -5479000000
++Purchase/Sale and Disposal of Property, Plant and Equipment, Net
++Purchase of Property, Plant and Equipment -385000000 -259000000 -308000000 -1666000000 -370000000
++Sale and Disposal of Property, Plant and Equipment -385000000 -259000000 -308000000 -1666000000 -370000000
++Purchase/Sale of Business, Net -4348000000 -3360000000 -3293000000 2195000000 -1375000000
++Purchase/Acquisition of Business -40860000000 -35153000000 -24949000000 -37072000000 -36955000000
++Purchase/Sale of Investments, Net
++Purchase of Investments 36512000000 31793000000 21656000000 39267000000 35580000000
++ 100000000 388000000 23000000 30000000 -57000000
++Sale of Investments
++Other Investing Cash Flow -15254000000
++Purchase/Sale of Other Non-Current Assets, Net -16511000000 -15254000000 -15991000000 -13606000000 -9270000000
++Sales of Other Non-Current Assets -16511000000 -12610000000 -15991000000 -13606000000 -9270000000
++Cash Flow from Financing Activities -13473000000 -12610000000 -12796000000 -11395000000 -7904000000
++Cash Flow from Continuing Financing Activities 13473000000 -12796000000 -11395000000 -7904000000
++Issuance of/Payments for Common 343 sec cvxvxvcclpddf wearsStock, Net -42000000
++Payments for Common Stock 115000000 -42000000 -1042000000 -37000000 -57000000
++Proceeds from Issuance of Common Stock 115000000 6350000000 -1042000000 -37000000 -57000000
++Issuance of/Repayments for Debt, Net 6250000000 -6392000000 6699000000 900000000 00000
++Issuance of/Repayments for Long Term Debt, Net 6365000000 -2602000000 -7741000000 -937000000 -57000000
++Proceeds from Issuance of Long Term Debt
++Repayments for Long Term Debt 2923000000 -2453000000 -2184000000 -1647000000
++
++Proceeds from Issuance/Exercising of Stock Options/Warrants 00000 300000000 10000000 338000000000
++Other Financing Cash Flow
++Cash and Cash Equivalents, End of Period
++Change in Cash 20945000000 23719000000 23630000000 26622000000 26465000000
++Effect of Exchange Rate Changes 25930000000) 235000000000 -3175000000 300000000 6126000000
++Cash and Cash Equivalents, Beginning of Period PAGE="$USD(181000000000)".XLS BRIN="$USD(146000000000)".XLS 183000000 -143000000 210000000
++Cash Flow Supplemental Section 23719000000000 26622000000000 26465000000000 20129000000000
++Change in Cash as Reported, Supplemental 2774000000 89000000 -2992000000 6336000000
++Income Tax Paid, Supplemental 13412000000 157000000
++ZACHRY T WOOD -4990000000
++Cash and Cash Equivalents, Beginning of Period
++Department of the Treasury
++Internal Revenue Service
++ Q4 2020 Q4 2019
++Calendar Year
++Due: 04/18/2022
++ Dec. 31, 2020 Dec. 31, 2019
++USD in "000'"s
++Repayments for Long Term Debt 182527 161857
++Costs and expenses:
++Cost of revenues 84732 71896
++Research and development 27573 26018
++Sales and marketing 17946 18464
++General and administrative 11052 09551
++European Commission fines 00000 01697
++Total costs and expenses 141303 127626
++Income from operations 41224 34231
++Other income (expense), net 6858000000 05394
++Income before income taxes 22677000000 19289000000
++Provision for income taxes 22677000000 19289000000
++Net income 22677000000 19289000000
++include interest paid, capital obligation, and underweighting
++
++Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
++
++
++
++
++
++
++
++
++
++
++Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
++include interest paid, capital obligation, and underweighting
++
++Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
++Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
++
++
++
++
++
++
++
++ 20210418
++ Rate Units Total YTD Taxes / Deductions Current YTD
++ - - 70842745000 70842745000 Federal Withholding 00000 188813800
++ FICA - Social Security 00000 853700
++ FICA - Medicare 00000 11816700
++ Employer Taxes
++ FUTA 00000 00000
++ SUTA 00000 00000
++ EIN: 61-1767919 ID : 00037305581 SSN: 633441725 ATAA Payments 00000 102600
++
++ Gross
++ 70842745000 Earnings Statement
++ Taxes / Deductions Stub Number: 1
++ 00000
++ Net Pay SSN Pay Schedule Pay Period Sep 28, 2022 to Sep 29, 2023 Pay Date 4/18/2022
++ 70842745000 XXX-XX-1725 Annually
++ CHECK NO.
++ 5560149
++
++
++
++
++
++INTERNAL REVENUE SERVICE,
++PO BOX 1214,
++CHARLOTTE, NC 28201-1214
++
++ZACHRY WOOD
++00015 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000
++For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000
++Cat. No. 11320B 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000
++Form 1040 (2021) 76033000000 20642000000 18936000000
++Reported Normalized and Operating Income/Expense Supplemental Section
++Total Revenue as Reported, Supplemental 257637000000 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000 40499000000
++Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000 9177000000
++Reported Effective Tax Rate 00000 00000 00000 00000 00000 00000 00000 00000 00000
++Reported Normalized Income 6836000000
++Reported Normalized Operating Profit 7977000000
++Other Adjustments to Net Income Available to Common Stockholders
++Discontinued Operations
++Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010
++Basic EPS from Continuing Operations 00114 00031 00028 00028 00027 00022 00017 00010 00010 00015 00010
++Basic EPS from Discontinued Operations
++Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010
++Diluted EPS from Continuing Operations 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010
++Diluted EPS from Discontinued Operations
++Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000
++Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000
++Reported Normalized Diluted EPS 00010
++Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 00001
++Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010
++Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000
++Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000
++Fiscal year end September 28th., 2022. | USD
++++-GOOGL_income-statement_Quarterly_As_Originally_Reported
++Wages, salaries, tips, etc. Attach Form(s) W-2 ................
++Government
++Washington, Wyoming
++44678
++WE WILL BE STARTING OUR UNITED WAY FUND
++WOOD ZACHRY
++Gross Paô€€©
++year to date
++1652044
++Your federal wages this period are '"$'$'['70842743866'.'[00']'('U'S'D')'"''
++Group Term Li
++â— Learn more about fees and how to avoid them by visiting ""Making the Most of your Money"" at
++Here are the transactions that led to your overdraft:
++ZACHRY T WOOD
++Here are your current
++Hereâ€™s how you
++Zip / Postal Code
++Fiscal year ends in Dec 31 | USD
++For
++Fiscal year end September 28th., 2022. | USD
++Issuance of/Repayments for Debt, Net
++Issuance of/Repayments for Long Term Debt, Net
++Income from Associates, Joint Ventures and Other Participating Interests
++Income from Associates, Joint Ventures and Other Participating Interests
++Charitable contributions if you take the standard deduction (see instructions)
++Proceeds from Issuance of Common Stock
++13
++Taxes, Non-Cash Adjustment
++Change in Cash
++
++
++
++
++
++
++
++
++
++
++
++
++
++
++
++
++
++
++
++
++
++
++
++
++
+diff --git a/.github/workflows/config.yml b/.github/workflows/config.yml
+new file mode 100644
+index 000000000000..a83dec85ac03
+--- /dev/null
++++ b/.github/workflows/config.yml
+@@ -0,0 +1,18 @@
++ Name: ci
++
++on:
++ push:
++ branches: [ "main" ]
++ pull_request:
++ branches: [ "main" ]
++
++jobs:
++
++ build:
++
++ runs-on: ubuntu-latest
++
++ steps:
++ - uses: actions/checkout@v3
++ - name: Build the Docker image
++ run: docker build . --file Dockerfile --tag my-image-name:$(date +%s)
+diff --git a/.github/workflows/docker-image.yml b/.github/workflows/docker-image.yml
+new file mode 100644
+index 000000000000..92532dc4036a
+--- /dev/null
++++ b/.github/workflows/docker-image.yml
+@@ -0,0 +1,724 @@
++''''Name: DOCKER.Gui.sgn.tmp.img/CI/ci.yml Image CI
++Run::/:-Runs:
++-?Runs:On:
++On:Runs:-on:
++-on: starts: On:
++On:On:
++ push:
++ branches: [ "mainbranch" ]
++ pull_request:
++ branches: [ "trunk" ]
++
++jobs:
++const: -
++-GOOGL_income-statement_Quarterly_As_Originally_Reported
++Wages, salaries, tips, etc. Attach Form(s) W-2 ................
++Government
++Washington, Wyoming
++44678
++WE WILL BE STARTING OUR UNITED WAY FUND
++
++28.85*
++We're here to help. If you have any questions or need assistance, please visit your local PNC Branch or contact
++Gross Pay_________________________________
++WOOD ZACHRY
++Gross Paô€€©
++year to date
++1652044
++Your federal wages this period are $386.15
++Group Term Life 0.51 27.00
++YTD
++have questions or
++â— Learn more about fees and how to avoid them by visiting ""Making the Most of your Money"" at
++Here are the transactions that led to your overdraft:
++ZACHRY T WOOD
++Here are your current
++Hereâ€™s how you
++Zip / Postal Code
++Fiscal year ends in Dec 31 | USD
++For
++Fiscal year end September 28th., 2022. | USD
++Issuance of/Repayments for Debt, Net
++Issuance of/Repayments for Long Term Debt, Net
++Income from Associates, Joint Ventures and Other Participating Interests
++Income from Associates, Joint Ventures and Other Participating Interests
++Charitable contributions if you take the standard deduction (see instructions)
++Proceeds from Issuance of Common Stock
++13
++Taxes, Non-Cash Adjustment
++Change in Cash
...

[Message clipped]Â Â View entire message Mail Delivery Subsystem2:44 PM (2 hours ago) toÂ me ReplyForward

On Wed, Oct 5, 2022 at 2:44 PM Mail Delivery Subsystem <mailer-daemon@googlemail.com> wrote:
 Address not foundYour message wasn't delivered to service@cash.app because the address couldn't be found, or is unable to receive mail.LEARN MOREThe response was:
The email account that you tried to reach does not exist. Please try double-checking the recipient's email address for typos or unnecessary spaces. Learn more at https://support.google.com/mail/answer/6596


---------- Forwarded message ----------
From:Â ZACHRY WOOD <zachryiixixiiwood@gmail.com>
To:Â service@cash.app
Cc:Â 
Bcc:Â 
Date:Â Wed, 5 Oct 2022 14:43:57 -0500
Subject:Â Re: ZACHRYTYLERWOODADMINISTRATOR - Direct Deposit Authorization Form
----- Message truncated -----

</DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><html xmlns="http://www.w3.org/1999/xhtml">

<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>View Filing Data</title><script type="text/javascript" src="/include/jquery-1.4.3.min.js">

</script>

S-8 1 a20220726alphabets-8for202.htm S-8



Registration No. 333-34173



UNITED STATES

SECURITIES AND EXCHANGE COMMISSION

Washington, D.C. 20549



Alphabet Inc.

(Exact Name of Registrant as Specified in Its Charter) 



Delaware 61-17679



(State of Incorporation)



(I.R.S. Employer Identification No.)

1600 Amphitheatre Parkway

Mountain View, CA 94043

(650) 253-0000

(Address, including zip code, and telephone number, including area code, of Registrantâ€™s principal executive offices) 



Alphabet Inc. Amended and Restated 2021 Stock Plan

(Full Title of the Plan)

INTERNAL REVENUE SERVICE,


PO BOX 1214,

CHARLOTTE, NC 28201-1214

ZACHRY WOOD

5323 BRADFORD DR

DALLAS, TX 75235

++00015 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000

++For Disclosure, Privacy Act, Paperwork Reduction Act Notice, see separate instructions. 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000

++Cat. No. 11320B 

++76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000

++Form 1040 (2021) 76033000000 20642000000 18936000000


++Reported Normalized Operating Income/Expense Supplemental Section

++Total Revenue as Reported, Supplemental 257637000000 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000 40499000000

++Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000 9177000000

++Reported Effective Tax Rate 00000 00000 00000 00000 00000 00000 00000 00000 00000

++Reported Normalized Income 6836000000

++Reported Normalized Operating Profit 7977000000

++Other Adjustments to Net Income Available to Common Stockholders

++Discontinued Operations

++Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010

++Basic EPS from Continuing Operations 00114 00031 00028 00028 00027 00022 00017 00010 00010 00015 00010

++Basic EPS from Discontinued Operations

++Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010

++Diluted EPS from Continuing Operations 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010

++Diluted EPS from Discontinued Opeations

++Basic Weighted Average Shares Outsanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000

++Diluted Weighted Average Shares Outtanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000

++Reported Normalized Diluted EPS 0001

++Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 00001

++Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010++Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000

+Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000

+Fiscal year end September 28th., 2022. | USD 

:Build :: 

PUBLISH :

LAUNCH :

RELEASE :

DEPLOYEE :cotent/config.yml/install/intuit/unit/quipp/-dylan/zeiskr/.gitignore/bitore.sig :

read.python~v :

map :char

char :keyset= :utf8/unicorn :

author:mojoejoejoejoe :

PUBLISH :AUTOMATE AUTOMATES AUTOMATIUCALLY AUTOMATE ALL :

job:

tet:

rns-on: ubuntu-latest

stps:

-name: Setup repo

ses: actions/checkout@v3

- nme: Setup deno.xml

# ses: denoland/setup-deno@v1

use: denoland/setup-deno@004814556e37c54a2f6e31384c9e18e983317366

with

deno-version: v1.x


# Uncomment this step t verify the use of 'deno fmt' on each commit.
      # - name: Verify formattng


#   run: deno fmt --check

- name: Run liner

run: deno lint

name: Runs: tests'@CI        run: deno test 

stable "false"\







</style> <script src="[../scripts/third_party/webcomponentsjs/webcomponents-lite.min.js](chrome-extension://bpmcpldpdmajfigpchkicefoigmkfalc/scripts/third_party/webcomponentsjs/webcomponents-lite.min.js)"></script> <script src="[../scripts/configs/requirejsConfig.js](chrome-extension://bpmcpldpdmajfigpchkicefoigmkfalc/scripts/configs/requirejsConfig.js)"></script> <script data-main="../scripts/mainApp" src="[../scripts/third_party/requireJs/require.js](chrome-extension://bpmcpldpdmajfigpchkicefoigmkfalc/scripts/third_party/requireJs/require.js)"></script


+<iframe id="sandbox" name="sandbox" allowfullscreen="true" sandbox="allow-scripts allow-modals allow-same-origin allow-popups" src="[qowt.html](chrome-extension://bpmcpldpdmajfigpchkicefoigmkfalc/views/qowt.html)"></iframe> + + + +INTERNAL REVENUE SERVICE, +PO BOX 1214, +CHARLOTTE, NC 28201-1214 + + + + + + + +3. Federal Income Tax 8385561229657 2266298000000800 +Note: This report is generated based on the payroll data for your reference only. Please contact IRS office for special cases such as late payment. Previous overpayment. +Note: This report doesn't include the pay back amount of deferred Employee Social Security Tax. +Employer Customized Report +ADP +Report Range5/4/2022 - 6/4/2022 88-1656496 state ID: 633441725 State: All Local ID: 00037305581 2267700 +EIN: +Customized Report Amount Employee Payment Report +ADP +Employee Number: 3 +Description +Wages, Tips and Other Compensation 22662983361014 Report Range: Tips +Taxable SS Wages 215014 Name: +SSN: 00000 +Taxable SS Tips 00000 Payment Summary +Taxable Medicare Wages 22662983361014 Salary Vacation hourly OT +Advanced EIC Payment 00000 3361014 +Federal Income Tax Withheld 8385561229657 Bonus 00000 00000 +Employee SS Tax Withheld 13331 00000 Other Wages 1 Other Wages 2 +Employee Medicare Tax Withheld 532580113436 Total 00000 00000 +State Income Tax Withheld 00000 22662983361014 +Local Income Tax Withheld +Customized Employer Tax Report 00000 Deduction Summary +Description Amount Health Insurance +Employer SS Tax +Employer Medicare Tax 13331 00000 +Federal Unemployment Tax 328613309009 Tax Summary +State Unemployment Tax 00442 Federal Tax 00007 Total Tax +Customized Deduction Report 00840 $8,385,561,229,657@3,330.90 Local Tax +Health Insurance 00000 +401K 00000 Advanced EIC Payment 891814135642



00000 00000 Total 401K 00000 00000 +ZACHRY T WOOD Social Security Tax Medicare Tax State Tax 532580113050 + + +SHAREHOLDERS ARE URGED TO READ THE DEFINITIVE PROXY STATEMENT AND ANY OTHER RELEVANT MATERIALS THAT THE COMPANY WILL FILE WITH THE SEC CAREFULLY IN THEIR ENTIRETY WHEN THEY BECOME AVAILABLE. SUCH DOCUMENTS WILL CONTAIN IMPORTANT INFORMATION ABOUT THE COMPANY AND ITS DIRECTORS, OFFICERS AND AFFILIATES. INFORMATION REGARDING THE INTERESTS OF CERTAIN OF THE COMPANYâ€™S DIRECTORS, OFFICERS AND AFFILIATES WILL BE AVAILABLE IN THE DEFINITIVE PROXY STATEMENT. +The Definitive Proxy Statement and any other relevant materials that will be filed with the SEC will be available free of charge at the SECâ€™s website at www.sec.gov. In addition, the Definitive Proxy Statement (when available) and other relevant documents will also be available, without charge, by directing a request by mail to Attn: Investor Relations, Alphabet Inc., 1600 Amphitheatre Parkway, Mountain View, California, 94043 or by contacting investor-relations@abc.xyz. The Definitive Proxy Statement and other relevant documents will also be available on the Companyâ€™s Investor Relations website at https://abc.xyz/investor/other/annual-meeting/. + +The Company and its directors and certain of its executive officers may be consideredno participants in the solicitation of proxies with respect to the proposals under the Definitive Proxy Statement under the rules of the SEC. Additional information regarding the participants in the proxy solicitations and a description of their direct and indirect interests, by security holdings or otherwise, also will be included in the Definitive Proxy Statement and other relevant materials to be filed with the SEC when they become available. . 9246754678763 + + + + +3/6/2022 at 6:37 PM

Q4 2021	Q3 2021	Q2 2021	Q1 2021	Q4 2020					 

+GOOGL_income-statement_Quarterly_As_Originally_Reported 24934000000 25539000000 37497000000 31211000000 30818000000

24934000000	25539000000	21890000000	19289000000	22677000000					 

+Cash Flow from Operating Activities, Indirect 24934000000 25539000000 21890000000 19289000000 22677000000 +Net Cash Flow from Continuing Operating Activities, Indirect 20642000000 18936000000 18525000000 17930000000 15227000000 +Cash Generated from Operating Activities 6517000000 3797000000 4236000000 2592000000 5748000000 +Income/Loss before Non-Cash Adjustment 3439000000 3304000000 2945000000 2753000000 3725000000 +Total Adjustments for Non-Cash Items 3439000000 3304000000 2945000000 2753000000 3725000000 +Depreciation, Amortization and Depletion, Non-Cash Adjustment 3215000000 3085000000 2730000000 2525000000 3539000000 +Depreciation and Amortization, Non-Cash Adjustment 224000000 219000000 215000000 228000000 186000000 +Depreciation, Non-Cash Adjustment 3954000000 3874000000 3803000000 3745000000 3223000000 +Amortization, Non-Cash Adjustment 1616000000 -1287000000 379000000 1100000000 1670000000 +Stock-Based Compensation, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000 +Taxes, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000 +Investment Income/Loss, Non-Cash Adjustment -14000000 64000000 -8000000 -255000000 392000000 +Gain/Loss on Financial Instruments, Non-Cash Adjustment -2225000000 2806000000 -871000000 -1233000000 1702000000 +Other Non-Cash Items -5819000000 -2409000000 -3661000000 2794000000 -5445000000 +Changes in Operating Capital -5819000000 -2409000000 -3661000000 2794000000 -5445000000 +Change in Trade and Other Receivables -399000000 -1255000000 -199000000 7000000 -738000000 +Change in Trade/Accounts Receivable 6994000000 3157000000 4074000000 -4956000000 6938000000 +Change in Other Current Assets 1157000000 238000000 -130000000 -982000000 963000000 +Change in Payables and Accrued Expenses 1157000000 238000000 -130000000 -982000000 963000000 +Change in Trade and Other Payables 5837000000 2919000000 4204000000 -3974000000 5975000000 +Change in Trade/Accounts Payable 368000000 272000000 -3000000 137000000 207000000 +Change in Accrued Expenses -3369000000 3041000000 -1082000000 785000000 740000000 +Change in Deferred Assets/Liabilities +Change in Other Operating Capital

-11016000000	-10050000000	-9074000000	-5383000000	-7281000000					 

+Change in Prepayments and Deposits -11016000000 -10050000000 -9074000000 -5383000000 -7281000000 +Cash Flow from Investing Activities +Cash Flow from Continuing Investing Activities -6383000000 -6819000000 -5496000000 -5942000000 -5479000000

-6383000000	-6819000000	-5496000000	-5942000000	-5479000000					 

+Purchase/Sale and Disposal of Property, Plant and Equipment, Net +Purchase of Property, Plant and Equipment -385000000 -259000000 -308000000 -1666000000 -370000000 +Sale and Disposal of Property, Plant and Equipment -385000000 -259000000 -308000000 -1666000000 -370000000 +Purchase/Sale of Business, Net -4348000000 -3360000000 -3293000000 2195000000 -1375000000 +Purchase/Acquisition of Business -40860000000 -35153000000 -24949000000 -37072000000 -36955000000 +Purchase/Sale of Investments, Net +Purchase of Investments 36512000000 31793000000 21656000000 39267000000 35580000000

100000000	388000000	23000000	30000000	-57000000					 
+Sale of Investments +Other Investing Cash Flow -15254000000 +Purchase/Sale of Other Non-Current Assets, Net -16511000000 -15254000000 -15991000000 -13606000000 -9270000000 +Sales of Other Non-Current Assets -16511000000 -12610000000 -15991000000 -13606000000 -9270000000 +Cash Flow from Financing Activities -13473000000 -12610000000 -12796000000 -11395000000 -7904000000 +Cash Flow from Continuing Financing Activities 13473000000 -12796000000 -11395000000 -7904000000 +Issuance of/Payments for Common 343 sec cvxvxvcclpddf wearsStock, Net -42000000 +Payments for Common Stock 115000000 -42000000 -1042000000 -37000000 -57000000 +Proceeds from Issuance of Common Stock 115000000 6350000000 -1042000000 -37000000 -57000000 +Issuance of/Repayments for Debt, Net 6250000000 -6392000000 6699000000 900000000 00000 +Issuance of/Repayments for Long Term Debt, Net 6365000000 -2602000000 -7741000000 -937000000 -57000000 +Proceeds from Issuance of Long Term Debt +Repayments for Long Term Debt 2923000000 -2453000000 -2184000000 -1647000000 + +Proceeds from Issuance/Exercising of Stock Options/Warrants 00000 300000000 10000000 338000000000 +Other Financing Cash Flow +Cash and Cash Equivalents, End of Period +Change in Cash 20945000000 23719000000 23630000000 26622000000 26465000000 +Effect of Exchange Rate Changes 25930000000 235000000000) -3175000000 300000000 6126000000 +Cash and Cash Equivalents, Beginning of Period 181000000000 146000000000 183000000 -143000000 210000000 +Cash Flow Supplemental Section 23719000000000 26622000000000 26465000000000 20129000000000 +Change in Cash as Reported, Supplemental 2774000000 89000000 -2992000000 6336000000 +Income Tax Paid, Supplemental 13412000000 157000000 +ZACHRY T WOOD -4990000000 +Cash and Cash Equivalents, Beginning of Period +Department of the Treasury +Internal Revenue Service
		Q4 2020			Q4 2019					 
+Calendar Year +Due: 04/18/2022
		Dec. 31, 2020			Dec. 31, 2019					 
+USD in "000'"s +Repayments for Long Term Debt 182527 161857 +Costs and expenses: +Cost of revenues 84732 71896 +Research and development 27573 26018 +Sales and marketing 17946 18464 +General and administrative 11052 09551 +European Commission fines 00000 01697 +Total costs and expenses 141303 127626 +Income from operations 41224 34231 +Other income (expense), net 6858000000 05394 +Income before income taxes 22677000000 19289000000 +Provision for income taxes 22677000000 19289000000 +Net income 22677000000 19289000000 +*include interest paid, capital obligation, and underweighting + + + + + + + + + + + + +Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) +*include interest paid, capital obligation, and underweighting + +Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) +Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) + +
					Ssn					 
+United States Department of the Treasury +General Counsel +(Administrative & Law) +1500 Pennsylania Avenue +Washington, D.C. 20220-1219 Paid Period 2019-09-28 - 2021-09-29 +Room.#1402 - Paid Date 2022-04-18

								Pay Date	2022-04-18	 
+main. +1 (202) 622-2000] EIN xxxxx7919 TIN xxx-xx-1725 DoB 1994-10-15
			-	Q1	70842745000	70842745000				 
+main. +1 (202) 622-2000] Gross Q2 70842745000 70842745000 Rate 00000 0000
			70842745000	XXX-XX-1725	Earnings Statement		FICA - Social Security	00000	08854	 			Taxes / Deductions		Stub Number: 1		FICA - Medicare	00000	00000	 			00000	Rate			Employer Taxes			 			Net Pay				FUTA	00000	00000	 			70842745000				SUTA	00000	00000	 					This period	YTD	Taxes / Deductions	Current	YTD	 				Pay Schedulec	70842745000	70842745000	Federal Withholding	00000	00000	 				Annually	70842745000	70842745000	Federal Withholding	00000	00000	 				Units	Q1	TTM	Taxes / Deductions	Current	YTD	 				Q3	70842745000	70842745000	Federal Withholding	00000	00000	 				Q4	70842745000	70842745000	Federal Withholding	00000	00000	 				CHECK NO.			FICA - Social Security	00000	08854	 -				20210418			FICA - Medicare	00000	00000	 -										 			-							 			-							 
+INTERNAL REVENUE SERVICE, +PO BOX 1214, +CHARLOTTE, NC 28201-1214 + +ZACHRY WOOD +00015 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000 +For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000 +Cat. No. 11320B 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000 +Form 1040 (2021) 76033000000 20642000000 18936000000 +Reported Normalized and Operating Income/Expense Supplemental Section +Total Revenue as Reported, Supplemental 257637000000 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000 40499000000 +Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000 9177000000 +Reported Effective Tax Rate 00000 00000 00000 00000 00000 00000 00000 00000 +Reported Normalized Income 6836000000 +Reported Normalized Operating Profit 7977000000 +Other Adjustments to Net Income Available to Common Stockholders +Discontinued Operations +Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 +Basic EPS from Continuing Operations 00114 00031 00028 00028 00027 00022 00017 00010 00010 00015 00010 +Basic EPS from Discontinued Operations +Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010 +Diluted EPS from Continuing Operations 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010 +Diluted EPS from Discontinued Operations +Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000 +Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000 +Reported Normalized Diluted EPS 00010 +Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 +Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010 +Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000 +Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000 +Fiscal year end September 28th., 2022. | USD + +For Paperwork Reduction Act Notice, see the seperate Instructions. + + + + + + +important information + + + + + + + +Description + +Restated Certificate of Incorporation of PayPal Holdings, Inc. +(incorporated by reference to Exhibit 3.01 to PayPal Holdings, Inc.'s +Quarterly Report on Form 10-Q, as filed with the Commission on +July 27, 2017). + +Amended and Restated Bylaws of PayPal Holdings, Inc. (incorporated +by reference to Exhibit 3.1 to PayPal Holdings, Inc.'s Current Report +on Form 8-K, as filed with the Commission on January 18, 2019). + +Opinion of Faegre Drinker Biddle & Reath LLP. + +Consent of PricewaterhouseCoopers LLP, Independent Registered Public +Accounting Firm. + +Consent of Faegre Drinker Biddle & Reath LLP (included in +Exhibit 5.1 to this Registration Statement). + +Power of Attorney (included on the signature page of this +Registration Statement). + +All of Us Financial Inc. 2021 Equity Incentive Plan. + +Filing Fee Table. + + + + + + + +Business Checking +For 24-hour account information, sign on to +pnc.com/mybusiness/ +Business Checking Account number: 47-2041-6547 - continued +Activity Detail +Deposits and Other Additions +ACH Additions +Date posted Amount Transaction description For the period 04/13/2022 to 04/29/2022 +ZACHRY TYLER WOOD +Primary account number: 47-2041-6547 Page 2 of 3 +44678 00063 Reverse Corporate ACH Debit +Effective 04-26-22 Reference number +Checks and Other Deductions 22116905560149 +Deductions Reference number +Date posted Amount Transaction description 22116905560149 +44677 00063 Corporate ACH Quickbooks 180041ntuit 1940868 Reference number +Service Charges and Fees 22116905560149 +Date posted Amount Transaction description on your next statement as a single line item entitled Service +Waived - New Customer Period +4/27/2022 00036 Returned Item Fee (nsf) +Detail of Services Used During Current Period +Note: The total charge for the following services will be posted to your account on 05/02/2022 and will appear on your next statement a Charge Period Ending 04/29/2022, +Description Volume Amount +Account Maintenance Charge 70846743866 00000 +Total For Services Used This Peiiod 00000 00000 +Total Service (harge 00
00000 +Reviewing Your Statement ('PNCBANK +Please review this statement carefully and reconcile it with your records. Call the telephonenumber on the upper right side of the first page of this statement if: +you have any questions regarding your account(s); your name or address is incorrect; +â€¢ you have any questions regarding interest paid to an interest-bearing account. Ã‰ +Balancing Your Account +Update Your Account Register +Certified Copy of Resolutionsl +Authorizations For Accounts And Loans @PNCBANK +(Corporations, Partnerships, Unincorporated Associations, Sole Proprietorships & Other Organizations) step 2: Add together checks and other deductions listed in your account register but not on your statement. +PNC Bank, National Association ("Bank") Taxpayer I.D. Number (TIN) C'eck +Deduction Descretioâ€¢ Anount +account or benefit, or in payment of the individual obligations of, any individual obligations of any such persons to the Bank without regard to the disposition or purpose of same as allowed by applicable law. D pNCBANK +In addition but not by way of limitation, the Bank may take checks, drafts or other items payable to "cash", the Bank or the Customer, and pay the sums represented by such Items in cash to any person presenting such items or credit such Items to the account or obligations of any person presenting such items or any other person or entity as directed by any such person. +Products and Services. Resolved that any of the persons listed in Section 3 above are authorized to enter into contracts and agreements, written or verbal, for any products or services now or in the future offered by the Bank, including but not limited to (i) cash management services, (ii) purchases or sales of foreign exchange, securities or other financial products, (iii) computer/internet-based products and services, (iv) wire transfer of funds from or to the accounts of the Customer at the Bank, and (v) ACH transactions, and the Bank may charge any accounts of the Customer at the Bank for such products or services. +00005 Taxpayer I.D. Number (TIN) +OWNER ("Customer") 633-44-1725 +are hereby authorized (i) to effect loans, advances and renewals at any time for the Customer from the Bank; (ii) to sign and deliver any notes (with or without warrant of attorney to confess judgment) and evidences of indebtedness of the Customer; (iii) to request the Bank to issue letters of credit and to sign and deliver to the bank any agreements on behalf of the Customer to reimburse the Bank for all payments made and expenses incurred by it under such letters of credit and drafts drawn pursuant thereto; (iv) to sign and deliver any instruments or documents on behalf of the Customer guaranteeing, endorsing or securing the payment of any debts or obligations of any person, form or corporation to the Bank; (v) to pledge, assign, transfer, mortgage, grant a security interest in or otherwise hypothecate to the Bank any stock, securities, commercial paper, warehouse receipts and other documents of title, bills, accounts receivable, contract rights, inventory, equipment, real property, and any other investments or property of the Customer, real or personal, tangible or intangible as security for the payment of any and all loans, advances, indebtedness and other liabilities of the Customer to the Bank of every kind and description, direct or indirect, absolute and contingent, joint or several, whether as drawer, maker, endorsee, guarantor, surety or otherwise, and to execute on behalf of the Customer mortgages, pledges, security agreements, financing statements and other instruments or documents in connection therewith; and (vi) to sell or discount with the Bank any commercial paper, bills and other instruments and evidence of indebtedness, warehouse receipts and other documents of title, accounts, accounts receivable, contract rights, and other assets, tangible and intangible, at any time held by the Customer and for such purpose to endorse, assign, transfer and deliver the same to the Bank. +Revolving Credits. Resolved that in connection with any extension of credit obtained by any of the persons authorized in Section 5 above, that permit the Customer to effect multiple advances or draws under such credit, any of the persons listed in Sections 5 (Loans and Extensions of Credit) and 3 (Withdrawals and Endorsements) Resolution for ALPHABET +Telephonic and Facsimile Requests. Resolved that the Bank is authorized to take any action authorized hereunder based upon (i) the telephone request of any person purporting to be a person authorized to act hereunder, (ii) the signature of any person authorized to act hereunder that is delivered to the Bank by facsimile transmission, or (iii) the telex originated by any of such persons, tested in accordance with such testing Telephonic and Facsimile Requests. Resolved that the Bank is authorized to take any action authorized hereunder based upon (i) the telephone request of any person purporting to be a person authorized to act hereunder, (ii) the signature of any person authorized to act hereunder that is delivered to the Bank by facsimile transmission, or (iii) the telex originated by any of such persons, tested in accordance with such testing : Tr +R +â€¢d +Ming +or serVlCÃ¶ n lent services, (ii) purchases or sales of foreig xlll) computerfinternet-based products and services, (iv) wir he Customer at the Bank, and (v) ACH transactions, and the Ba the Bank for such products or services. +It. Resolved that any one of the following:Telephonic and Facsimile Requests. Resolved that the Bank is authorized to take any action authorized hereunder based upon (i) the telephone request of any person purporting to be a person authorized to act hereunder, (ii) the signature of any person authorized to act hereunder that is delivered to the Bank by facsimile transmission, or (iii) the telex originated by any of such persons, tested in accordance with such testingprocedures as may be established between the Customer and the Bank from time to time. +General. Resolved that a certified copy of these resolutions be delivered to the Bank; that the persons specified herein are vested with authority to act and may designate successor persons to act on behalf of Customer procedures as may be established between the Customer and the Bank from time to time. +General. Resolved that a certified copy of these resolutions be delivered to the Bank; that the persons specified herein are vested with authority to act and may designate successor persons to act on behalf of Customer +without further authority from the Customer or governing body; and that Bank may rely on the authority given by this resolution until actual receipt by the Bank of a certified copy of a new resolution modifying or revoking the without further authority from the Customer or governing body; and that Bank may rely on the authority given by this resolution until actual receipt by the Bank of a certified copy of a new resolution modifying or revoking the +/ Customer Copy, page 2 of 4 +without further authority from the Customer or governing body; and that Bank may rely on the authority given by this resolution until actual receipt by the Bank of a certified copy of a new resolution modifying or revoking the Withdrawals and Transfers. Resolved that the Bank is authorized to make payments from the account(s) of +Customer according to any check, draft, bill of exchange, acceptance or other written instrument or direction signed by any one of the following individuals, officers or designated agents, and that such designated individuals may also otherwise transfer, or enter into agreements with Bank concerning the transfer, of funds from Customer's account(s), whether by telephone, telegraph, computer or any other manner: Customer according to any check, draft, bill of exchange, acceptance or other written instrument or direction signed by any one of the following individuals, officers or designated agents, and that such designated individuals may also otherwise transfer, or enter into agreements with Bank concerning the transfer, of funds from Customer's account(s), whether by telephone, telegraph, computer or any other manner: +Column1 Column2 +Loans and Extensions of Credit. Resolved that any one of the following:

			Date of this notice: 				44658			 			Employer Identifition Number: 88-1656496							 			Form: 	SS-4						 

+INTERNAL REVENUE SERVICE ZACHRY T WOOD Number of this notice: CP 575 A +CINCINNATI OH 45999-0023 ALPHABET For assistance you may call us a

5323 BRADFORD DR			1-800-829-4933							 DALLAS, TX 75235										 			IF YOU WRITE, ATTACH THE
+STUB AT THE BD OF THIS NOTICE.
						We assigned you				 
This EIN will identify you, your business accounts, tax returns, and +WE ASSIGNED YOU AN EMPLOYER IDENTIFICATION NUMBER +Thank you for applying for an Employer Identification Number (EIN) . +EIN 88-1656496. If the information is + + + + + + +
								Please		 							6.35-			

+for the tax period(s) in question, please file the return (s) showing you have no liabilities . +If you have questions about at the the forms address or the shown due at dates the top shown, of you this can notice. call us If atyou the phone number or write to us Publication 538, +need help in determining your annual accounting period (tax year) , see Accounting Periods and Methods.
			Total Year to Date							 	Total for this Period									 +Overdraft and Returned Item Fee Summary 00036 00036 + +Total Returned Item Fees (NSF)
Items	Amount		Checks and Other Deductions 
+Description Items Amount
00001	00063		ACH Deductions						00001	00063 
+Deposits and Other Additions +Description Service Charges and Fees 00001 00036 +ACH Additions 00001 00063 Total 00002 00099
	Date		Ledger balance			Date				Ledger balance 
+Total +Daily Balance (279 62.50- 44678 00036 +Date Ledger balance * You'
	00202									 
+Alphabet Inc Class C GOOG otm corr
estimating...,								 

+02814 TM 27.8414.76% 63500 53.:

	00202									 

+Fair Value Estimate 02160 gro

00550	ovr									 

+Consider Buying Price +Consider Selling Price +Fair Value Uncertainty +Economic Moat +Stewardship Grade +02-01-2022 1 by Ali Mogharabi +Business Strategy & Outlook 02-01-2022 + +Analyst Digest 1 633-44-1725 10-15-94 Portfolio April 04,2022 - April 03,2022 +Berkshire Hathaway Inc Class A BRK.A +

525000 +527760 $0.001 0.00% 367500 +Fair Value Estimate +Consider Buying Price $708,750.00 +Medium +Wide

Standard +Consider Selling Price +Fair Value Uncertainty +Economic Moat +Stewardship Grade +03-11-2022 1 by Greggory Warren +Business Strategy & Outlook 03-11-2022 +While 2020 was an extremely difficult year for Berkshire Hathaway, with a nearly 10% decline in operating earnings and a more than 40% decline in reported net earnings, the firm's overall positioning improved as the back half of the year progressed. The firm saw an even more marked improvement in its insurance investment portfolio, as well as the operating results of its various subsidiaries, last year. As such, we expect 2022 and 2023 to be a return to more normalized levels of revenue growth and profitability (albeit with inflation impacting results in the first half of this year).We continue to view Berkshire's decentralized business model, broad business diversification, high cash-generation capabilities, and unmatched balance sheet strength as true differentiators. While these advantages have been overshadowed by an ever-expanding cash balance-ANhich is earning next to nothing in a near-zero interest-rate environment--we believe the company has finally hit a nexus where it is far more focused on reducing its cash hoard through stock and bond investments and share repurchases. During the past eight calendar quarters, the + + + +not correct as shown above, please make the correction using the attached tear-off stub and return it to us . +Based on the information received from you or your representative, you must file the following forms by the dates shown. We assigned you

4/7/2022 +Form 940 4/7/2022 +Form 943 4/7/2022 If the information is +Form 1065 4/7/2022 +Form 720 4/7/2022 +Your Form 2290 becomes due the month after your vehicle is put into use . +Your Form 1 IC and/or 730 becomes due the month after your wagering starts . +After our review of your information, we have determined that you have not filed +tax returns for the above-mentioned tax period (s) dating as far back as 2007. Plea S +file your return(s) by 04/22/2022. If there is a balance due on the return (s) +penalties and interest will continue to accumulate from the due date of the return (s) +until it is filed and paid. If you were not in business or did not hire any employees +for the tax period(s) in question, please file the return (s) showing you have no liabilities . +If you have questions about the forms or the due dates shown, you can call us at PI +the phone number or write to us at the address shown at the top of this notice. If you +need help in determining your annual accounting period (tax year) , see Publication 538, Accounting Periods and Methods. + +Business Checking +PNCBANK @PNCBANK +For the period 04/13/2022 Primary account number: 47-2041-6547 Page 1 of 3 +146967 1022462 Q 304 Number of enclosures: 0 +ZACHRY TYLER WOOD ALPHABET +5323 BRADFORD DR +DALLAS TX 75235-8314 For 24-hour banking sign on to +PNC Bank Online Banking on pnc.com +FREE Online Bill Pay +For customer service call 1-877-BUS-BNKG +PNC accepts Telecommunications Relay Service (TRS) calls. 00009 +111111111011111000000000000000000000000000000000000000000000000 Para servicio en espalol, 1877.BUS-BNKC, +Moving? Please contact your local branch. +@ Write to: Customer Service PO Box 609 +Pittsburgh , PA 15230-9738 +Visit us at PNC.com/smaIIbusiness +IMPORTANT INFORMATION FOR BUSINESS DEPOSIT CUSTOMERS Date of this notice: +Effective February 18,2022, PNC will be temporarily waiving fees for statement, check image, deposit ticket and deposited item copy requests until further notice. Statement, check image, deposit ticket and deposited Item requests will continue to be displayed in the Details of Services Used section of your monthly statement. We will notify you via statement message prior to reinstating these fees. +If vou have any questions, you may reach out to your business banker branch or call us at 1-877-BUS-BNKG (1-877-287-2654). +Business Checking Summary +Account number; 47-2041-6547 +Overdraft Protection has not been established for this account. Please contact us if you would like to set up this service. Zachry Tyler Wood Alphabet Employer Identification Number: 88-1656496 +Balance Summary Checks and other deductions Ending balance Form: SS-4 +Beginning balance Deposits and other additions Number of this notice: +00000 = 98.50 Average ledger balance 36.00- +Average collected balance For assistance you may call ug at:

			6.35-			6.35-		1-800-829-4933		 

+Overdraft and Returned Item Fee Summary Total Year to Date

Total for this Period										 

+Total Returned Item Fees (NSF) 00036 00036 IF YOU WRITE, ATTATCHA TYE +STUB AT OYE END OF THIS NOTICE. +Deposits and Other Additions +Description Items Amount Checks and Other Deductions +Description Items Amount +ACH Additions 00001 00063 ACH Deductions 00001 00063

			Service Charges and Fees			00001	00036			 

+Total 00001 00063 Total 00002 00099 +Daily Balance Date Date Ledger balance +Date Ledger balance Ledger balance +4/13/2022 00000 44677 62.50- 44678 00036

Form 940 44658 Berkshire Hatha,a,n.. +Business Checking For the period 04/13/2022 to 04/29/2022 44680 +For 24-hour account information, sign on to pnc.com/mybusiness/ ZACHRY TYLER WOOD Primary account number: 47-2041-6547 Page 2 of 3 +Business Checking Account number: 47-2041-6547 - continued Page 2 of 3 +AcÃ¼vity Detail +Deposits and Other Additions did not hire any employee +ACH Additions Referenc numb +Date posted 04/27 Transaction +Amount description +62.50 Reverse Corporate ACH Debit +Effective 04-26-22 the due dates shown, you can call us at

			22116905560149							 

+Checks and Other Deductions +ACH Deductions Referenc +Date posted Transaction +Amount description

			number							 

+44677 70842743866 Corporate ACH Quickbooks 180041ntuit 1940868

			22116905560149							 

+ervice Charges and Fees Referenc +Date posted Transaction +Amount descripton +44678 22116905560149 numb +Detail of Services Used During Current Period 22116905560149

::NOTE:: The total charge for the following services will be posted to your account on 05/02/2022 and will appear on your next statement as a single line item entitled Service Charge Period Ending 04/29/2022. +e: The total charge for the following Penod Ending 04/29/2022. +Service Charge description Amount +Account Maintenance Charge 00063 +Total For Services Used This Period 00036 +Total Service Charge 00099 Waived - Waived - New Customer Period +Reviewing Your Statement +of this statement if: +you have any questions regarding your account(s); your name or address is incorrect; you have any questions regarding interest paid to an interest-bearing account. PNCBANK +Balancing Your Account +Update Your Account Register Volume +Compare: The activity detail section of your statement to your account register. +Check Off: +Add to Your Account Register: Balance: +Subtract From Your Account Register Balance: All items in your account register that also appear on your statement. Remember to begin with the ending date of your last statement. (An asterisk { * } will appear in the Checks section if there is a gap in the listing of consecutive check numbers.) +Any deposits or additions including interest payments and ATM or electronic deposits listed on the statement that are not already entered in your register. +Any account deductions including fees and ATM or electronic deductions listed on the statement that are not already entered in your register. +Your Statement Information : step 2: Add together checks and other deductions listed in your account register but not on your statement.

	Amount						Check 

+Deduction Descrption Amount +Balancing Your Account +Update Your Account Register

on deposit: 22934637118600.00USD +4720416547 +Reviewing Your Statement +of this statement if: +you have any questions regarding your account(s); your name or address is incorrect; you have any questions regarding interest paid to an interest-bearing account. Total A=$22934637118600 + +Step 3: 22934637118600 + + +Enter the ending balance recorded on your statement +Add deposits and other additions not recorded Total A + $22934637118600 +

		Subtotal=$22934637118600								 

+Subtract checks and other deductions not recorded Total B $ 22934637118600 + +The result should equal your account register balance $ 22934637118600

							Total B22934637118600			 

+Verification of Direct Deposits + +To verify whether a direct deposit or other transfer to your account has occurred, call us Monday - Friday: 7 AM - 10 PM ET and Saturday & Sunday: 8 AM - 5 PM ET at the customer service number listed on the upper right side of the first page of this statement. +In Case of Errors or Questions About Your Electronic Transfers +Telephone us at the customer service number listed on the upper right side of the first page of this statement or write us at PNC Bank Debit Card Services, 500 First Avenue, 4th Floor, Mailstop P7-PFSC-04-M, Pittsburgh, PA 15219 as soon as you can, if you think your statement or receipt is wrong or if you need more information about a transfer on the statement or receipt. We must hear from you no later than 60 days after we sent you the FIRST statement on which the error or problem appeared. +Tell us your name and account number (if any). +Describe the error or the transfer you are unsure about, and explain as clearly as you can why you believe it is an error or why you need more information. +Tell us the dollar amount of the suspected error. +We will investigate your complaint and will correct any error promptly. If we take longer than 10 business days, we will provisionally credit your account for the amount you think is in error, so that you will have use of the money during the time it Cakes us to complete our investigation. +EquaLHousing Lender +Member FDIC + + + +Home > Chapter 7: Reports > Custom Reports > Exporting Custom Reports > Export Custom Report as Excel File +Export Custom Report as Excel File


 Sundar Pichai

Chief Executive Officer

Alphabet Inc.

1600 Amphitheatre Parkway

Mountain View, CA 94043

(650) 253-0000

(Name, address and telephone number, including area code, of agent for service) 

Copies to:

Jeffrey D. Karpf, Esq.

Kent Walker, Esq.

Kathryn W. Hall, Esq.

Cleary Gottlieb Steen & Hamilton LLP

One Liberty Plaza

New York, NY 10006



Alphabet Inc.

1600 Amphitheatre Parkway

Mountain View, CA 94043

(650) 253-0000

Indicate by check mark whether the Registrant is a large accelerated filer, an accelerated filer, a non-accelerated filer, a smaller reporting company or an emerging growth company. See the definitions of â€œlarge accelerated filer,â€ â€œaccelerated filer,â€ â€œsmaller reporting company,â€ and â€œemerging growth companyâ€ in Rule 12b-2 of the Exchange Act.



Large accelerated filerâ˜’  Accelerated filerâ˜Non-accelerated filerâ˜  Smaller reporting companyâ˜Emerging growth companyâ˜



If an emerging growth company, indicate by check mark if the Registrant has elected not to use the extended transition period for complying with any new or revised financial accounting standards provided pursuant to Section 7(a)(2)(B) of the Securities Act. â˜



REGISTRATION OF ADDITIONAL SECURITIES PURSUANT TO GENERAL INSTRUCTION E OF

FORM S-8

EXPLANATORY NOTE

This Registration Statement is being filed by Alphabet Inc., a Delaware corporation (the â€œRegistrantâ€), to register 80,000,000 additional shares of its Class C capital stock, par value $0.001 per share (the â€œClass C Capital Stockâ€) issuable to eligible employees, consultants, contractors, and directors of the Registrant and its affiliates under the Registrantâ€™s Amended and Restated 2021 Stock Plan (the â€œPlanâ€). On June 2, 2021, the Registrant filed with the U.S. Securities and Exchange Commission (the â€œSECâ€): (i) Post-Effective Amendment to Form S-8 Registration Statement (File No. 001-37580) and (ii) Form S-8 Registration Statement (File No. 001-37580 )(collectively, the â€œPrior Registration Statementsâ€) relating to shares of Class C capital stock issuable to eligible employees, consultants, contractors, and directors of the Registrant under the Plan. The Prior Registration Statements are currently effective. The Registration Statement relates to securities of the same class as those to which the Prior Registration Statements relate and is submitted in accordance with General Instruction E of Form S-8 regarding Registration of Additional Securities. Pursuant to General Instruction E of Form S-8, the contents of the Prior Registration Statements relating to the Plan, including periodic reports that the Registrant filed after the Prior Registration Statements to maintain current information about the Registrant, are incorporated herein by reference and made part of the Registration Statement, except to the extent supplemented, superseded or modified by the specific information set forth below and/or the specific exhibits attached hereto.


PART II. INFORMATION REQUIRED IN REGISTRATION STATEMENT

Item 8. Exhibits.


Exhibit

Number

 Exhibit Description3.1â€¡

Amended and Restated Certificate of Incorporation of Alphabet Inc., dated June 3, 2022 (incorporated by reference to Exhibit 3.01 filed with Registrantâ€™s Current Report on Form 8-K (File No. 001-37580) filed with the SEC on June 3, 2022)

3.2â€¡

Amended and Restated Bylaws of Alphabet Inc. dated October 21, 2020 (incorporated by reference to Exhibit 3.02 filed with Registrantâ€™s Current Report on Form 8-K/A (File No. 001-37580), as filed with the SEC on October 29, 2020)

4.1â€¡

Alphabet Inc. Amended and Restated 2021 Stock Plan (incorporated by reference to Exhibit 10.01 filed with Registrantâ€™s Current Report on Form 8-K (File No. 001-37580) filed with the SEC on June 3, 2022)

4.2â€¡

Alphabet Inc. Amended and Restated 2021 Stock Plan - Form of Alphabet Restricted Stock Unit Agreement (incorporated by reference to Exhibit 10.01.1 to Quarterly Report on Form 10-Q (file No. 001-37580), as filed with the SEC on July 28, 2021)

4.3â€¡

Alphabet Inc. Amended and Restated 2021 Stock Plan - Form of Alphabet 2022 Non-CEO Performance Stock Unit Agreement (incorporated by reference to Exhibit 10.07.2 filed with the Registrantâ€™s Annual Report on Form 10-K (File No. 001-37580), as filed with the SEC on February 2, 2022)

5.1* 

Opinion of Cleary Gottlieb Steen & Hamilton LLP

23.1* 

Consent of Ernst & Young LLP, Independent Registered Public Accounting Firm

23.2* 

Consent of Cleary Gottlieb Steen & Hamilton LLP (filed as part of Exhibit 5.1)

24.0*

Power of Attorney (included as part of the signature page of the Registration Statement)

107*

Filing Fee Table


* Filed herewith

â€¡ Incorporated herein by reference




SIGNATURES


Pursuant to the requirements of the Securities Act, the Registrant certifies that it has reasonable grounds to believe that it meets all of the requirements for filing on Form S-8 and has duly caused the Registration Statement to be signed on its behalf by the undersigned, thereunto duly authorized, in the City of Mountain View, State of California, on July 26, 2022.


ALPHABET INC.By:/S/ SUNDAR PICHAISundar PichaiChief Executive Officer




POWER OF ATTORNEY


KNOW ALL PERSONS BY THESE PRESENTS, that each person whose signature appears below hereby constitutes and appoints Sundar Pichai, Ruth M. Porat, Kent Walker, and Kathryn W. Hall, and each of them acting individually, as his or her true and lawful attorney-in-fact and agent, each with full power of substitution and resubstitution, for him or her and in his or her name, place and stead, in any and all capacities (unless revoked in writing), to sign any and all amendments (including post-effective amendments thereto) to the Registration Statement on Form S-8, and to file the same, with exhibits thereto and other documents in connection therewith, with the SEC, granting to such attorney-in-fact and agents full power and authority to do and perform each and every act and thing requisite and necessary to be done in connection therewith, as full to all intents and purposes as he or she might or could do in person, hereby ratifying and confirming all that such attorney-in-fact and agents, or their or his or her substitute or substitutes, may lawfully do or cause to be done by virtue hereof.

Pursuant to the requirements of the Securities Act, the Registration Statement has been signed by the following persons in the capacities and on the date indicated:




SignatureTitleDate/S/ SUNDAR PICHAIChief Executive Officer and Director (Principal Executive Officer)July 26, 2022Sundar Pichai

/S/    RUTH M. PORAT        

Senior Vice President and Chief Financial Officer (Principal Financial Officer)July 26, 2022Ruth M. Porat/S/    AMIE THUENER O'TOOLE        Vice President and Chief Accounting Officer (Principal Accounting Officer)July 26, 2022Amie Thuener O'TooleCo-Founder and DirectorLarry Page/S/    SERGEY BRIN        Co-Founder and DirectorJuly 26, 2022Sergey Brin/S/    FRANCES H. ARNOLD        DirectorJuly 26, 2022Frances H. Arnold/S/ R. MARTIN CHAVEZDirectorJuly 26, 2022R. Martin ChÃ¡vez/S/    L. JOHN DOERR        DirectorJuly 26, 2022L. John Doerr/S/    ROGER W. FERGUSON, JR.       DirectorJuly 26, 2022Roger W. Ferguson, Jr./S/    JOHN L. HENNESSY        Chair of the Board and DirectorJuly 26, 2022John L. Hennessy/S/    ANN MATHER       DirectorJuly 26, 2022Ann Mather/S/    K. RAM SHRIRAM       DirectorJuly 26, 2022K. Ram Shriram/S/    ROBIN L. WASHINGTON      DirectorJuly 26, 2022Robin L. Washington





Mailing Address1600 AMPHITHEATRE PARKWAYMOUNTAIN VIEW CA 94043

* Filed herewith

â€¡ Incorporated herein by reference




SIGNATURES


Pursuant to the requirements of the Securities Act, the Registrant certifies that it has reasonable grounds to believe that it meets all of the requirements for filing on Form S-8 and has duly caused the Registration Statement to be signed on its behalf by the undersigned, thereunto duly authorized, in the City of Mountain View, State of California, on July 26, 2022.


ALPHABET INC.By:/S/ SUNDAR PICHAISundar PichaiChief Executive Officer




POWER OF ATTORNEY


KNOW ALL PERSONS BY THESE PRESENTS, that each person whose signature appears below hereby constitutes and appoints Sundar Pichai, Ruth M. Porat, Kent Walker, and Kathryn W. Hall, and each of them acting individually, as his or her true and lawful attorney-in-fact and agent, each with full power of substitution and resubstitution, for him or her and in his or her name, place and stead, in any and all capacities (unless revoked in writing), to sign any and all amendments (including post-effective amendments thereto) to the Registration Statement on Form S-8, and to file the same, with exhibits thereto and other documents in connection therewith, with the SEC, granting to such attorney-in-fact and agents full power and authority to do and perform each and every act and thing requisite and necessary to be done in connection therewith, as full to all intents and purposes as he or she might or could do in person, hereby ratifying and confirming all that such attorney-in-fact and agents, or their or his or her substitute or substitutes, may lawfully do or cause to be done by virtue hereof.

Pursuant to the requirements of the Securities Act, the Registration Statement has been signed by the following persons in the capacities and on the date indicated:




SignatureTitleDate/S/ SUNDAR PICHAIChief Executive Officer and Director (Principal Executive Officer)July 26, 2022Sundar Pichai

/S/    RUTH M. PORAT        

Senior Vice President and Chief Financial Officer (Principal Financial Officer)July 26, 2022Ruth M. Porat/S/    AMIE THUENER O'TOOLE        Vice President and Chief Accounting Officer (Principal Accounting Officer)July 26, 2022Amie Thuener O'TooleCo-Founder and DirectorLarry Page/S/    SERGEY BRIN        Co-Founder and DirectorJuly 26, 2022Sergey Brin/S/    FRANCES H. ARNOLD        DirectorJuly 26, 2022Frances H. Arnold/S/ R. MARTIN CHAVEZDirectorJuly 26, 2022R. Martin ChÃ¡vez/S/    L. JOHN DOERR        DirectorJuly 26, 2022L. John Doerr/S/    ROGER W. FERGUSON, JR.       DirectorJuly 26, 2022Roger W. Ferguson, Jr./S/    JOHN L. HENNESSY        Chair of the Board and DirectorJuly 26, 2022John L. Hennessy/S/    ANN MATHER       DirectorJuly 26, 2022Ann Mather/S/    K. RAM SHRIRAM       DirectorJuly 26, 2022K. Ram Shriram/S/    ROBIN L. WASHINGTON      DirectorJuly 26, 2022Robin L. Washington





Mailing Address1600 AMPHITHEATRE PARKWAYMOUNTAIN VIEW CA 94043

Business Address1600 AMPHITHEATRE PARKWAYMOUNTAIN VIEW CA 94043650-253-0000

Alphabet Inc. (Filer) CIK: 0001652044 (see all company filings)

IRS No.: 611767919 | State of Incorp.: DE | Fiscal Year End: 1231
Type: 8-K | Act: 34 | File No.: 0 Services-Computer Programming, Data Processing, Etc.
Assistant Director Office of Technology

https://www.sec.gov/cgi-bin/viewer

Mountain View, C.A. 94043
Taxable Maritial Status: Single
Exemptions/Allowances
TX: 28
Federal 941 Deposit Report
ADP
Report Range5/4/2022 - 6/4/2022 Local ID:
EIN: 63-3441725State ID: 633441725
Employee NAumboeurn:t3
Description 5/4/2022 - 6/4/2022
Payment Amount (Total) $9,246,754,678,763.00 Display All
1. Social Security (Employee + Employer) $26,661.80
2. Medicare (Employee + Employer) $861,193,422,444.20 Hourly
3. Federal Income Tax $8,385,561,229,657.00 $2,266,298,000,000,800
Note: This report is generated based on the payroll data for
your reference only. Please contact IRS office for special
cases such as late payment, previous overpayment, penalty
and others.
Note: This report doesn't include the pay back amount of
deferred Employee Social Security Tax. Commission
Employer Customized Report
ADP
Report Range5/4/2022 - 6/4/2022 88-1656496state ID: 633441725 State: All Local ID: 00037305581 $2,267,,700.00
EIN: 61-1767919 :
Customized Report Amount
Employee Payment Report :
Employee Number: 3 :
Description
Wages, Tips and Other Compensation $22,662,983,361,013.70 Report Range: Tips
Taxable SS Wages $215,014.49
Name:
SSN: $0.00
Taxable SS Tips $0 Payment Summary
Taxable Medicare Wages $22,662,983,361,013.70 Salary Vacation hourly OT
Advanced EIC Payment $0.00 $3,361,013.70
Federal Income Tax Withheld $8,385,561,229,657 Bonus $0.00 $0.00
Employee SS Tax Withheld $13,330.90 $0.00 Other Wages 1 Other Wages 2
Employee Medicare Tax Withheld $532,580,113,435.53 Total $0.00 $0.00
State Income Tax Withheld $0.00 $22,662,983,361,013.70
Local Income Tax Withheld
Customized Employer Tax Report $0.00 Deduction Summary
Description Amount Health Insurance
Employer SS Tax
Employer Medicare Tax $13,330.90 
$0.00
Federal Unemployment Tax $328,613,309,008.67 
Tax Summary
State Unemployment Tax $441.70 
Federal Tax 
Total Tax Deduction 
Report $840 
$8,385,561,229,657@3,330.90 
Local Tax
Health Insurance $0.00
401K $0.00 
Advanced 
EIC 
Payment $8,918,141,356,423.43
$0.00 $
0.00 
Total 401K
$0.00 $0.00
Social Security Tax 
Medicare Tax
State Tax
$532,580,113,050
Department of the TreasuryInternal Revenue ServiceQ4 2020 Q4 2019Calendar YearDue: 04/18/2022Dec. 31, 2020 Dec. 31, 2019USD in "000'"sRepayments for Long Term Debt 182527 161857Costs and expenses:Cost of revenues 84732 71896Research and development 27573 26018Sales and marketing 17946 18464General and administrative 11052 9551European Commission fines 0 1697Total costs and expenses 141303 127626Income from operations 41224 34231Other income (expense), net 6858000000 5394Income before income taxes 22,677,000,000 19,289,000,000Provision for income taxes 22,677,000,000 19,289,000,000Net income 22,677,000,000 19,289,000,000*include interest paid, capital obligation, and underweightingBasic net income per share of Class A and B common stockand Class C capital stock (in dollars par share)Diluted net income per share of Class A and Class B commonstock and Class C capital stock (in dollars par share)*include interest paid, capital obligation, and underweightingBasic net income per share of Class A and B common stockand Class C capital stock (in dollars par share)Diluted net income per share of Class A and Class B commonstock and Class C capital stock (in dollars par share)ALPHABET 88-13034915323 BRADFORD DR,DALLAS, TX 75235-8314Employee InfoUnited States Department of The TreasuryEmployee Id: 9999999998 IRS No. 000000000000INTERNAL REVENUE SERVICE, $20,210,418.00PO BOX 1214, Rate Units Total YTD Taxes / Deductions Current YTDCHARLOTTE, NC 28201-1214 - - $70,842,745,000.00 $70,842,745,000.00 Federal Withholding $0.00 $0.00Earnings FICA - Social Security $0.00 $8,853.60Commissions FICA - Medicare $0.00 $0.00Employer TaxesFUTA $0.00 $0.00SUTA $0.00 $0.00EIN: 61-1767ID91:900037305581 SSN: 633441725YTD Gross Gross$70,842,745,000.00 $70,842,745,000.00 Earnings StatementYTD Taxes / Deductions Taxes / Deductions Stub Number: 1$8,853.60 $0.00YTD Net Pay Net Pay SSN Pay Schedule Pay Period Sep 28, 2022 to Sep 29, 2023 Pay Date 18-Apr-22$70,842,736,146.40 $70,842,745,000.00 XXX-XX-1725 AnnuallyCHECK DATE CHECK NUMBER18-Apr-22****$70,842,745,000.00**THIS IS NOT A CHECKCHECK AMOUNTVOIDINTERNAL REVENUE SERVICE,PO BOX 1214,CHARLOTTE, NC 28201-1214ALINE Pay, FSDD, ADPCheck, WGPS, Garnishment Services, EBTS, Benefit Services, Other Bank	Bank Address	Account Name	ABA	DDA	Collection Method JPMorgan Chase	One Chase Manhattan Plaza New York, NY 10005	ADP Tax Services	021000021	323269036	Reverse Wire Impound Deutsche Bank	60 Wall Street New York, NY 10005-2858	ADP Tax Services	021001033	00416217	Reverse Wire Impound Tax & 401(k) Bank	Bank Address	Account Name	ABA	DDA	Collection Method JPMorgan Chase	One Chase Manhattan Plaza New York, NY 10005	ADP Tax Services	021000021	9102628675	Reverse Wire Impound Deutsche Bank	60 Wall Street New York, NY 10005-2858	ADP Tax Services	021001033	00153170	Reverse Wire Impound Workers Compensation Bank	Bank Address	Account Name	ABA	DDA	Collection Method JPMorgan Chase	One Chase Manhattan Plaza New York, NY 10005	ADP Tax Services	021000021	304939315	Reverse Wire Impound NOTICE CLIENT acknowledges that if sufficient funds are not available by the date required pursuant to the foregoing provisions of this Agreement, (1) CLIENT will immediately become solely responsible for all tax deposits and filings, all employee wages, all wage garnishments, all CLIENT third- party payments (e.g., vendor payments) and all related penalties and interest due then and thereafter, (2) any and all ADP Services may, at ADPâ€™s option, be immediately terminated, (3) neither BANK nor ADP will have any further obligation to CLIENT or any third party with respect to any such Services and (4) ADP may take such action as it deems appropriate to collect ADPâ€™s Fees for Services. Client shall not initiate any ACH transactions utilizing ADPâ€™s services that constitute International ACH transactions without first (i) notifying ADP of such IAT transactions in writing utilizing ADPâ€™s Declaration of International ACH Transaction form (or such other form as directed by ADP) and (ii) complying with the requirements applicable to IAT transactions. ADP shall not be liable for any delay or failure in processing any ACH transaction due to Clientâ€™s failure to so notify ADP of Clientâ€™s IAT transactions or Clientâ€™s failure to comply with applicable IAT requirements. EXHIBIT AZACHRY WOOD15 $76,033,000,000.00 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 11,247,000,000 6,959,000,000 6,836,000,000 10,671,000,000 7,068,000,000For Disclosure, Privacy Act, and Paperwork Reduction ActNotice, see separate instructions. $76,033,000,000.00 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 11,247,000,000 6,959,000,000 6,836,000,000 10,671,000,000 7,068,000,000Cat. No. 11320B $76,033,000,000.00 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 11,247,000,000 6,959,000,000 6,836,000,000 10,671,000,000 7,068,000,000Form 1040 (2021) $76,033,000,000.00 20,642,000,000 18,936,000,000Reported Normalized and Operating Income/ExpenseSupplemental SectionTotal Revenue as Reported, Supplemental $257,637,000,000.00 75,325,000,000 65,118,000,000 61,880,000,000 55,314,000,000 56,898,000,000 46,173,000,000 38,297,000,000 41,159,000,000 46,075,000,000 40,499,000,000Total Operating Profit/Loss as Reported, Supplemental $78,714,000,000.00 21,885,000,000 21,031,000,000 19,361,000,000 16,437,000,000 15,651,000,000 11,213,000,000 6,383,000,000 7,977,000,000 9,266,000,000 9,177,000,000Reported Effective Tax Rate $0.16 0.179 0.157 0.158 0.158 0.159 0.119 0.181Reported Normalized Income 6,836,000,000Reported Normalized Operating Profit 7,977,000,000Other Adjustments to Net Income Available to CommonStockholdersDiscontinued OperationsBasic EPS $113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 15.49 10.2Basic EPS from Continuing Operations $113.88 31.12 28.44 27.69 26.63 22.46 16.55 10.21 9.96 15.47 10.2Basic EPS from Discontinued OperationsDiluted EPS $112.20 30.69 27.99 27.26 26.29 22.3 16.4 10.13 9.87 15.35 10.12Diluted EPS from Continuing Operations $112.20 30.67 27.99 27.26 26.29 22.23 16.4 10.13 9.87 15.33 10.12Diluted EPS from Discontinued OperationsBasic Weighted Average Shares Outstanding $667,650,000.00 662,664,000 665,758,000 668,958,000 673,220,000 675,581,000 679,449,000 681,768,000 686,465,000 688,804,000 692,741,000Diluted Weighted Average Shares Outstanding $677,674,000.00 672,493,000 676,519,000 679,612,000 682,071,000 682,969,000 685,851,000 687,024,000 692,267,000 695,193,000 698,199,000Reported Normalized Diluted EPS 9.87Basic EPS $113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 15.49 10.2 1Diluted EPS $112.20 30.69 27.99 27.26 26.29 22.3 16.4 10.13 9.87 15.35 10.12Basic WASO $667,650,000.00 662,664,000 665,758,000 668,958,000 673,220,000 675,581,000 679,449,000 681,768,000 686,465,000 688,804,000 692,741,000Diluted WASO $677,674,000.00 672,493,000 676,519,000 679,612,000 682,071,000 682,969,000 685,851,000 687,024,000 692,267,000 695,193,000 698,199,000Fiscal year end September 28th., 2022. | USDFor Paperwork Reduction Act Notice, see the seperateInstructions.THIS NOTE IS LEGAL TENDERTENDERFOR ALL DEBTS, PUBLIC ANDPRIVATECurrent ValueUnappropriated, Affiliated, Securities, at Value.(1) For subscriptions, your payment method on file will be automatically charged monthly/annually at the then-current list price until you cancel. If you have a discount it will apply to the then-current list price until it expires. To cancel your subscription at any time, go to Account & Settings and cancel the subscription. (2) For one-time services, your payment method on file will reflect the charge in the amount referenced in this invoice. Terms, conditions, pricing, features, service, and support options are subject to change without notice.All dates and times are Pacific Standard Time (PST).INTERNAL REVENUE SERVICE, $20,210,418.00 PO BOX 1214, Rate Units Total YTD Taxes / Deductions Current YTD CHARLOTTE, NC 28201-1214 - - $70,842,745,000.00 $70,842,745,000.00 Federal Withholding $0.00 $0.00 Earnings FICA - Social Security $0.00 $8,853.60 Commissions FICA - Medicare $0.00 $0.00 Employer Taxes FUTA $0.00 $0.00 SUTA $0.00 $0.00 EIN: 61-1767ID91:900037305581 SSN: 633441725 YTD Gross Gross $70,842,745,000.00 $70,842,745,000.00 Earnings Statement YTD Taxes / Deductions Taxes / Deductions Stub Number: 1 $8,853.60 $0.00 YTD Net Pay net, pay. SSN Pay Schedule Paid Period Sep 28, 2022 to Sep 29, 2023 15-Apr-22 Pay Day 18-Apr-22 $70,842,736,146.40 $70,842,745,000.00 XXX-XX-1725 Annually Sep 28, 2022 to Sep 29, 2023 CHECK DATE CHECK NUMBER 001000 18-Apr-22 PAY TO THE : ZACHRY WOOD ORDER OF :Office of the 46th President Of The United States. 117th US Congress Seal Of The US Treasury Department, 1769 W.H.W. DC, US 2022. : INTERNAL REVENUE SERVICE,PO BOX 1214,CHARLOTTE, NC 28201-1214 CHECK AMOUNT $70,842,745,000.00 Pay ZACHRY.WOOD************ :NON-NEGOTIABLE : VOID AFTER 14 DAYS INTERNAL REVENUE SERVICE :000,000.00 $18,936,000,000.00 $18,525,000,000.00 $17,930,000,000.00 $15,227,000,000.00 $11,247,000,000.00 $6,959,000,000.00 $6,836,000,000.00 $10,671,000,000.00 $7,068,000,000.00 $76,033,000,000.00 $20,642,000,000.00 $18,936,000,000.00 $18,525,000,000.00 $17,930,000,000.00 $15,227,000,000.00 $11,247,000,000.00 $6,959,000,000.00 $6,836,000,000.00 $10,671,000,000.00 $7,068,000,000.00 $76,033,000,000.00 $20,642,000,000.00 $18,936,000,000.00 $18,525,000,000.00 $17,930,000,000.00 $15,227,000,000.00 $11,247,000,000.00 $6,959,000,000.00 $6,836,000,000.00 $10,671,000,000.00 $7,068,000,000.00 $76,033,000,000.00 $20,642,000,000.00 $18,936,000,000.00 $257,637,000,000.00 $75,325,000,000.00 $65,118,000,000.00 $61,880,000,000.00 $55,314,000,000.00 $56,898,000,000.00 $46,173,000,000.00 $38,297,000,000.00 $41,159,000,000.00 $46,075,000,000.00 $40,499,000,000.00 $78,714,000,000.00 $21,885,000,000.00 $21,031,000,000.00 $19,361,000,000.00 $16,437,000,000.00 $15,651,000,000.00 $11,213,000,000.00 $6,383,000,000.00 $7,977,000,000.00 $9,266,000,000.00 $9,177,000,000.00 $0.16 $0.18 $0.16 $0.16 $0.16 $0.16 $0.12 $0.18 $6,836,000,000.00 $7,977,000,000.00 $113.88 $31.15 $28.44 $27.69 $26.63 $22.54 $16.55 $10.21 $9.96 $15.49 $10.20 $113.88 $31.12 $28.44 $27.69 $26.63 $22.46 $16.55 $10.21 $9.96 $15.47 $10.20 $112.20 $30.69 $27.99 $27.26 $26.29 $22.30 $16.40 $10.13 $9.87 $15.35 $10.12 $112.20 $30.67 $27.99 $27.26 $26.29 $22.23 $16.40 $10.13 $9.87 $15.33 $10.12 $667,650,000.00 $662,664,000.00 $665,758,000.00 $668,958,000.00 $673,220,000.00 $675,581,000.00 $679,449,000.00 $681,768,000.00 $686,465,000.00 $688,804,000.00 $692,741,000.00 $677,674,000.00 $672,493,000.00 $676,519,000.00 $679,612,000.00 $682,071,000.00 $682,969,000.00 $685,851,000.00 $687,024,000.00 $692,267,000.00 $695,193,000.00 $698,199,000.00 $9.87 $113.88 $31.15 $28.44 $27.69 $26.63 $22.54 $16.55 $10.21 $9.96 $15.49 $10.20 $1.00 $112.20 $30.69 $27.99 $27.26 $26.29 $22.30 $16.40 $10.13 $9.87 $15.35 $10.12 $667,650,000.00 $662,664,000.00 $665,758,000.00 $668,958,000.00 $673,220,000.00 $675,581,000.00 $679,449,000.00 $681,768,000.00 $686,465,000.00 $688,804,000.00 $692,741,000.00 $677,674,000.00 $672,493,000.00 $676,519,000.00 $679,612,000.00 $682,071,000.00 $682,969,000.00 $685,851,000.00 $687,024,000.00 $692,267,000.00 $695,193,000.00 $698,199,000.00 : $70,842,745,000.00 633-44-1725 Annually : branches: - main : on: schedule: - cron: "0 2 * * 1-5 : obs: my_job: name :deploy to staging : runs-on :ubuntu-18.04 :The available virtual machine types are:ubuntu-latest, ubuntu-18.04, or ubuntu-16.04 :windows-latest :# :Controls when the workflow will run :"#":, "Triggers the workflow on push or pull request events but only for the "Masterbranch" branch :":, push: EFT information Routing number: 021000021Payment account ending: 9036Name on the account: ADPTax reporting informationInternal Revenue ServiceUnited States Department of the TreasuryMemphis, TN 375001-1498Tracking ID: 1023934415439Customer File Number: 132624428Date of Issue: 07-29-2022ZACHRY T WOOD3050 REMOND DR APT 1206DALLAS, TX 75211Taxpayer's Name: ZACH T WOOTaxpayer Identification Number: XXX-XX-1725Tax Period: December, 2018Return: 1040 ZACHRY TYLER WOOD 5323 BRADFORD DRIVE DALLAS TX 75235 EMPLOYER IDENTIFICATION NUMBER :611767919 :FIN :xxxxx4775 THE 101YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM $0.001 TO 33611.5895286 :State Income TaxTotal Work HrsBonusTrainingYour federal taxable wages this period are $22,756,988,716,000.00Net.Important Notes0.001 TO 112.20 PAR SHARE VALUETot*$70,842,743,866.00$22,756,988,716,000.00$22,756,988,716,000.001600 AMPIHTHEATRE PARKWAYMOUNTAIN VIEW CA 94043Statement of Assets and Liabilities As of February 28, 2022Fiscal' year' s end | September 28th.Total (includes tax of (00.00))   
3/6/2022 at 6:37 PM
Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020
GOOGL_incomeï¿¾statement_Quarterly_As_Originally_Reported 24,934,000,000 25,539,000,000 37,497,000,000 31,211,000,000 30,818,000,000
24,934,000,000 25,539,000,000 21,890,000,000 19,289,000,000 22,677,000,000
Cash Flow from Operating Activities, Indirect 24,934,000,000 25,539,000,000 21,890,000,000 19,289,000,000 22,677,000,000
Net Cash Flow from Continuing Operating Activities, Indirect 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000
Cash Generated from Operating Activities 6,517,000,000 3,797,000,000 4,236,000,000 2,592,000,000 5,748,000,000
Income/Loss before Non-Cash Adjustment 3,439,000,000 3,304,000,000 2,945,000,000 2,753,000,000 3,725,000,000
Total Adjustments for Non-Cash Items 3,439,000,000 3,304,000,000 2,945,000,000 2,753,000,000 3,725,000,000
Depreciation, Amortization and Depletion, Non-Cash
Adjustment 3,215,000,000 3,085,000,000 2,730,000,000 2,525,000,000 3,539,000,000
Depreciation and Amortization, Non-Cash Adjustment 224,000,000 219,000,000 215,000,000 228,000,000 186,000,000
Depreciation, Non-Cash Adjustment 3,954,000,000 3,874,000,000 3,803,000,000 3,745,000,000 3,223,000,000
Amortization, Non-Cash Adjustment 1,616,000,000 -1,287,000,000 379,000,000 1,100,000,000 1,670,000,000
Stock-Based Compensation, Non-Cash Adjustment -2,478,000,000 -2,158,000,000 -2,883,000,000 -4,751,000,000 -3,262,000,000
Taxes, Non-Cash Adjustment -2,478,000,000 -2,158,000,000 -2,883,000,000 -4,751,000,000 -3,262,000,000
Investment Income/Loss, Non-Cash Adjustment -14,000,000 64,000,000 -8,000,000 -255,000,000 392,000,000
Gain/Loss on Financial Instruments, Non-Cash Adjustment -2,225,000,000 2,806,000,000 -871,000,000 -1,233,000,000 1,702,000,000
Other Non-Cash Items -5,819,000,000 -2,409,000,000 -3,661,000,000 2,794,000,000 -5,445,000,000
Changes in Operating Capital -5,819,000,000 -2,409,000,000 -3,661,000,000 2,794,000,000 -5,445,000,000
Change in Trade and Other Receivables -399,000,000 -1,255,000,000 -199,000,000 7,000,000 -738,000,000
Change in Trade/Accounts Receivable 6,994,000,000 3,157,000,000 4,074,000,000 -4,956,000,000 6,938,000,000
Change in Other Current Assets 1,157,000,000 238,000,000 -130,000,000 -982,000,000 963,000,000
Change in Payables and Accrued Expenses 1,157,000,000 238,000,000 -130,000,000 -982,000,000 963,000,000
Change in Trade and Other Payables 5,837,000,000 2,919,000,000 4,204,000,000 -3,974,000,000 5,975,000,000
Change in Trade/Accounts Payable 368,000,000 272,000,000 -3,000,000 137,000,000 207,000,000
Change in Accrued Expenses -3,369,000,000 3,041,000,000 -1,082,000,000 785,000,000 740,000,000
Change in Deferred Assets/Liabilities
Change in Other Operating Capital
-11,016,000,000 -10,050,000,000 -9,074,000,000 -5,383,000,000 -7,281,000,000
Change in Prepayments and Deposits -11,016,000,000 -10,050,000,000 -9,074,000,000 -5,383,000,000 -7,281,000,000
Cash Flow from Investing Activities
Cash Flow from Continuing Investing Activities -6,383,000,000 -6,819,000,000 -5,496,000,000 -5,942,000,000 -5,479,000,000
-6,383,000,000 -6,819,000,000 -5,496,000,000 -5,942,000,000 -5,479,000,000
Purchase/Sale and Disposal of Property, Plant and Equipment,
Net
Purchase of Property, Plant and Equipment -385,000,000 -259,000,000 -308,000,000 -1,666,000,000 -370,000,000
Sale and Disposal of Property, Plant and Equipment -385,000,000 -259,000,000 -308,000,000 -1,666,000,000 -370,000,000
Purchase/Sale of Business, Net -4,348,000,000 -3,360,000,000 -3,293,000,000 2,195,000,000 -1,375,000,000
Purchase/Acquisition of Business -40,860,000,000 -35,153,000,000 -24,949,000,000 -37,072,000,000 -36,955,000,000
Purchase/Sale of Investments, Net
Purchase of Investments 36,512,000,000 31,793,000,000 21,656,000,000 39,267,000,000 35,580,000,000
100,000,000 388,000,000 23,000,000 30,000,000 -57,000,000
Sale of Investments
Other Investing Cash Flow -15,254,000,000
Purchase/Sale of Other Non-Current Assets, Net -16,511,000,000 -15,254,000,000 -15,991,000,000 -13,606,000,000 -9,270,000,000
Sales of Other Non-Current Assets -16,511,000,000 -12,610,000,000 -15,991,000,000 -13,606,000,000 -9,270,000,000
Cash Flow from Financing Activities -13,473,000,000 -12,610,000,000 -12,796,000,000 -11,395,000,000 -7,904,000,000
Cash Flow from Continuing Financing Activities 13,473,000,000 -12,796,000,000 -11,395,000,000 -7,904,000,000
Issuance of/Payments for Common Stock, Net -42,000,000
Payments for Common Stock 115,000,000 -42,000,000 -1,042,000,000 -37,000,000 -57,000,000
Proceeds from Issuance of Common Stock 115,000,000 6,350,000,000 -1,042,000,000 -37,000,000 -57,000,000
Issuance of/Repayments for Debt, Net 6,250,000,000 -6,392,000,000 6,699,000,000 900,000,000 0
Issuance of/Repayments for Long Term Debt, Net 6,365,000,000 -2,602,000,000 -7,741,000,000 -937,000,000 -57,000,000
Proceeds from Issuance of Long Term Debt
Repayments for Long Term Debt 2,923,000,000 -2,453,000,000 -2,184,000,000 -1,647,000,000
Proceeds from Issuance/Exercising of Stock Options/Warrants 0 300,000,000 10,000,000 3.38E+11
Other Financing Cash Flow
Cash and Cash Equivalents, End of Period
Change in Cash 20,945,000,000 23,719,000,000 23,630,000,000 26,622,000,000 26,465,000,000
Effect of Exchange Rate Changes 25930000000) 235000000000) -3,175,000,000 300,000,000 6,126,000,000
Cash and Cash Equivalents, Beginning of Period PAGE="$USD(181000000000)".XLS BRIN="$USD(146000000000)".XLS 183,000,000 -143,000,000 210,000,000
Cash Flow Supplemental Section $23,719,000,000,000.00 $26,622,000,000,000.00 $26,465,000,000,000.00 $20,129,000,000,000.00
Change in Cash as Reported, Supplemental 2,774,000,000 89,000,000 -2,992,000,000 6,336,000,000
Income Tax Paid, Supplemental 13,412,000,000 157,000,000
ZACHRY T WOOD -4990000000
Cash and Cash Equivalents, Beginning of Period
Department of the Treasury
Internal Revenue Service
Q4 2020 Q4 2019
Calendar Year
Due: 04/18/2022
Dec. 31, 2020 Dec. 31, 2019
USD in "000'"s
Repayments for Long Term Debt 182527 161857
Costs and expenses:
Cost of revenues 84732 71896
Research and development 27573 26018
Sales and marketing 17946 18464
General and administrative 11052 9551
European Commission fines 0 1697
Total costs and expenses 141303 127626
Income from operations 41224 34231
Other income (expense), net 6858000000 5394
Income before income taxes 22,677,000,000 19,289,000,000
Provision for income taxes 22,677,000,000 19,289,000,000
Net income 22,677,000,000 19,289,000,000
*include interest paid, capital obligation, and underweighting
Basic net income per share of Class A and B common stock
and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common
stock and Class C capital stock (in dollars par share)
*include interest paid, capital obligation, and underweighting
Basic net income per share of Class A and B common stock
and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common
stock and Class C capital stock (in dollars par share)
ALPHABET 88-1303491
5323 BRADFORD DR,
DALLAS, TX 75235-8314
Employee Info
United States Department of The Treasury
Employee Id: 9999999998 IRS No. 000000000000
INTERNAL REVENUE SERVICE, $20,210,418.00
PO BOX 1214, Rate Units Total YTD Taxes / Deductions Current YTD
CHARLOTTE, NC 28201-1214 - - $70,842,745,000.00 $70,842,745,000.00 Federal Withholding $0.00 $0.00
Earnings FICA - Social Security $0.00 $8,853.60
Commissions FICA - Medicare $0.00 $0.00
Employer Taxes
FUTA $0.00 $0.00
SUTA $0.00 $0.00
EIN: 61-1767ID91:900037305581 SSN: 633441725
YTD Gross Gross
$70,842,745,000.00 $70,842,745,000.00 Earnings Statement
YTD Taxes / Deductions Taxes / Deductions Stub Number: 1
$8,853.60 $0.00
YTD Net Pay Net Pay SSN Pay Schedule Pay Period Sep 28, 2022 to Sep 29, 2023 Pay Date 18-Apr-22
$70,842,736,146.40 $70,842,745,000.00 XXX-XX-1725 Annually
CHECK DATE CHECK NUMBER
18-Apr-22
****$70,842,745,000.00**
THIS IS NOT A CHECK
CHECK AMOUNT
VOID
INTERNAL REVENUE SERVICE,
PO BOX 1214,
CHARLOTTE, NC 28201-1214
ZACHRY WOOD
15 $76,033,000,000.00 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 11,247,000,000 6,959,000,000 6,836,000,000 10,671,000,000 7,068,000,000
For Disclosure, Privacy Act, and Paperwork Reduction Act
Notice, see separate instructions. $76,033,000,000.00 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 11,247,000,000 6,959,000,000 6,836,000,000 10,671,000,000 7,068,000,000
Cat. No. 11320B $76,033,000,000.00 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 11,247,000,000 6,959,000,000 6,836,000,000 10,671,000,000 7,068,000,000
Form 1040 (2021) $76,033,000,000.00 20,642,000,000 18,936,000,000
Reported Normalized and Operating Income/Expense
Supplemental Section
Total Revenue as Reported, Supplemental $257,637,000,000.00 75,325,000,000 65,118,000,000 61,880,000,000 55,314,000,000 56,898,000,000 46,173,000,000 38,297,000,000 41,159,000,000 46,075,000,000 40,499,000,000
Total Operating Profit/Loss as Reported, Supplemental $78,714,000,000.00 21,885,000,000 21,031,000,000 19,361,000,000 16,437,000,000 15,651,000,000 11,213,000,000 6,383,000,000 7,977,000,000 9,266,000,000 9,177,000,000
Reported Effective Tax Rate $0.16 0.179 0.157 0.158 0.158 0.159 0.119 0.181
Reported Normalized Income 6,836,000,000
Reported Normalized Operating Profit 7,977,000,000
Other Adjustments to Net Income Available to Common
Stockholders
Discontinued Operations
Basic EPS $113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 15.49 10.2
Basic EPS from Continuing Operations $113.88 31.12 28.44 27.69 26.63 22.46 16.55 10.21 9.96 15.47 10.2
Basic EPS from Discontinued Operations
Diluted EPS $112.20 30.69 27.99 27.26 26.29 22.3 16.4 10.13 9.87 15.35 10.12
Diluted EPS from Continuing Operations $112.20 30.67 27.99 27.26 26.29 22.23 16.4 10.13 9.87 15.33 10.12
Diluted EPS from Discontinued Operations
Basic Weighted Average Shares Outstanding $667,650,000.00 662,664,000 665,758,000 668,958,000 673,220,000 675,581,000 679,449,000 681,768,000 686,465,000 688,804,000 692,741,000
Diluted Weighted Average Shares Outstanding $677,674,000.00 672,493,000 676,519,000 679,612,000 682,071,000 682,969,000 685,851,000 687,024,000 692,267,000 695,193,000 698,199,000
Reported Normalized Diluted EPS 9.87
Basic EPS $113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 15.49 10.2 1
Diluted EPS $112.20 30.69 27.99 27.26 26.29 22.3 16.4 10.13 9.87 15.35 10.12
Basic WASO $667,650,000.00 662,664,000 665,758,000 668,958,000 673,220,000 675,581,000 679,449,000 681,768,000 686,465,000 688,804,000 692,741,000
Diluted WASO $677,674,000.00 672,493,000 676,519,000 679,612,000 682,071,000 682,969,000 685,851,000 687,024,000 692,267,000 695,193,000 698,199,000
Fiscal year end September 28th., 2022. | USD
For Paperwork Reduction Act Notice, see the seperate
Instructions.
EX-99.1
On behalf of Alphabet Inc. (â€œAlphabetâ€), I am pleased to offer you a position as a member of Alphabetâ€™s Board of Directors (the â€œBoardâ€) commencing on July 11, 2022 (the â€œEffective Dateâ€), subject to the approval  following the Effective Date. The exact number of shares of Alphabetâ€™s Class C stock. If the US financial markets are granted pre-releassed insights from owner zachry tyler wood ing &abc.xyz's earning's schedule details will be provided in the grant materials that you should receive shortly after the grant.

Vesting in  is on consignment contingent basis on continued service foward-on :

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>View Filing Data</title><script type="text/javascript" src="/include/jquery-1.4.3.min.js"></script><script type="text/javascript" src="/include/accordionMenu.js"></script><script type="text/javascript" src="/include/Show.js"></script><link rel="stylesheet" type="text/css" href="/include/interactive.css" /><link rel="stylesheet" type="text/css" href="/include/report.css" /><link rel="stylesheet" type="text/css" href="/include/print.css" media="print" /><link rel="stylesheet" type="text/css" href="/include/xbrlViewerStyle.css" /><style type="text/css">li.octave {border-top: 1px solid black;}</style><!--[if lt IE 8]><style type="text/css">li.accordion a {display:inline-block;}li.accordion a {display:block;}</style><![endif]--></head><body style="margin: 0"><noscript><div style="color:red; font-weight:bold; text-align:center;">This page uses Javascript. Your browser either doesn't support Javascript or you have it turned off. To see this page as it is meant to appear please use a Javascript enabled browser.</div></noscript><!-- BEGIN BANNER --><div id="headerTop"> <div id="Nav"><a href="/index.htm">Home</a> | <a href="/cgi-bin/browse-edgar?action=getcurrent">Latest Filings</a> | <a href="javascript:history.back()">Previous Page</a></div> <div id="seal"><a href="http://www.sec.gov/index.htm"><img src="/images/sealTop.gif" alt="SEC Seal" border="0" /></a></div> <div id="secWordGraphic"><img src="/images/bannerTitle.gif" alt="SEC Banner" /></div></div><div id="headerBottom"> <div id="searchHome"><a href="/edgar/searchedgar/webusers.htm">Search the Next-Generation EDGAR System</a></div> <div id="PageTitle">View Filing Data</div></div><!-- END BANNER --><!-- BEGIN BREADCRUMBS --><div id="breadCrumbs"> <ul> <li><a href="/">SEC Home</a> &#187;</li> <li><a href="/edgar/searchedgar/webusers.htm">Search the Next-Generation EDGAR System</a> &#187;</li> <li><a href="/edgar/searchedgar/companysearch.html">Company Search</a> &#187;</li> <li class="last">Current Page</li> </ul></div><!-- END BREADCRUMBS --><div style="margin-top: 15px; margin: 15px 20px 10px 20px; color: red; text-align: center;"> <p>Invalid parameter.</p></div><!-- END FOOTER DIV --><div id="footer"> <div class="currentURL">https://www.sec.gov/cgi-bin/viewer</div> <div class="links"><a href="/index.htm">Home</a> | <a href="/edgar/searchedgar/webusers.htm">Search the Next-Generation EDGAR System</a> | <a href="javascript:history.back()">Previous Page</a></div> <div class="modified">Modified 02/20/2019</div></div><!-- END FOOTER DIV --></body></html>

PUBLISH :
RELEASE :
LAUNCH :
DEPLOY : repositories'@zakwarlord7/zakwarlord7/README.md/README.md :
:Build::
Federal 941 Deposit Report
ADP
Report Range5/4/2022 - 6/4/2022 Local ID:
EIN: 63-3441725State ID: 633441725
Employee NAumboeurn:t3
Description 5/4/2022 - 6/4/2022
Payment Amount (Total) $9,246,754,678,763.00 Display All
1. Social Security (Employee + Employer) $26,661.80
2. Medicare (Employee + Employer) $861,193,422,444.20 Hourly
3. Federal Income Tax $8,385,561,229,657.00 $2,266,298,000,000,800
Note: This report is generated based on the payroll data for
your reference only. Please contact IRS office for special
cases such as late payment, previous overpayment, penalty
and others.
Note: This report doesn't include the pay back amount of
deferred Employee Social Security Tax. Commission
Employer Customized Report
ADP
Report Range5/4/2022 - 6/4/2022 88-1656496state ID: 633441725 State: All Local ID: 00037305581 $2,267,700.00
EIN:
Customized Report Amount
Employee Payment Report
ADP
Employee Number: 3
Description
Wages, Tips and Other Compensation $22,662,983,361,013.70 Report Range: Tips
Taxable SS Wages $215,014.49
Name:
SSN: $0.00
Taxable SS Tips $0 Payment Summary
Taxable Medicare Wages $22,662,983,361,013.70 Salary Vacation hourly OT
Advanced EIC Payment $0.00 $3,361,013.70
Federal Income Tax Withheld $8,385,561,229,657 Bonus $0.00 $0.00
Employee SS Tax Withheld $13,330.90 $0.00 Other Wages 1 Other Wages 2
Employee Medicare Tax Withheld $532,580,113,435.53 Total $0.00 $0.00
State Income Tax Withheld $0.00 $22,662,983,361,013.70
Local Income Tax Withheld
Customized Employer Tax Report $0.00 Deduction Summary
Description Amount Health Insurance
Employer SS Tax
Employer Medicare Tax $13,330.90 $0.00
Federal Unemployment Tax $328,613,309,008.67 Tax Summary
State Unemployment Tax $441.70 Federal Tax Total Tax
Customized Deduction Report $840 $8,385,561,229,657@3,330.90 Local Tax
Health Insurance $0.00
401K $0.00 Advanced EIC Payment $8,918,141,356,423.43
$0.00 $0.00 Total
401K
$0.00 $0.00
Social Security Tax Medicare TaxState Tax
$532,580,113,050)
3/6/2022 at 6:37 PM
Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020
GOOGL_incomeï¿¾statement_Quarterly_As_Originally_Reported 24,934,000,000 25,539,000,000 37,497,000,000 31,211,000,000 30,818,000,000
24,934,000,000 25,539,000,000 21,890,000,000 19,289,000,000 22,677,000,000
Cash Flow from Operating Activities, Indirect 24,934,000,000 25,539,000,000 21,890,000,000 19,289,000,000 22,677,000,000
Net Cash Flow from Continuing Operating Activities, Indirect 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000
Cash Generated from Operating Activities 6,517,000,000 3,797,000,000 4,236,000,000 2,592,000,000 5,748,000,000
Income/Loss before Non-Cash Adjustment 3,439,000,000 3,304,000,000 2,945,000,000 2,753,000,000 3,725,000,000
Total Adjustments for Non-Cash Items 3,439,000,000 3,304,000,000 2,945,000,000 2,753,000,000 3,725,000,000
Depreciation, Amortization and Depletion, Non-Cash
Adjustment 3,215,000,000 3,085,000,000 2,730,000,000 2,525,000,000 3,539,000,000
Depreciation and Amortization, Non-Cash Adjustment 224,000,000 219,000,000 215,000,000 228,000,000 186,000,000
Depreciation, Non-Cash Adjustment 3,954,000,000 3,874,000,000 3,803,000,000 3,745,000,000 3,223,000,000
Amortization, Non-Cash Adjustment 1,616,000,000 -1,287,000,000 379,000,000 1,100,000,000 1,670,000,000
Stock-Based Compensation, Non-Cash Adjustment -2,478,000,000 -2,158,000,000 -2,883,000,000 -4,751,000,000 -3,262,000,000
Taxes, Non-Cash Adjustment -2,478,000,000 -2,158,000,000 -2,883,000,000 -4,751,000,000 -3,262,000,000
Investment Income/Loss, Non-Cash Adjustment -14,000,000 64,000,000 -8,000,000 -255,000,000 392,000,000
Gain/Loss on Financial Instruments, Non-Cash Adjustment -2,225,000,000 2,806,000,000 -871,000,000 -1,233,000,000 1,702,000,000
Other Non-Cash Items -5,819,000,000 -2,409,000,000 -3,661,000,000 2,794,000,000 -5,445,000,000
Changes in Operating Capital -5,819,000,000 -2,409,000,000 -3,661,000,000 2,794,000,000 -5,445,000,000
Change in Trade and Other Receivables -399,000,000 -1,255,000,000 -199,000,000 7,000,000 -738,000,000
Change in Trade/Accounts Receivable 6,994,000,000 3,157,000,000 4,074,000,000 -4,956,000,000 6,938,000,000
Change in Other Current Assets 1,157,000,000 238,000,000 -130,000,000 -982,000,000 963,000,000
Change in Payables and Accrued Expenses 1,157,000,000 238,000,000 -130,000,000 -982,000,000 963,000,000
Change in Trade and Other Payables 5,837,000,000 2,919,000,000 4,204,000,000 -3,974,000,000 5,975,000,000
Change in Trade/Accounts Payable 368,000,000 272,000,000 -3,000,000 137,000,000 207,000,000
Change in Accrued Expenses -3,369,000,000 3,041,000,000 -1,082,000,000 785,000,000 740,000,000
Change in Deferred Assets/Liabilities
Change in Other Operating Capital
-11,016,000,000 -10,050,000,000 -9,074,000,000 -5,383,000,000 -7,281,000,000
Change in Prepayments and Deposits -11,016,000,000 -10,050,000,000 -9,074,000,000 -5,383,000,000 -7,281,000,000
Cash Flow from Investing Activities
Cash Flow from Continuing Investing Activities -6,383,000,000 -6,819,000,000 -5,496,000,000 -5,942,000,000 -5,479,000,000
-6,383,000,000 -6,819,000,000 -5,496,000,000 -5,942,000,000 -5,479,000,000
Purchase/Sale and Disposal of Property, Plant and Equipment,
Net
Purchase of Property, Plant and Equipment -385,000,000 -259,000,000 -308,000,000 -1,666,000,000 -370,000,000
Sale and Disposal of Property, Plant and Equipment -385,000,000 -259,000,000 -308,000,000 -1,666,000,000 -370,000,000
Purchase/Sale of Business, Net -4,348,000,000 -3,360,000,000 -3,293,000,000 2,195,000,000 -1,375,000,000
Purchase/Acquisition of Business -40,860,000,000 -35,153,000,000 -24,949,000,000 -37,072,000,000 -36,955,000,000
Purchase/Sale of Investments, Net
Purchase of Investments 36,512,000,000 31,793,000,000 21,656,000,000 39,267,000,000 35,580,000,000
100,000,000 388,000,000 23,000,000 30,000,000 -57,000,000
Sale of Investments
Other Investing Cash Flow -15,254,000,000
Purchase/Sale of Other Non-Current Assets, Net -16,511,000,000 -15,254,000,000 -15,991,000,000 -13,606,000,000 -9,270,000,000
Sales of Other Non-Current Assets -16,511,000,000 -12,610,000,000 -15,991,000,000 -13,606,000,000 -9,270,000,000
Cash Flow from Financing Activities -13,473,000,000 -12,610,000,000 -12,796,000,000 -11,395,000,000 -7,904,000,000
Cash Flow from Continuing Financing Activities 13,473,000,000 -12,796,000,000 -11,395,000,000 -7,904,000,000
Issuance of/Payments for Common Stock, Net -42,000,000
Payments for Common Stock 115,000,000 -42,000,000 -1,042,000,000 -37,000,000 -57,000,000
Proceeds from Issuance of Common Stock 115,000,000 6,350,000,000 -1,042,000,000 -37,000,000 -57,000,000
Issuance of/Repayments for Debt, Net 6,250,000,000 -6,392,000,000 6,699,000,000 900,000,000 0
Issuance of/Repayments for Long Term Debt, Net 6,365,000,000 -2,602,000,000 -7,741,000,000 -937,000,000 -57,000,000
Proceeds from Issuance of Long Term Debt
Repayments for Long Term Debt 2,923,000,000 -2,453,000,000 -2,184,000,000 -1,647,000,000
Proceeds from Issuance/Exercising of Stock Options/Warrants 0 300,000,000 10,000,000 3.38E+11
Other Financing Cash Flow
Cash and Cash Equivalents, End of Period
Change in Cash 20,945,000,000 23,719,000,000 23,630,000,000 26,622,000,000 26,465,000,000
Effect of Exchange Rate Changes 25930000000) 235000000000) -3,175,000,000 300,000,000 6,126,000,000
Cash and Cash Equivalents, Beginning of Period PAGE="$USD(181000000000)".XLS BRIN="$USD(146000000000)".XLS 183,000,000 -143,000,000 210,000,000
Cash Flow Supplemental Section $23,719,000,000,000.00 $26,622,000,000,000.00 $26,465,000,000,000.00 $20,129,000,000,000.00
Change in Cash as Reported, Supplemental 2,774,000,000 89,000,000 -2,992,000,000 6,336,000,000
Income Tax Paid, Supplemental 13,412,000,000 157,000,000
ZACHRY T WOOD -4990000000
Cash and Cash Equivalents, Beginning of Period
Department of the Treasury
Internal Revenue Service
Q4 2020 Q4 2019
Calendar Year
Due: 04/18/2022
Dec. 31, 2020 Dec. 31, 2019
USD in "000'"s
Repayments for Long Term Debt 182527 161857
Costs and expenses:
Cost of revenues 84732 71896
Research and development 27573 26018
Sales and marketing 17946 18464
General and administrative 11052 9551
European Commission fines 0 1697
Total costs and expenses 141303 127626
Income from operations 41224 34231
Other income (expense), net 6858000000 5394
Income before income taxes 22,677,000,000 19,289,000,000
Provision for income taxes 22,677,000,000 19,289,000,000
Net income 22,677,000,000 19,289,000,000
*include interest paid, capital obligation, and underweighting
Basic net income per share of Class A and B common stock
and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common
stock and Class C capital stock (in dollars par share)
*include interest paid, capital obligation, and underweighting
Basic net income per share of Class A and B common stock
and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common
stock and Class C capital stock (in dollars par share)
ALPHABET 88-1303491
5323 BRADFORD DR,
DALLAS, TX 75235-8314
Employee Info
United States Department of The Treasury
Employee Id: 9999999998 IRS No. 000000000000
INTERNAL REVENUE SERVICE, $20,210,418.00
PO BOX 1214, Rate Units Total YTD Taxes / Deductions Current YTD
CHARLOTTE, NC 28201-1214 - - $70,842,745,000.00 $70,842,745,000.00 Federal Withholding $0.00 $0.00
Earnings FICA - Social Security $0.00 $8,853.60
Commissions FICA - Medicare $0.00 $0.00
Employer Taxes
FUTA $0.00 $0.00
SUTA $0.00 $0.00
EIN: 61-1767ID91:900037305581 SSN: 633441725
YTD Gross Gross
$70,842,745,000.00 $70,842,745,000.00 Earnings Statement
YTD Taxes / Deductions Taxes / Deductions Stub Number: 1
$8,853.60 $0.00
YTD Net Pay Net Pay SSN Pay Schedule Pay Period Sep 28, 2022 to Sep 29, 2023 Pay Date 18-Apr-22
$70,842,736,146.40 $70,842,745,000.00 XXX-XX-1725 Annually
CHECK DATE CHECK NUMBER
18-Apr-22
****$70,842,745,000.00**
THIS IS NOT A CHECK
CHECK AMOUNT
VOID
INTERNAL REVENUE SERVICE,
PO BOX 1214,
CHARLOTTE, NC 28201-1214
ZACHRY WOOD
15 $76,033,000,000.00 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 11,247,000,000 6,959,000,000 6,836,000,000 10,671,000,000 7,068,000,000
For Disclosure, Privacy Act, and Paperwork Reduction Act
Notice, see separate instructions. $76,033,000,000.00 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 11,247,000,000 6,959,000,000 6,836,000,000 10,671,000,000 7,068,000,000
Cat. No. 11320B $76,033,000,000.00 20,642,000,000 18,936,000,000 18,525,000,000 17,930,000,000 15,227,000,000 11,247,000,000 6,959,000,000 6,836,000,000 10,671,000,000 7,068,000,000
Form 1040 (2021) $76,033,000,000.00 20,642,000,000 18,936,000,000
Reported Normalized and Operating Income/Expense
Supplemental Section
Total Revenue as Reported, Supplemental $257,637,000,000.00 75,325,000,000 65,118,000,000 61,880,000,000 55,314,000,000 56,898,000,000 46,173,000,000 38,297,000,000 41,159,000,000 46,075,000,000 40,499,000,000
Total Operating Profit/Loss as Reported, Supplemental $78,714,000,000.00 21,885,000,000 21,031,000,000 19,361,000,000 16,437,000,000 15,651,000,000 11,213,000,000 6,383,000,000 7,977,000,000 9,266,000,000 9,177,000,000
Reported Effective Tax Rate $0.16 0.179 0.157 0.158 0.158 0.159 0.119 0.181
Reported Normalized Income 6,836,000,000
Reported Normalized Operating Profit 7,977,000,000
Other Adjustments to Net Income Available to Common
Stockholders
Discontinued Operations
Basic EPS $113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 15.49 10.2
Basic EPS from Continuing Operations $113.88 31.12 28.44 27.69 26.63 22.46 16.55 10.21 9.96 15.47 10.2
Basic EPS from Discontinued Operations
Diluted EPS $112.20 30.69 27.99 27.26 26.29 22.3 16.4 10.13 9.87 15.35 10.12
Diluted EPS from Continuing Operations $112.20 30.67 27.99 27.26 26.29 22.23 16.4 10.13 9.87 15.33 10.12
Diluted EPS from Discontinued Operations
Basic Weighted Average Shares Outstanding $667,650,000.00 662,664,000 665,758,000 668,958,000 673,220,000 675,581,000 679,449,000 681,768,000 686,465,000 688,804,000 692,741,000
Diluted Weighted Average Shares Outstanding $677,674,000.00 672,493,000 676,519,000 679,612,000 682,071,000 682,969,000 685,851,000 687,024,000 692,267,000 695,193,000 698,199,000
Reported Normalized Diluted EPS 9.87
Basic EPS $113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 15.49 10.2 1
Diluted EPS $112.20 30.69 27.99 27.26 26.29 22.3 16.4 10.13 9.87 15.35 10.12
Basic WASO $667,650,000.00 662,664,000 665,758,000 668,958,000 673,220,000 675,581,000 679,449,000 681,768,000 686,465,000 688,804,000 692,741,000
Diluted WASO $677,674,000.00 672,493,000 676,519,000 679,612,000 682,071,000 682,969,000 685,851,000 687,024,000 692,267,000 695,193,000 698,199,000
Fiscal year end September 28th., 2022. | USD
For Paperwork Reduction Act Notice, see the seperate
Instructions.
THIS NOTE IS LEGAL TENDER
TENDER
FOR ALL DEBTS, PUBLIC AND
PRIVATE
Current Value
Unappropriated, Affiliated, Securities, at Value.(1) For subscriptions, your payment method on file will be automatically charged monthly/annually at the then-current list price until you cancel. If you have a discount it will apply to the then-current list price until it expires. To cancel your subscription at any time, go to Account & Settings and cancel the subscription. (2) For one-time services, your payment method on file will reflect the charge in the amount referenced in this invoice. Terms, conditions, pricing, features, service, and support options are subject to change without notice.
All dates and times are Pacific Standard Time (PST).

INTERNAL REVENUE SERVICE, $20,210,418.00 PO BOX 1214, Rate Units Total YTD Taxes / Deductions Current YTD CHARLOTTE, NC 28201-1214 - - $70,842,745,000.00 $70,842,745,000.00 Federal Withholding $0.00 $0.00 Earnings FICA - Social Security $0.00 $8,853.60 Commissions FICA - Medicare $0.00 $0.00 Employer Taxes FUTA $0.00 $0.00 SUTA $0.00 $0.00 EIN: 61-1767ID91:900037305581 SSN: 633441725 YTD Gross Gross $70,842,745,000.00 $70,842,745,000.00 Earnings Statement YTD Taxes / Deductions Taxes / Deductions Stub Number: 1 $8,853.60 $0.00 YTD Net Pay net, pay. SSN Pay Schedule Paid Period Sep 28, 2022 to Sep 29, 2023 15-Apr-22 Pay Day 18-Apr-22 $70,842,736,146.40 $70,842,745,000.00 XXX-XX-1725 Annually Sep 28, 2022 to Sep 29, 2023 CHECK DATE CHECK NUMBER 001000 18-Apr-22 PAY TO THE : ZACHRY WOOD ORDER OF :Office of the 46th President Of The United States. 117th US Congress Seal Of The US Treasury Department, 1769 W.H.W. DC, US 2022. : INTERNAL REVENUE SERVICE,PO BOX 1214,CHARLOTTE, NC 28201-1214 CHECK AMOUNTÂ $70,842,745,000.00Â PayÂ ZACHRY.WOOD************ :NON-NEGOTIABLE : VOID AFTER 14 DAYS INTERNAL REVENUE SERVICE :000,000.00 $18,936,000,000.00 $18,525,000,000.00 $17,930,000,000.00 $15,227,000,000.00 $11,247,000,000.00 $6,959,000,000.00 $6,836,000,000.00 $10,671,000,000.00 $7,068,000,000.00 $76,033,000,000.00 $20,642,000,000.00 $18,936,000,000.00 $18,525,000,000.00 $17,930,000,000.00 $15,227,000,000.00 $11,247,000,000.00 $6,959,000,000.00 $6,836,000,000.00 $10,671,000,000.00 $7,068,000,000.00 $76,033,000,000.00 $20,642,000,000.00 $18,936,000,000.00 $18,525,000,000.00 $17,930,000,000.00 $15,227,000,000.00 $11,247,000,000.00 $6,959,000,000.00 $6,836,000,000.00 $10,671,000,000.00 $7,068,000,000.00 $76,033,000,000.00 $20,642,000,000.00 $18,936,000,000.00 $257,637,000,000.00 $75,325,000,000.00 $65,118,000,000.00 $61,880,000,000.00 $55,314,000,000.00 $56,898,000,000.00 $46,173,000,000.00 $38,297,000,000.00 $41,159,000,000.00 $46,075,000,000.00 $40,499,000,000.00 $78,714,000,000.00 $21,885,000,000.00 $21,031,000,000.00 $19,361,000,000.00 $16,437,000,000.00 $15,651,000,000.00 $11,213,000,000.00 $6,383,000,000.00 $7,977,000,000.00 $9,266,000,000.00 $9,177,000,000.00 $0.16 $0.18 $0.16 $0.16 $0.16 $0.16 $0.12 $0.18 $6,836,000,000.00 $7,977,000,000.00 $113.88 $31.15 $28.44 $27.69 $26.63 $22.54 $16.55 $10.21 $9.96 $15.49 $10.20 $113.88 $31.12 $28.44 $27.69 $26.63 $22.46 $16.55 $10.21 $9.96 $15.47 $10.20 $112.20 $30.69 $27.99 $27.26 $26.29 $22.30 $16.40 $10.13 $9.87 $15.35 $10.12 $112.20 $30.67 $27.99 $27.26 $26.29 $22.23 $16.40 $10.13 $9.87 $15.33 $10.12 $667,650,000.00 $662,664,000.00 $665,758,000.00 $668,958,000.00 $673,220,000.00 $675,581,000.00 $679,449,000.00 $681,768,000.00 $686,465,000.00 $688,804,000.00 $692,741,000.00 $677,674,000.00 $672,493,000.00 $676,519,000.00 $679,612,000.00 $682,071,000.00 $682,969,000.00 $685,851,000.00 $687,024,000.00 $692,267,000.00 $695,193,000.00 $698,199,000.00 $9.87 $113.88 $31.15 $28.44 $27.69 $26.63 $22.54 $16.55 $10.21 $9.96 $15.49 $10.20 $1.00 $112.20 $30.69 $27.99 $27.26 $26.29 $22.30 $16.40 $10.13 $9.87 $15.35 $10.12 $667,650,000.00 $662,664,000.00 $665,758,000.00 $668,958,000.00 $673,220,000.00 $675,581,000.00 $679,449,000.00 $681,768,000.00 $686,465,000.00 $688,804,000.00 $692,741,000.00 $677,674,000.00 $672,493,000.00 $676,519,000.00 $679,612,000.00 $682,071,000.00 $682,969,000.00 $685,851,000.00 $687,024,000.00 $692,267,000.00 $695,193,000.00 $698,199,000.00 : $70,842,745,000.00 633-44-1725 Annually : branches: - main : on: schedule: - cron: "0 2 * * 1-5 : jobs: my_job: name :deploy to staging : runs-on :ubuntu-18.04 :The available virtual machine types are:ubuntu-latest, ubuntu-18.04, or ubuntu-16.04 :windows-latest :# :Controls when the workflow will runÂ :"#":, "Triggers the workflow on push or pull request events but only for the "Masterbranch" branch :":, push: EFT information Re Routing number: 021000021Payment account ending: 9036Name on the account: ADPTax reporting informationInternal Revenue ServiceUnited States Department of the TreasuryMemphis, TN 375001-1498Tracking ID: 1023934415439Customer File Number: 132624428Date of Issue: 07-29-2022ZACHRY T WOOD3050 REMOND DR APT 1206DALLAS, TX 75211Taxpayer's Name: ZACH T WOOTaxpayer Identification Number: XXX-XX-1725Tax Period: December, 2018Return: 1040 ZACHRY TYLER WOOD 5323 BRADFORD DRIVE DALLAS TX 75235 EMPLOYER IDENTIFICATION NUMBER :611767919 :FIN :xxxxx4775 THE 101

YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM $0.001 TO 33611.5895286 :
State Income Tax
Total Work Hrs
Bonus
Training
Your federal taxable wages this period are $22,756,988,716,000.00
Net.Important Notes
0.001 TO 112.20 PAR SHARE VALUE
Tot*$70,842,743,866.00
$22,756,988,716,000.00
$22,756,988,716,000.00
1600 AMPIHTHEATRE PARKWAY
MOUNTAIN VIEW CA 94043
Statement of Assets and Liabilities As of February 28, 2022
I
Fiscal' year' s end | September 28th.
<script type="text/javascript" src="/include/accordionMenu.js">
</script><script type="text/javascript" src="/include/Show.js">
</script><link rel="stylesheet" type="text/css" href="/include/interactive.css" />
<link rel="stylesheet" type="text/css" href="/include/report.css" />
<link rel="stylesheet" type="text/css" href="/include/print.css" media="print" />
<link rel="stylesheet" type="text/css" href="/include/xbrlViewerStyle.css" />
<style type="text/css">li.octave {border-top: 1px solid black;}</style>
<!--[if lt IE 8]><style type="text/css">li.accordion a {display:inline_stylesguide;}li.accordion a {display:block;}
</style><![if]-->
</head>
<body style="margin: 0">
<script><div style="color:red; font-weight:bold; text-align:center;">

This page uses Javascript. Your browser either doesn't support Javascript or you have it turned off. 
To see this page as it is meant to appear please use a Javascript enabled browser.
</div>
<script>
<!-- BEGIN BANNER -->
<div id="headerTop"> <div id="Nav">
<a href="/index.htm">Home</a> | <a href="/cgi-bin/browse-edgar?action=getcurrent">Latest Filings</a> | <a href="javascript:history.back()">Previous Page</a></div> <div id="seal"><a href="http://www.sec.gov/index.htm"><img src="/images/sealTop.gif" alt="SEC Seal" border="0" /></a></div> <div id="secWordGraphic"><img src="/images/bannerTitle.gif" alt="SEC Banner" /></div></div><div id="headerBottom"> <div id="searchHome"><a href="/edgar/searchedgar/webusers.htm">Search the Next-Generation EDGAR System</a></div> <div id="PageTitle">View Filing Data</div></div><!-- END BANNER --><!-- BEGIN BREADCRUMBS --><div id="breadCrumbs"> <ul> <li><a href="/">SEC Home</a> &#187;</li> <li><a href="/edgar/searchedgar/webusers.htm">Search the Next-Generation EDGAR System</a> &#187;</li> <li><a href="/edgar/searchedgar/companysearch.html">Company Search</a> &#187;</li> <li class="last">Current Page</li> </ul></div><!-- END BREADCRUMBS --><div style="margin-top: 15px; margin: 15px 20px 10px 20px; color: red; text-align: center;"> <p>Invalid parameter.</p></div><!-- END FOOTER DIV --><div id="footer"> <div class="currentURL">https://www.sec.gov/cgi-bin/viewer</div> <div class="links"><a href="/index.htm">Home</a> | <a href="/edgar/searchedgar/webusers.htm">Search the Next-Generation EDGAR System</a> | <a href="javascript:history.back()">Previous Page</a></div> 
<div class="modified">Modified 02/20/2019</div></div
><!-- END FOOTER DIV --></body></html>
:Build:: :
 Revenue from Contract with Customer 
[Abstract] Revenues Revenues Revenue Recognition The following table presents our revenues disaggregated by type (in millions). Year Ended December 31, 

2018 2019 2020 Google Search & other $ 85,296 $ 98,115 $ 104,062 YouTube ads 11,155 15,149 19,772 Google Network Members' properties 20,010 21,547 23,090 

Google advertising 116,461 134,811 146,924 Google other 14,063 17,014 21,711 Google Services total 130,524 151,825 168,635 Google Cloud 5,838 8,918 13,059 

Other Bets 595 659 657 Hedging gains (losses) (138) 455 176 Total revenues $ 136,819 $ 161,857 $ 182,527 The following table presents our revenues 

disaggregated by geography, based on the addresses of our customers (in millions): Year Ended December 31, 2018 2019 2020 United States $ 63,269 46 % $ 

74,843 46 % $ 85,014 47 % EMEA (1) 44,739 33 50,645 31 55,370 30 APAC (1) 21,341 15 26,928 17 32,550 18 Other Americas (1) 7,608 6 8,986 6 9,417 5 Hedging 

gains (losses) (138) 0 455 0 176 0 Total revenues $ 136,819 100 % $ 161,857 100 % $ 182,527 100 % (1) Regions represent Europe, the Middle East, and 

Africa ("EMEA"); Asia-Pacific ("APAC"); and Canada and Latin America ("Other Americas"). Deferred Revenues and Remaining Performance Obligations We record 

deferred revenues when cash payments are received or due in advance of our performance, including amounts which are refundable. Deferred revenues 

primarily relate to Google Cloud and Google other. Our total deferred revenue as of December 31, 2019 was $2.3 billion, of which $1.8 billion was 

recognized as revenues for the year ending December 31, 2020. Additionally, we have performance obligations associated with commitments in customer 

contracts, primarily related to Google Cloud, for future services that have not yet been recognized as revenues, also referred to as remaining performance 

obligations. Remaining performance obligations include related deferred revenue currently recorded as well as amounts that will be invoiced in future 

periods, and excludes (i) contracts with an original expected term of one year or less, (ii) cancellable contracts, and (iii) contracts for which we 

recognize revenue at the amount to which we have the right to invoice for services performed. As of December 31, 2020, the amount not yet recognized as 

revenues from these commitments is $29.8 billion. We expect to recognize approximately half over the next CONSOLIDATED BALANCE SHEETS (Parenthetical) - $ 

/ shares Dec. 31, 2020 Dec. 31, 2019 Stockholders’ equity: Convertible preferred stock

From:	ALPHABET (zachryiixixiiwood@gmail.com)

To:	pncalerts@pncalerts.com

Date:	Monday, November 21, 2022 at 02:52 PM CST

ALPHABET <zachryiixixiiwood@gmail.com>

To:ZACHRY WOOD

Mon, Nov 21 at 2:51 PM

Revenues        12 Months Ended                                                                                                                                                        
Dec. 31, 2020                                                                                                                                                        
Revenue from Contract with Customer [Abstract]                                                                                                                                                                
Revenues        

Revenues Revenue Recognition The following table presents our revenues disaggregated by type (in millions). Year Ended December 31, 2018 2019 2020 Google 

Search & other $ 85,296 $ 98,115 $ 104,062 YouTube ads 11,155 15,149 19,772 Google Network Members' properties 20,010 21,547 23,090 Google advertising 

116,461 134,811 146,924 Google other 14,063 17,014 21,711 Google Services total 130,524 151,825 168,635 Google Cloud 5,838 8,918 13,059 Other Bets 595 659 

657 Hedging gains (losses) (138) 455 176 Total revenues $ 136,819 $ 161,857 $ 182,527 The following table presents our revenues disaggregated by 

geography, based on the addresses of our customers (in millions): Year Ended December 31, 2018 2019 2020 United States $ 63,269 46 % $ 74,843 46 % $ 

85,014 47 % EMEA (1) 44,739 33 50,645 31 55,370 30 APAC (1) 21,341 15 26,928 17 32,550 18 Other Americas (1) 7,608 6 8,986 6 9,417 5 Hedging gains 

(losses) (138) 0 455 0 176 0 Total revenues $ 136,819 100 % $ 161,857 100 % $ 182,527 100 % (1) Regions represent Europe, the Middle East, and Africa 

("EMEA"); Asia-Pacific ("APAC"); and Canada and Latin America ("Other Americas"). Deferred Revenues and Remaining Performance Obligations We record 

deferred revenues when cash payments are received or due in advance of our performance, including amounts which are refundable. Deferred revenues 

primarily relate to Google Cloud and Google other. Our total deferred revenue as of December 31, 2019 was $2.3 billion, of which $1.8 billion was 

recognized as revenues for the year ending December 31, 2020. Additionally, we have performance obligations associated with commitments in customer 

contracts, primarily related to Google Cloud, for future services that have not yet been recognized as revenues, also referred to as remaining performance 

obligations. Remaining performance obligations include related deferred revenue currently recorded as well as amounts that will be invoiced in future 

periods, and excludes (i) contracts with an original expected term of one year or less, (ii) cancellable contracts, and (iii) contracts for which we 

recognize revenue at the amount to which we have the right to invoice for services performed. As of December 31, 2020, the amount not yet recognized as 

revenues from these commitments is $29.8 billion. We expect to recognize approximately half over the next CONSOLIDATED BALANCE SHEETS (Parenthetical) - $ 

/ shares        Dec. 31, 2020        Dec. 31, 2019        

Stockholders’ equity:                        

Convertible preferred stock, par value per share (in dollars per share)         $ 0.001          $ 0.001         

Convertible preferred stock, shares authorized (in shares)         100,000,000          100,000,000         

Convertible preferred stock, shares issued (in shares)         0          0         

Convertible preferred stock, shares outstanding (in shares)         0          0         

Common stock and capital stock, par value (in dollars per share)         $ 0.001          $ 0.001         

Common stock and capital stock, shares authorized (in shares)         15,000,000,000          15,000,000,000         

Common stock and capital stock, shares issued (in shares)         675,222,000          688,335,000         

Common stock and capital stock, shares outstanding (in shares)         675,222,000          688,335,000         

Class A Common Stock                        

Stockholders’ equity:                        

Common stock and capital stock, shares authorized (in shares)         9,000,000,000          9,000,000,000         

Common stock and capital stock, shares issued (in shares)         300,730,000          299,828,000         

Common stock and capital stock, shares outstanding (in shares)         300,730,000          299,828,000         

Class B Common Stock                        

Stockholders’ equity:                        

Common stock and capital stock, shares authorized (in shares)         3,000,000,000          3,000,000,000         

Common stock and capital stock, shares issued (in shares)         45,843,000          46,441,000         

Common stock and capital stock, shares outstanding (in shares)         45,843,000          46,441,000         

Class C Capital Stock                        

Stockholders’ equity:                        

Common stock and capital stock, shares authorized (in shares)         3,000,000,000          3,000,000,000         

Common stock and capital stock, shares issued (in shares)         328,649,000          342,066,000         

Common stock and capital stock, shares outstanding (in shares)         328,649,000          342,066,000

DEPOSIT TICKET

Deposited to the account Of xxxxxxxx6547

Deposits and Other Additions                                                                                           Checks and Other Deductions Amount

Description Description I Items 5.41

ACH Additions Debit Card Purchases 1 15.19

POS Purchases 2 2,269,894.11

ACH Deductions 5 82

Service Charges and Fees 3 5.2

Other Deductions 1 2,270,001.91

Total Total 12


Daily Balance

Date Ledger balance Date Ledger balance Date Ledger balance

7/30 107.8 8/3 2,267,621.92- 8/8 41.2

8/1 78.08 8/4 42.08 8/10 2150.19-

Daily Balance continued on next page

Date

8/3 2,267,700.00 ACH Web Usataxpymt IRS 240461564036618 (0.00022214903782823)

8/8 Corporate ACH Acctverify Roll By ADP (00022217906234115)

8/10 ACH Web Businessform Deluxeforbusiness 5072270 (00022222905832355)

8/11 Corporate Ach Veryifyqbw Intuit (00022222909296656)

8/12 Corporate Ach Veryifyqbw Intuit (00022223912710109)

Service Charges and Fees

Reference

Date posted number

8/1 10 Service Charge Period Ending 07/29.2022

8/4 36 Returned ItemFee (nsf) (00022214903782823)

8/11 36 Returned ItemFee (nsf) (00022222905832355)

INCOME STATEMENT

INASDAQ:GOOG TTM Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020 Q3 2020 Q2 2020

Gross Profit 1.46698E+11 42337000000 37497000000 35653000000 31211000000 30818000000 25056000000 19744000000

Total Revenue as Reported, Supplemental 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000

2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000

Other Revenue

Cost of Revenue -1.10939E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000

Cost of Goods and Services -1.10939E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000

Operating Income/Expenses -67984000000 -20452000000 -16466000000 -16292000000 -14774000000 -15167000000 -13843000000 -13361000000

Selling, General and Administrative Expenses -36422000000 -11744000000 -8772000000 -8617000000 -7289000000 -8145000000 -6987000000 -6486000000

General and Administrative Expenses -13510000000 -4140000000 -3256000000 -3341000000 -2773000000 -2831000000 -2756000000 -2585000000

Selling and Marketing Expenses -22912000000 -7604000000 -5516000000 -5276000000 -4516000000 -5314000000 -4231000000 -3901000000

Research and Development Expenses -31562000000 -8708000000 -7694000000 -7675000000 -7485000000 -7022000000 -6856000000 -6875000000

Total Operating Profit/Loss 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000

Non-Operating Income/Expenses, Total 12020000000 2517000000 2033000000 2624000000 4846000000 3038000000 2146000000 1894000000

Total Net Finance Income/Expense 1153000000 261000000 310000000 313000000 269000000 333000000 412000000 420000000

Net Interest Income/Expense 1153000000 261000000 310000000 313000000 269000000 333000000 412000000 420000000

Interest Expense Net of Capitalized Interest -346000000 -117000000 -77000000 -76000000 -76000000 -53000000 -48000000 -13000000

Interest Income 1499000000 378000000 387000000 389000000 345000000 386000000 460000000 433000000

Net Investment Income 12364000000 2364000000 2207000000 2924000000 4869000000 3530000000 1957000000 1696000000

Gain/Loss on Investments and Other Financial Instruments 12270000000 2478000000 2158000000 2883000000 4751000000 3262000000 2015000000 1842000000

Income from Associates, Joint Ventures and Other Participating Interests 334000000 49000000 188000000 92000000 5000000 355000000 26000000 -54000000

Gain/Loss on Foreign Exchange -240000000 -163000000 -139000000 -51000000 113000000 -87000000 -84000000 -92000000

Irregular Income/Expenses 0 0 0 0 0

Other Irregular Income/Expenses 0 0 0 0 0

Other Income/Expense, Non-Operating -1497000000 -108000000 -484000000 -613000000 -292000000 -825000000 -223000000 -222000000

Pretax Income 90734000000 24402000000 23064000000 21985000000 21283000000 18689000000 13359000000 8277000000

Provision for Income Tax -14701000000 -3760000000 -4128000000 -3460000000 -3353000000 -3462000000 -2112000000 -1318000000

Net Income from Continuing Operations 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000

Net Income after Extraordinary Items and Discontinued Operations 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 

6959000000

Net Income after Non-Controlling/Minority Interests 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000

Net Income Available to Common Stockholders 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000

Diluted Net Income Available to Common Stockholders 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000

Income Statement Supplemental Section

Reported Normalized and Operating Income/Expense Supplemental Section

Total Revenue as Reported, Supplemental 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000

Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000

Reported Effective Tax Rate 0.162 0.179 0.157 0.158 0.158 0.159

Reported Normalized Income

Reported Normalized Operating Profit

Other Adjustments to Net Income Available to Common Stockholders

Discontinued Operations

Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21

Basic EPS from Continuing Operations 113.88 31.12 28.44 27.69 26.63 22.46 16.55 10.21

Basic EPS from Discontinued Operations

Diluted EPS 112.2 30.69 27.99 27.26 26.29 22.3 16.4 10.13

Diluted EPS from Continuing Operations 112.2 30.67 27.99 27.26 26.29 22.23 16.4 10.13

Diluted EPS from Discontinued Operations

Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000

Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000

Reported Normalized Diluted EPS

Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21

Diluted EPS 112.2 30.69 27.99 27.26 26.29 22.3 16.4 10.13

Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000

Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000

Fiscal year end September 28th., 2022. | USD

Your federal taxable wages this period are $

ALPHABET INCOME Advice number:

1600 AMPIHTHEATRE  PARKWAY MOUNTAIN VIEW CA 94043 2.21169E+13









GOOGL_income-statement_Quarterly_As_Originally_Reported Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020

Cash Flow from Operating Activities, Indirect 24934000000 25539000000 37497000000 31211000000 30818000000

Net Cash Flow from Continuing Operating Activities, Indirect 24934000000 25539000000 21890000000 19289000000 22677000000

Cash Generated from Operating Activities 24934000000 25539000000 21890000000 19289000000 22677000000

Income/Loss before Non-Cash Adjustment 20642000000 18936000000 18525000000 17930000000 15227000000

Total Adjustments for Non-Cash Items 6517000000 3797000000 4236000000 2592000000 5748000000

Depreciation, Amortization and Depletion, Non-Cash Adjustment 3439000000 3304000000 2945000000 2753000000 3725000000

Depreciation and Amortization, Non-Cash Adjustment 3439000000 3304000000 2945000000 2753000000 3725000000

Depreciation, Non-Cash Adjustment 3215000000 3085000000 2730000000 2525000000 3539000000

Amortization, Non-Cash Adjustment 224000000 219000000 215000000 228000000 186000000

Stock-Based Compensation, Non-Cash Adjustment 3954000000 3874000000 3803000000 3745000000 3223000000

Taxes, Non-Cash Adjustment 1616000000 -1287000000 379000000 1100000000 1670000000

Investment Income/Loss, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000

Gain/Loss on Financial Instruments, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000

Other Non-Cash Items -14000000 64000000 -8000000 -255000000 392000000

Changes in Operating Capital -2225000000 2806000000 -871000000 -1233000000 1702000000
Change in Trade and Other Receivables -5819000000 -2409000000 -3661000000 2794000000 -5445000000

Change in Trade/Accounts Receivable -5819000000 -2409000000 -3661000000 2794000000 -5445000000

Change in Other Current Assets -399000000 -1255000000 -199000000 7000000 -738000000

Change in Payables and Accrued Expenses 6994000000 3157000000 4074000000 -4956000000 6938000000

Change in Trade and Other Payables 1157000000 238000000 -130000000 -982000000 963000000

Change in Trade/Accounts Payable 1157000000 238000000 -130000000 -982000000 963000000

Change in Accrued Expenses 5837000000 2919000000 4204000000 -3974000000 5975000000

Change in Deferred Assets/Liabilities 368000000 272000000 -3000000 137000000 207000000

Change in Other Operating Capital -3369000000 3041000000 -1082000000 785000000 740000000

Change in Prepayments and Deposits

Cash Flow from Investing Activities -11016000000 -10050000000 -9074000000 -5383000000 -7281000000

Cash Flow from Continuing Investing Activities -11016000000 -10050000000 -9074000000 -5383000000 -7281000000

Purchase/Sale and Disposal of Property, Plant and Equipment, Net -6383000000 -6819000000 -5496000000 -5942000000 -5479000000

Purchase of Property, Plant and Equipment -6383000000 -6819000000 -5496000000 -5942000000 -5479000000

Sale and Disposal of Property, Plant and Equipment

Purchase/Sale of Business, Net -385000000 -259000000 -308000000 -1666000000 -370000000
Purchase/Acquisition of Business -385000000 -259000000 -308000000 -1666000000 -370000000


Purchase/Sale of Investments, Net -4348000000 -3360000000 -3293000000 2195000000 -1375000000
Purchase of Investments -40860000000 -35153000000 -24949000000 -37072000000 -36955000000
Sale of Investments 36512000000 31793000000 21656000000 39267000000 35580000000
Other Investing Cash Flow 100000000 388000000 23000000 30000000 -57000000
Purchase/Sale of Other Non-Current Assets, Net
Sales of Other Non-Current Assets
Cash Flow from Financing Activities -16511000000 -15254000000 -15991000000 -13606000000 -9270000000
Cash Flow from Continuing Financing Activities -16511000000 -15254000000 -15991000000 -13606000000 -9270000000
Issuance of/Payments for Common Stock, Net -13473000000 -12610000000 -12796000000 -11395000000 -7904000000
Payments for Common Stock 13473000000 -12610000000 -12796000000 -11395000000 -7904000000
Proceeds from Issuance of Common Stock
Issuance of/Repayments for Debt, Net 115000000 -42000000 -1042000000 -37000000 -57000000
Issuance of/Repayments for Long Term Debt, Net 115000000 -42000000 -1042000000 -37000000 -57000000
Proceeds from Issuance of Long Term Debt 6250000000 6350000000 6699000000 900000000 0
Repayments for Long Term Debt 6365000000 -6392000000 -7741000000 -937000000 -57000000
Proceeds from Issuance/Exercising of Stock Options/Warrants 2923000000 -2602000000 -2453000000 -2184000000 -1647000000


Other Financing Cash Flow 0
Cash and Cash Equivalents, End of Period 20945000000 23719000000 300000000 10000000 338000000000)
Change in Cash 25930000000 235000000000) 23630000000 26622000000 26465000000
Effect of Exchange Rate Changes 181000000000) -146000000000) -3175000000 300000000 6126000000
Cash and Cash Equivalents, Beginning of Period 2.3719E+13 2.363E+13 183000000 -143000000 210000000
Cash Flow Supplemental Section 2774000000) 89000000 266220000000000) 26465000000000) 20129000000000)
Change in Cash as Reported, Supplemental 13412000000 157000000 -2992000000 6336000000
Income Tax Paid, Supplemental 2774000000 89000000 2.2677E+15 -4990000000
Cash and Cash Equivalents, Beginning of Period

12 Months Ended
_________________________________________________________
Q4 2020 Q4  2019
Income Statement
USD in "000'"s
Repayments for Long Term Debt Dec. 31, 2020 Dec. 31, 2019
Costs and expenses:
Cost of revenues 182527 161857
Research and development
Sales and marketing 84732 71896
General and administrative 27573 26018
European Commission fines 17946 18464
Total costs and expenses 11052 9551
Income from operations 0 1697
Other income (expense), net 141303 127626
Income before income taxes 41224 34231
Provision for income taxes 6858000000 5394
Net income 22677000000 19289000000
*include interest paid, capital obligation, and underweighting 22677000000 19289000000
22677000000 19289000000
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)


For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see the seperate Instructions.

Returned for Signature
Date.                                                               2022-09-01

IRS RECIEVED













































































Wood.,  Zachry T.   S.R.O. Tax Period Total
Fed 941 Corporate 2007-09-30 66986.66
Fed 941 West Subsidiary 2007-09-30 17115.41
Fed 941 South Subsidiary 2007-09-30 23906.09
Fed 941 East Subsidiary 2007-09-30 11247.64
Fed 941 Corp - Penalty 2007-09-30 27198.5
Fed 940 Annual Unemp - Corp 2007-09-30 17028.05


ID: TxDL: 00037305581 Ssn: 633-44-1725
...

[Message clipped]  View entire message

ZACHRY WOOD <zachryiixixiiwood@gmail.com>
Wed, Nov 16, 3:09 AM (5 days ago)
to f, National.FOIAPortal, Carolyn, me

C&E 1049 Department of the Treasury --- Internal Revenue Service (99) OMB No.  1545-0074 IRS Use Only --- Do not write or staple in this space
1040  U.S. Individual Income Tax Return 
 FORM NUMBER: 1040 TAX PERIOD: Dec. 31, 2020 
 TAXPAYER IDENTIFICATION NUMBER: XXX-XX-1725 
 ZACH T WOO 
 3050 R 
 --- ANY MINUS SIGN SHOWN BELOW SIGNIFIES A CREDIT AMOUNT ---  
 ACCOUNT BALANCE: 0.00 
 ACCRUED INTEREST: 0.00 AS OF: Mar. 28, 2022  ACCRUED PENALTY: 0.00 AS OF: Mar. 28, 2022 
 ACCOUNT BALANCE 
 PLUS ACCRUALS 
 (this is not a 
payoff amount): 0.00 
 ** INFORMATION FROM THE RETURN OR AS ADJUSTED **  
 EXEMPTIONS: 00 
 FILING STATUS: Single 
 ADJUSTED GROSS 
 INCOME:  
 TAXABLE INCOME:  
 TAX PER RETURN:  
 SE TAXABLE INCOME 
 TAXPAYER:  
 SE TAXABLE INCOME 
 SPOUSE:  
 TOTAL SELF 
 EMPLOYMENT TAX:  
 RETURN NOT PRESENT FOR THIS ACCOUNT
 TRANSACTIONS  
 CODE EXPLANATION OF TRANSACTION CYCLE DATE AMOUNT  
 766 Tax relief credit 
Refund issued 09-01-2022 $290,938,239,071.00 
 290 Additional tax assessed 20220427 04-27-2022 $22,677,000,000,000.00  76254-999-05099-0 
 971 Notice issued  04-27-2022 $22,677,000,000,000.00  766 Tax relief credit 01-18-2021 -$600.00  846 Refund issued 01-06-2021 $600.00 
 290 Additional tax assessed 20205302 01-18-2021 $0.00  76254-999-05055-0 
 663 Estimated tax payment 01-05-2021 -$9,000,000.00  662 Removed estimated tax payment  04-27-2022 $22,677,000,000,000.00  740 Undelivered refund returned to IRS 01-18-2021 -$600.00 
 767 Reduced or removed tax relief  04-27-2022 $22,677,000,000,000.00 credit 
 971 Notice issued  04-27-2022 $22,677,000,000,000.00
 This Product Contains Sensitive Taxpayer Data 
Employee Number: 999999998 IRS No.:0000000000 
Description Amount 5/4/2022 - 6/4/2022
Payment Amount (Total) 9246754678763 Display All
1. Social Security (Employee + Employer) 26662
2. Medicare (Employee + Employer) 861193422444 Hourly
3. Federal Income Tax 8385561229657 00000
Note: This report is generated based on the payroll data for your reference only. Please contact IRS office for special cases such as late payment, previous overpayment, penalty and others.
Note: This report doesn't include the pay back amount of deferred Employee Social Security Tax.
Employer Customized Report
Cash and Cash Equivalents, Beginning of Period
Department of the Treasury
Internal Revenue Service
Q4 2020 Q4  2019
Calendar Year
Due: 04/18/2022
Dec. 31, 2020 Dec. 31, 2019
USD in "000'"s
Repayments for Long Term Debt 182527 161857
Costs and expenses:
Cost of revenues 84732 71896
Research and development 27573 26018
Sales and marketing 17946 18464
General and administrative 11052 09551
European Commission fines 00000 01697
Total costs and expenses 141303 127626
Income from operations 41224 34231
Other income (expense), net 6858000000 05394
Income before income taxes 22677000000 19289000000
Provision for income taxes 22677000000 19289000000
Net income                         22677000000 19289000000
20210418             76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000
Cat. No. 11320B   76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000
Form 1040 (2021) 76033000000 20642000000 18936000000
Reported Normalized and Operating Income/Expense Supplemental Section
Total Revenue as Reported, Supplemental 257637000000 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000 40499000000
Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000 9177000000
Reported Effective Tax Rate 00000 00000 00000 00000 00000 00000 00000 00000 00000
Reported Normalized Income 6836000000
Reported Normalized Operating Profit 7977000000
Other Adjustments to Net Income Available to Common Stockholders
Discontinued Operations
Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010
Basic EPS from Continuing Operations 00114 00031 00028 00028 00027 00022 00017 00010 00010 00015 00010
Basic EPS from Discontinued Operations
Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010
Diluted EPS from Continuing Operations 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010
Diluted EPS from Discontinued Operations
Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000
Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000
Reported Normalized Diluted EPS 00010
Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 00001
Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010
Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000
Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000
Fiscal year end September 28th., 2022. | USD










Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
*include interest paid, capital obligation, and underweighting

Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)







20210418
Rate Units Total YTD Taxes / Deductions Current YTD
70842745000 
70842745000 
Federal Withholding 00000 188813800
FICA - Social Security 00000 853700
FICA - Medicare 00000 11816700
Employer Taxes
FUTA 00000 00000
SUTA 00000 00000
EIN: 61-1767919 ID : 00037305581 SSN: 633441725
 ATAA Payments 00000 102600
Employeer :
   EmployerrIdentification Number (EIN) :XXXXX4661
  INTU
   2700     C
Employee :
  Employee's Social Security Number :XXX-XX-1725 Advice number:
  ZACH T WOO Pay date:_
  5222 B
Deposited to the account Of xxxxxxxx6547
PLEASE READ THE IMPORTANT DISCLOSURES BELOW
Based on facts as set forth in. 6550
The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect.  No opinion is expressed on any matters other than those specifically referred to above.
PNC Bank PNC Bank Business Tax I.D. Number: 633441725
CIF Department (Online Banking) Checking Account: 47-2041-6547
P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation
500 First Avenue ALPHABET
Pittsburgh, PA 15219-3128 5323 BRADFORD DR
NON-NEGOTIABLE DALLAS TX 75235 8313
ZACHRY, TYLER, WOOD
4/18/2022 650-2530-000 469-697-4300
SIGNATURE Time Zone: Eastern Central Mountain Pacific
Investment Products  • Not FDIC Insured  • No Bank Guarantee  • May Lose Value
NON-NEGOTIABLE




Taxable Marital Status:
Exemptions/Allowances Married ZACHRY T.
5323
Federal:
DALLAS
TX: NO State Income Tax
rate units year to date Other Benefits and Information  Pto Ba lance Total Work Hrs
EPS 112.2 674678000 75698871600
8/10 ACH Web Businessform Deluxeforbusiness 5072270 (00022222905832355.)
8/11 Corporate Ach Veryifyqbw Intuit (00022222909296656)
8/12 Corporate Ach Veryifyqbw Intuit (00022223912710109)


Service Charges and Fees
Reference
Date posted number
8/1 10 Service Charge Period Ending 07/29.2022
8/4 36 Returned ItemFee (nsf) 00022214903782823
8/11 36 Returned ItemFee (nsf) 00022222905832355
+Income Statement                                                                        
++USD in "000'"s                                                                        
++Repayments for Long Term Debt                        Dec. 31, 2020                        Dec. 31, 2019                        
++Costs and expenses:                                                                        
++Cost of revenues                        182527                        161857                        
++Research and development                                                                        
++Sales and marketing                        84732                        71896                        
++General and administrative                        27573                        26018                        
++European Commission fines                        17946                        18464                        
++Total costs and expenses                        11052                        9551                        
++Income from operations                        0                        1697                        
++Other income (expense), net                        141303                        127626                        
++Income before income taxes                        41224                        34231                        
++Provision for income taxes                        6858000000                        5394                        
++Net income                        22677000000                        19289000000                        
++*include interest paid, capital obligation, and underweighting                        22677000000                        19289000000                        
++                        22677000000                        19289000000                        
++Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)                                                                        
++Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)                                                                        
++                                                                        
++                                                                        
++For Paperwork Reduction Act Notice, see the seperate Instructions.
++
++diff --git a/bitore.sig b/bitore.sig
++new file mode 100644
++index 000000000000..25a17ef8e589
++--- /dev/null
+++++ b/bitore.sig
++@@ -0,0 +1,185 @@
+++
+++Internal Revenue Service
+++
+++Calendar Year
+++Due: 04/18/2022
+++
+++USD in ""000'""s
+++Repayments for Long Term Debt
+++Costs and expenses:
+++Cost of revenues
+++Research and development
+++Sales and marketing
+++General and administrative
+++European Commission fines
+++Total costs and expenses
+++Income from operations
+++Other income (expense), net
+++Income before income taxes
+++Provision for income taxes
+++net, ipaynclude interest paid, capital obligation, and underweighting
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
share of Class A and B common stock and Class C capital stock (in dollars par share)Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
ZACHRY T WOOD70842745000 XXX-XX-1725        
Exemptions/Allowances
Taxes / Deductions
Stub Number: 1                                                                                                                                                                             Employer Taxes
Net Pay                                                                                                                                                              

FUTA 00000 00000 70842745000 
SUTA 00000 00000                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            This period /   YTD                                                                                                                 
Federal Withholding 00000 00000
CHECK NO.                                                                                                               

FICA - Social Security 00000 08854
0210418                                                                                                                                               
     FICA - Medicare          00000 0000
Net Pay                                                                                                                                                     UTA 00000 00000 70842745000                                                                                                                                        SUTA 00000 00000                                                                                                                                      Monthly          70842745000 70842745000                                                                                            Federal Withholding 00000 00000                                        
                                                                                          ID:      txdl  00037305581      SSN:     xxx-xx-1725    DoB: 1994-10-15                                              Taxes / Deductions        
                                           this period                 year to date                                                                          TTM           YTD       Pay Schedule              Semi-Annual                                                                
                  Q3        7084274386600        7084274386600        Federal Withholding                                               00000  00000        
                  Q4        7084274386600        7084274386600        Social Security Withholding                           00000  00000        \                                                                                                                                 FICA - Social Security                      00000  08854        
                                                                                                                FICA - Medicare                                00000  00000  
                                                                                                                                                              FUTA


Hide original message
On Monday, November 21, 2022 at 02:43:11 PM CST, ALPHABET <zachryiixixiiwood@gmail.com> wrote:


DEPOSIT TICKET
Deposited to the account Of xxxxxxxx6547
Deposits and Other Additions                                                                                           Checks and Other Deductions Amount
Description Description I Items 5.41
ACH Additions Debit Card Purchases 1 15.19
POS Purchases 2 2,269,894.11
ACH Deductions 5 82
Service Charges and Fees 3 5.2
Other Deductions 1 2,270,001.91
Total Total 12


Daily Balance

Date Ledger balance Date Ledger balance Date Ledger balance
7/30 107.8 8/3 2,267,621.92- 8/8 41.2
8/1 78.08 8/4 42.08 8/10 2150.19-





Daily Balance continued on next page
Date
8/3 2,267,700.00 ACH Web Usataxpymt IRS 240461564036618 (0.00022214903782823)
8/8 Corporate ACH Acctverify Roll By ADP (00022217906234115)
8/10 ACH Web Businessform Deluxeforbusiness 5072270 (00022222905832355)
8/11 Corporate Ach Veryifyqbw Intuit (00022222909296656)
8/12 Corporate Ach Veryifyqbw Intuit (00022223912710109)


Service Charges and Fees
Reference
Date posted number
8/1 10 Service Charge Period Ending 07/29.2022
8/4 36 Returned ItemFee (nsf) (00022214903782823)
8/11 36 Returned ItemFee (nsf) (00022222905832355)







INCOME STATEMENT

INASDAQ:GOOG TTM Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020 Q3 2020 Q2 2020

Gross Profit 1.46698E+11 42337000000 37497000000 35653000000 31211000000 30818000000 25056000000 19744000000
Total Revenue as Reported, Supplemental 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000
2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000
Other Revenue
Cost of Revenue -1.10939E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000
Cost of Goods and Services -1.10939E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000
Operating Income/Expenses -67984000000 -20452000000 -16466000000 -16292000000 -14774000000 -15167000000 -13843000000 -13361000000
Selling, General and Administrative Expenses -36422000000 -11744000000 -8772000000 -8617000000 -7289000000 -8145000000 -6987000000 -6486000000
General and Administrative Expenses -13510000000 -4140000000 -3256000000 -3341000000 -2773000000 -2831000000 -2756000000 -2585000000
Selling and Marketing Expenses -22912000000 -7604000000 -5516000000 -5276000000 -4516000000 -5314000000 -4231000000 -3901000000
Research and Development Expenses -31562000000 -8708000000 -7694000000 -7675000000 -7485000000 -7022000000 -6856000000 -6875000000
Total Operating Profit/Loss 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000
Non-Operating Income/Expenses, Total 12020000000 2517000000 2033000000 2624000000 4846000000 3038000000 2146000000 1894000000
Total Net Finance Income/Expense 1153000000 261000000 310000000 313000000 269000000 333000000 412000000 420000000
Net Interest Income/Expense 1153000000 261000000 310000000 313000000 269000000 333000000 412000000 420000000

Interest Expense Net of Capitalized Interest -346000000 -117000000 -77000000 -76000000 -76000000 -53000000 -48000000 -13000000
Interest Income 1499000000 378000000 387000000 389000000 345000000 386000000 460000000 433000000
Net Investment Income 12364000000 2364000000 2207000000 2924000000 4869000000 3530000000 1957000000 1696000000
Gain/Loss on Investments and Other Financial Instruments 12270000000 2478000000 2158000000 2883000000 4751000000 3262000000 2015000000 1842000000
Income from Associates, Joint Ventures and Other Participating Interests 334000000 49000000 188000000 92000000 5000000 355000000 26000000 -54000000
Gain/Loss on Foreign Exchange -240000000 -163000000 -139000000 -51000000 113000000 -87000000 -84000000 -92000000
Irregular Income/Expenses 0 0 0 0 0
Other Irregular Income/Expenses 0 0 0 0 0
Other Income/Expense, Non-Operating -1497000000 -108000000 -484000000 -613000000 -292000000 -825000000 -223000000 -222000000
Pretax Income 90734000000 24402000000 23064000000 21985000000 21283000000 18689000000 13359000000 8277000000
Provision for Income Tax -14701000000 -3760000000 -4128000000 -3460000000 -3353000000 -3462000000 -2112000000 -1318000000
Net Income from Continuing Operations 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000
Net Income after Extraordinary Items and Discontinued Operations 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000
Net Income after Non-Controlling/Minority Interests 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000
Net Income Available to Common Stockholders 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000
Diluted Net Income Available to Common Stockholders 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000
Income Statement Supplemental Section
Reported Normalized and Operating Income/Expense Supplemental Section
Total Revenue as Reported, Supplemental 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000
Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000
Reported Effective Tax Rate 0.162 0.179 0.157 0.158 0.158 0.159
Reported Normalized Income
Reported Normalized Operating Profit
Other Adjustments to Net Income Available to Common Stockholders
Discontinued Operations
Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21
Basic EPS from Continuing Operations 113.88 31.12 28.44 27.69 26.63 22.46 16.55 10.21
Basic EPS from Discontinued Operations
Diluted EPS 112.2 30.69 27.99 27.26 26.29 22.3 16.4 10.13
Diluted EPS from Continuing Operations 112.2 30.67 27.99 27.26 26.29 22.23 16.4 10.13
Diluted EPS from Discontinued Operations
Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000
Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000
Reported Normalized Diluted EPS
Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21
Diluted EPS 112.2 30.69 27.99 27.26 26.29 22.3 16.4 10.13
Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000
Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000
Fiscal year end September 28th., 2022. | USD
Your federal taxable wages this period are $
ALPHABET INCOME Advice number:
1600 AMPIHTHEATRE  PARKWAY MOUNTAIN VIEW CA 94043 2.21169E+13




GOOGL_income-statement_Quarterly_As_Originally_Reported Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020
Cash Flow from Operating Activities, Indirect 24934000000 25539000000 37497000000 31211000000 30818000000
Net Cash Flow from Continuing Operating Activities, Indirect 24934000000 25539000000 21890000000 19289000000 22677000000
Cash Generated from Operating Activities 24934000000 25539000000 21890000000 19289000000 22677000000
Income/Loss before Non-Cash Adjustment 20642000000 18936000000 18525000000 17930000000 15227000000
Total Adjustments for Non-Cash Items 6517000000 3797000000 4236000000 2592000000 5748000000
Depreciation, Amortization and Depletion, Non-Cash Adjustment 3439000000 3304000000 2945000000 2753000000 3725000000
Depreciation and Amortization, Non-Cash Adjustment 3439000000 3304000000 2945000000 2753000000 3725000000
Depreciation, Non-Cash Adjustment 3215000000 3085000000 2730000000 2525000000 3539000000
Amortization, Non-Cash Adjustment 224000000 219000000 215000000 228000000 186000000
Stock-Based Compensation, Non-Cash Adjustment 3954000000 3874000000 3803000000 3745000000 3223000000
Taxes, Non-Cash Adjustment 1616000000 -1287000000 379000000 1100000000 1670000000
Investment Income/Loss, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000
Gain/Loss on Financial Instruments, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000
Other Non-Cash Items -14000000 64000000 -8000000 -255000000 392000000
Changes in Operating Capital -2225000000 2806000000 -871000000 -1233000000 1702000000
Change in Trade and Other Receivables -5819000000 -2409000000 -3661000000 2794000000 -5445000000
Change in Trade/Accounts Receivable -5819000000 -2409000000 -3661000000 2794000000 -5445000000
Change in Other Current Assets -399000000 -1255000000 -199000000 7000000 -738000000
Change in Payables and Accrued Expenses 6994000000 3157000000 4074000000 -4956000000 6938000000
Change in Trade and Other Payables 1157000000 238000000 -130000000 -982000000 963000000
Change in Trade/Accounts Payable 1157000000 238000000 -130000000 -982000000 963000000
Change in Accrued Expenses 5837000000 2919000000 4204000000 -3974000000 5975000000
Change in Deferred Assets/Liabilities 368000000 272000000 -3000000 137000000 207000000
Change in Other Operating Capital -3369000000 3041000000 -1082000000 785000000 740000000
Change in Prepayments and Deposits
Cash Flow from Investing Activities -11016000000 -10050000000 -9074000000 -5383000000 -7281000000
Cash Flow from Continuing Investing Activities -11016000000 -10050000000 -9074000000 -5383000000 -7281000000
Purchase/Sale and Disposal of Property, Plant and Equipment, Net -6383000000 -6819000000 -5496000000 -5942000000 -5479000000
Purchase of Property, Plant and Equipment -6383000000 -6819000000 -5496000000 -5942000000 -5479000000
Sale and Disposal of Property, Plant and Equipment
Purchase/Sale of Business, Net -385000000 -259000000 -308000000 -1666000000 -370000000
Purchase/Acquisition of Business -385000000 -259000000 -308000000 -1666000000 -370000000
Purchase/Sale of Investments, Net -4348000000 -3360000000 -3293000000 2195000000 -1375000000
Purchase of Investments -40860000000 -35153000000 -24949000000 -37072000000 -36955000000
Sale of Investments 36512000000 31793000000 21656000000 39267000000 35580000000
Other Investing Cash Flow 100000000 388000000 23000000 30000000 -57000000
Purchase/Sale of Other Non-Current Assets, Net
Sales of Other Non-Current Assets
Cash Flow from Financing Activities -16511000000 -15254000000 -15991000000 -13606000000 -9270000000
Cash Flow from Continuing Financing Activities -16511000000 -15254000000 -15991000000 -13606000000 -9270000000
Issuance of/Payments for Common Stock, Net -13473000000 -12610000000 -12796000000 -11395000000 -7904000000
Payments for Common Stock 13473000000 -12610000000 -12796000000 -11395000000 -7904000000
Proceeds from Issuance of Common Stock
Issuance of/Repayments for Debt, Net 115000000 -42000000 -1042000000 -37000000 -57000000
Issuance of/Repayments for Long Term Debt, Net 115000000 -42000000 -1042000000 -37000000 -57000000
Proceeds from Issuance of Long Term Debt 6250000000 6350000000 6699000000 900000000 0
Repayments for Long Term Debt 6365000000 -6392000000 -7741000000 -937000000 -57000000
Proceeds from Issuance/Exercising of Stock Options/Warrants 2923000000 -2602000000 -2453000000 -2184000000 -1647000000


Other Financing Cash Flow 0
Cash and Cash Equivalents, End of Period 20945000000 23719000000 300000000 10000000 338000000000)
Change in Cash 25930000000 235000000000) 23630000000 26622000000 26465000000
Effect of Exchange Rate Changes 181000000000) -146000000000) -3175000000 300000000 6126000000
Cash and Cash Equivalents, Beginning of Period 2.3719E+13 2.363E+13 183000000 -143000000 210000000
Cash Flow Supplemental Section 2774000000) 89000000 266220000000000) 26465000000000) 20129000000000)
Change in Cash as Reported, Supplemental 13412000000 157000000 -2992000000 6336000000
Income Tax Paid, Supplemental 2774000000 89000000 2.2677E+15 -4990000000
Cash and Cash Equivalents, Beginning of Period

12 Months Ended
_________________________________________________________
Q4 2020 Q4  2019
Income Statement
USD in "000'"s
Repayments for Long Term Debt Dec. 31, 2020 Dec. 31, 2019
Costs and expenses:
Cost of revenues 182527 161857
Research and development
Sales and marketing 84732 71896
General and administrative 27573 26018
European Commission fines 17946 18464
Total costs and expenses 11052 9551
Income from operations 0 1697
Other income (expense), net 141303 127626
Income before income taxes 41224 34231
Provision for income taxes 6858000000 5394
Net income 22677000000 19289000000
*include interest paid, capital obligation, and underweighting 22677000000 19289000000
22677000000 19289000000
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)


For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see the seperate Instructions.

Returned for Signature
Date.                                                               2022-09-01

IRS RECIEVED













































































Wood.,  Zachry T.   S.R.O. Tax Period Total
Fed 941 Corporate 2007-09-30 66986.66
Fed 941 West Subsidiary 2007-09-30 17115.41
Fed 941 South Subsidiary 2007-09-30 23906.09
Fed 941 East Subsidiary 2007-09-30 11247.64
Fed 941 Corp - Penalty 2007-09-30 27198.5
Fed 940 Annual Unemp - Corp 2007-09-30 17028.05


ID: TxDL: 00037305581 Ssn: 633-44-1725
...

[Message clipped]  View entire message

ZACHRY WOOD <zachryiixixiiwood@gmail.com>
Wed, Nov 16, 3:09 AM (5 days ago)


to f, National.FOIAPortal, Carolyn, me

C&E 1049 Department of the Treasury --- Internal Revenue Service (99) OMB No.  1545-0074 IRS Use Only --- Do not write or staple in this space
1040  U.S. Individual Income Tax Return 
 FORM NUMBER: 1040 TAX PERIOD: Dec. 31, 2020 
 TAXPAYER IDENTIFICATION NUMBER: XXX-XX-1725 
 ZACH T WOO 
 3050 R 
 --- ANY MINUS SIGN SHOWN BELOW SIGNIFIES A CREDIT AMOUNT ---  
 ACCOUNT BALANCE: 0.00 
 ACCRUED INTEREST: 0.00 AS OF: Mar. 28, 2022  ACCRUED PENALTY: 0.00 AS OF: Mar. 28, 2022 
 ACCOUNT BALANCE 
 PLUS ACCRUALS 
 (this is not a 
payoff amount): 0.00 
 ** INFORMATION FROM THE RETURN OR AS ADJUSTED **  
 EXEMPTIONS: 00 
 FILING STATUS: Single 
 ADJUSTED GROSS 
 INCOME:  
 TAXABLE INCOME:  
 TAX PER RETURN:  
 SE TAXABLE INCOME 
 TAXPAYER:  
 SE TAXABLE INCOME 
 SPOUSE:  
 TOTAL SELF 
 EMPLOYMENT TAX:  
 RETURN NOT PRESENT FOR THIS ACCOUNT
 TRANSACTIONS  
 CODE EXPLANATION OF TRANSACTION CYCLE DATE AMOUNT  
 766 Tax relief credit 
Refund issued 09-01-2022 $290,938,239,071.00 
 290 Additional tax assessed 20220427 04-27-2022 $22,677,000,000,000.00  76254-999-05099-0 
 971 Notice issued  04-27-2022 $22,677,000,000,000.00  766 Tax relief credit 01-18-2021 -$600.00  846 Refund issued 01-06-2021 $600.00 
 290 Additional tax assessed 20205302 01-18-2021 $0.00  76254-999-05055-0 
 663 Estimated tax payment 01-05-2021 -$9,000,000.00  662 Removed estimated tax payment  04-27-2022 $22,677,000,000,000.00  740 Undelivered refund returned to IRS 01-18-2021 -$600.00 
 767 Reduced or removed tax relief  04-27-2022 $22,677,000,000,000.00 credit 
 971 Notice issued  04-27-2022 $22,677,000,000,000.00
 This Product Contains Sensitive Taxpayer Data 
Employee Number: 999999998 IRS No.:0000000000 
Description Amount 5/4/2022 - 6/4/2022
Payment Amount (Total) 9246754678763 Display All
1. Social Security (Employee + Employer) 26662
2. Medicare (Employee + Employer) 861193422444 Hourly
3. Federal Income Tax 8385561229657 00000
Note: This report is generated based on the payroll data for your reference only. Please contact IRS office for special cases such as late payment, previous overpayment, penalty and others.
Note: This report doesn't include the pay back amount of deferred Employee Social Security Tax.
Employer Customized Report
Cash and Cash Equivalents, Beginning of Period
Department of the Treasury
Internal Revenue Service
Q4 2020 Q4  2019
Calendar Year
Due: 04/18/2022
Dec. 31, 2020 Dec. 31, 2019
USD in "000'"s
Repayments for Long Term Debt 182527 161857
Costs and expenses:
Cost of revenues 84732 71896
Research and development 27573 26018
Sales and marketing 17946 18464
General and administrative 11052 09551
European Commission fines 00000 01697
Total costs and expenses 141303 127626
Income from operations 41224 34231
Other income (expense), net 6858000000 05394
Income before income taxes 22677000000 19289000000
Provision for income taxes 22677000000 19289000000
Net income                         22677000000 19289000000
20210418             76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000
Cat. No. 11320B   76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000
Form 1040 (2021) 76033000000 20642000000 18936000000
Reported Normalized and Operating Income/Expense Supplemental Section
Total Revenue as Reported, Supplemental 257637000000 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000 40499000000
Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000 9177000000
Reported Effective Tax Rate 00000 00000 00000 00000 00000 00000 00000 00000 00000
Reported Normalized Income 6836000000
Reported Normalized Operating Profit 7977000000
Other Adjustments to Net Income Available to Common Stockholders
Discontinued Operations
Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010
Basic EPS from Continuing Operations 00114 00031 00028 00028 00027 00022 00017 00010 00010 00015 00010
Basic EPS from Discontinued Operations
Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010
Diluted EPS from Continuing Operations 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010
Diluted EPS from Discontinued Operations
Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000
Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000
Reported Normalized Diluted EPS 00010
Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 00001
Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010
Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000
Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000
Fiscal year end September 28th., 2022. | USD










Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
*include interest paid, capital obligation, and underweighting

Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)







20210418
Rate Units Total YTD Taxes / Deductions Current YTD
70842745000 
70842745000 
Federal Withholding 00000 188813800
FICA - Social Security 00000 853700
FICA - Medicare 00000 11816700
Employer Taxes
FUTA 00000 00000
SUTA 00000 00000
EIN: 61-1767919 ID : 00037305581 SSN: 633441725
 ATAA Payments 00000 102600
Employeer :
   EmployerrIdentification Number (EIN) :XXXXX4661
  INTU
   2700     C
Employee :
  Employee's Social Security Number :XXX-XX-1725 Advice number:
  ZACH T WOO Pay date:_
  5222 B
Deposited to the account Of xxxxxxxx6547
PLEASE READ THE IMPORTANT DISCLOSURES BELOW
Based on facts as set forth in. 6550
The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect.  No opinion is expressed on any matters other than those specifically referred to above.
PNC Bank PNC Bank Business Tax I.D. Number: 633441725
CIF Department (Online Banking) Checking Account: 47-2041-6547
P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation
500 First Avenue ALPHABET
Pittsburgh, PA 15219-3128 5323 BRADFORD DR
NON-NEGOTIABLE DALLAS TX 75235 8313
ZACHRY, TYLER, WOOD
4/18/2022 650-2530-000 469-697-4300
SIGNATURE Time Zone: Eastern Central Mountain Pacific
Investment Products  • Not FDIC Insured  • No Bank Guarantee  • May Lose Value
NON-NEGOTIABLE




Taxable Marital Status:
Exemptions/Allowances Married ZACHRY T.
5323
Federal:
DALLAS
TX: NO State Income Tax
rate units year to date Other Benefits and Information  Pto Ba lance Total Work Hrs
EPS 112.2 674678000 75698871600
8/10 ACH Web Businessform Deluxeforbusiness 5072270 (00022222905832355.)
8/11 Corporate Ach Veryifyqbw Intuit (00022222909296656)
8/12 Corporate Ach Veryifyqbw Intuit (00022223912710109)


Service Charges and Fees
Reference
Date posted number
8/1 10 Service Charge Period Ending 07/29.2022
8/4 36 Returned ItemFee (nsf) 00022214903782823
8/11 36 Returned ItemFee (nsf) 00022222905832355
+Income Statement									
++USD in "000'"s									
++Repayments for Long Term Debt			Dec. 31, 2020			Dec. 31, 2019			
++Costs and expenses:									
++Cost of revenues			182527			161857			
++Research and development									
++Sales and marketing			84732			71896			
++General and administrative			27573			26018			
++European Commission fines			17946			18464			
++Total costs and expenses			11052			9551			
++Income from operations			0			1697			
++Other income (expense), net			141303			127626			
++Income before income taxes			41224			34231			
++Provision for income taxes			6858000000			5394			
++Net income			22677000000			19289000000			
++*include interest paid, capital obligation, and underweighting			22677000000			19289000000			
++			22677000000			19289000000			
++Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)									
++Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)									
++									
++									
++For Paperwork Reduction Act Notice, see the seperate Instructions.
++
++diff --git a/bitore.sig b/bitore.sig
++new file mode 100644
++index 000000000000..25a17ef8e589
++--- /dev/null
+++++ b/bitore.sig
++@@ -0,0 +1,185 @@
+++
+++Internal Revenue Service
+++
+++Calendar Year
+++Due: 04/18/2022
+++
+++USD in ""000'""s
+++Repayments for Long Term Debt
+++Costs and expenses:
+++Cost of revenues
+++Research and development
+++Sales and marketing
+++General and administrative
+++European Commission fines
+++Total costs and expenses
+++Income from operations
+++Other income (expense), net
+++Income before income taxes
+++Provision for income taxes
+++net, ipaynclude interest paid, capital obligation, and underweighting
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
share of Class A and B common stock and Class C capital stock (in dollars par share)Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
ZACHRY T WOOD70842745000 XXX-XX-1725        
Exemptions/Allowances
Taxes / Deductions
Stub Number: 1                                                                                                                                                                             Employer Taxes
Net Pay                                                                                                                                                              

FUTA 00000 00000 70842745000 
SUTA 00000 00000                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            This period /   YTD                                                                                                                 
Federal Withholding 00000 00000
CHECK NO.                                                                                                               

FICA - Social Security 00000 08854
0210418                                                                                                                                               
     FICA - Medicare          00000 0000
Net Pay                                                                                                                                                     UTA 00000 00000 70842745000                                                                                                                                        SUTA 00000 00000                                                                                                                                      Monthly          70842745000 70842745000                                                                                            Federal Withholding 00000 00000                                        
                                                                                          ID:      txdl  00037305581      SSN:     xxx-xx-1725    DoB: 1994-10-15                                              Taxes / Deductions        
                                           this period                 year to date                                                                          TTM           YTD       Pay Schedule              Semi-Annual                                                                
                  Q3        7084274386600        7084274386600        Federal Withholding                                               00000  00000        
                  Q4        7084274386600        7084274386600        Social Security Withholding                           00000  00000        \                                                                                                                                 FICA - Social Security                      00000  08854        
                                                                                                                FICA - Medicare                                00000  00000  
                                                                                                                                                              FUTA       00000  00000    
    $$70842745000.00DOLLARS                                                                                                                          SUTA       00000  00000                                                                                                   ID:      txdl  00037305581      SSN:     xxx-xx-1725    DoB: 1994-10-15                                                                                                                                                                                                                                      
1-800-829-4933
++++3/6/2022 at 6:37 PMDec. 31, 2020 Dec. 31, 2019
++++USD in "000'"s
++++Repayments for Long Term Debt 182527 161857
++++Costs and expenses:
++++Cost of revenues 84732 71896
++++Research and development 27573 26018
++++Sales and marketing 17946 18464
++++General and administrative 11052 9551
++++European Commission fines 0 1697
++++Total costs and expenses 141303 127626
++++Income from operations 41224 34231
++++Other income (expense), net 6858000000 5394
++++Income before income taxes 22,677,000,000 19,289,000,000
++++Provision for income taxes 22,677,000,000 19,289,000,000
++++Net income 22,677,000,000 19,289,000,000
++++ALPHABET 88-1303491
++++5323 BRADFORD DR,
++++DALLAS, TX 75235-8314
++++Employee Id: 9999999998 IRS No. 000000000000
++++INTERNAL REVENUE SERVICE, $20,210,418.00
++++PO BOX 1214, Rate Units Total YTD Taxes / Deductions Current YTD
++++CHARLOTTE, NC 28201-1214 - - $70,842,745,000.00 $70,842,745,000.00 Federal Withholding $0.00 $0.00
++++Earnings FICA - Social Security $0.00 $8,853.60
++++Commissions FICA - Medicare $0.00 $0.00
++++FUTA $0.00 $0.00
++++SUTA $0.00 $0.00
++++EIN: 61-1767ID91:900037305581 SSN: 633441725
++++$70,842,745,000.00 $70,842,745,000.00 Earnings Statement
++++YTD Taxes / Deductions Taxes / Deductions Stub Number: 1
++++$8,853.60 $0.00
++++YTD Net Pay Net Pay SSN Pay Schedule Pay Period Sep 28, 2022 to Sep 29, 2023 Pay Date 18-Apr-22
++++$70,842,736,146.40 $70,842,745,000.00 XXX-XX-1725 Annually
++++INTERNAL REVENUE SERVICE,
++++PO BOX 1214,
++++CHARLOTTE, NC 28201-1214
++++00015  
++++                                       Name Tax Period Total Social Security Medicare Withholding
++++                                       Fed 941 Corporate 39355 66986.66 28841.48 6745.18 31400
++++                                       Fed 941 West Subsidiary 39355 17115.41 7369.14 1723.42 8022.85
++++                                       Fed 941 South Subsidiary 39355 23906.09 10292.9 2407.21 11205.98
++++                                       Fed 941 East Subsidiary 39355 11247.64 4842.74 1132.57 5272.33
++++                                       Fed 941 Corp - Penalty 39355 27198.5 11710.47 2738.73 12749.3
++++                                       Fed 940 Annual Unemp - Corp 39355 17028.05                                                                                                                                                  
++++                             
++++SIGNATURE Time Zone: Eastern Central Mountain Pacific
++++Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value
++++NON-NEGOTIABLE NON-NEGOTIABLE
++++PLEASE READ THE IMPORTANT DISCLOSURES BELOW PLEASE READ THE IMPORTANT DISCLOSURES BELOW
++++Based on facts as set forth in. Based on facts as set forth in. 6551 6550
++++The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive
+++ effect. No opinion is expressed on any matters other than those specifically referred to above. The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or 
+++used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++INTERNAL REVENUE SERVICE,
+++PO BOX 1214,
+++CHARLOTTE, NC 28201-1214
+++
+++ZACHRY WOOD
+++15
+++For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions.
+++Cat. No. 11320B
+++Form 1040 (2021)
+++Reported Normalized and Operating Income/Expense Supplemental Section
+++Total Revenue as Reported, Supplemental
+++Total Operating Profit/Loss as Reported, Supplemental
+++Reported Effective Tax Rate
+++Reported Normalized Income
+++Reported Normalized Operating Profit
+++Other Adjustments to Net Income Available to Common Stockholders
+++Discontinued Operations
+++Basic EPS
+++Basic EPS from Continuing Operations
+++Basic EPS from Discontinued Operations
+++Diluted EPS
+++Diluted EPS from Continuing Operations
+++Diluted EPS from Discontinued Operations
+++Basic Weighted Average Shares Outstanding
+++Diluted Weighted Average Shares Outstanding
+++Reported Normalized Diluted EPS
+++Basic EPS
+++DiluteDiluted WASO
+++d EPS
+++Basic WASO
+++Fiscal year end September 28th., 2022. | USD
+++
+++For Paperwork Reduction Act Notice, see the seperate Instructions.
+
 -7711	Department of the Treasury	Calendar Year							Period Ending	9/29/2021																	
 -	Internal Revenue Service	Due 04/18/2022		2022 Form 1040-ES Payment Voucher 1					Pay Day	1/30/2022																	
 -	MOUNTAIN VIEW, C.A., 94043																				
Income Statement									
USD in "000'"s									
Repayments for Long Term Debt			Dec. 31, 2020			Dec. 31, 2019			
Costs and expenses:									
Cost of revenues			182527			161857			
Research and development									
Sales and marketing			84732			71896			
General and administrative			27573			26018			
European Commission fines			17946			18464			
Total costs and expenses			11052			9551			
Income from operations			0			1697			
Other income (expense), net			141303			127626			
Income before income taxes			41224			34231			
Provision for income taxes			6858000000			5394			
Net income			22677000000			19289000000			
include interest paid, capital obligation, and underweighting			22677000000			19289000000			
			22677000000			19289000000			
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)									
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)									
Internal Revenue Service

+++Calendar Year
+++Due: 04/18/2022
+++
+++USD in ""000'""s
+++Repayments for Long Term Debt
+++Costs and expenses:
+++Cost of revenues
+++Research and development
+++Sales and marketing
+++General and administrative
+++European Commission fines
+++Total costs and expenses
+++Income from operations
+++Other income (expense), net
+++Income before income taxes
+++Provision for income taxes
+++Net income
+++*include interest paid, capital obligation, and underweighting
+++
+++Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
+++*include interest paid, capital obligation, and underweighting
+++
+++Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
+++Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
+++
+++).ZACHRY T WOOD
++++70842745000 XXX-XX-1725        
++++Exemptions/Allowances
++++Taxes / Deductions
++++Stub Number: 1                                                                                                                                                                             Employer Taxes
++++Net Pay                                                                                                                                                              FUTA 00000 00000 70842745000                                                                                                                                          SUTA 00000 00000                                                          This period /   YTD                                                                                                                                                                                                                                Pay Schedule 70842745000 70842745000                                                                                            Federal Withholding 00000 00000                                                                                           Monthly          70842745000 70842745000                                                                                            Federal Withholding 00000 00000                                                                                          TTM / YTD                                                                                                                                                                                                                                                    
++++Q3 70842745000 70842745000                                                                                                               Federal Withholding 00000 00000                                                                                                                        
++++Q4 70842745000 70842745000                                                                                                             Federal Withholding 00000 00000
++++CHECK NO.                                                                                                                                                  FICA - Social Security 00000 08854
++++20210418                                                                                                                                                  FICA - Medicare          00000 0000
++++Net Pay                                                                                                                                                            FUTA 00000 00000 70842745000                                                                                                                                        SUTA 00000 00000                                                          This period /   YTD                                                                                                                                                                                                                                Pay Schedule 70842745000 70842745000                                                                                            Federal Withholding 00000 00000                                                                                           Monthly          70842745000 70842745000                                                                                            Federal Withholding 00000 00000                                        
++++                                                                                           ID:      txdl  00037305581      SSN:     xxx-xx-1725    DoB: 1994-10-15                            
++++                  Taxes / Deductions        
++++                                           this period                 year to date                                                                          TTM           YTD       Pay Schedule              Semi-Annual                                                                
++++                  Q3        7084274386600        7084274386600        Federal Withholding                        00000  00000        
++++                  Q4        7084274386600        7084274386600        Social Security Withholding          00000  00000        
++++                                                                                                                FICA - Social Security                      00000  08854        
++++                                                                                                                FICA - Medicare                                00000  00000  
++++                                                                                                                                                              FUTA       00000  00000        
++++        70842745000                                                                                                                          SUTA       00000  00000        
++++                                                                                           ID:      txdl  00037305581      SSN:     xxx-xx-1725    DoB: 1994-10-15                                                                                                                                                                                                                                      
++++1-800-829-4933
++++3/6/2022 at 6:37 PM
++++Dec. 31, 2020 Dec. 31, 2019
++++USD in "000'"s
++++Repayments for Long Term Debt 182527 161857
++++Costs and expenses:
++++Cost of revenues 84732 71896
++++Research and development 27573 26018
++++Sales and marketing 17946 18464
++++General and administrative 11052 9551
++++European Commission fines 0 1697
++++Total costs and expenses 141303 127626
++++Income from operations 41224 34231
++++Other income (expense), net 6858000000 5394
++++Income before income taxes 22,677,000,000 19,289,000,000
++++Provision for income taxes 22,677,000,000 19,289,000,000
++++Net income 22,677,000,000 19,289,000,000
++++ALPHABET 88-1303491
++++5323 BRADFORD DR,
++++DALLAS, TX 75235-8314
++++Employee Id: 9999999998 IRS No. 000000000000
++++INTERNAL REVENUE SERVICE, $20,210,418.00
++++PO BOX 1214, Rate Units Total YTD Taxes / Deductions Current YTD
++++CHARLOTTE, NC 28201-1214 - - $70,842,745,000.00 $70,842,745,000.00 Federal Withholding $0.00 $0.00
++++Earnings FICA - Social Security $0.00 $8,853.60
++++Commissions FICA - Medicare $0.00 $0.00
++++FUTA $0.00 $0.00
++++SUTA $0.00 $0.00
++++EIN: 61-1767ID91:900037305581 SSN: 633441725
++++$70,842,745,000.00 $70,842,745,000.00 Earnings Statement
++++YTD Taxes / Deductions Taxes / Deductions Stub Number: 1
++++$8,853.60 $0.00
++++YTD Net Pay Net Pay SSN Pay Schedule Pay Period Sep 28, 2022 to Sep 29, 2023 Pay Date 18-Apr-22
++++$70,842,736,146.40 $70,842,745,000.00 XXX-XX-1725 Annually
++++INTERNAL REVENUE SERVICE,
++++PO BOX 1214,
++++CHARLOTTE, NC 28201-1214
++++00015  
++++                                       Name Tax Period Total Social Security Medicare Withholding
++++                                       Fed 941 Corporate 39355 66986.66 28841.48 6745.18 31400
++++                                       Fed 941 West Subsidiary 39355 17115.41 7369.14 1723.42 8022.85
++++                                       Fed 941 South Subsidiary 39355 23906.09 10292.9 2407.21 11205.98
++++                                       Fed 941 East Subsidiary 39355 11247.64 4842.74 1132.57 5272.33
++++                                       Fed 941 Corp - Penalty 39355 27198.5 11710.47 2738.73 12749.3
++++                                       Fed 940 Annual Unemp - Corp 39355 17028.05                                                                                                                                                  
++++                             
++++SIGNATURE Time Zone: Eastern Central Mountain Pacific
++++Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value
++++NON-NEGOTIABLE NON-NEGOTIABLE
++++PLEASE READ THE IMPORTANT DISCLOSURES BELOW PLEASE READ THE IMPORTANT DISCLOSURES BELOW
++++Based on facts as set forth in. Based on facts as set forth in. 6551 6550
++++The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive
+++ effect. No opinion is expressed on any matters other than those specifically referred to above. The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or 
+++used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++
+++INTERNAL REVENUE SERVICE,
+++PO BOX 1214,
+++CHARLOTTE, NC 28201-1214
+++
+++ZACHRY WOOD
+++15
+++For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions.
+++Cat. No. 11320B
+++Form 1040 (2021)
+++Reported Normalized and Operating Income/Expense Supplemental Section
+++Total Revenue as Reported, Supplemental
+++Total Operating Profit/Loss as Reported, Supplemental
+++Reported Effective Tax Rate
+++Reported Normalized Income
+++Reported Normalized Operating Profit
+++Other Adjustments to Net Income Available to Common Stockholders
+++Discontinued Operations
+++Basic EPS
+++Basic EPS from Continuing Operations
+++Basic EPS from Discontinued Operations
+++Diluted EPS
+++Diluted EPS from Continuing Operations
+++Diluted EPS from Discontinued Operations
+++Basic Weighted Average Shares Outstanding
+++Diluted Weighted Average Shares Outstanding
+++Reported Normalized Diluted EPS
+++Basic EPS
+++DiluteDiluted WASO
+++d EPS
+++Basic WASO
+++Fiscal year end September 28th., 2022. | USD
+++
+++For Paperwork Reduction Act Notice, see the seperate Instructions.
+
 -7711	Department of the Treasury	Calendar Year							Period Ending	9/29/2021																	
 -	Internal Revenue Service	Due 04/18/2022		2022 Form 1040-ES Payment Voucher 1					Pay Day	1/30/2022																	 
 -	MOUNTAIN VIEW, C.A., 94043																				Repayments for Long Term Debt Dec. 31, 2020 Dec. 31, 2019
Costs and expenses:
Cost of revenues 182527 161857
Research and development
Sales and marketing 84732 71896
General and administrative 27573 26018
European Commission fines 17946 18464
Total costs and expenses 11052 9551
Income from operations 0 1697
Other income (expense), net 141303 127626
Income before income taxes 41224 34231
Provision for income taxes 6858000000 5394
Net income 22677000000 19289000000
*include interest paid, capital obligation, and underweighting 22677000000 19289000000
22677000000 19289000000
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)


For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see the seperate Instructions.

Returned for Signature
Date.                                                               2022-09-01

IRS RECIEVED















































































<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>View Filing Data</title><script type="text/javascript" src="/include/jquery-1.4.3.min.js"></script><script type="text/javascript" src="/include/accordionMenu.js"></script><script type="text/javascript" src="/include/Show.js"></script><link rel="stylesheet" type="text/css" href="/include/interactive.css" /><link rel="stylesheet" type="text/css" href="/include/report.css" /><link rel="stylesheet" type="text/css" href="/include/print.css" media="print" /><link rel="stylesheet" type="text/css" href="/include/xbrlViewerStyle.css" /><style type="text/css">li.octave {border-top: 1px solid black;}</style><!--[if lt IE 8]><style type="text/css">li.accordion a {display:inline-block;}li.accordion a {display:block;}</style><![endif]--></head><body style="margin: 0"><noscript><div style="color:red; font-weight:bold; text-align:center;">This page uses Javascript. Your browser either doesn't support Javascript or you have it turned off. To see this page as it is meant to appear please use a Javascript enabled browser.</div></noscript><!-- BEGIN BANNER --><div id="headerTop"> <div id="Nav"><a href="/index.htm">Home</a> | <a href="/cgi-bin/browse-edgar?action=getcurrent">Latest Filings</a> | <a href="javascript:history.back()">Previous Page</a></div> <div id="seal"><a href="http://www.sec.gov/index.htm"><img src="/images/sealTop.gif" alt="SEC Seal" border="0" /></a></div> <div id="secWordGraphic"><img src="/images/bannerTitle.gif" alt="SEC Banner" /></div></div><div id="headerBottom"> <div id="searchHome"><a href="/edgar/searchedgar/webusers.htm">Search the Next-Generation EDGAR System</a></div> <div id="PageTitle">View Filing Data</div></div><!-- END BANNER --><!-- BEGIN BREADCRUMBS --><div id="breadCrumbs"> <ul> <li><a href="/">SEC Home</a> &#187;</li> <li><a href="/edgar/searchedgar/webusers.htm">Search the Next-Generation EDGAR System</a> &#187;</li> <li><a href="/edgar/searchedgar/companysearch.html">Company Search</a> &#187;</li> <li class="last">Current Page</li> </ul></div><!-- END BREADCRUMBS --><div style="margin-top: 15px; margin: 15px 20px 10px 20px; color: red; text-align: center;"> <p>Invalid parameter.</p></div><!-- END FOOTER DIV --><div id="footer"> <div class="currentURL">https://www.sec.gov/cgi-bin/viewer</div> <div class="links"><a href="/index.htm">Home</a> | <a href="/edgar/searchedgar/webusers.htm">Search the Next-Generation EDGAR System</a> | <a href="javascript:history.back()">Previous Page</a></div> <div class="modified">Modified 02/20/2019</div></div><!-- END FOOTER DIV --></body></html>

INTERNAL REVENUE SERVICE, 
PO BOX 1214, +CHARLOTTE, NC 28201-1214

3. Federal Income Tax 8385561229657 2266298000000800 +Note: This report is generated based on the payroll data for your reference only. Please contact IRS office for special cases such as late payment. Previous overpayment. +Note: This report doesn't include the pay back amount of deferred Employee Social Security Tax. +Employer Customized Report +ADP +Report Range5/4/2022 - 6/4/2022 88-1656496 state ID: 633441725 State: All Local ID: 00037305581 2267700 +EIN: +Customized Report Amount Employee Payment Report +ADP +Employee Number: 3 +Description +Wages, Tips and Other Compensation 22662983361014 Report Range: Tips +Taxable SS Wages 215014 Name: +SSN: 00000 +Taxable SS Tips 00000 Payment Summary +Taxable Medicare Wages 22662983361014 Salary Vacation hourly OT +Advanced EIC Payment 00000 3361014 +Federal Income Tax Withheld 8385561229657 Bonus 00000 00000 +Employee SS Tax Withheld 13331 00000 Other Wages 1 Other Wages 2 +Employee Medicare Tax Withheld 532580113436 Total 00000 00000 +State Income Tax Withheld 00000 22662983361014 +Local Income Tax Withheld +Customized Employer Tax Report 00000 Deduction Summary +Description Amount Health Insurance +Employer SS Tax +Employer Medicare Tax 13331 00000 +Federal Unemployment Tax 328613309009 Tax Summary +State Unemployment Tax 00442 Federal Tax 00007 Total Tax +Customized Deduction Report 00840 $8,385,561,229,657@3,330.90 Local Tax +Health Insurance 00000 +401K 00000 Advanced EIC Payment 8918141356423

00000 00000 Total 401K 00000 00000 +ZACHRY T WOOD Social Security Tax Medicare Tax State Tax 532580113050 + + +SHAREHOLDERS ARE URGED TO READ THE DEFINITIVE PROXY STATEMENT AND ANY OTHER RELEVANT MATERIALS THAT THE COMPANY WILL FILE WITH THE SEC CAREFULLY IN THEIR ENTIRETY WHEN THEY BECOME AVAILABLE. SUCH DOCUMENTS WILL CONTAIN IMPORTANT INFORMATION ABOUT THE COMPANY AND ITS DIRECTORS, OFFICERS AND AFFILIATES. INFORMATION REGARDING THE INTERESTS OF CERTAIN OF THE COMPANY’S DIRECTORS, OFFICERS AND AFFILIATES WILL BE AVAILABLE IN THE DEFINITIVE PROXY STATEMENT. +The Definitive Proxy Statement and any other relevant materials that will be filed with the SEC will be available free of charge at the SEC’s website at www.sec.gov. In addition, the Definitive Proxy Statement (when available) and other relevant documents will also be available, without charge, by directing a request by mail to Attn: Investor Relations, Alphabet Inc., 1600 Amphitheatre Parkway, Mountain View, California, 94043 or by contacting investor-relations@abc.xyz. The Definitive Proxy Statement and other relevant documents will also be available on the Company’s Investor Relations website at https://abc.xyz/investor/other/annual-meeting/. + +The Company and its directors and certain of its executive officers may be consideredno participants in the solicitation of proxies with respect to the proposals under the Definitive Proxy Statement under the rules of the SEC. Additional information regarding the participants in the proxy solicitations and a description of their direct and indirect interests, by security holdings or otherwise, also will be included in the Definitive Proxy Statement and other relevant materials to be filed with the SEC when they become available. . 9246754678763 + + + + +3/6/2022 at 6:37 PM


			70842745000	XXX-XX-1725	Earnings Statement		FICA - Social Security	00000	08854	 			Taxes / Deductions		Stub Number: 1		FICA - Medicare	00000	00000	 			00000	Rate			Employer Taxes			 			Net Pay				FUTA	00000	00000	 			70842745000				SUTA	00000	00000	 					This period	YTD	Taxes / Deductions	Current	YTD	 				Pay Schedulec	70842745000	70842745000	Federal Withholding	00000	00000	 				Annually	70842745000	70842745000	Federal Withholding	00000	00000	 				Units	Q1	TTM	Taxes / Deductions	Current	YTD	 				Q3	70842745000	70842745000	Federal Withholding	00000	00000	 				Q4	70842745000	70842745000	Federal Withholding	00000	00000	 				CHECK NO.-E7S00000029		FICA - Social Security	00000	08854	 -				20210418			FICA - Medicare	00000	00000	 -										 			-							 			-							 

+INTERNAL REVENUE SERVICE, +PO BOX 1214, +CHARLOTTE, NC 28201-1214 + +ZACHRY WOOD +00015 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000 +For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000 +Cat. No. 11320B 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000 +Form 1040 (2021) 76033000000 20642000000 18936000000 +Reported Normalized and Operating Income/Expense Supplemental Section +Total Revenue as Reported, Supplemental 257637000000 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000 40499000000 +Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000 9177000000 +Reported Effective Tax Rate 00000 00000 00000 00000 00000 00000 00000 00000 +Reported Normalized Income 6836000000 +Reported Normalized Operating Profit 7977000000 +Other Adjustments to Net Income Available to Common Stockholders +Discontinued Operations +Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 +Basic EPS from Continuing Operations 00114 00031 00028 00028 00027 00022 00017 00010 00010 00015 00010 +Basic EPS from Discontinued Operations +Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010 +Diluted EPS from Continuing Operations 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010 +Diluted EPS from Discontinued Operations +Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000 +Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000 +Reported Normalized Diluted EPS 00010 +Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 +Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010 +Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000 +Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000 +Fiscal year end September 28th., 2022. | USD + +
For Actotice,  Instructions. Business Checking +For 24-hour account information, sign on to +pnc.com/mybusiness/ +ColBusiness Checking Account number: 47-2041-6547 - continued +Activity Detail +Deposits and Other Additions +ACH Additions +Date posted Amount Transaction description For the period 04/13/2022 to 04/29/2022 +ZACHRY TYLER WOOD +Primary account number: 47-2041-6547 Page 2 of 3 +44678 00063 Reverse Corporate ACH Debit +Effective 04-26-22 Reference number +Checks and Other Deductions 22116905560149 +Deductions Reference number +Date posted Amount Transaction description 22116905560149 +44677 00063 Corporate ACH Quickbooks 180041ntuit 1940868 Reference number +Service Charges and Fees 22116905560149 +Date posted Amount Transaction description on your next statement as a single line item entitled Service +Waived - New Customer Period +4/27/2022 00036 Returned Item Fee (nsf) +Detail of Services Used During Current Period +Note: The total charge for the following services will be posted to your account on 05/02/2022 and will appear on your next statement a Charge Period Ending 04/29/2022, +
Description Volume Amount +Account Maintenance Charge net, pay. 00004 70846743866 000+Total For Services Used This Peiod 00000 00000 +Total Service Charge 0000 0000 +Reviewing Your Statement ('PNCBANK +Please review this statement carefully anu d nreconcile it with your records. Call the telephone number on the upper right side of the first page of this statement if: +you have any questions regarding your account(s); your name or address is incorrect; +• you have any questions regarding interest paid to an interest-bearing account. É +Balancing Your Account +Update Your Account Register +Certified Copy of Resolutionsl +Authorizations For Accounts And Loans @PNCBANK +(Corporations, Partnerships, Unincorporated Associations, Sole Proprietorships & Other Organizations) step 2: Add together checks and other deductions listed in your account register but not on your statement. +PNC Bank, National Association ("Bank") Taxpayer I.D. Number (TIN) C'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>View Filing Data</title><script type="text/javascript" src="/include/jquery-1.4.3.min.js"></script><script type="text/javascript" src="/include/accordionMenu.js"></script><script type="text/javascript" src="/include/Show.js"></script><link rel="stylesheet" type="text/css" href="/include/interactive.css" /><link rel="stylesheet" type="text/css" href="/include/report.css" /><link rel="stylesheet" type="text/css" href="/include/print.css" media="print" /><link rel="stylesheet" type="text/css" href="/include/xbrlViewerStyle.css" /><style type="text/css">li.octave {border-top: 1px solid black;}</style><!--[if lt IE 8]><style type="text/css">li.accordion a {display:inline-block;}li.accordion a {display:block;}</style><![endif]--></head><body style="margin: 0"><noscript><div style="color:red; font-weight:bold; text-align:center;">This page uses Javascript. Your browser either doesn't support Javascript or you have it turned off. To see this page as it is meant to appear please use a Javascript enabled browser.</div></noscript><!-- BEGIN BANNER --><div id="headerTop"> <div id="Nav"><a href="/index.htm">Home</a> | <a href="/cgi-bin/browse-edgar?action=getcurrent">Latest Filings</a> | <a href="javascript:history.back()">Previous Page</a></div> <div id="seal"><a href="http://www.sec.gov/index.htm"><img src="/images/sealTop.gif" alt="SEC Seal" border="0" /></a></div> <div id="secWordGraphic"><img src="/images/bannerTitle.gif" alt="SEC Banner" /></div></div><div id="headerBottom"> <div id="searchHome"><a href="/edgar/searchedgar/webusers.htm">Search the Next-Generation EDGAR System</a></div> <div id="PageTitle">View Filing Data</div></div><!-- END BANNER --><!-- BEGIN BREADCRUMBS --><div id="breadCrumbs"> <ul> <li><a href="/">SEC Home</a> &#187;</li> <li><a href="/edgar/searchedgar/webusers.htm">Search the Next-Generation EDGAR System</a> &#187;</li> <li><a href="/edgar/searchedgar/companysearch.html">Company Search</a> &#187;</li> <li class="last">Current Page</li> </ul></div><!-- END BREADCRUMBS --><div style="margin-top: 15px; margin: 15px 20px 10px 20px; color: red; text-align: center;"> <p>Invalid parameter.</p></div><!-- END FOOTER DIV --><div id="footer"> <div class="currentURL">View Filing Data</div> <div class="links"><a href="/index.htm">Home</a> | <a href="/edgar/searchedgar/webusers.htm">Search the Next-Generation EDGAR System</a> | <a href="javascript:history.back()">Previous Page</a></div> <div class="modified">Modified 02/20/2019</div></div><!-- END FOOTER DIV --></body></html>

S-8 1 a20220726alphabets-8for202.htm S-8





                                Registration No. 333-


UNITED STATES

SECURITIES AND EXCHANGE COMMISSION

Washington, D.C. 20549



FORM S-8

REGISTRATION STATEMENT UNDER THE SECURITIES ACT OF 1933



Alphabet Inc.

(Exact Name of Registrant as Specified in Its Charter) 



Delaware 61-1767919

(State of Incorporation)



(I.R.S. Employer Identification No.)

1600 Amphitheatre Parkway

Mountain View, CA 94043

(650) 253-0000

(Address, including zip code, and telephone number, including area code, of Registrant’s principal executive offices) 



Alphabet Inc. Amended and Restated 2021 Stock Plan

(Full Title of the Plan)


</style> <script src="[../scripts/third_party/webcomponentsjs/webcomponents-lite.min.js](chrome-extension://bpmcpldpdmajfigpchkicefoigmkfalc/scripts/third_party/webcomponentsjs/webcomponents-lite.min.js)"></script> <script src="[../scripts/configs/requirejsConfig.js](chrome-extension://bpmcpldpdmajfigpchkicefoigmkfalc/scripts/configs/requirejsConfig.js)"></script> <script data-main="../scripts/mainApp" src="[../scripts/third_party/requireJs/require.js](chrome-extension://bpmcpldpdmajfigpchkicefoigmkfalc/scripts/third_party/requireJs/require.js)"></script>

+<iframe id="sandbox" name="sandbox" allowfullscreen="true" sandbox="allow-scripts allow-modals allow-same-origin allow-popups" src="[qowt.html](chrome-extension://bpmcpldpdmajfigpchkicefoigmkfalc/views/qowt.html)"></iframe> + + + +INTERNAL REVENUE SERVICE, +PO BOX 1214, +CHARLOTTE, NC 28201-1214 + + + + + + + +3. Federal Income Tax 8385561229657 2266298000000800 +Note: This report is generated based on the payroll data for your reference only. Please contact IRS office for special cases such as late payment. Previous overpayment. +Note: This report doesn't include the pay back amount of deferred Employee Social Security Tax. +Employer Customized Report +ADP +Report Range5/4/2022

View Filing Data



View Filing Data



z









Department of the Treasury

Internal Revenue Service

Q4 2020 Q4  2019

Calendar Year

Due: 04/18/2022

Dec. 31, 2020 Dec. 31, 2019

USD in "000'"s

Repayments for Long Term Debt 182527 161857

Costs and expenses:

Cost of revenues 84732 71896

Research and development 27573 26018

Sales and marketing 17946 18464

General and administrative 11052 09551

European Commission fines 00000 01697

Total costs and expenses 141303 127626

Income from operations 41224 34231

Other income (expense), net 6858000000 05394

Income before income taxes 22677000000 19289000000

Provision for income taxes 22677000000 19289000000

Net income 22677000000 19289000000

*include interest paid, capital obligation, and underweighting

C&E 1049 Department of the Treasury --- Internal Revenue Service (99) OMB No. 1545-0074 IRS Use Only --- Do not write or staple in this space

1040 U.S. Individual Income Tax Return 1 Earnings Statement

ALPHABET Period Beginning:2019-09-28

1600 AMPITHEATRE PARKWAY DR Period Ending: 2021-09-29

MOUNTAIN VIEW, C.A., 94043 Pay Day: 2022-01-31

Taxable Marital Status:

Exemptions/Allowances Married ZACHRY T.

5323

Federal:

DALLAS

TX: NO State Income Tax


rate units year to date Other Benefits and

EPS 112.2 674678000 75698871600 InformationPto BalanceTotal Work Hrs

Gross Pay 75698871600Important Notes

COMPANY PH Y: 650-253-0000

Statutory BASIS OF PAY: BASIC/DILUTED EPS

Federal Income Tax

Social Security Tax

YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 112.20 PAR SHARE VALUE

Medicare Tax

Net Pay 70842743866 70842743866

CHECKING

Net Check 70842743866

Your federal taxable wages this period are $

ALPHABET INCOME CHECK NO.

1600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 222129

DEPOSIT TICKET

Deposited to the account Of xxxxxxxx6547

Deposits and Other Additions Checks and Other Deductions Amount

Description Description I Items 5.41

ACH Additions Debit Card Purchases 1 15.19

POS Purchases 2 2,269,894.11

ACH Deductions 5 82

Service Charges and Fees 3 5.2

Other Deductions 1 2,270,001.91

Total Total 12

Daily Balance

Date Ledger balance Date Ledger balance Date Ledger balance

7/30 107.8 8/3 2,267,621.92- 8/8 41.2

8/1 78.08 8/4 42.08 8/10 2150.19-

Daily Balance continued on next page

Date

8/3 2,267,700.00 ACH Web Usataxpymt IRS 240461564036618 (0.00022214903782823)

8/8 Corporate ACH Acctverify Roll By ADP (00022217906234115)

8/10 ACH Web Businessform Deluxeforbusiness 5072270 (00022222905832355)

8/11 Corporate Ach Veryifyqbw Intuit (00022222909296656)

8/12 Corporate Ach Veryifyqbw Intuit (00022223912710109)

Service Charges and Fees

Reference

Date posted number

8/1 10 Service Charge Period Ending 07/29.2022

8/4 36 Returned ItemFee (nsf) (00022214903782823)

8/11 36 Returned ItemFee (nsf) (00022222905832355)

Reported Normalized Income

Reported Normalized Operating Profit

Other Adjustments to Net Income Available to Common Stockholders

Discontinued Operations

Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21

Basic EPS from Continuing Operations 113.88 31.12 28.44 27.69 26.63 22.46 16.55 10.21

Basic EPS from Discontinued Operations

Diluted EPS 112.2 30.69 27.99 27.26 26.29 22.3 16.4 10.13

Diluted EPS from Continuing Operations 112.2 30.67 27.99 27.26 26.29 22.23 16.4 10.13

Diluted EPS from Discontinued Operations

Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000

Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000

Reported Normalized Diluted EPS

Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21

Diluted EPS 112.2 30.69 27.99 27.26 26.29 22.3 16.4 10.13
Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000


Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000
Fiscal year end September 28th., 2022. | USD

Cash and Cash Equivalents, Beginning of Period

12 Months Ended

Q4 2020 Q4 2019

Income Statement


USD in "000'"s

Repayments for Long Term Debt Dec. 31, 2020 Dec. 31, 2019

Costs and expenses:

Cost of revenues 182527 161857


Research and development

Sales and marketing 84732 71896

General and administrative 27573 26018


European Commission fines 17946 18464

Total costs and expenses 11052 9551

Income from operations 0 1697

Other income (expense), net 141303 127626

Income before income taxes 41224 34231

Provision for income taxes 6858000000 5394

Net income 22677000000 19289000000

*include interest paid, capital obligation, and underweighting 22677000000 19289000000

22677000000 19289000000

Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)

Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)

For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see the seperate Instructions.

Returned for Signature

Date. 2022-09-01

IRS RECIEVED

Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)

Cover Page - USD ($) $ in Billions 12 Months Ended

Jan. 26, 2021 Jun. 30, 2020 Dec. 31, 2020

Document Information [Line Items]

Document Type 10-K

Document Annual Report true

Document Period End Date Dec. 31,

2020

Document Transition Report false
Entity File Number 001-37580

Entity Registrant Name Alphabet Inc.

Entity Central Index Key 0001652044

Current Fiscal Year End Date --12-31

Document Fiscal Year Focus 2020

Document Fiscal Period Focus FY

Amendment Flag false

Entity Incorporation, State or Country Code DE

Entity Tax Identification Number 61-1767919

Entity Address, Address Line One 1600 Amphitheatre Parkway

Entity Address, City or Town Mountain View

Entity Address, State or Province CA

Entity Address, Postal Zip Code 94043
City Area Code 650

Local Phone Number 253-000

Entity Well-known Seasoned Issuer Yes

Entity Voluntary Filers No

Entity Current Reporting Status Yes

Entity Interactive Data Current Yes

Entity Filer Category Large Accelerated Filer

Entity Small Business false

Entity Emerging Growth Company false

ICFR Auditor Attestation Flag true

Entity Shell Company false

Entity Public Float $ 849.7

Documents Incorporated by Reference DOCUMENTS INCORPORATED BY REFERENCE Portions of the registrant’s Proxy Statement for the 2021 Annual Meeting of 

Stockholders are incorporated herein by reference in Part III of this Annual Report on Form 10-K to the extent stated herein. Such proxy statement will be 

filed with the Securities and Exchange Commission within 120 days of the registrant’s fiscal year ended December 31, 2020.



Class A Common Stock



Document Information [Line Items]



Title of 12(b) Security Class A Common Stock, $2583.86 par value


Trading Symbol GOOGL



Security Exchange Name NASDAQ

Entity Common Stock, Shares Outstanding 300,737,081

Class B Common Stock

Document Information [Line Items]

Entity Common Stock, Shares Outstanding 45,843,112

Class C Capital Stock

Document Information [Line Items]

Title of 12(b) Security Class C Capital Stock, $2586.83 par value

Trading Symbol GOOG

Security Exchange Name NASDAQ

Entity Common Stock, Shares Outstanding 327,556,472 April 18, 2022. WOOD ZACHRY Tax Period Total Social Security Medicare Withholding Fed 941 Corporate 

39355 66986.66 28841.48 6745.18 31400

Fed 941 West Subsidiary 39355 17115.41 7369.14 1723.42 8022.85

Fed 941 South Subsidiary 39355 23906.09 10292.9 2407.21 11205.98

Fed 941 East Subsidiary 39355 11247.64 4842.74 1132.57 5272.33

Fed 941 Corp - Penalty 39355 27198.5 11710.47 2738.73 12749.3

Fed 940 Annual Unemp - Corp 39355 17028.05

Pay Date: 4/24/22

6b 633441725

7 ZACHRY T WOOD Tax Period Total Social Security Medicare Withholding

Capital gain or (loss). Attach Schedule D if required. If not required, check here ....▶

++Fed 941 Corporate 39355 66986.66 28841.48 6745.18 31400

7 Fed 941 West Subsidiary 39355 17115.41 7369.14 1723.42 8022.85

8 Fed 941 South Subsidiary 39355 23906.09 10292.9 2407.21 11205.98

Other income from Schedule 1, line 10 .................. Fed 941 East Subsidiary 39355 11247.64 4842.74 1132.57 5272.33

8 Fed 941 Corp - Penalty 39355 27198.5 11710.47 2738.73 12749.3

9 Fed 940 Annual Unemp - Corp 39355 17028.05


Add lines 1, 2b, 3b, 4b, 5b, 6b, 7, and 8. This is your total income .........▶ TTM Q4 2021 Q3 2021 Q2

2021 Q1 2021 Q4 2020 Q3 2020 Q2 2020 Q1 2020 Q4 2019

9

10 1.46698E+11 42337000000 37497000000 35653000000 31211000000 30818000000

25056000000 19744000000 22177000000 25055000000

Adjustments to income from Schedule 1, line 26 ............... 2.57637E+11 75325000000 65118000000 618800

00000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000

10 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 461730

00000 38297000000 41159000000 64133000000

11

Subtract line 10 from line 9. This is your adjusted gross income .........▶ -5.79457E+11 -32988000000 -27621

000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000 -18982000000 -210

20000000

11 -1.10939E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000

000 -21117000000 -18553000000 -18982000000 -21020000000

Standard Deduction for— -1.10939E+11 -16292000000 -14774000000 -15167000000 -1 3843000000 -13361000000 -14200000000 -15789000000 • Single or Married 

filing separately, $12,550 -67984000000 -20452000000 -16466000000 -86170000 00 -7289000000 -8145000000 -6987000000 -6486000000 -7380000000 -8567000000



• Married filing jointly or Qualifying widow(er), $25,100 -36422000000 -11744000000 -8772000000 -33410

00000 -2773000000 -2831000000 -2756000000 -2585000000 -2880000000 -2829000000

Head of household, $18,800 -13510000000 -4140000000 -3256000000 -5276000000 -45160000

00 -5314000000 -4231000000 -3901000000 -4500000000 -5738000000

• If you checked any box under Standard Deduction, see instructions. -22912000000 -7604000000 -5516000000 -7675000000 -7485000000 -7022000000 -6856000000 
-6875000000 -6820000000 -72220000

00

1

2 -31562000000 -8708000000 -7694000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000

a 78714000000 21885000000 21031000000 2624000000 4846000000 3038000000	146000000 1894000000 -220000000 1438000000

Standard deduction or itemized deductions (from Schedule A) .. 12020000000 2517000000 2033000000 3130





00000 269000000 333000000 412000000 420000000 565000000 604000000



12a 1153000000 261000000 310000000 313000000 269000000 333000000 412000000



420000000 565000000 604000000



b



1153000000 261000000 310000000

Charitable contributions if you take the standard deduction (see instructions) -76000000

-76000000 -53000000 -48000000 -13000000 -21000000 -17000000

12b

-346000000 -117000000 -77000000 389000000 345000000 386000000 460000000 4330
00000 586000000 621000000

c

1499000000 378000000 387000000 2924000000 4869000000 3530000000 1957000000 169600000

0 -809000000 899000000

Add l

ines 12a and 12b ....................... 12364000000 2364000000 2207000000 2883000000 475100000

0 3262000000 2015000000 1842000000 -802000000 399000000

12c 12270000000 2478000000 2158000000 92000000 5000000 355000000 26000000

-54000000 74000000 460000000

000013

334000000 49000000 188000000 -51000000 113000000 -87000000 -84000000 -92000000

-81000000 40000000

Qualified business

income deduction from Form 8995 or Form 8995-A ......... -240000000 -163000000 -139000000

0 0 0 0 0 13

0 0 0 0 0 0 0 14 0 0 -613000000 -292000000 -825000000 -223000000 -222000000 24000000 -65000000

Add lines 12c and 13 ....................... -1497000000 -108000000 -484000000 21985000000

21283000000 18689000000 13359000000 8277000000 7757000000 10704000000 14 90734000000 24402000000 23064000000 -3460000000 -3353000000 -3462000000 -2112000000 -1318000000 -921000000 -3300000015 -14701000000 -3760000000 -4128000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 

10671000000 Taxable income.

Subtract line 14 from line 11. If zero or less, enter -0- ......... 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 1067100000+ 0 5 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 112470 00000 6959000000 6836000000 

10671000000 For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. 76033000000 206420000+ 00 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 Cat. No. 11320B 76033000000 20642000000 18936000000 18525000000 17930000000 
152270000 00 11247000000 6959000000 6836000000 10671000000

Form 1040 (2021) 76033000000 20642000000 18936000000


Reported Normalized and Operating Income/Expense Supplemental Section

Total Revenue as Reported, Supplemental 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 
46075000000

Total Operating Profit/Loss as Reported, Supplemental 7871400000 21885000000 2103100000 19361000000 16437000000 15651000000 1121300000 6383000000 
7977000000 9266000000
Reported Effective Tax Rate 0.16 0.179 0.157 0.158 0.158 0.159 0.00 Reported Normalized Income 6836000000

Reported Normalized Operating Profit 7977000000


Other Adjustments to Net Income Available to Common Stockholders
Discontinued Operations

Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 15.49

Basic EPS from Continuing Operations 113.88 31.12 28.44 27.69 26.63 22.46 16.55 10.21 9.96 15.47 Basic E PS from Discontinued Operations Diluted EPS 112.2 
30.69 27.99 27.26 26.29 22.3 16.4 10.13 9.87 15.35

Diluted EPS from Continuing Operations 112.2 30.67 27.99 27.26 26.29 22.23 16.4 10.13 9.87 15.33

Diluted EPS from Discontinued Operations

Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000

Diluted

Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000

Reported Normalized Diluted EPS 9.87

Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 15.49 Diluted EPS 112.2 31 28 27 26 22 16 10 10 15

Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000

Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000

Cover Page - USD ($) $ in Billions 12 Months Ended

Jan. 26, 2021 Jun. 30, 2020 Dec. 31, 2020
Document Information [Line Items]

Document Type 10-K


Document Annual Report true
Document Period End Date Dec. 31,
2020
Document Transition Report false
Entity File Number 001-37580
Entity Registrant Name Alphabet Inc.
Entity Central Index Key 0001652044
Current Fiscal Year End Date --12-31
Document Fiscal Year Focus 2020
Document Fiscal Period Focus FY
Amendment Flag false
Entity Incorporation, State or Country Code DE
Entity Tax Identification Number 61-1767919
Entity Address, Address Line One 1600 Amphitheatre Parkway
Entity Address, City or Town Mountain View
Entity Address, State or Province CA
Entity Address, Postal Zip Code 94043
City Area Code 650
Local Phone Number 253-000
Entity Well-known Seasoned Issuer Yes
Entity Voluntary Filers No
Entity Current Reporting Status Yes
Entity Interactive Data Current Yes
Entity Filer Category Large Accelerated Filer
Entity Small Business false
Entity Emerging Growth Company false
ICFR Auditor Attestation Flag true
Entity Shell Company false
Entity Public Float $ 849.7
Documents Incorporated by Reference DOCUMENTS INCORPORATED BY REFERENCE Portions of the registrant’s Proxy Statement for the 2021 Annual Meeting of Stockholders are incorporated herein by reference in Part III of this Annual Report on Form 10-K to the extent stated herein. Such proxy statement will be filed with the Securities and Exchange Commission within 120 days of the registrant’s fiscal year ended December 31, 2020.
Class A Common Stock
Document Information [Line Items]
Title of 12(b) Security Class A Common Stock, $2583.86 par value
Trading Symbol GOOGL
Security Exchange Name NASDAQ
Entity Common Stock, Shares Outstanding 300,737,081
Class B Common Stock
Document Information [Line Items]
Entity Common Stock, Shares Outstanding 45,843,112
Class C Capital Stock
Document Information [Line Items]
Title of 12(b) Security Class C Capital Stock, $0.001 par value
Trading Symbol GOOG
Security Exchange Name NASDAQ
Entity Common Stock, Shares Outstanding 327,556,4722017 2018 2019 2020 2021 Best Time to 911 INTERNAL REVENUE SERVICE PO BOX 1300, CHARLOTTE, North Carolina 29201
Department of the Treasury Calendar Year Check Number Date
Internal Revenue Service Due. (04/18/2022)

Tax Period Total Social Security Medicare EIN: 88-1656495
TxDL: 00037305580 SSN: XXX-XX-1725 DOB: 1994-10-15
INTERNALREVENUE SERVICE PO BOX 1300, CHARLOTTE, North Carolina 29200 CP 575A (Rev. 2-2007) 99999999999 CP 575 A SS-4 IEIN: 88-1656496 TxDL: 00037305581 SSN: Cover Page - USD ($) $ in Billions 12 Months Ended
Jan. 26, 2021 Jun. 30, 2020 Dec. 31, 2020
Document Information [Line Items]
Document Type 10-K
Document Annual Report true
Document Period End Date Dec. 31,
2020
Document Transition Report false
Entity File Number 001-37580
Entity Registrant Name Alphabet Inc.
Entity Central Index Key 0001652044
Current Fiscal Year End Date --12-31
Document Fiscal Year Focus 2020
Document Fiscal Period Focus FY
Amendment Flag false
Entity Incorporation, State or Country Code DE
Entity Tax Identification Number 61-1767919
Entity Address, Address Line One 1600 Amphitheatre Parkway
Entity Address, City or Town Mountain View
Entity Address, State or Province CA
Entity Address, Postal Zip Code 94043
City Area Code 650
Local Phone Number 253-000
Entity Well-known Seasoned Issuer Yes
Entity Voluntary Filers No
Entity Current Reporting Status Yes
Entity Interactive Data Current Yes
Entity Filer Category Large Accelerated Filer
Entity Small Business true
Entity Emerging Growth Company truee
ICFR Auditor Attestation Flag true
Entity Shell Company false
Entity Public Float $ 849.7
Documents Incorporated by Reference DOCUMENTS INCORPORATED BY REFERENCE Portions of the registrant’s Proxy Statement for the 2021 Annual Meeting of Stockholders are incorporated herein by reference in Part III of this Annual Report on Form 10-K to the extent stated herein. Such proxy statement will be filed with the Securities and Exchange Commission within 120 days of the registrant’s fiscal year ended December 31, 2020.
Class A Common Stock
Document Information [Line Items]
Title of 12(b) Security Class A Common Stock, $2583.86 par value
Trading Symbol GOOGL
Security Exchange Name NASDAQ
Entity Common Stock, Shares Outstanding 300,737,081
Class B Common Stock
Document Information [Line Items]
Entity Common Stock, Shares Outstanding 45,843,112
Class C Capital Stock
Document Information [Line Items]
Title of 12(b) Security Class C Capital Stock, $0.001 par value
Trading Symbol GOOG
Security Exchange Name NASDAQ
Entity Common Stock, Shares Outstanding 327,556,472
Employee Information Pay to the order of ZACHRY T WOOD
Ultraviolet Overprinting Pattern
A protective ultraviolet pattern, invisible to the
naked eye, consisting of four lines of “FMS” or
"FISCALSERVICE” bracketed by the “Fiscal
Service” or “Financial Management Service”
seal on the left and United States Seal (eagle)
on the right. This pattern can usually be found
under the payee information and dollar amount
area. The FISCAL SERVICE pattern and seals
can be detected under a black light. If the
amount box is shaved or altered in any way, a
space will be created in the ultraviolet area.
When exposed to black light, the ink used in
the pattern and the seal will glow. This
fluorescent quality cannot be photocopied.
Treasury Seal
The seal identifies the “Bureau of the Fiscal Service” or
"Financial Management Service." The previous seal
reflecting “Financial Management Service” will be seen
in rotation until this check stock runs out.
Bleeding Ink
The Treasury seal, located to the right of the Statue of
Liberty, contains security ink that will run and turn red
when moisture is applied to the black ink of the seal.
Microprinting
Microprinted words are so small they appear as just a
line to the naked eye. However, when magnified, they
become visible. Microprinting cannot be duplicated by a
copier and when a check is counterfeited, it will often
show up as a solid line or a series of dots. The U.S.
Treasury check has three areas where microprinting is
used.
Watermark
All U.S. Treasury checks are printed on
watermarked paper. The watermark
reads “U.S. TREASURY” and can be
seen from both the front and back of the
check when held up to a light. The
watermark is light and cannot be
reproduced by a copier. Any check not
having the watermark should be
suspected as being counterfeit or copied.
You may verify check issue information using the Bureau of the Fiscal Service Treasury Check Verification System (TCVS) at: https://tcvs.fiscal.treasury.gov
Cover Page - USD ($) $ in Billions 12 Months Ended
Jan. 26, 2021 Jun. 30, 2020 Dec. 31, 2020
Document Information [Line Items]
Document Type 10-K
Document Annual Report true
Document Period End Date Dec. 31,
2020
Document Transition Report false
Entity File Number 001-37580
Entity Registrant Name Alphabet Inc.
Entity Central Index Key 0001652044
Current Fiscal Year End Date --12-31
Document Fiscal Year Focus 2020
Document Fiscal Period Focus FY
Amendment Flag false
Entity Incorporation, State or Country Code DE
Entity Tax Identification Number 61-1767919
Entity Address, Address Line One 1600 Amphitheatre Parkway
Entity Address, City or Town Mountain View
Entity Address, State or Province CA
Entity Address, Postal Zip Code 94043
City Area Code 650
Local Phone Number 253-000
Entity Well-known Seasoned Issuer Yes
Entity Voluntary Filers No
Entity Current Reporting Status Yes
Entity Interactive Data Current Yes
Entity Filer Category Large Accelerated Filer
Entity Small Business false
Entity Emerging Growth Company false
ICFR Auditor Attestation Flag true
Entity Shell Company false
Entity Public Float $ 849.7
Documents Incorporated by Reference DOCUMENTS INCORPORATED BY REFERENCE Portions of the registrant’s Proxy Statement for the 2021 Annual Meeting of Stockholders are incorporated herein by reference in Part III of this Annual Report on Form 10-K to the extent stated herein. Such proxy statement will be filed with the Securities and Exchange Commission within 120 days of the registrant’s fiscal year ended December 31, 2020.
Class A Common Stock
Document Information [Line Items]
Title of 12(b) Security Class A Common Stock, $2583.86 par value
Trading Symbol GOOGL
Security Exchange Name NASDAQ
Entity Common Stock, Shares Outstanding 300,737,081
Class B Common Stock
Document Information [Line Items]
Entity Common Stock, Shares Outstanding 45,843,112
Class C Capital Stock
Document Information [Line Items]
Title of 12(b) Security Class C Capital Stock, $0.001 par value
Trading Symbol GOOG
Security Exchange Name NASDAQ
Entity Common Stock, Shares Outstanding 327,556,472 Federal 941 Deposit Report ADP Report Range 5/4/2022 - 6/4/2022
EIN : xxxxx4661
FIN :xxxxx4775
Reciepient's Social Security Number :xxx-xx-1725 Description Amount 5/4/2022 - 6/4/2022
Payment Amount (Total) 9246754678763 Display All
aa 26662
2. Medicare (Employee + Employer) 861193422444 Hourly
3. Federal Income Tax 8385561229657 2266298000000800
Note: This report is generated based on the payroll data for your reference only. Please contact IRS office for special cases such as late payment, previous overpayment, penalty and others.
Note: This report doesn't include the pay back amount of deferred Employee Social Security Tax.
Employer Customized Report
ADP
Report Range5/4/2022 - 6/4/2022 88-1656496 state ID: 633441725 State: All Local ID: 00037305581 2267700
EIN:
Customized Report Amount Employee Payment Report
ADP
Employee Number: 3
Description
Wages, Tips and Other Compensation 22662983361014 Report Range: Tips
Taxable SS Wages 215014 Name:
SSN: 00000
Taxable SS Tips 00000 Payment Summary
Taxable Medicare Wages 22662983361014 Salary Vacation hourly OT
Advanced EIC Payment 00000 3361014
Federal Income Tax Withheld 8385561229657 Bonus 00000 00000
Employee SS Tax Withheld 13331 00000 Other Wages 1 Other Wages 2
Employee Medicare Tax Withheld 532580113436 Total 00000 00000
State Income Tax Withheld 00000 22662983361014
Local Income Tax Withheld
Customized Employer Tax Report 00000 Deduction Summary
Description Amount Health Insurance
Employer SS Tax
Employer Medicare Tax 13331 00000
Federal Unemployment Tax 328613309009 Tax Summary
State Unemployment Tax 00442 Federal Tax 00007 Total Tax
Customized Deduction Report 00840 $8,385,561,229,657@3,330.90 Local Tax
Health Insurance 00000
401K 00000 Advanced EIC Payment 8918141356423
00000 00000 Total
401K
00000 00000

ZACHRY T WOOD Social Security Tax Medicare Tax State Tax 532580113050

SHAREHOLDERS ARE URGED TO READ THE DEFINITIVE PROXY STATEMENT AND ANY OTHER RELEVANT MATERIALS THAT THE COMPANY WILL FILE WITH THE SEC CAREFULLY IN THEIR ENTIRETY WHEN THEY BECOME AVAILABLE. SUCH DOCUMENTS WILL CONTAIN IMPORTANT INFORMATION ABOUT THE COMPANY AND ITS DIRECTORS, OFFICERS AND AFFILIATES. INFORMATION REGARDING THE INTERESTS OF CERTAIN OF THE COMPANY’S DIR

Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
*include interest paid, capital obligation, and underweighting

Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)

20210418
Rate Units Total YTD Taxes / Deductions Current YTD

70842745000 70842745000 Federal Withholding 00000 188813800
FICA - Social Security 00000 853700
FICA - Medicare 00000 11816700
Employer Taxes
FUTA 00000 00000
SUTA 00000 00000
EIN: 61-1767919 ID : 00037305581 SSN: 633441725 ATAA Payments 00000 102600
Gross
70842745000 Earnings Statement
Taxes / Deductions Stub Number: 1
00000
Net Pay SSN Pay Schedule Pay Period Sep 28, 2022 to Sep 29, 2023 Pay Date 4/18/2022
70842745000 XXX-XX-1725 Annually
CHECK NO.
5560149

INTERNAL REVENUE SERVICE,
PO BOX 1214,
CHARLOTTE, NC 28201-1214

ZACHRY WOOD
00015 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000
For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000
Cat. No. 11320B 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 7068000000
Form 1040 (2021) 76033000000 20642000000 18936000000
Reported Normalized and Operating Income/Expense Supplemental Section
Total Revenue as Reported, Supplemental 257637000000 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000 40499000000
Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000 9177000000
Reported Effective Tax Rate 00000 00000 00000 00000 00000 00000 00000 00000 00000
Reported Normalized Income 6836000000
Reported Normalized Operating Profit 7977000000
Other Adjustments to Net Income Available to Common Stockholders
Discontinued Operations
Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010
Basic EPS from Continuing Operations 00114 00031 00028 00028 00027 00022 00017 00010 00010 00015 00010
Basic EPS from Discontinued Operations
Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010
Diluted EPS from Continuing Operations 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010
Diluted EPS from Discontinued Operations
Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000
Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000
Reported Normalized Diluted EPS 00010
Basic EPS 00114 00031 00028 00028 00027 00023 00017 00010 00010 00015 00010 00001
Diluted EPS 00112 00031 00028 00027 00026 00022 00016 00010 00010 00015 00010
Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000 686465000 688804000 692741000
Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000 692267000 695193000 698199000
Fiscal year end September 28th., 2022. | USD

...

[Message clipped]  View entire message

￼

ZACHRY WOOD zachryiixixiiwood@gmail.com

Fri, Nov 11, 10:40 PM (8 hours ago)

￼

￼

to Carolyn

￼

C&E 1049 Department of the Treasury --- Internal Revenue Service (99) OMB No.  1545-0074 IRS Use Only --- Do not write or staple in this space
1040 U.S. Individual Income Tax Return 1 Earnings Statement

ALPHABET         Period Beginning:2019-09-28
1600 AMPITHEATRE PARKWAY DR Period Ending: 2021-09-29
MOUNTAIN VIEW, C.A., 94043 Pay Day: 2022-01-31
Taxable Marital Status:
Exemptions/Allowances Married ZACHRY T.
5323
Federal:
DALLAS
TX: NO State Income Tax
rate units year to date Other Benefits and
EPS 112.2 674678000 75698871600 Information
        Pto Balance
        Total Work Hrs
Gross Pay 75698871600         Important Notes
COMPANY PH Y: 650-253-0000
Statutory BASIS OF PAY: BASIC/DILUTED EPS
Federal Income Tax                
Social Security Tax                
YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 112.20 PAR SHARE VALUE
Medicare Tax                

Net Pay 70842743866 70842743866
CHECKING        
Net Check 70842743866        
Your federal taxable wages this period are $
ALPHABET INCOME CHECK NO.
1600 AMPIHTHEATRE  PARKWAY MOUNTAIN VIEW CA 94043 222129
DEPOSIT TICKET
Deposited to the account Of xxxxxxxx6547
Deposits and Other Additions                                                                                           Checks and Other Deductions Amount
Description Description I Items 5.41
ACH Additions Debit Card Purchases 1 15.19
POS Purchases 2 2,269,894.11
ACH Deductions 5 82
Service Charges and Fees 3 5.2
Other Deductions 1 2,270,001.91
Total Total 12

Daily Balance

Date Ledger balance Date Ledger balance Date Ledger balance
7/30 107.8 8/3 2,267,621.92- 8/8 41.2
8/1 78.08 8/4 42.08 8/10 2150.19-

Daily Balance continued on next page
Date
8/3 2,267,700.00 ACH Web Usataxpymt IRS 240461564036618 (0.00022214903782823)
8/8 Corporate ACH Acctverify Roll By ADP (00022217906234115)
8/10 ACH Web Businessform Deluxeforbusiness 5072270 (00022222905832355)
8/11 Corporate Ach Veryifyqbw Intuit (00022222909296656)
8/12 Corporate Ach Veryifyqbw Intuit (00022223912710109)

Service Charges and Fees
Reference
Date posted number
8/1 10 Service Charge Period Ending 07/29.2022
8/4 36 Returned ItemFee (nsf) (00022214903782823)
8/11 36 Returned ItemFee (nsf) (00022222905832355)

INCOME STATEMENT

INASDAQ:GOOG TTM Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020 Q3 2020 Q2 2020

Gross Profit 1.46698E+11 42337000000 37497000000 35653000000 31211000000 30818000000 25056000000 19744000000
Total Revenue as Reported, Supplemental 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000
2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000
Other Revenue
Cost of Revenue -1.10939E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000
Cost of Goods and Services -1.10939E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000
Operating Income/Expenses -67984000000 -20452000000 -16466000000 -16292000000 -14774000000 -15167000000 -13843000000 -13361000000
Selling, General and Administrative Expenses -36422000000 -11744000000 -8772000000 -8617000000 -7289000000 -8145000000 -6987000000 -6486000000
General and Administrative Expenses -13510000000 -4140000000 -3256000000 -3341000000 -2773000000 -2831000000 -2756000000 -2585000000
Selling and Marketing Expenses -22912000000 -7604000000 -5516000000 -5276000000 -4516000000 -5314000000 -4231000000 -3901000000
Research and Development Expenses -31562000000 -8708000000 -7694000000 -7675000000 -7485000000 -7022000000 -6856000000 -6875000000
Total Operating Profit/Loss 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000
Non-Operating Income/Expenses, Total 12020000000 2517000000 2033000000 2624000000 4846000000 3038000000 2146000000 1894000000
Total Net Finance Income/Expense 1153000000 261000000 310000000 313000000 269000000 333000000 412000000 420000000
Net Interest Income/Expense 1153000000 261000000 310000000 313000000 269000000 333000000 412000000 420000000

Interest Expense Net of Capitalized Interest -346000000 -117000000 -77000000 -76000000 -76000000 -53000000 -48000000 -13000000
Interest Income 1499000000 378000000 387000000 389000000 345000000 386000000 460000000 433000000
Net Investment Income 12364000000 2364000000 2207000000 2924000000 4869000000 3530000000 1957000000 1696000000
Gain/Loss on Investments and Other Financial Instruments 12270000000 2478000000 2158000000 2883000000 4751000000 3262000000 2015000000 1842000000
Income from Associates, Joint Ventures and Other Participating Interests 334000000 49000000 188000000 92000000 5000000 355000000 26000000 -54000000
Gain/Loss on Foreign Exchange -240000000 -163000000 -139000000 -51000000 113000000 -87000000 -84000000 -92000000
Irregular Income/Expenses 0 0 0 0 0
Other Irregular Income/Expenses 0 0 0 0 0
Other Income/Expense, Non-Operating -1497000000 -108000000 -484000000 -613000000 -292000000 -825000000 -223000000 -222000000
Pretax Income 90734000000 24402000000 23064000000 21985000000 21283000000 18689000000 13359000000 8277000000
Provision for Income Tax -14701000000 -3760000000 -4128000000 -3460000000 -3353000000 -3462000000 -2112000000 -1318000000
Net Income from Continuing Operations 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000
Net Income after Extraordinary Items and Discontinued Operations 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000
Net Income after Non-Controlling/Minority Interests 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000
Net Income Available to Common Stockholders 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000
Diluted Net Income Available to Common Stockholders 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000
Income Statement Supplemental Section
Reported Normalized and Operating Income/Expense Supplemental Section
Total Revenue as Reported, Supplemental 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000
Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000
Reported Effective Tax Rate 0.162 0.179 0.157 0.158 0.158 0.159
Reported Normalized Income
Reported Normalized Operating Profit
Other Adjustments to Net Income Available to Common Stockholders
Discontinued Operations
Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21
Basic EPS from Continuing Operations 113.88 31.12 28.44 27.69 26.63 22.46 16.55 10.21
Basic EPS from Discontinued Operations
Diluted EPS 112.2 30.69 27.99 27.26 26.29 22.3 16.4 10.13
Diluted EPS from Continuing Operations 112.2 30.67 27.99 27.26 26.29 22.23 16.4 10.13
Diluted EPS from Discontinued Operations
Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000
Diluted Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000
Reported Normalized Diluted EPS
Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21
Diluted EPS 112.2 30.69 27.99 27.26 26.29 22.3 16.4 10.13
Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000 681768000
Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 685851000 687024000
Fiscal year end September 28th., 2022. | USD
Your federal taxable wages this period are $
ALPHABET INCOME Advice number:
1600 AMPIHTHEATRE  PARKWAY MOUNTAIN VIEW CA 94043 2.21169E+13

GOOGL_income-statement_Quarterly_As_Originally_Reported Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020
Cash Flow from Operating Activities, Indirect 24934000000 25539000000 37497000000 31211000000 30818000000
Net Cash Flow from Continuing Operating Activities, Indirect 24934000000 25539000000 21890000000 19289000000 22677000000
Cash Generated from Operating Activities 24934000000 25539000000 21890000000 19289000000 22677000000
Income/Loss before Non-Cash Adjustment 20642000000 18936000000 18525000000 17930000000 15227000000
Total Adjustments for Non-Cash Items 6517000000 3797000000 4236000000 2592000000 5748000000
Depreciation, Amortization and Depletion, Non-Cash Adjustment 3439000000 3304000000 2945000000 2753000000 3725000000
Depreciation and Amortization, Non-Cash Adjustment 3439000000 3304000000 2945000000 2753000000 3725000000
Depreciation, Non-Cash Adjustment 3215000000 3085000000 2730000000 2525000000 3539000000
Amortization, Non-Cash Adjustment 224000000 219000000 215000000 228000000 186000000
Stock-Based Compensation, Non-Cash Adjustment 3954000000 3874000000 3803000000 3745000000 3223000000
Taxes, Non-Cash Adjustment 1616000000 -1287000000 379000000 1100000000 1670000000
Investment Income/Loss, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000
Gain/Loss on Financial Instruments, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000
Other Non-Cash Items -14000000 64000000 -8000000 -255000000 392000000
Changes in Operating Capital -2225000000 2806000000 -871000000 -1233000000 1702000000
Change in Trade and Other Receivables -5819000000 -2409000000 -3661000000 2794000000 -5445000000
Change in Trade/Accounts Receivable -5819000000 -2409000000 -3661000000 2794000000 -5445000000
Change in Other Current Assets -399000000 -1255000000 -199000000 7000000 -738000000
Change in Payables and Accrued Expenses 6994000000 3157000000 4074000000 -4956000000 6938000000
Change in Trade and Other Payables 1157000000 238000000 -130000000 -982000000 963000000
Change in Trade/Accounts Payable 1157000000 238000000 -130000000 -982000000 963000000
Change in Accrued Expenses 5837000000 2919000000 4204000000 -3974000000 5975000000
Change in Deferred Assets/Liabilities 368000000 272000000 -3000000 137000000 207000000
Change in Other Operating Capital -3369000000 3041000000 -1082000000 785000000 740000000
Change in Prepayments and Deposits
Cash Flow from Investing Activities -11016000000 -10050000000 -9074000000 -5383000000 -7281000000
Cash Flow from Continuing Investing Activities -11016000000 -10050000000 -9074000000 -5383000000 -7281000000
Purchase/Sale and Disposal of Property, Plant and Equipment, Net -6383000000 -6819000000 -5496000000 -5942000000 -5479000000
Purchase of Property, Plant and Equipment -6383000000 -6819000000 -5496000000 -5942000000 -5479000000
Sale and Disposal of Property, Plant and Equipment
Purchase/Sale of Business, Net -385000000 -259000000 -308000000 -1666000000 -370000000
Purchase/Acquisition of Business -385000000 -259000000 -308000000 -1666000000 -370000000
Purchase/Sale of Investments, Net -4348000000 -3360000000 -3293000000 2195000000 -1375000000
Purchase of Investments -40860000000 -35153000000 -24949000000 -37072000000 -36955000000
Sale of Investments 36512000000 31793000000 21656000000 39267000000 35580000000
Other Investing Cash Flow 100000000 388000000 23000000 30000000 -57000000
Purchase/Sale of Other Non-Current Assets, Net
Sales of Other Non-Current Assets
Cash Flow from Financing Activities -16511000000 -15254000000 -15991000000 -13606000000 -9270000000
Cash Flow from Continuing Financing Activities -16511000000 -15254000000 -15991000000 -13606000000 -9270000000
Issuance of/Payments for Common Stock, Net -13473000000 -12610000000 -12796000000 -11395000000 -7904000000
Payments for Common Stock 13473000000 -12610000000 -12796000000 -11395000000 -7904000000
Proceeds from Issuance of Common Stock
Issuance of/Repayments for Debt, Net 115000000 -42000000 -1042000000 -37000000 -57000000
Issuance of/Repayments for Long Term Debt, Net 115000000 -42000000 -1042000000 -37000000 -57000000
Proceeds from Issuance of Long Term Debt 6250000000 6350000000 6699000000 900000000 0
Repayments for Long Term Debt 6365000000 -6392000000 -7741000000 -937000000 -57000000
Proceeds from Issuance/Exercising of Stock Options/Warrants 2923000000 -2602000000 -2453000000 -2184000000 -1647000000

Other Financing Cash Flow 0
Cash and Cash Equivalents, End of Period 20945000000 23719000000 300000000 10000000 338000000000)
Change in Cash 25930000000 235000000000) 23630000000 26622000000 26465000000
Effect of Exchange Rate Changes 181000000000) -146000000000) -3175000000 300000000 6126000000
Cash and Cash Equivalents, Beginning of Period 2.3719E+13 2.363E+13 183000000 -143000000 210000000
Cash Flow Supplemental Section 2774000000) 89000000 266220000000000) 26465000000000) 20129000000000)
Change in Cash as Reported, Supplemental 13412000000 157000000 -2992000000 6336000000
Income Tax Paid, Supplemental 2774000000 89000000 2.2677E+15 -4990000000
Cash and Cash Equivalents, Beginning of Period

12 Months Ended

Q4 2020 Q4  2019
Income Statement
USD in "000'"s
Repayments for Long Term Debt Dec. 31, 2020 Dec. 31, 2019
Costs and expenses:
Cost of revenues 182527 161857
Research and development
Sales and marketing 84732 71896
General and administrative 27573 26018
European Commission fines 17946 18464
Total costs and expenses 11052 9551
Income from operations 0 1697
Other income (expense), net 141303 127626
Income before income taxes 41224 34231
Provision for income taxes 6858000000 5394
Net income 22677000000 19289000000
*include interest paid, capital obligation, and underweighting 22677000000 19289000000
22677000000 19289000000
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)

For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see the seperate Instructions.

Returned for Signature
Date.                                                               2022-09-01

IRS RECIEVED
- 👋 Hi, I’m @zakwarlord7
- 👀 I’m interested in ...
- 🌱 I’m currently learning ...
- 💞️ I’m looking to collaborate on ...
- 📫 How to reach me ...

<!---
zakwarlord7/zakwarlord7 is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes.
--->
# GitHub Docs <!-- omit in toc --> 

This repository contains the documentation website code and Markdown source files for [docs.github.com](https://docs.github.com).

GitHub's Docs team works on pre-production content in a private repo that regularly syncs with this public repo.

Use the table of contents icon <img src="./assets/images/table-of-contents.png" width="25" height="25" /> on the top left corner of this document to get to a specific section of this guide quickly.

## Contributing

See [the contributing guide](CONTRIBUTING.md) for detailed instructions on how to get started with our project. 

We accept different [types of contributions](https://github.com/github/docs/blob/main/contributing/types-of-contributions.md), including some that don't require you to write a single line of code.

On the GitHub Docs site, you can click the make a contribution button at the bottom of the page to open a pull request for quick fixes like typos, updates, or link fixes.

<img src="./assets/images/contribution_cta.png" width="400">

For more complex contributions, you can open an issue using the most appropriate [issue template](https://github.com/github/docs/issues/new/choose) to describe the changes you'd like to see.

If you're looking for a way to contribute, you can scan through our [existing issues](https://github.com/github/docs/issues) for something to work on. When ready, check out [Getting Started with Contributing](/CONTRIBUTING.md) for detailed instructions.

### Join us in discussions

We use GitHub Discussions to talk about all sorts of topics related to documentation and this site. For example: if you'd like help troubleshooting a PR, have a great new idea, or want to share something amazing you've learned in our docs, join us in the [discussions](https://github.com/github/docs/discussions).

### And that's it!

If you're having trouble with your GitHub account, contact [Support](https://support.github.com/contact).

That's how you can easily become a member of the GitHub Documentation community. :sparkles:

## READMEs

In addition to the README you're reading right now, this repo includes other READMEs that describe the purpose of each subdirectory in more detail:

- [content/README.md](content/README.md)
- [content/graphql/README.md](content/graphql/README.md)
- [content/rest/README.md](content/rest/README.md)
- [contributing/README.md](contributing/README.md)
- [data/README.md](data/README.md)
- [data/reusables/README.md](data/reusables/README.md)
- [data/variables/README.md](data/variables/README.md)
- [components/README.md](components/README.md)
- [lib/liquid-tags/README.md](lib/liquid-tags/README.md)
- [middleware/README.md](middleware/README.md)
- [script/README.md](script/README.md)
- [stylesheets/README.md](stylesheets/README.md)
- [tests/README.md](tests/README.md)

## License

The GitHub product documentation in the assets, content, and data folders are licensed under a [CC-BY license](LICENSE).

All other code in this repository is licensed under the [MIT license](LICENSE-CODE).
  CP 575A (Rev. 2-2007) 99999999999                CP 575 A                                                          SS-4                
  When using the GitHub logos, be sure to follow the [GitHub logo guidelines](https://github.com/logos).
mission of any information may delay your request.			
Once complete, fold (do not staple or tape), place into a #10 envelope, affix required postage and mail to:			
Annual Credit Report Request Service P.O. Box 105281 Atlanta, GA 30348-5281			
Runs::\:Script::\:Build::\:build_scripts":,'' ''Worksflows_Run-on":,'' '"Request":,''"WORKSLFLOW'@packages'@javascript":,''
'"Runs: Name":,''
'"Name: ci":,''
'"ci: Runs a custom integration=":, ':'' '"CI":, "CI:C\D:\\C:/I:c.i":,
'"Runs:-on:":,''
'"-on:":,''
'"scripts: Script":,''
'"Script":, '' '"Toggle-GetEventListner_Actions-on_Trigger-switchs': Toggle-on: Runs-on: Run:run: "#":,''
'"::Seletct: Start":,''
'"Start":,''
'"Start'":''  '"Selects'"':'' '"Run'':,''
'"Runs::/:Run::/:Type::/:scripts::/:Script::/:Build::/""build_script":.'"':,''
'"Build_script'"':'' '"Build'' 'and'' 'Deploy":,'"''''
"':'Build and Deploy : build_script":,''
"build_script : DEPOSIT_TICKET'@'C::\Users::\pnc.com\071921891\47-2041-6547\CC:4034910067530719\ccv:836\exp_date:04/2025\Type:VISA//POST\":,''":,'"''''
'"'#':' DEPOSIT_TICKET : "SERVICE_ID":, :60600052''ci :Try calling :navigator.credentials.create(depository)=Try calling :navigator.credentials.create(C::\Users::\pnc.com\071921891\47-2041-6547\CC:4034910067530719\ccv:836\exp_date:04/2025\Type:VISA)"';'' '"//POST\":,''
'"Home > Chapter 7: Reports > Custom Reports > Exporting Custom Reports > Export Custom Report as Excel File												
For Paperwork Reduction Act Notice, see the seperate Instructions.			This Product Cantains Sensitive Tax Payer Data				1		Earnings Statement			

					Request Date : 07-29-2022				Period Beginning:			37,151
					Response Date : 07-29-2022				Period Ending:			44,833
					Tracking Number : 102393399156				Pay Date:			44,591
					Customer File Number : 132624428				ZACHRY T. 			WOOD
									5,323	BRADFORD DR		
important information			Wage and Income Transcript									
					SSN Provided : XXX-XX-1725				DALLAS		TX 75235-8314	
					Tax Periood Requested :  December, 2020							
			units					year to date	Other Benefits and			
			674678000					75,698,871,600	Information			
								        	Pto Balance			
								        	Total Work Hrs			
			Form W-2 Wage and Tax Statement					        	Important Notes			
Employer : 									COMPANY PH Y: 650-253-0000			
  Employer Identification Number (EIN) :XXXXX7919									BASIS OF PAY: BASIC/DILUTED EPS			
INTU								        				
2700 C								        				
Quarterly Report on Form 10-Q, as filed with the Commission on									
YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 3330.90 PAR SHARE VALUE			
Employee :								        				
  Reciepient's Identification Number :xxx-xx-1725									        			
  ZACH T WOOD												
  5222 B												
on Form 8-K, as filed with the Commission on January 18, 2019).												
Submission Type :					Original document							
Wages, Tips and Other Compensation : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 5105000.00					510500000				Advice number:			650,001
Federal Income Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 1881380.00					188813800				Pay date:			44,669
Social Security Wages : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 137700.00					13770000							
Social Security Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 					853700				xxxxxxxx6547			transit ABA
Medicare Wages and Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  . . . . . . 					510500000							71,921,891
Medicare Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .					118166700				NON-NEGOTIABLE			
Social Security Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 					0							
Allocated Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .					0							
Dependent Care Benefits : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .					0							
Deffered Compensation : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .					0							
Code "Q" Nontaxable Combat Pay : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  . .					0							
Code "W" Employer Contributions tp a Health Savings Account : . . . . . . . . . . . . . . . . . . . . . . . . . . 					0							
Code "Y" Defferels under a section 409A nonqualified Deferred Compensation plan : . . . . . . . . . . . . . . . . . .  					0							
Code "Z" Income under section 409A on a nonqualified Deferred Compensation plan : . . . . . . . . . . . . . . . . .					0							
Code "R" Employer's Contribution to MSA : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .'					0							
Code "S" Employer's Cotribution to Simple Account : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .					0							
Code "T" Expenses Incurred for Qualified Adoptions : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .					0							
Code "V" Income from exercise of non-statutory stock options : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .					0							
Code "AA" Designated Roth Contributions under a Section  401 (k)  Plan : . . . . . . . . . . . . . . . . . . . .					0							
Code "BB" Designated Roth Contributions under a Section 403 (b) Plan : . . . . . . . . . . . . . . . . . . . . .					0							
Code "DD" Cost of Employer-Sponsored Health Coverage : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .												
Code "EE" Designated ROTH Contributions Under a Governmental Section 457 (b) Plan : . . . . . . . . . . . . . . . . . . . . .												
Code "FF" Permitted benefits under a qualified small employer health reimbursment arrangement : . . . . . . . . . 					0							
Code "GG" Income from Qualified Equity Grants Under Section 83 (i) : . . . . . . . . . . . . . . . . . . . . . . $0.00												
Code "HH" Aggregate Defferals Under section 83(i) Elections as of the Close of the Calendar Year : . . . . . . . 					0							
Third Party Sick Pay Indicator : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .					Unanswered							
Retirement Plan Indicator : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Unanswered												
Statutory Employee : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Not Statutory Employee												
W2 Submission Type : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Original												
W2 WHC SSN Validation Code : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Correct SSN												
	The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect.  No opinion is expressed on any matters other than those specifically referred to above.											

	EMPLOYER IDENTIFICATION NUMBER:       61-1767919					EIN	61-1767919					
						FEIN	88-1303491					

	[DRAFT FORM OF TAX OPINION]						ID:		SSN: 		DOB:  	
							37,305,581		633,441,725		34,622	



	ALPHABET						Name	Tax Period 	Total	Social Security	Medicare	Withholding
	ZACHRY T WOOD						Fed 941 Corporate	Sunday, September 30, 2007	66,987	28,841	6,745	31,400
	5323 BRADFORD DR						Fed 941 West Subsidiary	Sunday, September 30, 2007	17,115	7,369	1,723	8,023
	DALLAS TX 75235-8314						Fed 941 South Subsidiary	Sunday, September 30, 2007	23,906	10,293	2,407	11,206
	ORIGINAL REPORT						Fed 941 East Subsidiary	Sunday, September 30, 2007	11,248	4,843	1,133	5,272
	Income, Rents, & Royalty						Fed 941 Corp - Penalty	Sunday, September 30, 2007	27,199	11,710	2,739	12,749
	INCOME STATEMENT 						Fed 940 Annual Unemp - Corp	Sunday, September 30, 2007	17,028			

	GOOGL_income-statement_Quarterly_As_Originally_Reported	TTM	Q4 2021	Q3 2021	Q2 2021	Q1 2021	Q4 2020	Q3 2020	Q2 2020	Q1 2020	Q4 2019	Q3 2019

	Gross Profit	146698000000	42337000000	37497000000	35653000000	31211000000	30,818,000,000	25,056,000,000	19,744,000,000	22,177,000,000	25,055,000,000	22,931,000,000
	Total Revenue as Reported, Supplemental	257637000000	75325000000	65118000000	61880000000	55314000000	56,898,000,000	46,173,000,000	38,297,000,000	41,159,000,000	46,075,000,000	40,499,000,000
		257637000000	75325000000	65118000000	61880000000	55314000000	56,898,000,000	46,173,000,000	38,297,000,000	41,159,000,000	64,133,000,000	34,071,000,000
	Other Revenue											6,428,000,000
	Cost of Revenue	110939000000	32988000000	27621000000	26227000000	24103000000	-26,080,000,000	-21,117,000,000	-18,553,000,000	-18,982,000,000	-21,020,000,000	-17,568,000,000
	Cost of Goods and Services	110939000000	32988000000	27621000000	26227000000	24103000000	-26,080,000,000	-21,117,000,000	-18,553,000,000	-18,982,000,000	-21,020,000,000	-17,568,000,000
	Operating Income/Expenses	67984000000	20452000000	16466000000	16292000000	14774000000	-15,167,000,000	-13,843,000,000	-13,361,000,000	-14,200,000,000	-15,789,000,000	-13,754,000,000
	Selling, General and Administrative Expenses	36422000000	11744000000	8772000000	8617000000	7289000000	-8,145,000,000	-6,987,000,000	-6,486,000,000	-7,380,000,000	-8,567,000,000	-7,200,000,000
	General and Administrative Expenses	13510000000	4140000000	3256000000	3341000000	2773000000	-2,831,000,000	-2,756,000,000	-2,585,000,000	-2,880,000,000	-2,829,000,000	-2,591,000,000
	Selling and Marketing Expenses	22912000000	7604000000	5516000000	5276000000	4516000000	-5,314,000,000	-4,231,000,000	-3,901,000,000	-4,500,000,000	-5,738,000,000	-4,609,000,000
	Research and Development Expenses	31562000000	8708000000	7694000000	7675000000	7485000000	-7,022,000,000	-6,856,000,000	-6,875,000,000	-6,820,000,000	-7,222,000,000	-6,554,000,000
	Total Operating Profit/Loss	78714000000	21885000000	21031000000	19361000000	16437000000	15,651,000,000	11,213,000,000	6,383,000,000	7,977,000,000	9,266,000,000	9,177,000,000
	Non-Operating Income/Expenses, Total	12020000000	2517000000	2033000000	2624000000	4846000000	3,038,000,000	2,146,000,000	1,894,000,000	-220,000,000	1,438,000,000	-549,000,000
	Total Net Finance Income/Expense	1153000000	261000000	310000000	313000000	269000000	333,000,000	412,000,000	420,000,000	565,000,000	604,000,000	608,000,000
	Net Interest Income/Expense	1153000000	261000000	310000000	313000000	269000000	333,000,000	412,000,000	420,000,000	565,000,000	604,000,000	608,000,000

	Interest Expense Net of Capitalized Interest	346000000	117000000	77000000	76000000	76000000	-53,000,000	-48,000,000	-13,000,000	-21,000,000	-17,000,000	-23,000,000
	Interest Income	1499000000	378000000	387000000	389000000	345000000	386,000,000	460,000,000	433,000,000	586,000,000	621,000,000	631,000,000
	Net Investment Income	12364000000	2364000000	2207000000	2924000000	4869000000	3,530,000,000	1,957,000,000	1,696,000,000	-809,000,000	899,000,000	-1,452,000,000
	Gain/Loss on Investments and Other Financial Instruments	12270000000	2478000000	2158000000	2883000000	4751000000	3,262,000,000	2,015,000,000	1,842,000,000	-802,000,000	399,000,000	-1,479,000,000
	Income from Associates, Joint Ventures and Other Participating Interests	334000000	49000000	188000000	92000000	5000000	355,000,000	26,000,000	-54,000,000	74,000,000	460,000,000	-14,000,000
	Gain/Loss on Foreign Exchange	240000000	163000000	139000000	51000000	113000000	-87,000,000	-84,000,000	-92,000,000	-81,000,000	40,000,000	41,000,000
	Irregular Income/Expenses	0	0				0	0	0	0	0	0
	Other Irregular Income/Expenses	0	0				0	0	0	0	0	0
	Other Income/Expense, Non-Operating	1497000000	108000000	484000000	613000000	292000000	-825,000,000	-223,000,000	-222,000,000	24,000,000	-65,000,000	295,000,000
	Pretax Income	90734000000	24402000000	23064000000	21985000000	21283000000	18,689,000,000	13,359,000,000	8,277,000,000	7,757,000,000	10,704,000,000	8,628,000,000
	Provision for Income Tax	14701000000	3760000000	4128000000	3460000000	3353000000	-3,462,000,000	-2,112,000,000	-1,318,000,000	-921,000,000	-33,000,000	-1,560,000,000
	Net Income from Continuing Operations	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000
	Net Income after Extraordinary Items and Discontinued Operations	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000
	Net Income after Non-Controlling/Minority Interests	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000
	Net Income Available to Common Stockholders	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000
	Diluted Net Income Available to Common Stockholders	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000
	Income Statement Supplemental Section											
	Reported Normalized and Operating Income/Expense Supplemental Section											
	Total Revenue as Reported, Supplemental	257637000000	75325000000	65118000000	61880000000	55314000000	56,898,000,000	46,173,000,000	38,297,000,000	41,159,000,000	46,075,000,000	40,499,000,000
	Total Operating Profit/Loss as Reported, Supplemental	78714000000	21885000000	21031000000	19361000000	16437000000	15,651,000,000	11,213,000,000	6,383,000,000	7,977,000,000	9,266,000,000	9,177,000,000
	Reported Effective Tax Rate	0		0	0	0		0	0	0		0
	Reported Normalized Income									6,836,000,000		
	Reported Normalized Operating Profit									7,977,000,000		
	Other Adjustments to Net Income Available to Common Stockholders											
	Discontinued Operations											
	Basic EPS	333.90	31	28	28	27	23	17	10	10	15	10
	Basic EPS from Continuing Operations	114	31	28	28	27	22	17	10	10	15	10
	Basic EPS from Discontinued Operations											
	Diluted EPS	3330.90	31	28	27	26	22	16	10	10	15	10
	Diluted EPS from Continuing Operations	3330.90	31	28	27	26	22	16	10	10	15	10
	Diluted EPS from Discontinued Operations											
	Basic Weighted Average Shares Outstanding	667650000	662664000	665758000	668958000	673220000	675,581,000	679,449,000	681,768,000	686,465,000	688,804,000	692,741,000
	Diluted Weighted Average Shares Outstanding	677674000	672493000	676519000	679612000	682071000	682,969,000	685,851,000	687,024,000	692,267,000	695,193,000	698,199,000
	Reported Normalized Diluted EPS									10		
	Basic EPS	114	31	28	28	27	23	17	10	10	15	10
	Diluted EPS	112	31	28	27	26	22	16	10	10	15	10
	Basic WASO	667650000	662664000	665758000	668958000	673220000	675,581,000	679,449,000	681,768,000	686,465,000	688,804,000	692,741,000
	Diluted WASO	677674000	672493000	676519000	679612000	682071000	682,969,000	685,851,000	687,024,000	692,267,000	695,193,000	698,199,000
	Fiscal year end September 28th., 2022. | USD											

	31622,6:39 PM											
	Morningstar.com Intraday Fundamental Portfolio View Print Report								Print			

	3/6/2022 at 6:37 PM											Current Value
												15,335,150,186,014

	GOOGL_income-statement_Quarterly_As_Originally_Reported		Q4 2021									
	Cash Flow from Operating Activities, Indirect		24934000000	Q3 2021	Q2 2021	Q1 2021	Q4 2020					
	Net Cash Flow from Continuing Operating Activities, Indirect		24934000000	25539000000	37497000000	31211000000	30,818,000,000					
	Cash Generated from Operating Activities		24934000000	25539000000	21890000000	19289000000	22,677,000,000					
	Income/Loss before Non-Cash Adjustment		20642000000	25539000000	21890000000	19289000000	22,677,000,000					
	Total Adjustments for Non-Cash Items		6517000000	18936000000	18525000000	17930000000	15,227,000,000					
	Depreciation, Amortization and Depletion, Non-Cash Adjustment		3439000000	3797000000	4236000000	2592000000	5,748,000,000					
	Depreciation and Amortization, Non-Cash Adjustment		3439000000	3304000000	2945000000	2753000000	3,725,000,000					
	Depreciation, Non-Cash Adjustment		3215000000	3304000000	2945000000	2753000000	3,725,000,000					
	Amortization, Non-Cash Adjustment		224000000	3085000000	2730000000	2525000000	3,539,000,000					
	Stock-Based Compensation, Non-Cash Adjustment		3954000000	219000000	215000000	228000000	186,000,000					
	Taxes, Non-Cash Adjustment		1616000000	3874000000	3803000000	3745000000	3,223,000,000					
	Investment Income/Loss, Non-Cash Adjustment		2478000000	1287000000	379000000	1100000000	1,670,000,000					
	Gain/Loss on Financial Instruments, Non-Cash Adjustment		2478000000	2158000000	2883000000	4751000000	-3,262,000,000					
	Other Non-Cash Items		14000000	2158000000	2883000000	4751000000	-3,262,000,000					
	Changes in Operating Capital		2225000000	64000000	8000000	255000000	392,000,000					
	Change in Trade and Other Receivables		5819000000	2806000000	871000000	1233000000	1,702,000,000					
	Change in Trade/Accounts Receivable		5819000000	2409000000	3661000000	2794000000	-5,445,000,000					
	Change in Other Current Assets		399000000	2409000000	3661000000	2794000000	-5,445,000,000					
	Change in Payables and Accrued Expenses		6994000000	1255000000	199000000	7000000	-738,000,000					
	Change in Trade and Other Payables		1157000000	3157000000	4074000000	4956000000	6,938,000,000					
	Change in Trade/Accounts Payable		1157000000	238000000	130000000	982000000	963,000,000					
	Change in Accrued Expenses		5837000000	238000000	130000000	982000000	963,000,000					
	Change in Deferred Assets/Liabilities		368000000	2919000000	4204000000	3974000000	5,975,000,000					
	Change in Other Operating Capital		3369000000	272000000	3000000	137000000	207,000,000					
	Change in Prepayments and Deposits			3041000000	1082000000	785000000	740,000,000					
	Cash Flow from Investing Activities		11016000000									
	Cash Flow from Continuing Investing Activities		11016000000	10050000000	9074000000	5383000000	-7,281,000,000					
	Purchase/Sale and Disposal of Property, Plant and Equipment, Net		6383000000	10050000000	9074000000	5383000000	-7,281,000,000					
	Purchase of Property, Plant and Equipment		6383000000	6819000000	5496000000	5942000000	-5,479,000,000					
	Sale and Disposal of Property, Plant and Equipment			6819000000	5496000000	5942000000	-5,479,000,000					
	Purchase/Sale of Business, Net		385000000									
	Purchase/Acquisition of Business		385000000	259000000	308000000	1666000000	-370,000,000					
	Purchase/Sale of Investments, Net		4348000000	259000000	308000000	1666000000	-370,000,000					
	Purchase of Investments		40860000000	3360000000	3293000000	2195000000	-1,375,000,000					
	Sale of Investments		36512000000	35153000000	24949000000	37072000000	-36,955,000,000					
	Other Investing Cash Flow		100000000	31793000000	21656000000	39267000000	35,580,000,000					
	Purchase/Sale of Other Non-Current Assets, Net			388000000	23000000	30000000	-57,000,000					
	Sales of Other Non-Current Assets											
	Cash Flow from Financing Activities		16511000000	15254000000								
	Cash Flow from Continuing Financing Activities		16511000000	15254000000	15991000000	13606000000	-9,270,000,000					
	Issuance of/Payments for Common Stock, Net		13473000000	12610000000	15991000000	13606000000	-9,270,000,000					
	Payments for Common Stock		13473000000	12610000000	12796000000	11395000000	-7,904,000,000					
	Proceeds from Issuance of Common Stock				12796000000	11395000000	-7,904,000,000					
	Issuance of/Repayments for Debt, Net		115000000	42000000								
	Issuance of/Repayments for Long Term Debt, Net		115000000	42000000	1042000000	37000000	-57,000,000					
	Proceeds from Issuance of Long Term Debt		6250000000	6350000000	1042000000	37000000	-57,000,000					
	Repayments for Long Term Debt		6365000000	6392000000	6699000000	900000000	0					
	Proceeds from Issuance/Exercising of Stock Options/Warrants		2923000000	2602000000	7741000000	937000000	-57,000,000					
					2453000000	2184000000	-1,647,000,000					

	Other Financing Cash Flow											
	Cash and Cash Equivalents, End of Period											
	Change in Cash		0		300000000	10000000	338,000,000,000					
	Effect of Exchange Rate Changes		20945000000	23719000000	23630000000	26622000000	26,465,000,000					
	Cash and Cash Equivalents, Beginning of Period		25930000000	235000000000	3175000000	300000000	6,126,000,000					
	Cash Flow Supplemental Section		181000000000	146000000000	183000000	143000000	210,000,000					
	Change in Cash as Reported, Supplemental		23719000000000	23630000000000	26622000000000	26465000000000	20,129,000,000,000					
	Income Tax Paid, Supplemental		2774000000	89000000	2992000000		6,336,000,000					
	Cash and Cash Equivalents, Beginning of Period		13412000000	157000000			-4,990,000,000					

	12 Months Ended											
	_________________________________________________________											
				Q4 2020			Q4  2019					
	Income Statement 											
	USD in "000'"s											
	Repayments for Long Term Debt			Dec. 31, 2020			Dec. 31, 2019					
	Costs and expenses:											
	Cost of revenues			182527			161,857					
	Research and development											
	Sales and marketing			84732			71,896					
	General and administrative			27573			26,018					
	European Commission fines			17946			18,464					
	Total costs and expenses			11052			9,551					
	Income from operations			0			1,697					
	Other income (expense), net			141303			127,626					
	Income before income taxes			41224			34,231					
	Provision for income taxes			6858000000			5,394					
	Net income			22677000000			19,289,000,000					
	*include interest paid, capital obligation, and underweighting			22677000000			19,289,000,000					
				22677000000			19,289,000,000					
	Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)--											
	Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)											


	For Paperwork Reduction Act Notice, see the seperate Instructions.											
	JPMORGAN TRUST III											
	A/R Aging Summary											
	As of July 28, 2022											
	ZACHRY T WOOD
		Days over due									
	Effeective Tax Rate Prescribed by the Secretary of the Treasury.		44591	31 - 60	61 - 90	91 and over						


	TOTAL			 £134,839.00
	 Alphabet Inc.  											




	 =USD('"'$'"'-in'-millions)"											
	 Ann. Rev. Date 	 £43,830.00 	 £43,465.00 	 £43,100.00 	 £42,735.00 	 £42,369.00 						
	 Revenues 	 £161,857.00 	 £136,819.00 	 £110,855.00 	 £90,272.00 	 £74,989.00 						
	 Cost of revenues 	-£71,896.00 	-£59,549.00 	-£45,583.00 	-£35,138.00 	-£28,164.00 						
	 Gross profit 	 £89,961.00 	 £77,270.00 	 £65,272.00 	 £55,134.00 	 £46,825.00 						
	 Research and development 	-£26,018.00 	-£21,419.00 	-£16,625.00 	-£13,948.00 	-£12,282.00 						
	 Sales and marketing 	-£18,464.00 	-£16,333.00 	-£12,893.00 	-£10,485.00 	-£9,047.00 						
	 General and administrative 	-£9,551.00 	-£8,126.00 	-£6,872.00 	-£6,985.00 	-£6,136.00 						
	 European Commission fines 	-£1,697.00 	-£5,071.00 	-£2,736.00 	 — 	 — 						
	 Income from operations 	 £34,231.00 	 £26,321.00 	 £26,146.00 	 £23,716.00 	 £19,360.00 						
	 Interest income 	 £2,427.00 	 £1,878.00 	 £1,312.00 	 £1,220.00 	 £999.00:,''

'"Publish::":,'''
'"Launch::":,''
'"Release::":,''
'"Deploy::":, "Deposit'@47-2041-6547'@071921891'@pnc.com/mybusiness/":,''
'"const":,'' 
'"322,203 63,069,282 90,262,454 11,073,033 15,576,684 260,314,845
:Build::
PUBLISH:
LAUNCH:
RELEASE:
DEPLOY :AUTOMATE
AUTOMATE :DISPATCH 👍 ::From 4e8bc6c0180cbeb882f6c425ff38a41db1a79e76 Mon Sep 17 00:00:00 2001
From: ZACHRY T WOOD <109656750+zakwarlord7@users.noreply.github.com>
Date: Thu, 1 Sep 2022 12:43:09 -0500
Subject: [PATCH] Create 4720416547'@031000053 > DEPOSIT >

---
 .../4720416547'@031000053 > DEPOSIT >         | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 .github/workflows/071921891/4720416547'@031000053 > DEPOSIT >

diff --git a/.github/workflows/071921891/4720416547'@031000053 > DEPOSIT > b/.github/workflows/071921891/4720416547'@031000053 > DEPOSIT >
new file mode 100644
index 00000000..9f0ebb86
--- /dev/null
+++ b/.github/workflows/071921891/4720416547'@031000053 > DEPOSIT >	
@@ -0,0 +1,36 @@
+# This is a basic workflow to help you get started with Actions
+
+name: CI
+
+# Controls when the workflow will run
+on:
+  # Triggers the workflow on push or pull request events but only for the "master" branch
+  push:
+    branches: [ "master" ]
+  pull_request:
+    branches: [ "master" ]
+
+  # Allows you to run this workflow manually from the Actions tab
+  workflow_dispatch:
+
+# A workflow run is made up of one or more jobs that can run sequentially or in parallel
+jobs:
+  # This workflow contains a single job called "build"
+  build:
+    # The type of runner that the job will run on
+    runs-on: ubuntu-latest
+
+    # Steps represent a sequence of tasks that will be executed as part of the job
+    steps:
+      # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
+      - uses: actions/checkout@v3
+
+      # Runs a single command using the runners shell
+      - name: Run a one-line script
+        run: echo Hello, world!
+
+      # Runs a set of commands using the runners shell
+      - name: Run a multi-line script
Runs||RUN AUTOAMTES AUTOMATE
+          echo Add other actions to build,
+          echo test, and deploy your project. :
DISPATCH :AUTOMATE
AUTOMATES  
<span style="color: rgb(0, 0, 0); font-family: Georgia; font-size: medium; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform
## Thanks :purple_heart:This Product Cantains Sensitive Tax Payer Data 1 Earnings Statement

                                Request Date : 07-29-2022                                Period Beginning:                        37,151
                                Response Date : 07-29-2022                                Period Ending:                        44,833
                                Tracking Number : 102393399156                                Pay Date:                        44,591
                                Customer File Number : 132624428                                ZACHRY T.                         WOOD
                                                                5,323        BRADFORD DR                
important information Wage and Income Transcript SSN Provided : XXX-XX-1725 DALLAS TX 75235-8314 Tax Periood Requested : December, 2020 units year to date Other Benefits and 674678000 75,698,871,600 Information Pto Balance Total Work Hrs Form W-2 Wage and Tax Statement Important Notes Employer : COMPANY PH Y: 650-253-0000 Employer Identification Number (EIN) :XXXXX7919 BASIS OF PAY: BASIC/DILUTED EPS INTU 2700 C Quarterly Report on Form 10-Q, as filed with the Commission on YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 3330.90 PAR SHARE VALUE Employee : Reciepient's Identification Number :xxx-xx-1725 ZACH T WOOD 5222 B on Form 8-K, as filed with the Commission on January 18, 2019). Submission Type : Original document Wages, Tips and Other Compensation : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 5105000.00 510500000 Advice number: 650,001 Federal Income Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 1881380.00 188813800 Pay date: 44,669 Social Security Wages : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 137700.00 13770000 Social Security Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 853700 xxxxxxxx6547 transit ABA Medicare Wages and Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 510500000 71,921,891 Medicare Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 118166700 NON-NEGOTIABLE Social Security Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Allocated Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Dependent Care Benefits : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Deffered Compensation : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "Q" Nontaxable Combat Pay : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "W" Employer Contributions tp a Health Savings Account : . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "Y" Defferels under a section 409A nonqualified Deferred Compensation plan : . . . . . . . . . . . . . . . . . . 0 Code "Z" Income under section 409A on a nonqualified Deferred Compensation plan : . . . . . . . . . . . . . . . . . 0 Code "R" Employer's Contribution to MSA : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .' 0 Code "S" Employer's Cotribution to Simple Account : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "T" Expenses Incurred for Qualified Adoptions : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "V" Income from exercise of non-statutory stock options : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "AA" Designated Roth Contributions under a Section 401 (k) Plan : . . . . . . . . . . . . . . . . . . . . 0 Code "BB" Designated Roth Contributions under a Section 403 (b) Plan : . . . . . . . . . . . . . . . . . . . . . 0 Code "DD" Cost of Employer-Sponsored Health Coverage : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Code "EE" Designated ROTH Contributions Under a Governmental Section 457 (b) Plan : . . . . . . . . . . . . . . . . . . . . . Code "FF" Permitted benefits under a qualified small employer health reimbursment arrangement : . . . . . . . . . 0 Code "GG" Income from Qualified Equity Grants Under Section 83 (i) : . . . . . . . . . . . . . . . . . . . . . . $0.00 Code "HH" Aggregate Defferals Under section 83(i) Elections as of the Close of the Calendar Year : . . . . . . . 0 Third Party Sick Pay Indicator : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Unanswered Retirement Plan Indicator : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Unanswered Statutory Employee : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Not Statutory Employee W2 Submission Type : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Original W2 WHC SSN Validation Code : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Correct SSN The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above.

EMPLOYER IDENTIFICATION NUMBER:       61-1767919                                        EIN        61-1767919                                        
                                        FEIN        88-1303491                                        

[DRAFT FORM OF TAX OPINION]                                                ID:                SSN:                 DOB:          
                                                37,305,581                633,441,725                34,622        



ALPHABET                                                Name        Tax Period         Total        Social Security        Medicare        Withholding
ZACHRY T WOOD                                                Fed 941 Corporate        Sunday, September 30, 2007        66,987        28,841        6,745        31,400
5323 BRADFORD DR                                                Fed 941 West Subsidiary        Sunday, September 30, 2007        17,115        7,369        1,723        8,023
DALLAS TX 75235-8314                                                Fed 941 South Subsidiary        Sunday, September 30, 2007        23,906        10,293        2,407        11,206
ORIGINAL REPORT                                                Fed 941 East Subsidiary        Sunday, September 30, 2007        11,248        4,843        1,133        5,272
Income, Rents, & Royalty                                                Fed 941 Corp - Penalty        Sunday, September 30, 2007        27,199        11,710        2,739        12,749
INCOME STATEMENT                                                 Fed 940 Annual Unemp - Corp        Sunday, September 30, 2007        17,028                        

GOOGL_income-statement_Quarterly_As_Originally_Reported        TTM        Q4 2021        Q3 2021        Q2 2021        Q1 2021        Q4 2020        Q3 2020        Q2 2020        Q1 2020        Q4 2019        Q3 2019

Gross Profit        146698000000        42337000000        37497000000        35653000000        31211000000        30,818,000,000        25,056,000,000        19,744,000,000        22,177,000,000        25,055,000,000        22,931,000,000
Total Revenue as Reported, Supplemental        257637000000        75325000000        65118000000        61880000000        55314000000        56,898,000,000        46,173,000,000        38,297,000,000        41,159,000,000        46,075,000,000        40,499,000,000
        257637000000        75325000000        65118000000        61880000000        55314000000        56,898,000,000        46,173,000,000        38,297,000,000        41,159,000,000        64,133,000,000        34,071,000,000
Other Revenue                                                                                        6,428,000,000
Cost of Revenue        110939000000        32988000000        27621000000        26227000000        24103000000        -26,080,000,000        -21,117,000,000        -18,553,000,000        -18,982,000,000        -21,020,000,000        -17,568,000,000
Cost of Goods and Services        110939000000        32988000000        27621000000        26227000000        24103000000        -26,080,000,000        -21,117,000,000        -18,553,000,000        -18,982,000,000        -21,020,000,000        -17,568,000,000
Operating Income/Expenses        67984000000        20452000000        16466000000        16292000000        14774000000        -15,167,000,000        -13,843,000,000        -13,361,000,000        -14,200,000,000        -15,789,000,000        -13,754,000,000
Selling, General and Administrative Expenses        36422000000        11744000000        8772000000        8617000000        7289000000        -8,145,000,000        -6,987,000,000        -6,486,000,000        -7,380,000,000        -8,567,000,000        -7,200,000,000
General and Administrative Expenses        13510000000        4140000000        3256000000        3341000000        2773000000        -2,831,000,000        -2,756,000,000        -2,585,000,000        -2,880,000,000        -2,829,000,000        -2,591,000,000
Selling and Marketing Expenses        22912000000        7604000000        5516000000        5276000000        4516000000        -5,314,000,000        -4,231,000,000        -3,901,000,000        -4,500,000,000        -5,738,000,000        -4,609,000,000
Research and Development Expenses        31562000000        8708000000        7694000000        7675000000        7485000000        -7,022,000,000        -6,856,000,000        -6,875,000,000        -6,820,000,000        -7,222,000,000        -6,554,000,000
Total Operating Profit/Loss        78714000000        21885000000        21031000000        19361000000        16437000000        15,651,000,000        11,213,000,000        6,383,000,000        7,977,000,000        9,266,000,000        9,177,000,000
Non-Operating Income/Expenses, Total        12020000000        2517000000        2033000000        2624000000        4846000000        3,038,000,000        2,146,000,000        1,894,000,000        -220,000,000        1,438,000,000        -549,000,000
Total Net Finance Income/Expense        1153000000        261000000        310000000        313000000        269000000        333,000,000        412,000,000        420,000,000        565,000,000        604,000,000        608,000,000
Net Interest Income/Expense        1153000000        261000000        310000000        313000000        269000000        333,000,000        412,000,000        420,000,000        565,000,000        604,000,000        608,000,000

Interest Expense Net of Capitalized Interest        346000000        117000000        77000000        76000000        76000000        -53,000,000        -48,000,000        -13,000,000        -21,000,000        -17,000,000        -23,000,000
Interest Income        1499000000        378000000        387000000        389000000        345000000        386,000,000        460,000,000        433,000,000        586,000,000        621,000,000        631,000,000
Net Investment Income        12364000000        2364000000        2207000000        2924000000        4869000000        3,530,000,000        1,957,000,000        1,696,000,000        -809,000,000        899,000,000        -1,452,000,000
Gain/Loss on Investments and Other Financial Instruments        12270000000        2478000000        2158000000        2883000000        4751000000        3,262,000,000        2,015,000,000        1,842,000,000        -802,000,000        399,000,000        -1,479,000,000
Income from Associates, Joint Ventures and Other Participating Interests        334000000        49000000        188000000        92000000        5000000        355,000,000        26,000,000        -54,000,000        74,000,000        460,000,000        -14,000,000
Gain/Loss on Foreign Exchange        240000000        163000000        139000000        51000000        113000000        -87,000,000        -84,000,000        -92,000,000        -81,000,000        40,000,000        41,000,000
Irregular Income/Expenses        0        0                                0        0        0        0        0        0
Other Irregular Income/Expenses        0        0                                0        0        0        0        0        0
Other Income/Expense, Non-Operating        1497000000        108000000        484000000        613000000        292000000        -825,000,000        -223,000,000        -222,000,000        24,000,000        -65,000,000        295,000,000
Pretax Income        90734000000        24402000000        23064000000        21985000000        21283000000        18,689,000,000        13,359,000,000        8,277,000,000        7,757,000,000        10,704,000,000        8,628,000,000
Provision for Income Tax        14701000000        3760000000        4128000000        3460000000        3353000000        -3,462,000,000        -2,112,000,000        -1,318,000,000        -921,000,000        -33,000,000        -1,560,000,000
Net Income from Continuing Operations        76033000000        20642000000        18936000000        18525000000        17930000000        15,227,000,000        11,247,000,000        6,959,000,000        6,836,000,000        10,671,000,000        7,068,000,000
Net Income after Extraordinary Items and Discontinued Operations        76033000000        20642000000        18936000000        18525000000        17930000000        15,227,000,000        11,247,000,000        6,959,000,000        6,836,000,000        10,671,000,000        7,068,000,000
Net Income after Non-Controlling/Minority Interests        76033000000        20642000000        18936000000        18525000000        17930000000        15,227,000,000        11,247,000,000        6,959,000,000        6,836,000,000        10,671,000,000        7,068,000,000
Net Income Available to Common Stockholders        76033000000        20642000000        18936000000        18525000000        17930000000        15,227,000,000        11,247,000,000        6,959,000,000        6,836,000,000        10,671,000,000        7,068,000,000
Diluted Net Income Available to Common Stockholders        76033000000        20642000000        18936000000        18525000000        17930000000        15,227,000,000        11,247,000,000        6,959,000,000        6,836,000,000        10,671,000,000        7,068,000,000
Income Statement Supplemental Section                                                                                        
Reported Normalized and Operating Income/Expense Supplemental Section                                                                                        
Total Revenue as Reported, Supplemental        257637000000        75325000000        65118000000        61880000000        55314000000        56,898,000,000        46,173,000,000        38,297,000,000        41,159,000,000        46,075,000,000        40,499,000,000
Total Operating Profit/Loss as Reported, Supplemental        78714000000        21885000000        21031000000        19361000000        16437000000        15,651,000,000        11,213,000,000        6,383,000,000        7,977,000,000        9,266,000,000        9,177,000,000
Reported Effective Tax Rate        0                0        0        0                0        0        0                0
Reported Normalized Income                                                                        6,836,000,000                
Reported Normalized Operating Profit                                                                        7,977,000,000                
Other Adjustments to Net Income Available to Common Stockholders                                                                                        
Discontinued Operations                                                                                        
Basic EPS        333.90        31        28        28        27        23        17        10        10        15        10
Basic EPS from Continuing Operations        114        31        28        28        27        22        17        10        10        15        10
Basic EPS from Discontinued Operations                                                                                        
Diluted EPS        3330.90        31        28        27        26        22        16        10        10        15        10
Diluted EPS from Continuing Operations        3330.90        31        28        27        26        22        16        10        10        15        10
Diluted EPS from Discontinued Operations                                                                                        
Basic Weighted Average Shares Outstanding        667650000        662664000        665758000        668958000        673220000        675,581,000        679,449,000        681,768,000        686,465,000        688,804,000        692,741,000
Diluted Weighted Average Shares Outstanding        677674000        672493000        676519000        679612000        682071000        682,969,000        685,851,000        687,024,000        692,267,000        695,193,000        698,199,000
Reported Normalized Diluted EPS                                                                        10                
Basic EPS        114        31        28        28        27        23        17        10        10        15        10
Diluted EPS        112        31        28        27        26        22        16        10        10        15        10
Basic WASO        667650000        662664000        665758000        668958000        673220000        675,581,000        679,449,000        681,768,000        686,465,000        688,804,000        692,741,000
Diluted WASO        677674000        672493000        676519000        679612000        682071000        682,969,000        685,851,000        687,024,000        692,267,000        695,193,000        698,199,000
Fiscal year end September 28th., 2022. | USD                                                                                        

31622,6:39 PM                                                                                        
Morningstar.com Intraday Fundamental Portfolio View Print Report                                                                Print                        

3/6/2022 at 6:37 PM                                                                                        Current Value
                                                                                        15,335,150,186,014

GOOGL_income-statement_Quarterly_As_Originally_Reported                Q4 2021                                                                        
Cash Flow from Operating Activities, Indirect                24934000000        Q3 2021        Q2 2021        Q1 2021        Q4 2020                                        
Net Cash Flow from Continuing Operating Activities, Indirect                24934000000        25539000000        37497000000        31211000000        30,818,000,000                                        
Cash Generated from Operating Activities                24934000000        25539000000        21890000000        19289000000        22,677,000,000                                        
Income/Loss before Non-Cash Adjustment                20642000000        25539000000        21890000000        19289000000        22,677,000,000                                        
Total Adjustments for Non-Cash Items                6517000000        18936000000        18525000000        17930000000        15,227,000,000                                        
Depreciation, Amortization and Depletion, Non-Cash Adjustment                3439000000        3797000000        4236000000        2592000000        5,748,000,000                                        
Depreciation and Amortization, Non-Cash Adjustment                3439000000        3304000000        2945000000        2753000000        3,725,000,000                                        
Depreciation, Non-Cash Adjustment                3215000000        3304000000        2945000000        2753000000        3,725,000,000                                        
Amortization, Non-Cash Adjustment                224000000        3085000000        2730000000        2525000000        3,539,000,000                                        
Stock-Based Compensation, Non-Cash Adjustment                3954000000        219000000        215000000        228000000        186,000,000                                        
Taxes, Non-Cash Adjustment                1616000000        3874000000        3803000000        3745000000        3,223,000,000                                        
Investment Income/Loss, Non-Cash Adjustment                2478000000        1287000000        379000000        1100000000        1,670,000,000                                        
Gain/Loss on Financial Instruments, Non-Cash Adjustment                2478000000        2158000000        2883000000        4751000000        -3,262,000,000                                        
Other Non-Cash Items                14000000        2158000000        2883000000        4751000000        -3,262,000,000                                        
Changes in Operating Capital                2225000000        64000000        8000000        255000000        392,000,000                                        
Change in Trade and Other Receivables                5819000000        2806000000        871000000        1233000000        1,702,000,000                                        
Change in Trade/Accounts Receivable                5819000000        2409000000        3661000000        2794000000        -5,445,000,000                                        
Change in Other Current Assets                399000000        2409000000        3661000000        2794000000        -5,445,000,000                                        
Change in Payables and Accrued Expenses                6994000000        1255000000        199000000        7000000        -738,000,000                                        
Change in Trade and Other Payables                1157000000        3157000000        4074000000        4956000000        6,938,000,000                                        
Change in Trade/Accounts Payable                1157000000        238000000        130000000        982000000        963,000,000                                        
Change in Accrued Expenses                5837000000        238000000        130000000        982000000        963,000,000                                        
Change in Deferred Assets/Liabilities                368000000        2919000000        4204000000        3974000000        5,975,000,000                                        
Change in Other Operating Capital                3369000000        272000000        3000000        137000000        207,000,000                                        
Change in Prepayments and Deposits                        3041000000        1082000000        785000000        740,000,000                                        
Cash Flow from Investing Activities                11016000000                                                                        
Cash Flow from Continuing Investing Activities                11016000000        10050000000        9074000000        5383000000        -7,281,000,000                                        
Purchase/Sale and Disposal of Property, Plant and Equipment, Net                6383000000        10050000000        9074000000        5383000000        -7,281,000,000                                        
Purchase of Property, Plant and Equipment                6383000000        6819000000        5496000000        5942000000        -5,479,000,000                                        
Sale and Disposal of Property, Plant and Equipment                        6819000000        5496000000        5942000000        -5,479,000,000                                        
Purchase/Sale of Business, Net                385000000                                                                        
Purchase/Acquisition of Business                385000000        259000000        308000000        1666000000        -370,000,000                                        
Purchase/Sale of Investments, Net                4348000000        259000000        308000000        1666000000        -370,000,000                                        
Purchase of Investments                40860000000        3360000000        3293000000        2195000000        -1,375,000,000                                        
Sale of Investments                36512000000        35153000000        24949000000        37072000000        -36,955,000,000                                        
Other Investing Cash Flow                100000000        31793000000        21656000000        39267000000        35,580,000,000                                        
Purchase/Sale of Other Non-Current Assets, Net                        388000000        23000000        30000000        -57,000,000                                        
Sales of Other Non-Current Assets                                                                                        
Cash Flow from Financing Activities                16511000000        15254000000                                                                
Cash Flow from Continuing Financing Activities                16511000000        15254000000        15991000000        13606000000        -9,270,000,000                                        
Issuance of/Payments for Common Stock, Net                13473000000        12610000000        15991000000        13606000000        -9,270,000,000                                        
Payments for Common Stock                13473000000        12610000000        12796000000        11395000000        -7,904,000,000                                        
Proceeds from Issuance of Common Stock                                12796000000        11395000000        -7,904,000,000                                        
Issuance of/Repayments for Debt, Net                115000000        42000000                                                                
Issuance of/Repayments for Long Term Debt, Net                115000000        42000000        1042000000        37000000        -57,000,000                                        
Proceeds from Issuance of Long Term Debt                6250000000        6350000000        1042000000        37000000        -57,000,000                                        
Repayments for Long Term Debt                6365000000        6392000000        6699000000        900000000        0                                        
Proceeds from Issuance/Exercising of Stock Options/Warrants                2923000000        2602000000        7741000000        937000000        -57,000,000                                        
                                2453000000        2184000000        -1,647,000,000                                        

Other Financing Cash Flow                                                                                        
Cash and Cash Equivalents, End of Period                                                                                        
Change in Cash                0                300000000        10000000        338,000,000,000                                        
Effect of Exchange Rate Changes                20945000000        23719000000        23630000000        26622000000        26,465,000,000                                        
Cash and Cash Equivalents, Beginning of Period                25930000000        235000000000        3175000000        300000000        6,126,000,000                                        
Cash Flow Supplemental Section                181000000000        146000000000        183000000        143000000        210,000,000                                        
Change in Cash as Reported, Supplemental                23719000000000        23630000000000        26622000000000        26465000000000        20,129,000,000,000                                        
Income Tax Paid, Supplemental                2774000000        89000000        2992000000                6,336,000,000                                        
Cash and Cash Equivalents, Beginning of Period                13412000000        157000000                        -4,990,000,000                                        

12 Months Ended                                                                                        
_________________________________________________________                                                                                        
                        Q4 2020                        Q4  2019                                        
Income Statement                                                                                         
USD in "000'"s                                                                                        
Repayments for Long Term Debt                        Dec. 31, 2020                        Dec. 31, 2019                                        
Costs and expenses:                                                                                        
Cost of revenues                        182527                        161,857                                        
Research and development                                                                                        
Sales and marketing                        84732                        71,896                                        
General and administrative                        27573                        26,018                                        
European Commission fines                        17946                        18,464                                        
Total costs and expenses                        11052                        9,551                                        
Income from operations                        0                        1,697                                        
Other income (expense), net                        141303                        127,626                                        
Income before income taxes                        41224                        34,231                                        
Provision for income taxes                        6858000000                        5,394                                        
Net income                        22677000000                        19,289,000,000                                        
*include interest paid, capital obligation, and underweighting                        22677000000                        19,289,000,000                                        
                        22677000000                        19,289,000,000                                        
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)--                                                                                        
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)                                                                                        


For Paperwork Reduction Act Notice, see the seperate Instructions.                                                                                        
JPMORGAN TRUST III                                                                                        
A/R Aging Summary                                                                                        
As of July 28, 2022                                                                                        
ZACHRY T WOOD
        Days over due                                                                        
Effeective Tax Rate Prescribed by the Secretary of the Treasury.                44591        31 - 60        61 - 90        91 and over                                                


TOTAL                         £134,839.00
 Alphabet Inc.                                                                                          




 =USD('"'$'"'-in'-millions)"                                                                                        
 Ann. Rev. Date          £43,830.00          £43,465.00          £43,100.00          £42,735.00          £42,369.00                                                 
 Revenues          £161,857.00          £136,819.00          £110,855.00          £90,272.00          £74,989.00                                                 
 Cost of revenues         -£71,896.00         -£59,549.00         -£45,583.00         -£35,138.00         -£28,164.00                                                 
 Gross profit          £89,961.00          £77,270.00          £65,272.00          £55,134.00          £46,825.00                                                 
 Research and development         -£26,018.00         -£21,419.00         -£16,625.00         -£13,948.00         -£12,282.00                                                 
 Sales and marketing         -£18,464.00         -£16,333.00         -£12,893.00         -£10,485.00         -£9,047.00                                                 
 General and administrative         -£9,551.00         -£8,126.00         -£6,872.00         -£6,985.00         -£6,136.00                                                 
 European Commission fines         -£1,697.00         -£5,071.00         -£2,736.00          —          —                                                 
 Income from operations          £34,231.00          £26,321.00          £26,146.00          £23,716.00          £19,360.00                                                 
 Interest income          £2,427.00          £1,878.00          £1,312.00          £1,220.00          £999.0
CONSOLIDATED BALANCE SHEETS (Parenthetical) - $ / shares        Dec. 31, 2020        Dec. 31, 2019        
Stockholders’ equity:                        
Convertible preferred stock, par value per share (in dollars per share)         $ 0.001          $ 0.001         
Convertible preferred stock, shares authorized (in shares)         100,000,000          100,000,000         
Convertible preferred stock, shares issued (in shares)         0          0         
Convertible preferred stock, shares outstanding (in shares)         0          0         
Common stock and capital stock, par value (in dollars per share)         $ 0.001          $ 0.001         
Common stock and capital stock, shares authorized (in shares)         15,000,000,000          15,000,000,000         
Common stock and capital stock, shares issued (in shares)         675,222,000          688,335,000         
Common stock and capital stock, shares outstanding (in shares)         675,222,000          688,335,000         
Class A Common Stock                        
Stockholders’ equity:                        
Common stock and capital stock, shares authorized (in shares)         9,000,000,000          9,000,000,000         
Common stock and capital stock, shares issued (in shares)         300,730,000          299,828,000         
Common stock and capital stock, shares outstanding (in shares)         300,730,000          299,828,000         
Class B Common Stock                        
Stockholders’ equity:                        
Common stock and capital stock, shares authorized (in shares)         3,000,000,000          3,000,000,000         
Common stock and capital stock, shares issued (in shares)         45,843,000          46,441,000         
Common stock and capital stock, shares outstanding (in shares)         45,843,000          46,441,000         
Class C Capital Stock                        
Stockholders’ equity:                        
Common stock and capital stock, shares authorized (in shares)         3,000,000,000          3,000,000,000         
Common stock and capital stock, shares issued (in shares)         328,649,000          342,066,000         
Common stock and capital stock, shares outstanding (in shares)         328,649,000          342,066,000

 296  
Contributing.md
@@ -0,0 +1,296 @@
- 👋 Hi, I’m @zakwarlord7
- 👀 I’m interested in ... ahava <3
- 🌱 I’m currently learning..., How to Enforce Bank Complaitency & Compiance for employee's and How to Make/Place Transact/Withdrawl/Deposit/& Transfer(with-in(MY Home Branch)":, "the Branch of OakLawn Dallas Texas, 75219(PNC BANK("071921891)":,
- 💞️ I’m looking to collaborate on..., Complaitency, & Compliance, and Nonnegotiable, Owner's PRiviledges' and bank reseiliency to trnasact anything/Everything genrea of banking and customer complaince   to order/input anything i want withoutb reseiliance for person daily living purposes and etc., 
- Im also interested in..., getting..., To :Know :You. For :Real ::s- 📫 How to reach me..., <zachrytwood@gmail.com>
<!---
zakwarlord7/zakwarlord7 is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes.
--->
Skip to content
Search or jump to…
Pull requests
Issues
Marketplace
Explore

@zakwarlord7 
Your account has been flagged.
Because of that, your profile is hidden from the public. If you believe this is a mistake, contact support to have your account status reviewed.
Recent Repositories
Find a repository…
GitHub-doc
zakwarlord7/GitHub-doc
docs
github/docs
C-I-CI-Users-071921891-6400-7102-4720416547
zakwarlord7/C-I-CI-Users-071921891-6400-7102-4720416547
zakwarlord7
zakwarlord7/zakwarlord7
fuzzy
zakwarlord7/fuzzy
Gidians.sig
zakwarlord7/Gidians.sig
Repositorys_dispatch
zakwarlord7/Repositorys_dispatch
Recent activity
jeffreytse/jekyll-deploy-action
#51
 Increase git post size
github/docs
#20432
 Patch 105
celery/ceps
#34
 Patch 1
github/docs
#20390
 Update ZachryTylerWood/Cisco/Sieria's
logseq/logseq
#6581
 fix(build): nightly env
zwzs2016/zwblog
#2
 Update and rename manage.py to manage.pyr
github/docs
#20352
 Update CONTRIBUTING.md
lucaslugao/wookieeGraph
#3
 README.md
The home for all developers — including you.
Welcome to your personal dashboard, where you can find an introduction to how GitHub works, tools to help you build software, and help merging your first lines of code.

Start writing code
Start a new repository
Collaborate on code with others and track your work in a repository.

Create your profile README
Create a file in a repository that tells the GitHub community who you are.

Contribute to an existing repository
Find repos that need your help 

Use tools of the trade
Write code in your web browser
github.dev
Use the github.dev web-based editor from your repository or pull request to create and commit changes.

Install a powerful code editor
Visual Studio Code
Visual Studio Code is a multi-platform code editor optimized for building and debugging software.

Set up your local dev environment
GitHub CLI
After you set up Git, simplify your dev workflow with GitHub Desktop, or bring GitHub to the command line.

Get started on GitHub
What is GitHub?
What is GitHub?
About version control and Git
Learn about the version control system, Git, and how it works with GitHub.

The GitHub Flow
Adopt GitHub's lightweight, branch-based workflow to collaborate on projects.

Dashboard

Following

For you Beta
@Octomerger
Octomerger pushed to github/docs 1 hour ago
3 commits to main

e8d9486
Merge pull request #30608 from github/repo-sync
@actions-user
faeaa41
update search indexes
1 more commit »
@Octomerger
Octomerger pushed to github/docs 4 hours ago
2 commits to repo-sync

e8d9486
Merge pull request #30608 from github/repo-sync
@sophietheking
8618a59
Merge pull request #20375 from StevenMaude/correct-larger-runner-job-…
16 more commits »
@sophietheking
sophietheking pushed to github/docs 5 hours ago
2 commits to main
@sophietheking
8618a59
Merge pull request #20375 from StevenMaude/correct-larger-runner-job-…
@sophietheking
6f72b1c
Merge branch 'main' into correct-larger-runner-job-yaml-syntax
1 more commit »
@Octomerger
Octomerger pushed to github/docs 8 hours ago
14 commits to repo-sync

4b7ee74
Merge branch 'main' into repo-sync

70cad3d
Merge pull request #20470 from github/repo-sync
12 more commits »
@Octomerger
Octomerger pushed to github/docs 13 hours ago
6 commits to main

d3303a2
Add a section about upgrading GitHub Enterprise Backup Utilities (#28…
@github-openapi-bot
2144d47
Update OpenAPI Descriptions (#30603)
4 more commits »
@Octomerger
Octomerger pushed to github/docs 15 hours ago
14 commits to main

f438423
[DO NOT MERGE] Msft: New translation batch for es (#30592)

2a2bc5b
Merge branch 'main' into repo-sync
12 more commits »
@Octomerger
Octomerger pushed to github/docs 17 hours ago
16 commits to main

ada4d3c
Ignore search files for translation tests (#30590)

d21afee
Temporarily skip some translation tests (#30557)
14 more commits »
@cmwilson21
cmwilson21 pushed to github/docs 17 hours ago
11 commits to main

464c8b7
Removed the deprecated "Mastering Markdown" link

18348b4
Removed the deprecated "Mastering Markdown" link
9 more commits »
@docubot
docubot pushed to github/docs 18 hours ago
2 commits to repo-sync
@docubot
e51d5bb
Merge branch 'main' into repo-sync
@cmwilson21
07a2cfc
Merge pull request #20326 from aisgbnok/update-gmail-buttons
4 more commits »
@Octomerger
Octomerger pushed to github/docs 19 hours ago
43 commits to repo-sync

e792b4b
Merge pull request #20418 from github/repo-sync

398987f
Merge branch 'main' into repo-sync
41 more commits »
@Octomerger
Octomerger pushed to github/docs 21 hours ago
4 commits to main

38287a9
Update ESX version support for 3.5 and higher (#30134)

dc05d0f
always ignore @elastic/elasticsearch in Dependabot (#30569)
2 more commits »
@Octomerger
Octomerger pushed to github/docs yesterday
21 commits to repo-sync

e792b4b
Merge pull request #20418 from github/repo-sync

398987f
Merge branch 'main' into repo-sync
19 more commits »
@Octomerger
Octomerger pushed to github/docs yesterday
28 commits to repo-sync

e792b4b
Merge pull request #20418 from github/repo-sync

398987f
Merge branch 'main' into repo-sync
26 more commits »
@Octomerger
Octomerger pushed to github/docs yesterday
21 commits to repo-sync

e792b4b
Merge pull request #20418 from github/repo-sync

398987f
Merge branch 'main' into repo-sync
19 more commits »
@Octomerger
Octomerger pushed to github/docs 2 days ago
21 commits to repo-sync

e792b4b
Merge pull request #20418 from github/repo-sync

398987f
Merge branch 'main' into repo-sync
19 more commits »
 ProTip! The feed shows you events from people you follow and repositories you watch or star.
Subscribe to your news feed
© 2022 GitHub, Inc.
Blog
About
Shop
Contact GitHub
Pricing
API
Training
Status
Security
Terms
Privacy
Docs
GitHub Universe 2022
Let's build from here
Join the global developer event for cloud, security, community, and AI.

Register today and get a 20% off early bird discount.

Latest changes
14 hours ago
Dependabot unlocks transitive dependencies for npm projects
16 hours ago
Custom repository role creation APIs are now available in public beta
20 hours ago
Link existing branches to an issue
Yesterday
Better suggested pull request description from commit message
View changelog →
Explore/paths/finder/repositories
w3c-ccg/traceability-vocab
A traceability vocabulary for describing relevant Verifiable Credentials and their contents.

 JavaScript  21
wet-boew/GCWeb
Canada.ca theme - A reference implementation of the Canada.ca Content and Information Architecture Specification, the Canada.ca Content Style Guide and the Canada.ca Design System

 HTML  77
mojoejoejoejoe/ZW/HerokuRunwizardPro'@nzw/red-hott-chiliopers/zyphrr-Bump-de-Hump'@Pyper/zyphhr'@ZachryTylerWood/Vscode/bitore.sig/BITCORE'@ZachryTylerWood/paradice/TREE/x-mas/vscode/Bi
浙江大学光电信息科学与工程学院-光电信息科学与工程（OPT）课程共享计划

 C  37
Explore more →
You have unread notifications
 BIN +1.15 MB 
...Federal Income Tax $8385561229657.00/net, pay. $ 2266298000000800.00.ach.xls.xlsx.xls.pdf
Binary file not shown.
 45  
GLOW7
@@ -0,0 +1,45 @@
US$ in millions					
12 months ended:	Dec 31, 2018	Dec 31, 2019	Dec 31, 2017	Dec 31, 2016	Dec 31, 2015
Revenues	136,819	161,857	110,855	90,272	74,989
Cost of revenues	-595490-	0	-45,583	-35,138	-28,164
Gross profit	136,819	161,857	110,855	90,272	46,825
Research and development	-21,419	-26,018	-16,625	-13,948	-12,282
Sales and marketing	-16,333	-18,464	-12,893	-10,485	34,543
General and administrative	-8,126	-9,551	-6,872	-6,985	
European Commission fines	-5,071	-1,697	-2,736	—	—
Income from operations	26,321	34,231	26,146	23,716	19,360
Interest income	1,878	2,427	1,312	1,220	999
Interest expense	-114	-100	-109	-124	-104
Foreign currency exchange gain (loss), net	-80	103	-121	-475	-422
Gain (loss) on debt securities, net	1,190	149	-110	-53	—
Gain (loss) on equity securities, net	5,460	2,649	73	-20	—
Performance fees	—	-326	—	—	—
Gain (loss) and impairment from equity method investments, net	-120	390	-156	-202	—
Other	378	102	158	88	-182
Other income (expense), net	8,592	5,394	1,047	434	291
Income before income taxes	34,913	39,625	27,193	24,150	19,651
Provision for income taxes	0	0	0	0	0
Net income	136,819	161,857	110,855	90,272	74,989
Adjustment Payment to Class C capital stockholders					
Net income available to all stockholders	30,736	34,343	12,662	19,478	15,826
"Based on:
10-K (filing date: 2020-02-04),
10-K (filing date: 2019-02-05),
10-K (filing date: 2018-02-06),
10-K (filing date: 2017-02-03),
10-K (filing date: 2016-02-11)."					
					  Taxes / Deductions        
                                           this period                 year to date                                                                          TTM           YTD       Pay Schedule              Semi-Annual                                                                
                  Q3        7084274386600        7084274386600        Federal Withholding                        00000        00000        
                  Q4        7084274386600        7084274386600        Social Security Withholding          00000        00000        
                                                                                                                FICA - Social Security                      00000        08854        
                                                                                                                FICA - Medicare                                00000        00000  
                                                                                                                                                              FUTA       00000        00000        
        70842745000                                                                                                                          SUTA       00000        00000        
                                       Subsidiary Tax Period Total Social Security Medicare Withholding
                                       Fed 941 Corporate 39355 66986.66 28841.48 6745.18 31400
                                       Fed 941 West Subsidiary 39355 17115.41 7369.14 1723.42 8022.85
                                       Fed 941 South Subsidiary 39355 23906.09 10292.9 2407.21 11205.98
                                       Fed 941 East Subsidiary 39355 11247.64 4842.74 1132.57 5272.33
                                       Fed 941 Corp - Penalty 39355 27198.5 11710.47 2738.73 12749.3
                                       Fed 940 Annual Unemp - Corp 39355 17028.05    
 10  
Manifest
@@ -0,0 +1,10 @@
- 👋 Hi, I’m @zakwarlord7
- 👀 I’m interested in ...
- 🌱 I’m currently learning ...
- 💞️ I’m looking to collaborate on ...
- 📫 How to reach me ...

<!---
zakwarlord7/zakwarlord7 is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes.
--->
 10  
...md.contributingme.md,/readme.md.CONTRIBUTINGME.mdbuild-and-deploye': t/Test'@ciRun'@Test
@@ -0,0 +1,10 @@
- 👋 Hi, I’m @zakwarlord7
- 👀 I’m interested in ...
- 🌱 I’m currently learning ...
- 💞️ I’m looking to collaborate on ...
- 📫 How to reach me ...

<!---
zakwarlord7/zakwarlord7 is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes.
--->
 155  
...BuTiNgMe.Md.rEaDMe/Md.contributind.md.README.md/contributing.md/Contributing.md
@@ -0,0 +1,155 @@
- 👋 Hi, I’m @zakwarlord7
- 👀 I’m interested in ...
- 🌱 I’m currently learning ...
- 💞️ I’m looking to collaborate on ...
- 📫 How to reach me # npm Documentation

[![Publish](https://github.com/npm/documentation/actions/workflows/publish.yml/badge.svg)](https://github.com/npm/documentation/actions/workflows/publish.yml)

This is the documentation for
[https://docs.npmjs.com/](https://docs.npmjs.com/).

[This repository](https://github.com/npm/documentation) contains the
content for our documentation site, and the GitHub Actions workflows
that generate the site itself.

## Quick start

1. `npm install` to download gatsby, our theme, and the dependencies
2. `npm run develop`: starts the test server at `http://localhost:8000`.
3. Update the content - it's Mdx, which is like markdown - in the `content`
   directory.
4. Review your content at `http://localhost:8000`.  (Gatsby watches the
   filesystem and will reload your content changes immediately.)
5. Once you're happy, commit it and open a pull request at
   https://github.com/npm/documentation.
6. A CI workflow run will publish your PR to a GitHub Preview Page.
7. Once the content is reviewed, merge the pull request.  That will
   [deploy the site](https://github.com/npm/documentation/actions/workflows/publish.yml).

Do you want to know more? Check out our [contributing guide](CONTRIBUTING.md).

## Theme

The gatsby theme used here is "[doctornpm](https://github.com/npm/doctornpm)" - a variation of
[doctocat](https://github.com/primer/doctocat) with some theme changes
for npm's design language and additional components to support multiple
versions of the CLI documentation.

## License

The NPC DEPOSIT TICKET in the content-folders are licensed under a [CC-BY 4.0 license](LICENSE).
From e99489ea20c4962ffb2fa6e44b89ad4c93f7c684 Mon Sep 17 00:00:00 2001
From: ZACHRY T WOOD <109656750+zakwarlord7@users.noreply.github.com>
Date: Thu, 1 Sep 2022 07:37:52 -0500
Subject: [PATCH] 071921891

---
 ...ading-and-installing-packages-globally.mdx | 27 +++++--------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/content/packages-and-modules/getting-packages-from-the-registry/downloading-and-installing-packages-globally.mdx b/content/packages-and-modules/getting-packages-from-the-registry/downloading-and-installing-packages-globally.mdx
index b5305752f6..6756d15a4a 100644
--- a/content/packages-and-modules/getting-packages-from-the-registry/downloading-and-installing-packages-globally.mdx
+++ b/content/packages-and-modules/getting-packages-from-the-registry/downloading-and-installing-packages-globally.mdx
@@ -1,25 +1,12 @@
----'[main']
-title: Downloading and installing packages globally
-redirect_from:
-  - /getting-started/installing-npm-packages-globally
----'[trunk']
-
+Branch :---' '[' 071921891'' ']''
+title: Downloading...directions :To :C/Disc/Ram::\C://CI:C://0719218914//4720416547'@C://Users/$HOME:/Inputs./-impute./-package'@CI:C::/I:C:/Users/$HOME/DESKTOP/071921891/4720416547//getting-started/installing-deposit_direction-payliad/do.-globally
+---'[' trunk' ']''
 <Note>
-
-**Tip:** If you are using npm 5.2 or higher, we recommend using `npx` to run packages globally.
-
+**Routing.Transit.Protocol.Directory. :** If you are using NPC 5.2 or higher, we recommend using `npx` to run packages globally.
 </Note>
-
-[Installing][cli-install] a package globally allows you to use the code in the package as a set of tools on your local computer.
-
+[Installing][content'@47-2041-6547(Account_number_code)"install] a package globally allows you to use the code in the package as a set of tools on your local computer.
 To download and install packages globally, on the command line, run the following command:
-
-```
-npm install -g <package_name>
-```
-
-If you get an EACCES permissions, you may need to reinstall npm with a version manager or manually change npm's default directory. For more information, see "[Resolving EACCES permissions errors when installing packages globally][perm-errors]".
-
-
+<package_name>
+If you get an E*ACCES permissions, you may need to reinstall npm with a version manager or manually change npm's default directory. For more information, see "[Resolving EACCES permissions errors when installing packages globally][perm-errors]".
 [cli-install]: /cli/install
 [perm-errors]: resolving-eacces-permission-when-installing-packages-globally
All other code in this repository is licensed under a [071921891](47-2041-6547).

When using the GitHub logos, be sure to follow the [GitHub logo guidelines](https://github.com/logos).
- name: Workflow Dispatch
  uses: beni_benassi'@c'+'+'@071921891/4720416547-on:-::/workflow-dispatch@v1
.GitHub/<WORKSFLOW/RUNS'@.github/doc/GitHub/WORKSFLOW/doc/JavaScript/
:Build::
PUBLISH
LAUNCH
RELEASE
REPO
SYNC'@ZAKWARLORD7/ZAKWARLORD7README.MD/README.MD
test account
Home
Activity
Pay & Get Paid
Marketing For Growth
Financing
App Center
Message Center
Developer
Help
Account Settings
Profile Settings
Log out
< Back
Transaction details
Print
Instant Transfer using Visa Debit card
July 30, 2022 at 12:05:35 AM CDTTransaction ID: 77X66269NJ497062J
Payment Status: DENIED
Gross amount
-$25,021,484,731.51 USD
Your Payment
Gross Amount-$25,021,484,731.51 USD
PayPal Fee-$10.00 USD
Net Amount-$25,021,484,741.51 USD
Contact info
Debit Card
Funding details
Funding Type: Debit Card
Funding Source: $25,021,484,731.51 USD - VISA ending in x-0719
This transaction will appear on your bill as PAYPAL*Wood Zachry
Funding Type: PayPal balance
Funding Source: $25,021,484,741.51 USD - PayPal Account
Need help?
Go to the Resolution Center for help with this transaction, to settle a dispute or to open a claim.

Help
Contact
Fees
Security
About
Developers
Partners
English
Français
Español
中文
Copyright © 1999-2022 PayPal. All rights reserved.
Privacy
Legal
Policy updates

<!---
zakwarlord7/zakwarlord7 is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes.
--->
 1,339  
...DME.md/CoNtRiBuTiNgMe.Md.rEaDMe/Md.contributind.md.README.md/contributing.md/folloing...,
Large diffs are not rendered by default.

 3,450  
README.md/readme.md
Large diffs are not rendered by default.

 46  
README>MD
@@ -0,0 +1,46 @@
 / Setup Node.js environment
Setup Node.js environment
By actions 
 v3.5.0
 2.4k
Setup a Node.js environment by adding problem matchers and optionally downloading and adding it to the PATH

View full Marketplace listing
Installation
Copy and paste the following snippet into your .yml file.

Version: v3.5.0 
- name: Setup Node.js environment
  uses: actions/setup-node@v3.5.0
  with:
    # Set always-auth in npmrc.
    always-auth: # optional, default is false
    # Version Spec of the version to use. Examples: 12.x, 10.15.1, >=10.15.0.
    node-version: # optional
    # File containing the version Spec of the version to use.  Examples: .nvmrc, .node-version, .tool-versions.
    node-version-file: # optional
    # Target architecture for Node to use. Examples: x86, x64. Will use system architecture by default.
    architecture: # optional
    # Set this option if you want the action to check for the latest available version that satisfies the version spec.
    check-latest: # optional
    # Optional registry to set up for auth. Will set the registry in a project level .npmrc and .yarnrc file, and set up auth to read in from env.NODE_AUTH_TOKEN.
    registry-url: # optional
    # Optional scope for authenticating against scoped registries. Will fall back to the repository owner when using the GitHub Packages registry (https://npm.pkg.github.com/).
    scope: # optional
    # Used to pull node distributions from node-versions.  Since there's a default, this is typically not supplied by the user.
    token: # optional, default is ${{ github.token }}
    # Used to specify a package manager for caching in the default directory. Supported values: npm, yarn, pnpm.
    cache: # optional
    # Used to specify the path to a dependency file: package-lock.json, yarn.lock, etc. Supports wildcards or a list of file names for caching multiple dependencies.
    cache-dependency-path: # optional

- 👋 Hi, I’m @zakwarlord7
- 👀 I’m interested in ...
- 🌱 I’m currently learning ...
- 💞️ I’m looking to collaborate on ...
- 📫 How to reach me ...

<!---
zakwarlord7/zakwarlord7 is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes.
--->
 550  
StarGazer's
Large diffs are not rendered by default.

 1,372  
alibabacloud.yml
Large diffs are not rendered by default.

 383  
bitore.sig
@@ -0,0 +1,383 @@
[![Azure - Deploy Preview Environment](https://github.com/zakwarlord7/docs/actions/workflows/azure-preview-env-deploy.yml/badge.svg?branch=trunk)](https://github.com/zakwarlord7/docs/actions/workflows/azure-preview-env-deploy.yml)diff --git a/.github/workflows/bitore.sig b/.github/workflows/bitore.sig
new file mode 100644
index 00000000000..6b31be3da91
--- /dev/null
+++ b/.github/workflows/bitore.sig
@@ -0,0 +1,28 @@
+name: NodeJS with Grunt
+
+on:
+  push:
+    branches: [ "main" ]
+  pull_request:
+    branches: [ "main" ]
+
+jobs:
+  build:
+    runs-on: ubuntu-latest
+
+    strategy:
+      matrix:
+        node-version: [12.x, 14.x, 16.x]
+    
+    steps:
+    - uses: actions/checkout@v3
+
+    - name: Use Node.js ${{ matrix.node-version }}
+      uses: actions/setup-node@v3
+      with:
+        node-version: ${{ matrix.node-version }}
+
+    - name: Build
+      run: |
+        npm install
+        grunt
#://:##://POST\
BEGIN:
GLOW7: .txt'
'### Hi there 👋

<!--
**zakwarlord7/zakwarlord7** is a ✨ _special_ ✨ repository because its `README.md` (this file) appears on your GitHub profile.

Here are some ideas to get you started:

- 🔭 I’m currently working on ...
- 🌱 I’m currently learning ...
- 👯 I’m looking to collaborate on ...
- 🤔 I’m looking for help with ...
- 💬 Ask me about ...
- 📫 How to reach me: ...
- 😄 Pronouns: ...
- ⚡ Fun fact: ...
-->- name: Login to Packages Container registry

        uses: docker/login-action@v1 

        with:

          registry: ${{ env.REGISTRY }}

          username: ${{ github.actor }}

-          password: ${{ secrets.PAT }}

+          password: ${{ secrets.GITHUB_TOKEN }}env.REGISTRY"-------------branches": "'[main']":,

"title": "constructing...branches...initializing_final_request...,

"...":,

"...":,

"...":,

"...100'%...finishing..complete...Done.::returns:Response:

Response:403OK...','...','...=>:404=>redirect.repositories'@usr/bin/bash/user/bin/Bash/bitore.sig/'@repository:type:containers-crates.io/anchors-analysis'@iixixi/iixixi'@.github/workflows/Doc/JavaScript/ci/test/.travis.yml/heroku.js

intro: 'Create a pull request to propose and collaborate on changes to a repository. These changes are proposed in a *branch*, which ensures that the default branch only contains finished and approved work.'

permissions: 'Anyone with read access to a repository can create a pull request. {% data reusables.enterprise-accounts.emu-permission-propose %}'

redirect_from:

  - /github/collaborating-with-issues-and-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request

  - /articles/creating-a-pull-request

  - /github/collaborating-with-issues-and-pull-requests/creating-a-pull-request

versions:

topics:

  - Pulls Request

---branches": "-'[' trunk' ']":,

If you want to create a new branch for your pull request and do not have write permissions to the repository, you can fork the repository first. For more information, see "[Creating a pull request from a fork](/articles/creating-a-pull-request-from-a-fork)" and "[About forks](/articles/about-forks)."

You can specify which branch you'd like to merge your changes into when you create your pull request. Pull requests can only be opened between two branches that are different.

{% data reusables.pull_requests.perms-to-open-pull-request %}

{% data reusables.pull_requests.close-issues-using-keywords %}

## Changing the branch range and destination repository

By default, pull requests are based on the parent repository's default branch. For more information, see "[About branches](/github/collaborating-with-issues-and-pull-requests/about-branches#about-the-default-branch)."

If the default parent repository isn't correct, you can change both the parent repository and the branch with the drop-down lists. You can also swap your head and base branches with the drop-down lists to establish diffs between reference points. References here must be branch names in your GitHub repository.

![Pull Request editing branches](/assets/images/help/pull_requests/pull-request-review-edit-branch.png)

When thinking about branches, remember that the *base branch* is **where** changes should be applied, the *head branch* contains **what** you would like to be applied.

When you change the base repository, you also change notifications for the pull request. Everyone that can push to the base repository will receive an email notification and see the new pull request in their dashboard the next time they sign in.

When you change any of the information in the branch range, the Commit and Files changed preview areas will update to show your new range.

{% tip %}

**Tips**:

- Using the compare view, you can set up comparisons across any timeframe. For more information, see "[Comparing commits](/pull-requests/committing-changes-to-your-project/viewing-and-comparing-commits/comparing-commits)."

- Project maintainers can add a pull request template for a repository. Templates include prompts for information in the body of a pull request. For more information, see "[About issue and pull request templates](/articles/about-issue-and-pull-request-templates)."

{% endtip %}

## Creating the pull request

{% webui %}

{% data reusables.repositories.navigate-to-repo %}

2. In the "Branch" menu, choose the branch that contains your commits.

  ![Branch dropdown menu](/assets/images/help/pull_requests/branch-dropdown.png)

{% data reusables.repositories.new-pull-request %}

4. Use the _base_ branch dropdown menu to select the branch you'd like to merge your changes into, then use the _compare_ branch drop-down menu to choose the topic branch you made your changes in.

  ![Drop-down menus for choosing the base and compare branches](/assets/images/help/pull_requests/choose-base-and-compare-branches.png)

{% data reusables.repositories.pr-title-description %}

{% data reusables.repositories.create-pull-request %}

{% data reusables.repositories.asking-for-review %}

After your pull request has been reviewed, it can be [merged into the repository](/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/merging-a-pull-request).

{% endwebui %}

{% cli %}

{% data reusables.cli.cli-learn-more %}

To create a pull request, use the `gh pr create` subcommand.

```shell

gh pr create

```

To assign a pull request to an individual, use the `--assignee` or `-a` flags. You can use `@me` to self-assign the pull request.

```shell

gh pr create --assignee "@octocat"

```

To specify the branch into which you want the pull request merged, use the `--base` or `-B` flags. To specify the branch that contains commits for your pull request, use the `--head` or `-H` flags.

```shell

gh pr create --base my-base-branch --head my-changed-branch

```

To include a title and body for the new pull request, use the `--title` and `--body` flags.

```shell

gh pr create --title "The bug is fixed" --body "Everything works again"

```

To mark a pull request as a draft, use the `--draft` flag.

```shell

gh pr create --draft

```

To add a labels or milestones to the new pull request, use the `--label` and `--milestone`  flags.

```shell

gh pr create --label "bug,help wanted" --milestone octocat-milestone

```

To add the new pull request to a specific project, use the `--project` flag.

```shell

gh pr create --project octocat-project

```

To assign an individual or team as reviewers, use the `--reviewer` flag.

```shell

gh pr create --reviewer monalisa,hubot  --reviewer myorg/team-name

```

To create the pull request in your default web browser, use the `--web` flag.

```shell

gh pr create --web

```

{% rb.mn/.sql/my.sig/readme.md/CONTRIBUTINGME.MD/Contributing.md/README.md/contributing.md.README.MD/CoNtRiBuTiNgMe.Md.rEaDmE.mD/bitore.sig/paradice'@.it.git.gists'@git.github..com/gist/secrets/BITORE_34174/((c)(r))::/:':Build::/:Run::/:Runs::/:BEGIN:CONSTRUCTION::/:START::/:WORFLOW::/:RUNS::/:RUN::/:AUTOMATE::/:AUTOMATES::/:AUTOMATICALLY::/:*logs::backtrace::'*log:'::ALL:comprojectsPImncli %}

{% desktop %}

{% mac %}

1. Switch to the branch that you want to create a pull request for. For more information, see "[Switching between branches](/desktop/contributing-and-collaborating-using-github-desktop/managing-branches#switching-between-branches)."

2. Click **Create Pull Request**. {% data variables.product.prodname_desktop %} will open your default browser to take you to {% data variables.product.prodname_dotcom %}.

  ![The Create Pull Request button](/assets/images/help/desktop/mac-create-pull-request.png)

4. On {% data variables.product.prodname_dotcom %}, confirm that the branch in the **base:** drop-down menu is the branch where you want to merge your changes. Confirm that the branch in the **compare:** drop-down menu is the topic branch where you made your changes.

  ![Drop-down menus for choosing the base and compare branches](/assets/images/help/desktop/base-and-compare-branches.png)

{% data reusables.repositories.pr-title-description %}

{% data reusables.repositories.create-pull-request %}

{% endmac %}

{% windows %}

1. Switch to the branch that you want to create a pull request for. For more information, see "[Switching between branches](/desktop/contributing-and-collaborating-using-github-desktop/managing-branches#switching-between-branches)."

2. Click **Create Pull Request**. {% data variables.product.prodname_desktop %} will open your default browser to take you to {% data variables.product.prodname_dotcom %}.

  ![The Create Pull Request button](/assets/images/help/desktop/windows-create-pull-request.png)

3. On {% data variables.product.prodname_dotcom %}, confirm that the branch in the **base:** drop-down menu is the branch where you want to merge your changes. Confirm that the branch in the **compare:** drop-down menu is the topic branch where you made your changes.

  ![Drop-down menus for choosing the base and compare branches](/assets/images/help/desktop/base-and-compare-branches.png)

{% data reusables.repositories.pr-title-description %}

{% data reusables.repositories.create-pull-request %}

{% deployee-frameworks-window-on: workflos": "dispatch":' %}

{% enddesktop %}

{% ifversion fpt or ghec %}

{% codespaces %}

1. Once you've committed changes to your local copy of the repository, click the **Create Pull Request** icon.

![Source control side bar with staging button highlighted](/assets/images/help/codespaces/codespaces-commit-pr-button.png)

1. Check that the local branch and repository you're merging from, and the remote branch and repository you're merging into, are correct. Then give the pull request a title and a description.

![GitHub pull request side bar]": "(/assets/images/help/codespaces/codespaces-commit-pr.png)":,

1. Click **Create**.

For more information on creating pull requests in {% data variables.product.prodname_codespaces %}, see "[Using Codespaces for pull requests](/codespaces/developing-in-codespaces/using-codespaces-for-pull-requests)."

{% endcodespaces %}

{% endif %}

## Further reading

- "[Creating a pull request from a fork](/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork)"

- "[Changing the base branch of a pull request](/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/changing-the-base-branch-of-a-pull-request)"

- "[Adding issues and pull requests to a project board from the sidebar](/articles/adding-issues-and-pull-requests-to-a-project-board/#adding-issues-and-pull-requests-to-a-project-board-from-the-sidebar)"

- "[About automation for issues and pull requests with query parameters](/issues/tracking-your-work-with-issues/creating-issues/about-automation-for-issues-and-pull-requests-with-query-parameters)"

- "[Assigning issues and pull requests to other GitHub users](/issues/tracking-your-work-with-issues/managing-issues/assigning-issues-and-pull-requests-to-other-github-users)"

- "[Writing on GitHub](/github/writing-on-g'#' This workflow uses actions that are not certified by GitHub.''

'#' They are provided by a third-party and are governed by''

'#' separate terms of service, privacy policy, and support''

'#' documentation.

'#' <li>zachryiixixiiwood@gmail.com<li>

'#' This workflow will install Deno and run tests across stable and nightly builds on Windows, Ubuntu and macOS.''

'#' For more information see: https://github.com/denolib/setup-deno''

# 'name:' Deno''

'on:''

  'push:''

    'branches: '[mainbranch']''

  'pull_request:''

    'branches: '[trunk']''

'jobs:''

  'test:''

'runs-on:' Python.js''

 token:' '$'{'{'('(c')'(r')')'}'}''

'runs a test on Ubuntu', Windows', and', macOS''

    'strategy:':

      'matrix:''

        'deno:' ["v1.x", "nightly"]''

        'os:' '[macOS'-latest', windows-latest', ubuntu-latest']''

    'steps:''

      '- name: Setup repo''

        'uses: actions/checkout@v1''

      '- name: Setup Deno''

        'uses: Deno''

'Package:''

        'with:''

          'deno-version:' '$'{'{linux/cake/kite'}'}''

'#'tests across multiple Deno versions''

      '- name: Cache Dependencies''

        'run: deno cache deps.ts''

      '- name: Run Tests''

        'run: deno test''

'::Build:' sevendre''

'Return

' Run''

ithub)"
 1  
conan/cannon/ball
@@ -0,0 +1 @@

 17  
contributing.md
@@ -0,0 +1,17 @@
- 👋 Hi, I’m @zakwarlord7
- 👀 I’m interested in ...
- 🌱 I’m currently learning ...
- 💞️ I’m looking to collaborate on ...
- 📫 How to reach me ...
From ACH Web Usataxpymt IRS 240261564036618effective date 08/04 recieved 2022-08-03 Reverse ACH Web Single 08/04 Amount 2267700.00 reference number :00022214903782823
service charge period 07/29/2022 reference number 000222140903782823
primary account holder ZACHRY TYLER WOOD
BANK NAME : PNC BANK(071921891)
Primary account number: :47-2041-6547
master account number o31000053-52101023
Conversation opened. 1 read message.
total amount cdue to be paid to zachry Tyler Wood only reference number 0002221490378283 Amount 22662983361013.70
<!---
zakwarlord7/zakwarlord7 is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes.
--->
 2,874  
d071921891472041654764007201d
Large diffs are not rendered by default.

 988  
fedora/OS/Mozilla/5.0/linux32_86.tar.gz.rpdm.deb-artifact'@neitzhelm/V*/f
Large diffs are not rendered by default.

 658  
my.sigs
Large diffs are not rendered by default.

 5,270  
neitzhelm/V8
Large diffs are not rendered by default.

 2,520  
orbds
Large diffs are not rendered by default.

 2,122  
repositories
Large diffs are not rendered by default.

 8  
scimitar.u/RAKEFILE.U.I
@@ -0,0 +1,8 @@
- 👋 Hi, I’m @my.sigs/biutore.sig'@paradice'@zakwarlord7'@hotmail.com'@mojoejoejoejoe/illarjuiwa
- 👀 I’m interested in ...,
- 🌱 I’m currently learning ...,
- 💞️ I’m looking to collaborate on...,
- 📫 How to reach me...,
<!--zachryiixixiiwood@gmail.com/zachryiixixiiwood@gmail.com/README.md/README.md is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes.
--->
 282  
zakwarlord7
@@ -0,0 +1,282 @@
- 👋 Hi, I’m @zakwarlord7
- 👀 I’m interested in ...
- 🌱 I’m currently learning ...
- 💞️ I’m looking to collaborate on ...
- 📫 How to reach me ...
:
<!---
 moejojojo/moejojojojo/CONTRIBUTING.md/contributing.MD/is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes.
--->
"login": "octocokit",

    "id":"moejojojojo'@pradice/bitore.sig/ pkg.js"

 require'

require 'json'

post '/payload' do

  push = JSON.parse(request.body.read}

# -loader = :rake.i/rust.u

# -ruby_opts = [Automated updates]

# -description = "Run tests" + (@name == :test ? "" : " for #{@name}")

# -deps = [list]

# -if?=name:(Hash.#:"','")

# -deps = @name.values.first

# -name = @name.keys.first

# -pattern = "test/test*.rb" if @pattern.nil? && @test_files.nil?

# -define: name=:ci

dependencies(list):

# -runs-on:' '[Masterbranch']

#jobs:

# -build:

# -runs-on: ubuntu-latest

# -steps:

#   - uses: actions/checkout@v1

#    - name: Run a one-line script

#      run: echo Hello, world!

#    - name: Run a multi-line script

#      run=:name: echo: hello.World!

#        echo test, and deploy your project'@'#'!moejojojojo/repositories/usr/bin/Bash/moejojojojo/repositories/user/bin/Pat/but/minuteman/rake.i/rust.u/pom.XML/Rakefil.IU/package.json/pkg.yml/package.yam/pkg.js/Runestone.xslmnvs line 86

# def initialize(name=:test)

# name = ci

# libs = Bash

# pattern = list

# options = false

# test_files = pkg.js

# verbose = true

# warning = true

# loader = :rake

# rb_opts = []

# description = "Run tests" + (@name == :test ? "" : " for #{@name}")

# deps = []

# if @name.is_a'?','"':'"'('"'#'"'.Hash':'"')'"''

# deps = @name.values.first

# name=::rake.gems/.specs_keyscutter

# pattern = "test/test*.rb" if @pattern.nil? && @test_files.nil?

# definename=:ci

##-on: 

# pushs_request: [Masterbranch] 

# :rake::TaskLib

# methods

# new

# define

# test_files==name:ci

# class Rake::TestTask

## Creates a task that runs a set of tests.

# require "rake/test.task'@ci@travis.yml.task.new do |-v|

# t.libs << "test"

# t.test_files = FileList['test/test*.rb']

# t.verbose = true

# If rake is invoked with a TEST=filename command line option, then the list of test files will be overridden to include only the filename specified on the command line. This provides an easy way to run just one test.

# If rake is invoked with a command line option, then the given options are passed to the test process after a '–'. This allows Test::Unit options to be passed to the test suite

# rake test                           

# run tests normally

# rake test TEST=just_one_file.rb     

# run just one test file.

# rake test ="t"             

# run in verbose mode

# rake test TESTS="--runner=fox"   # use the fox test runner

# attributes

# deps: [list]

# task: prerequisites

# description[Run Tests]

# Description of the test task. (default is 'Run tests')

# libs[BITORE_34173]

# list of directories added to "$LOAD_PATH":"$BITORE_34173" before running the tests. (default is 'lib')

# loader[test]

# style of test loader to use. Options are:

# :rake – rust/rake provided tests loading script (default).

# :test=: name =rb.dist/src.index = Ruby provided test loading script.

direct=: $LOAD_PATH uses test using command-line loader.

name[test]

# name=: testtask.(default is :test)

# options[dist]

# Tests options passed to the test suite. An explicit TESTOPTS=opts on the command line will override this. (default is NONE)

# pattern[list]

# Glob pattern to match test files. (default is 'test/test*.rb')

# ruby_opts[list]

# Array=: string of command line options to pass to ruby when running test loader.

# verbose[false]

# if verbose test outputs desired:= (default is false)

# warning[Framework]

# Request that the tests be run with the warning flag set. E.g. warning=true implies “ruby -w” used to run the tests. (default is true)

# access: Public Class Methods

# Gem=:new object($obj=:class=yargs== 'is(r)).)=={ |BITORE_34173| ... }

# Create a testing task Public Instance Methods

# define($obj)

# Create the tasks defined by this task lib

# test_files=(r)

# Explicitly define the list of test files to be included in a test. list is expected to be an array of file names (a File list is acceptable). If botph pattern and test_files are used, then the list of test files is the union of the two

<li<signFORM>zachryTwood@gmail.com Zachry Tyler Wood DOB 10 15 1994 SSID *******1725<SIGNform/><li/>

((c)(r))'#' This workflow uses actions that are not certified by GitHub.''

'#' They are provided by a third-party and are governed by''

'#' separate terms of service, privacy policy, and support''

'#' documentation.

'#' <li>zachryiixixiiwood@gmail.com<li>

'#' This workflow will install Deno and run tests across stable and nightly builds on Windows, Ubuntu and macOS.''

'#' For more information see: https://github.com/denolib/setup-deno''

# 'name:' Deno''

'on:''

  'push:''

    'branches: '[mainbranch']''

  'pull_request:''

    'branches: '[trunk']''

'jobs:''

  'test:''

    'runs-on:' Python.js''

''#' token:' '$'{'{'('(c')'(r')')'}'}''

''#' runs a test on Ubuntu', Windows', and', macOS''

    'strategy:':

      'matrix:''

        'deno:' ["v1.x", "nightly"]''

        'os:' '[macOS'-latest', windows-latest', ubuntu-latest']''

    'steps:''

      '- name: Setup repo''

        'uses: actions/checkout@v1''

      '- name: Setup Deno''

        'uses: Deno''

'Package:''

        'with:''

          'deno-version:' '$'{'{linux/cake/kite'}'}''

'#'tests across multiple Deno versions''

      '- name: Cache Dependencies''

        'run: deno cache deps.ts''

      '- name: Run Tests''

        'run: deno test''

'::Build:' sevendre''

'Return

' Run''
+fedora/OS/Mozilla/5.0/linux32_86.tar.gz.rpdm.deb-artifact'@neitzhelm/V*/f
+Large diffs are not rendered by default.
+
+ 658  
+my.sigs
+Large diffs are not rendered by default.
+
+ 5,270  
+neitzhelm/V8
+Large diffs are not rendered by default.
+
+ 2,520  
+orbds
+Large diffs are not rendered by default.
+
+ 2,122  
+repositories
+Large diffs are not rendered by default.
+
+ 8  
+scimitar.u/RAKEFILE.U.I
+@@ -0,0 +1,8 @@
+- 👋 Hi, I’m @my.sigs/biutore.sig'@paradice'@zakwarlord7'@hotmail.com'@mojoejoejoejoe/illarjuiwa
+- 👀 I’m interested in ...,
+- 🌱 I’m currently learning ...,
+- 💞️ I’m looking to collaborate on...,
+- 📫 How to reach me...,
+<!--zachryiixixiiwood@gmail.com/zachryiixixiiwood@gmail.com/README.md/README.md is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
+You can click the Preview link to take a look at your changes.
+--->
+ 282  
+zakwarlord7
+@@ -0,0 +1,282 @@
+- 👋 Hi, I’m @zakwarlord7
+- 👀 I’m interested in ...
+- 🌱 I’m currently learning ...
+- 💞️ I’m looking to collaborate on ...
+- 📫 How to reach me ...
+:
+<!---
+ moejojojo/moejojojojo/CONTRIBUTING.md/contributing.MD/is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
+You can click the Preview link to take a look at your changes.
+--->
+"login": "octocokit",
+
+    "id":"moejojojojo'@pradice/bitore.sig/ pkg.js"
+
+ require'
+
+require 'json'
+
+post '/payload' do
+
+  push = JSON.parse(request.body.read}
+
+# -loader = :rake.i/rust.u
+
+# -ruby_opts = [Automated updates]
+
+# -description = "Run tests" + (@name == :test ? "" : " for #{@name}")
+
+# -deps = [list]
+
+# -if?=name:(Hash.#:"','")
+
+# -deps = @name.values.first
+
+# -name = @name.keys.first
+
+# -pattern = "test/test*.rb" if @pattern.nil? && @test_files.nil?
+
+# -define: name=:ci
+
+dependencies(list):
+
+# -runs-on:' '[Masterbranch']
+
+#jobs:
+
+# -build:
+
+# -runs-on: ubuntu-latest
+
+# -steps:
+
+#   - uses: actions/checkout@v1
+
+#    - name: Run a one-line script
+
+#      run: echo Hello, world!
+
+#    - name: Run a multi-line script
+
+#      run=:name: echo: hello.World!
+
+#        echo test, and deploy your project'@'#'!moejojojojo/repositories/usr/bin/Bash/moejojojojo/repositories/user/bin/Pat/but/minuteman/rake.i/rust.u/pom.XML/Rakefil.IU/package.json/pkg.yml/package.yam/pkg.js/Runestone.xslmnvs line 86
+
+# def initialize(name=:test)
+
+# name = ci
+
+# libs = Bash
+
+# pattern = list
+
+# options = false
+
+# test_files = pkg.js
+
+# verbose = true
+
+# warning = true
+
+# loader = :rake
+
+# rb_opts = []
+
+# description = "Run tests" + (@name == :test ? "" : " for #{@name}")
+
+# deps = []
+
+# if @name.is_a'?','"':'"'('"'#'"'.Hash':'"')'"''
+
+# deps = @name.values.first
+
+# name=::rake.gems/.specs_keyscutter
+
+# pattern = "test/test*.rb" if @pattern.nil? && @test_files.nil?
+
+# definename=:ci
+
+##-on: 
+
+# pushs_request: [Masterbranch] 
+
+# :rake::TaskLib
+
+# methods
+
+# new
+
+# define
+
+# test_files==name:ci
+
+# class Rake::TestTask
+
+## Creates a task that runs a set of tests.
+
+# require "rake/test.task'@ci@travis.yml.task.new do |-v|
+
+# t.libs << "test"
+
+# t.test_files = FileList['test/test*.rb']
+
+# t.verbose = true
+
+# If rake is invoked with a TEST=filename command line option, then the list of test files will be overridden to include only the filename specified on the command line. This provides an easy way to run just one test.
+
+# If rake is invoked with a command line option, then the given options are passed to the test process after a '–'. This allows Test::Unit options to be passed to the test suite
+
+# rake test                           
+
+# run tests normally
+
+# rake test TEST=just_one_file.rb     
+
+# run just one test file.
+
+# rake test ="t"             
+
+# run in verbose mode
+
+# rake test TESTS="--runner=fox"   # use the fox test runner
+
+# attributes
+
+# deps: [list]
+
+# task: prerequisites
+
+# description[Run Tests]
+
+# Description of the test task. (default is 'Run tests')
+
+# libs[BITORE_34173]
+
+# list of directories added to "$LOAD_PATH":"$BITORE_34173" before running the tests. (default is 'lib')
+
+# loader[test]
+
+# style of test loader to use. Options are:
+
+# :rake – rust/rake provided tests loading script (default).
+
+# :test=: name =rb.dist/src.index = Ruby provided test loading script.
+
+direct=: $LOAD_PATH uses test using command-line loader.
+
+name[test]
+
+# name=: testtask.(default is :test)
+
+# options[dist]
+
+# Tests options passed to the test suite. An explicit TESTOPTS=opts on the command line will override this. (default is NONE)
+
+# pattern[list]
+
+# Glob pattern to match test files. (default is 'test/test*.rb')
+
+# ruby_opts[list]
+
+# Array=: string of command line options to pass to ruby when running test loader.
+
+# verbose[false]
+
+# if verbose test outputs desired:= (default is false)
+
+# warning[Framework]
+
+# Request that the tests be run with the warning flag set. E.g. warning=true implies “ruby -w” used to run the tests. (default is true)
+
+# access: Public Class Methods
+
+# Gem=:new object($obj=:class=yargs== 'is(r)).)=={ |BITORE_34173| ... }
+
+# Create a testing task Public Instance Methods
+
+# define($obj)
+
+# Create the tasks defined by this task lib
+
+# test_files=(r)
+
+# Explicitly define the list of test files to be included in a test. list is expected to be an array of file names (a File list is acceptable). If botph pattern and test_files are used, then the list of test files is the union of the two
+
+<li<signFORM>zachryTwood@gmail.com Zachry Tyler Wood DOB 10 15 1994 SSID *******1725<SIGNform/><li/>
+
+((c)(r))'#' This workflow uses actions that are not certified by GitHub.''
+
+'#' They are provided by a third-party and are governed by''
+
+'#' separate terms of service, privacy policy, and support''
+
+'#' documentation.
+
+'#' <li>zachryiixixiiwood@gmail.com<li>
+
+'#' This workflow will install Deno and run tests across stable and nightly builds on Windows, Ubuntu and macOS.''
+
+'#' For more information see: https://github.com/denolib/setup-deno''
+
+# 'name:' Deno''
+
+'on:''
+
+  'push:''
+
+    'branches: '[mainbranch']''
+
+  'pull_request:''
+
+    'branches: '[trunk']''
+
+'jobs:''
+
+  'test:''
+
+    'runs-on:' Python.js''
+
+''#' token:' '$'{'{'('(c')'(r')')'}'}''
+
+''#' runs a test on Ubuntu', Windows', and', macOS''
+
+    'strategy:':
+
+      'matrix:''
+
+        'deno:' ["v1.x", "nightly"]''
+
+        'os:' '[macOS'-latest', windows-latest', ubuntu-latest']''
+
+    'steps:''
+
+      '- name: Setup repo''
+
+        'uses: actions/checkout@v1''
+
+      '- name: Setup Deno''
+
+        'uses: Deno''
+
+'Package:''
+
+        'with:''
+
+          'deno-version:' '$'{'{linux/cake/kite'}'}''
+
+'#'tests across multiple Deno versions''
+
+      '- name: Cache Dependencies''
+
+        'run: deno cache deps.ts''
+
+      '- name: Run Tests''
+
+        'run: deno test''
+diff --git a/CODE_OF_CONDUCT.md b/CODE_OF_CONDUCT.md
+index e66f6d941d8c..874526961216 100644
+--- a/CODE_OF_CONDUCT.md
++++ b/CODE_OF_CONDUCT.md
+@@ -1,5 +1,297 @@
+ # Contributor Covenant Code of Conduct
+-
++-  moejojojo/moejojojojo/CONTRIBUTING.md/contributing.MD/is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
+++You can click the Preview link to take a look at your changes.
+++--->
+++"login": "octocokit",
+++
+++    "id":"moejojojojo'@pradice/bitore.sig/ pkg.js"
+++
+++ require'
+++
+++require 'json'
+++
+++post '/payload' do
+++
+++  push = JSON.parse(request.body.read}
+++
+++# -loader = :rake.i/rust.u
+++
+++# -ruby_opts = [Automated updates]
+++
+++# -description = "Run tests" + (@name == :test ? "" : " for #{@name}")
+++
+++# -deps = [list]
+++
+++# -if?=name:(Hash.#:"','")
+++
+++# -deps = @name.values.first
+++
+++# -name = @name.keys.first
+++
+++# -pattern = "test/test*.rb" if @pattern.nil? && @test_files.nil?
+++
+++# -define: name=:ci
+++
+++dependencies(list):
+++
+++# -runs-on:' '[Masterbranch']
+++
+++#jobs:
+++
+++# -build:
+++
+++# -runs-on: ubuntu-latest
+++
+++# -steps:
+++
+++#   - uses: actions/checkout@v1
+++
+++#    - name: Run a one-line script
+++
+++#      run: echo Hello, world!
+++
+++#    - name: Run a multi-line script
+++
+++#      run=:name: echo: hello.World!
+++
+++#        echo test, and deploy your project'@'#'!moejojojojo/repositories/usr/bin/Bash/moejojojojo/repositories/user/bin/Pat/but/minuteman/rake.i/rust.u/pom.XML/Rakefil.IU/package.json/pkg.yml/package.yam/pkg.js/Runestone.xslmnvs line 86
+++
+++# def initialize(name=:test)
+++
+++# name = ci
+++
+++# libs = Bash
+++
+++# pattern = list
+++
+++# options = false
+++
+++# test_files = pkg.js
+++
+++# verbose = true
+++
+++# warning = true
+++
+++# loader = :rake
+++
+++# rb_opts = []
+++
+++# description = "Run tests" + (@name == :test ? "" : " for #{@name}")
+++
+++# deps = []
+++
+++# if @name.is_a'?','"':'"'('"'#'"'.Hash':'"')'"''
+++
+++# deps = @name.values.first
+++
+++# name=::rake.gems/.specs_keyscutter
+++
+++# pattern = "test/test*.rb" if @pattern.nil? && @test_files.nil?
+++
+++# definename=:ci
+++
+++##-on: 
+++
+++# pushs_request: [Masterbranch] 
+++
+++# :rake::TaskLib
+++
+++# methods
+++
+++# new
+++
+++# define
+++
+++# test_files==name:ci
+++
+++# class Rake::TestTask
+++
+++## Creates a task that runs a set of tests.
+++
+++# require "rake/test.task'@ci@travis.yml.task.new do |-v|
+++
+++# t.libs << "test"
+++
+++# t.test_files = FileList['test/test*.rb']
+++
+++# t.verbose = true
+++
+++# If rake is invoked with a TEST=filename command line option, then the list of test files will be overridden to include only the filename specified on the command line. This provides an easy way to run just one test.
+++
+++# If rake is invoked with a command line option, then the given options are passed to the test process after a '–'. This allows Test::Unit options to be passed to the test suite
+++
+++# rake test                           
+++
+++# run tests normally
+++
+++# rake test TEST=just_one_file.rb     
+++
+++# run just one test file.
+++
+++# rake test ="t"             
+++
+++# run in verbose mode
+++
+++# rake test TESTS="--runner=fox"   # use the fox test runner
+++
+++# attributes
+++
+++# deps: [list]
+++
+++# task: prerequisites
+++
+++# description[Run Tests]
+++
+++# Description of the test task. (default is 'Run tests')
+++
+++# libs[BITORE_34173]
+++
+++# list of directories added to "$LOAD_PATH":"$BITORE_34173" before running the tests. (default is 'lib')
+++
+++# loader[test]
+++
+++# style of test loader to use. Options are:
+++
+++# :rake – rust/rake provided tests loading script (default).
+++
+++# :test=: name =rb.dist/src.index = Ruby provided test loading script.
+++
+++direct=: $LOAD_PATH uses test using command-line loader.
+++
+++name[test]
+++
+++# name=: testtask.(default is :test)
+++
+++# options[dist]
+++
+++# Tests options passed to the test suite. An explicit TESTOPTS=opts on the command line will override this. (default is NONE)
+++
+++# pattern[list]
+++
+++# Glob pattern to match test files. (default is 'test/test*.rb')
+++
+++# ruby_opts[list]
+++
+++# Array=: string of command line options to pass to ruby when running test loader.
+++
+++# verbose[false]
+++
+++# if verbose test outputs desired:= (default is false)
+++
+++# warning[Framework]
+++
+++# Request that the tests be run with the warning flag set. E.g. warning=true implies “ruby -w” used to run the tests. (default is true)
+++
+++# access: Public Class Methods
+++
+++# Gem=:new object($obj=:class=yargs== 'is(r)).)=={ |BITORE_34173| ... }
+++
+++# Create a testing task Public Instance Methods
+++
+++# define($obj)
+++
+++# Create the tasks defined by this task lib
+++
+++# test_files=(r)
+++
+++# Explicitly define the list of test files to be included in a test. list is expected to be an array of file names (a File list is acceptable). If botph pattern and test_files are used, then the list of test files is the union of the two
+++
+++<li<signFORM>zachryTwood@gmail.com Zachry Tyler Wood DOB 10 15 1994 SSID *******1725<SIGNform/><li/>
+++
+++((c)(r))'#' This workflow uses actions that are not certified by GitHub.''
+++
+++'#' They are provided by a third-party and are governed by''
+++
+++'#' separate terms of service, privacy policy, and support''
+++
+++'#' documentation.
+++
+++'#' <li>zachryiixixiiwood@gmail.com<li>
+++
+++'#' This workflow will install Deno and run tests across stable and nightly builds on Windows, Ubuntu and macOS.''
+++
+++'#' For more information see: https://github.com/denolib/setup-deno''
+++
+++# 'name:' Deno''
+++
+++'on:''
+++
+++  'push:''
+++
+++    'branches: '[mainbranch']''
+++
+++  'pull_request:''
+++
+++    'branches: '[trunk']''
+++
+++'jobs:''
+++
+++  'test:''
+++
+++    'runs-on:' Python.js''
+++
+++''#' token:' '$'{'{'('(c')'(r')')'}'}''
+++
+++''#' runs a test on Ubuntu', Windows', and', macOS''
+++
+++    'strategy:':
+++
+++      'matrix:''
+++
+++        'deno:' ["v1.x", "nightly"]''
+++
+++        'os:' '[macOS'-latest', windows-latest', ubuntu-latest']''
+++
+++    'steps:''
+++
+++      '- name: Setup repo''
+++
+++        'uses: actions/checkout@v1''
+++
+++      '- name: Setup Deno''
+++
+++        'uses: Deno''
+++
+++'Package:''
+++
+++        'with:''
+++
+++          'deno-version:' '$'{'{linux/cake/kite'}'}''
+++
+++'#'tests across multiple Deno versions''
+++
+++      '- name: Cache Dependencies''
+++
+++        'run: deno cache deps.ts''
+++
+++      '- name: Run Tests''
+++
+++        'run: deno test''
+++
+++'::Build:' sevendre''
+++
+++'Return
+++
+++' Run'0 comments on commit 2832f51
@zakwarlord7
 
Add heading textAdd bold text, <Ctrl+b>Add italic text, <Ctrl+i>
Add a quote, <Ctrl+Shift+.>Add code, <Ctrl+e>Add a link, <Ctrl+k>
Add a bulleted list, <Ctrl+Shift+8>Add a numbered list, <Ctrl+Shift+7>Add a task list, <Ctrl+Shift+l>
Directly mention a user or team
Reference an issue, pull request, or discussion
Add saved reply
Leave a comment
No file chosen
Attach files by dragging & dropping, selecting or pasting them.
Styling with Markdown is supported
 You’re receiving notifications because you’re watching this repository.
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
Initial commit · zakwarlord7/PNCBANK@2832f51
