diff --git "a/EMPLOYEE PAYMENT REPORT ADP/CI/CLI/Federal 941/Deposit/Report/ADP/Report/Range/2022-05-04 - 2022-06-04/Local ID :TxDL :00037305581/Employer Identification Number (EIN) :63-3441725/State ID : SSN 633441725/\"Employee Numbeer :3  Description\"/Amount/Display/All/Payment/Amount/(Total)/$9246754678763.00/Display All/1. Social Security (Employee + Employer) $26661.80/2.Medicare (EMployee + Employer) Hourly $3855661229657.00Federal Income Tax $8385561229657.00/net, pay. $ 2266298000000800.00.ach.xls.xlsx.xls.pdf" "b/EMPLOYEE PAYMENT REPORT ADP/CI/CLI/Federal 941/Deposit/Report/ADP/Report/Range/2022-05-04 - 2022-06-04/Local ID :TxDL :00037305581/Employer Identification Number (EIN) :63-3441725/State ID : SSN 633441725/\"Employee Numbeer :3  Description\"/Amount/Display/All/Payment/Amount/(Total)/$9246754678763.00/Display All/1. Social Security (Employee + Employer) $26661.80/2.Medicare (EMployee + Employer) Hourly $3855661229657.00Federal Income Tax $8385561229657.00/net, pay. $ 2266298000000800.00.ach.xls.xlsx.xls.pdf"
index 5816d95..c0afda1 100644
Binary files "a/EMPLOYEE PAYMENT REPORT ADP/CI/CLI/Federal 941/Deposit/Report/ADP/Report/Range/2022-05-04 - 2022-06-04/Local ID :TxDL :00037305581/Employer Identification Number (EIN) :63-3441725/State ID : SSN 633441725/\"Employee Numbeer :3  Description\"/Amount/Display/All/Payment/Amount/(Total)/$9246754678763.00/Display All/1. Social Security (Employee + Employer) $26661.80/2.Medicare (EMployee + Employer) Hourly $3855661229657.00Federal Income Tax $8385561229657.00/net, pay. $ 2266298000000800.00.ach.xls.xlsx.xls.pdf" and "b/EMPLOYEE PAYMENT REPORT ADP/CI/CLI/Federal 941/Deposit/Report/ADP/Report/Range/2022-05-04 - 2022-06-04/Local ID :TxDL :00037305581/Employer Identification Number (EIN) :63-3441725/State ID : SSN 633441725/\"Employee Numbeer :3  Description\"/Amount/Display/All/Payment/Amount/(Total)/$9246754678763.00/Display All/1. Social Security (Employee + Employer) $26661.80/2.Medicare (EMployee + Employer) Hourly $3855661229657.00Federal Income Tax $8385561229657.00/net, pay. $ 2266298000000800.00.ach.xls.xlsx.xls.pdf" differ
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
User-bin-env-Bash
Private
generated from zakwarlord7/peter-evans-create-pull-request
Code
Issues
Pull requests
Actions
Projects
Security
Insights
Settings
Comparing changes
Choose two branches to see what’s changed or to start a new pull request. If you need to, you can also .
  
 4 commits
 4 files changed
 1 contributor
Commits on Nov 21, 2022
Create README.md

@zakwarlord7
zakwarlord7 committed 2 hours ago
  
Create npm-grunt.yml

@zakwarlord7
zakwarlord7 committed 42 minutes ago
  
Update slash-command-dispatch.yml (#1)

@zakwarlord7
zakwarlord7 committed 34 minutes ago
  
Automates

@zakwarlord7
zakwarlord7 committed 4 minutes ago
  
Showing  with 9,970 additions and 2 deletions.
 2,119  
.github/workflows/npm-grunt.yml
@@ -0,0 +1,2119 @@
name: NodeJS with Grunt

on:
  push:
    branches: [ "master" ]
  pull_request:
    branches: [ "master" ]

jobs:
  build:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [14.x, 16.x, 18.x]

    steps:
    - uses: actions/checkout@v3

    - name: Use Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v3
      with:
        node-version: ${{ matrix.node-version }}

    - name: Build
      run: |
        npm install
        grunt
From fe6bd12338a89220c1f4af7310121894652b4342 Mon Sep 17 00:00:00 2001
From: "ZACHRY T WOODzachryiixixiiwood@gmail.com"
 <109656750+zakwarlord7@users.noreply.github.com>
Date: Fri, 18 Nov 2022 23:35:41 -0600
Subject: [PATCH 1/2] Revert "Revert "Update RakI.u (#1)" (#2)" (#3)

This reverts commit 21a7b70e4b4aea5e588362f75618306acc3e4ffe.
---
 RakI.u | 65 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/RakI.u b/RakI.u
index 2d5fcaa..1276ad0 100644
--- a/RakI.u
+++ b/RakI.u
@@ -1,17 +1,55 @@
-#3GLOW4
-BEGIN
-#TYPE
-#SCRIPTS
-#SCR?IPT
-#:Build::RUN RUNS ENV
+**#3GLOW4 :
+BEGIN4 :
+#TYPE :
+#SCRIPTS :
+#SCR?IPT :
+#:Build::RUN RUNS ENV :Runs #Test :tests'@ci'@#Test'@CI'' ':'':
 ENV :!#/User/bin/sdh/imp.yml'@bitore.sig'@Demlsr/Smber.yml'' 
 $mk.dir=: src.dir/index.md/.dist'@WIZARD/db/instsll/indtsller'@sun.java.org/py-Flask.eslint/rendeerer/slate.yml'ERaku.i :
 '#Clerks/chalk.yml-with :grunt.xml/Gulp.xml'@Trunk :'
 Package-on :Python.JS'@MAsterbranch :'
 bundle-with :rake.i'@master :'
 -with :bp/-dylan/th.boop/-quipp/ranger/helpers'@pom.YML ::Runs-on :sRust/Cake.io :'
-FANG
-#:Build::
+From: <Saved by Blink>										
+Snapshot-Content-Location: https://github.com/zakwarlord7/jekyll-deploy-action/commit/84218f644e73a68afdf9cf2da437b4062fccf28f										
+Subject: =?utf-8?Q?bitore.sig=20=C2=B7=20zakwarlord7/jekyll-deploy-action@84218f6?=										
+Date: Sat, 3 Sep 2022 19:21:01 -0000										
+MIME-Version: 1.0										
+Content-Type: multipart/related;										
+ype="text/html";									
+oundary="----MultipartBoundary--wjliXQErN1i5NgVkHr2WB1jdr56S5qoNszw7DpylZJ----"									
+-----MultipartBoundary--wjliXQErN1i5NgVkHr2WB1jdr56S5qoNszw7DpylZJ----										
+Content-Type: text/html										
+Content-ID: <frame-8C2C552DF38E22E03BFE31C46E0F2BAD@mhtml.blink>										
+Content-Transfer-Encoding: quoted-printable										
+Content-Location: https://github.com/zakwarlord7/jekyll-deploy-action/commit/84218f644e73a68afdf9cf2da437b4062fccf28f										
+										
+<!DOCTYPE html><html lang=3D"en" data-color-mode=3D"auto" data-light-theme=										
+=3D"light" data-dark-theme=3D"dark" data-a11y-animated-images=3D"system" da=										
+ta-turbo-loaded=3D""><head><meta http-equiv=3D"Content-Type" content=3D"tex=										
+t/html; charset=3DUTF-8"><link rel=3D"stylesheet" type=3D"text/css" href=3D=										
+cid:css-ac2db60c-b042-4e6b-befd-5e5586566410@mhtml.blink /><link rel=3D"s=										
+tylesheet" type=3D"text/css" href=3D"cid:css-61746e5e-f864-4b7d-8ddb-37d72a=										
+aab8ed@mhtml.blink" />										
+   =20										
+ =20										
+ =20										
+ =20										
+ =20										
+ =20										
+ =20										
+  <link crossorigin=3D"anonymous" media=3D"all" rel=3D"stylesheet" href=3D"=										
+https://github.githubassets.com/assets/light-5178aee0ee76.css"><link crosso=										
+rigin=3D"anonymous" media=3D"all" rel=3D"stylesheet" href=3D"https://github=										
+.githubassets.com/assets/dark-217d4f9c8e70.css">										
+ =20										
+    <link crossorigin=3D"anonymous" media=3D"all" rel=3D"stylesheet" href=										
+=3D"https://github.githubassets.com/assets/primer-49141272cf08.css">										
+    <link crossorigin=3D"anonymous" media=3D"all" rel=3D"stylesheet" href=										
+=3D"https://github.githubassets.com/assets/global-1dc19945fbd1.css">										
+    <link crossorigin=3D"anonymous" media=3D"all" rel=3D"stylesheet" href=										
+=3D"https://github.githubassets.com/assets/github-a7280cace57c.css">										
+  <link crossorigin=3D"anonymous" media=3D"all" rel=3D"stylesheet" href=3D"=										
 WORKSFLOW_call-on:Run::Runs:
 Runs::Name: NodeJS with Grunt
 On :Runs::/:Run::/:run-on:, "-on":,'' ':'' 
@@ -30,20 +68,15 @@ On :Runs::/:Run::/:run-on:, "-on":,'' ':''
     runs-on: ubuntu-latest
     strategy:C\commits on Oct 20, 202 41224 Stub Number: 1++Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)++ INTERNAL REVENUE SERVICE, *include interest paid, capital obligation, and underweighting 6858000000 + PO BOX 1214, Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) + 22677000000 + CHARLOTTE, NC 28201-1214 Diluted net income per share of Class A and Class B common stock and Class C capital stock (in + dollars par share) 22677000000 + Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) + 22677000000 + Taxes / Deductions Current YTD + Fiscal year ends in Dec 31 | USD + Rate + Total + 7567263607 ID 00037305581 SSN 633441725 DoB 1994-10-15 +year to date :++this period :++ April 18, 2022. + 7567263607 + WOOD ZACHRY Tax Period Total Social Security Medicare Withholding + Fed 941 Corporate 39355 66986.66 28841.48 6745.18 31400 + Fed 941 West Subsidiary 39355 17115.41 7369.14 1723.42 8022.85 + Fed 941 South Subsidiary 39355 23906.09 10292.9 2407.21 11205.98 + Fed 941 East Subsidiary 39355 11247.64 4842.74 1132.57 5272.33 + Fed 941 Corp - Penalty 39355 27198.5 11710.47 2738.73 12749.3 + Fed 940 Annual Unemp - Corp 39355 17028.05 + Pay Date: + 44669 + 6b 633441725 + 7 ZACHRY T WOOD Tax Period Total Social Security Medicare Withholding + Capital gain or (loss). Attach Schedule D if required. If not required, check here ....â–¶ +Fed 941 Corporate 39355 66986.66 28841.48 6745.18 31400++ 7 Fed 941 West Subsidiary 39355 17115.41 7369.14 1723.42 8022.85 + 8 Fed 941 South Subsidiary 39355 23906.09 10292.9 2407.21 11205.98 + Other income from Schedule 1, line 10 .................. Fed 941 East Subsidiary 39355 11247.64 4842.74 1132.57 5272.33 + 8 Fed 941 Corp - Penalty 39355 27198.5 11710.47 2738.73 12749.3 + 9 Fed 940 Annual Unemp - Corp 39355 17028.05 + Add lines 1, 2b, 3b, 4b, 5b, 6b, 7, and 8. This is your total income .........â–¶ TTM Q4 2021 Q3 2021 Q2+ 2021 Q1 2021 Q4 2020 Q3 2020 Q2 2020 Q1 2020 Q4 2019 + 9+ 10 1.46698E+11 42337000000 37497000000 35653000000 31211000000 30818000000 + 25056000000 19744000000 22177000000 25055000000 + Adj+ ustments to income from Schedule 1, line 26 ............... 2.57637E+11 75325000000 65118000000 618800+ 00000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000 + 10 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 461730+ 00000 38297000000 41159000000 64133000000 + 11 + Subtract line 10 from line 9. This is your adjusted gross income .........â–¶ -5.79457E+11 -32988000000 -27621+ 000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000 -18982000000 -210+ 20000000 + 11 -1.10939E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000+ 000 -21117000000 -18553000000 -18982000000 -21020000000 + Standard Deduction forâ€” -1.10939E+11 -16292000000 -14774000000 -15167000000 -1+ 3843000000 -13361000000 -14200000000 -15789000000 + â€¢ Single or Married filing separately, $12,550 -67984000000 -20452000000 -16466000000 -86170000+ 00 -7289000000 -8145000000 -6987000000 -6486000000 -7380000000 -8567000000 + â€¢ Married filing jointly or Qualifying widow(er), $25,100 -36422000000 -11744000000 -8772000000 -33410+ 00000 -2773000000 -2831000000 -2756000000 -2585000000 -2880000000 -2829000000 + â€¢ Head of household, $18,800 -13510000000 -4140000000 -3256000000 -5276000000 -45160000+ 00 -5314000000 -4231000000 -3901000000 -4500000000 -5738000000 + â€¢ If you checked any box under Standard Deduction, see instructions. -22912000000 -7604000000 -5516000000 -7675000000 -7485000000 -7022000000 -6856000000 -6875000000 -6820000000 -72220000+ 00 + 1+ 2 -31562000000 -8708000000 -7694000000 19361000000 16437000000 15651000000 11213+ 000000 6383000000 7977000000 9266000000 + a 78714000000 21885000000 21031000000 2624000000 4846000000 3038000000 + 2146000000 1894000000 -220000000 1438000000 + Standard deduction or itemized deductions (from Schedule A) .. 12020000000 2517000000 2033000000 3130+ 00000 269000000 333000000 412000000 420000000 565000000 604000000 + 12a 1153000000 261000000 310000000 313000000 269000000 333000000 412000000+ 420000000 565000000 604000000 + b + 1153000000 261000000 310000000 + Charitable contributions if you take the standard deduction (see instructions) -76000000 + -76000000 -53000000 -48000000 -13000000 -21000000 -17000000 + 12b + -346000000 -117000000 -77000000 389000000 345000000 386000000 460000000 4330+ 00000 586000000 621000000 + c + 1499000000 378000000 387000000 2924000000 4869000000 3530000000 1957000000 169600000+ 0 -809000000 899000000 + Add l+ ines 12a and 12b ....................... 12364000000 2364000000 2207000000 2883000000 475100000+ 0 3262000000 2015000000 1842000000 -802000000 399000000 + 12c 12270000000 2478000000 2158000000 92000000 5000000 355000000 26000000 + -54000000 74000000 460000000 + 13 + 334000000 49000000 188000000 -51000000 113000000 -87000000 -84000000 -92000000+ -81000000 40000000 + Qualified business + income deduction from Form 8995 or Form 8995-A ......... -240000000 -163000000 -139000000 + 0 0 0 0 0 + 13 + 0 0 0 0 0 0 0 + 14 0 0+ -613000000 -292000000 -825000000 -223000000 -222000000 24000000 -65000000+ Add lines 12c and 13 ....................... -1497000000 -108000000 -484000000 21985000000 + 21283000000 18689000000 13359000000 8277000000 7757000000 10704000000 + 14 90734000000 24402000000 23064000000 -3460000000 -3353000000 -3462000000 + -2112000000 -1318000000 -921000000 -33000000 + 15 + -14701000000 -3760000000 -4128000000 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 10671000000 + Taxable income.+ Subtract line 14 from line 11. If zero or less, enter -0- ......... 76033000000 20642000000 189360000+ 00 18525000000 17930000000 15227000000 11247000000 6959000000 6836000000 1067100000+ 0 + 1+ 5 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 112470+ 00000 6959000000 6836000000 10671000000 + For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. 76033000000 206420000+ 00 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 683600000+ 0 10671000000 + Cat. No. 11320B 76033000000 20642000000 18936000000 18525000000 17930000000 152270000+ 00 11247000000 6959000000 6836000000 10671000000 + Form 1040 (2021) 76033000000 20642000000 18936000000 + Reported Normalized and Operating Income/Expense Supplemental Section + Total Revenue as Reported, Supplemental 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 41159000000 46075000000 + Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 193610000+ 00 16437000000 15651000000 11213000000 6383000000 7977000000 9266000000 + Reported Effective Tax Rate 0.16 0.179 0.157 0.158 0.158 0.159 0 + Reported Normalized Income 6836000000 + Reported Normalized Operating Profit 7977000000 + Other Adjustments to Net Income Available to Common Stockholders + Discontinued Operations + Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 + 15.49 + Basic EPS from Continuing Operations 113.88 31.12 28.44 27.69 26.63 22.46 16.55 + 10.21 9.96 15.47 + Basic E+ PS from Discontinued Operations + Diluted EPS 112.2 30.69 27.99 27.26 26.29 22.3 16.4 10.13 9.87 + 15.35 + Diluted EPS from Continuing Operations 112.2 30.67 27.99 27.26 26.29 22.23 16.4 + 10.13 9.87 15.33 + Dilute+ d EPS from Discontinued Operations + Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000+ 675581000 679449000 681768000 686465000 688804000 + Diluted + Weighted Average Shares Outstanding 677674000 672493000 676519000 679612000 682071000 68+ 2969000 685851000 687024000 692267000 695193000 + Reported Normalized Diluted EPS 9.87 + Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 9.96 + 15.49 + Diluted EPS 112.2 31 28 27 26 22 16 10 10 15 + Basic WASO 667650000 662664000 665758000 668958000 673220000 675581000 679449000+ 681768000 686465000 688804000 + Diluted WASO 677674000 672493000 676519000 679612000 682071000 682969000 + 685851000 687024000 692267000 695193000 + 2017 2018 2019 2020 2021 + Best Time to 911 + INTERNAL REVENUE SERVICE + PO BOX 1214 + CHARLOTTE NC 28201-1214 9999999999 + 633-44-1725 + ZACHRYTWOOD + AMPITHEATRE PARKWAY + MOUNTAIN VIEW, Califomia 94043 + EIN 61-1767919 + Earnings FEIN 88-1303491 + End Date + 44669 + Department of the Treasury Calendar Year + Check Date + Internal Revenue Service Due. (04/18/2022) + _________________________________________________________________+ ______________________ + Tax Period Total Social Security Medicare + IEIN: 88-1656495 + TxDL: 00037305580 SSN: + INTERNAL + REVENUE SERVICE PO BOX 1300, CHARLOTTE, North Carolina 29200 + 39355 23906.09 10292.9 2407.21 + 20210418 39355 11247.64 4842.74 1132.57 + 39355 27198.5 11710.47 2738.73 + 39355 17028.05 + CP 575A (Rev. 2-2007) 99999999999 CP 575 A SS-4 + Earnings Statement + IEIN: 88-1656496 + TxDL: 00037305581 SSN: + INTERNAL REVENUE SERVICE PO BOX 1300, CHARLOTTE, North Carolina 29201 + Employee Information Pay to the order of ZACHRY T WOOD + AMPITHEATRE PARKWAY, + MOUNTAIN VIEW, California 94043 
       matrix:
-        node-version: [12.x, 14.x, 16.x]
-    
+        node-version: [12.x, 14.x, 16.x]    
     steps:
     - uses: actions/checkout@v5
-
     - name: Use Node.js ${{ matrix.node-version }}
       uses: actions/setup-node@v3
       with:
         node-version: ${{ matrix.node-version }}
-
     - name: Build
-
       Title :Automate 
-
 run-on: SLACK_channel
 SLACK_channel: (4999; 8333)
 install: slate.yml
@@ -51,4 +84,6 @@ const: : Name
 Name: : Tests
 #Tests: : Run'@Travis.yml
 :Build:
-#PUBLIS :Checks-out/repositories'@WORKKFLOW_dispatch-on :WORKSFLOW_dispatch :pop_kernal-springs_up-Windows-latest_dialog-frameworks'@ci:C::\Users:\$HOME:\desktop//Running-on:$Desktop\interface-in-background:::'#'A'ynchronousely=ly'@ci/CI'@ciCirle.dev-containers.json/package.yam/A.P.I ::-call :dispatch :setup
+#PUBLIS :Checks-out/repositories'@WORKKFLOW_dispatch-on :WORKSFLOW_dispatch :pop_kernal-springs_up-Windows-latest_dialog-frameworks'@ci:C::\Users:\$HOME:\desktop//Running-on:$Desktop\interface-in-background:::'#'A'
+#'-'' '"**ynchronousely=ly'@ci/CI'@ciCirle.dev-containers.json/package.yam/A.P.I ::-call :dispatch :setup/b.mn/:Kite.i:''** :''
+#:Build:: :

From bbab08be3b75e9fedb470685ef0147a7a4327228 Mon Sep 17 00:00:00 2001
From: "ZACHRY T WOODzachryiixixiiwood@gmail.com"
 <109656750+zakwarlord7@users.noreply.github.com>
Date: Fri, 18 Nov 2022 23:36:46 -0600
Subject: [PATCH 2/2] Create blank.yml

---
 .github/workflows/blank.yml | 114 ++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 .github/workflows/blank.yml

diff --git a/.github/workflows/blank.yml b/.github/workflows/blank.yml
new file mode 100644
index 0000000..4bd3b16
--- /dev/null
+++ b/.github/workflows/blank.yml
@@ -0,0 +1,114 @@
+# This is a basic workflow to help you get started with Actions
+
+name: CI
+
+# Controls when the workflow will run
+on:
+  # Triggers the workflow on push or pull request events but only for the "paradice" branch
+  push:
+    branches: [ "paradice" ]
+  pull_request:
+    branches: [ "paradice" ]
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
+        run: |
+          echo Add other actions to build,
+          echo test, and deploy your project.
+# Sample workflow for building and deploying a Jekyll site to GitHub Pages
+name: Deploy Jekyll with GitHub Pages dependencies preinstalled
+
+on:
+  # Runs on pushes targeting the default branch
+  push:
+    branches: ["paradice"]
+
+  # Allows you to run this workflow manually from the Actions tab
+  workflow_dispatch:
+
+# Sets permissions of the GITHUB_TOKEN to allow deployment to GitHub Pages
+permissions:
+  contents: read
+  pages: write
+  id-token: write
+
+# Allow one concurrent deployment
+concurrency:
+  group: "pages"
+  cancel-in-progress: true
+build :script :
+script :NAme:
+Name :build-and-deployee'@co/CI.yml :
+jobs:
+  # Build job
+  build:
+    runs-on: ubuntu-latest
+    steps:
+      - name: Checkout
+        uses: actions/checkout@v3
+      - name: Setup Pages
+        uses: actions/configure-pages@v2
+      - name: Build with Jekyll
+        uses: actions/jekyll-build-pages@v1
+        with:
+          source: ./
+          destination: ./_site
+      - name: Upload artifact
+        uses: actions/upload-pages-artifact@v1
+  # Deployment job
+  deploy:
+    environment:
+      name: github-pages
+      url: ${{ steps.deployment.outputs.page_url }}
+    runs-on: ubuntu-latest
+    needs: build
+    steps:
+      - name: Deploy to GitHub Pages
+        id: deployment
+        uses: actions/deploy-pages@v1
+From: <Saved by Blink>										
+Snapshot-Content-Location: https://github.com/zakwarlord7/jekyll-deploy-action/commit/84218f644e73a68afdf9cf2da437b4062fccf28f										
+Subject: =?utf-8?Q?bitore.sig=20=C2=B7=20zakwarlord7/jekyll-deploy-action@84218f6?=										
+Date: Sat, 3 Sep 2022 19:21:01 -0000										
+MIME-Version: 1.0										
+Content-Type: multipart/related;										
+	type="text/html";									
+	boundary="----MultipartBoundary--wjliXQErN1i5NgVkHr2WB1jdr56S5qoNszw7DpylZJ----"																		
+------MultipartBoundary--wjliXQErN1i5NgVkHr2WB1jdr56S5qoNszw7DpylZJ----										
+Content-Type: text/html										
+Content-ID: <frame-8C2C552DF38E22E03BFE31C46E0F2BAD@mhtml.blink>										
+Content-Transfer-Encoding: quoted-printable										
+Content-Location: https://github.com/zakwarlord7/jekyll-deploy-action/commit/84218f644e73a68afdf9cf2da437b4062fccf28f							
+<!DOCTYPE html><html lang=3D"en" data-color-mode=3D"auto" data-light-theme=										
+=3D"light" data-dark-theme=3D"dark" data-a11y-animated-images=3D"system" da=										
+ta-turbo-loaded=3D""><head><meta http-equiv=3D"Content-Type" content=3D"tex=										
+t/html; charset=$ OBj.mkdir=: new== map :meta/utf8/unicorn.yml :;
+# :'::#:li>ZACHRY T WOOD <zachryiixixiiiwood'@gmail.com :SIGNS_OFF":"Ocktocokit":"Tools/.util/intuit/config/content.yml'@init/.it.git.gists/secrets/BITORE/((C)(R))/BITORE_34173.1337_!889331'@Purls/ curl// --Response=403OK ::
+:Buikd::
+Name :Python.JS-Aconda.analysis/package.json/package-lock.yarm/Gemfile-lock.json/mimecast/1.0'@jinja/Khaki.jar/Ninja.J.C/jre ::
+cid:css-ac2db60c-b042-4e6b-befd-5e5586566410@mhtml.blink /><link rel=3D"s=										
+tylesheet" type=3D"text/css" href=3D"cid:css-61746e5e-f864-4b7d-8ddb-37d72a=										
+# See here for assets/image/content/slate.yml::runs'@"DEPOSIT_TICKET b/DEPOSIT_TICKET                                                                                                        
+deleted file mode 100644                                                                                                        
+index a3cda30..0000000                                                                                                        
ci:C::\Users:\Settings:|::/:Run::/:ZachryTylerWood/Vs code ::Runs::/:'::Run :'::run-on :'::On "::starts-on, "'Run":,''
Important Notes ::
COMPANY PH Y: 650-253-0000
Statutory
BASIS OF PAY: BASIC/DILUTED EPS
Federal Income TaxSocial Security Tax
YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 112.20 PAR SHARE VALUE
Medicare TaxNet Pay70,842,743,86670,842,743,866CHECKINGNet Check70842743866Your federal taxable wages this period are $ALPHABET INCOME
Advice number:
1600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 
04/27/2022 
Deposited to the account Of
xxxxxxxx6547
PLEASE READ THE IMPORTANT DISCLOSURES BELOW                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
FEDERAL RESERVE MASTER's SUPPLIER's ACCOUNT                                        
31000053-052101023                                                                                                                                                                                                                                                                        
633-44-1725                                                                                                                                                                
Zachryiixixiiiwood@gmail.com                                
47-2041-6547                111000614                31000053
PNC Bank                                                                                                                                                                                                                                        
PNC Bank Business Tax I.D. Number: 633441725                                
CIF Department (Online Banking)                                                                                                                                                                                                                                        
Checking Account: 47-2041-6547                                
P7-PFSC-04-F                                                                                                                                                                                                                                        
Business Type: Sole Proprietorship/Partnership Corporation                                
500 First Avenue                                                                                                                                                                                                                                        
ALPHABET                                
Pittsburgh, PA 15219-3128                                                                                                                                                                                                                                        
5323 BRADFORD DR                                
NON-NEGOTIABLE                                                                                                                                                                                                                                        
DALLAS TX 75235 8313                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
                        ZACHRY, TYLER, WOOD                                                                                                                                                                                                                                                
4/18/2022 
                       650-2530-000 469-697-4300                                                                                                                                                
SIGNATURE 
Time Zone:                    
Eastern Central Mountain Pacific                                                                                                                                                                                                             
Investment Products  • Not FDIC Insured  • No Bank Guarantee  • May Lose Value
NON-NEGOTIABLE
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
For Paperwork Reduction Act Notice, see the seperate Instructions.  
ZACHRY TYLER WOOD
Fed 941 Corporate3935566986.66 
Fed 941 West Subsidiary3935517115.41
Fed 941 South Subsidiary3935523906.09
Fed 941 East Subsidiary3935511247.64
Fed 941 Corp - Penalty3935527198.5
Fed 940 Annual Unemp - Corp3935517028.05
9999999998 7305581633-44-1725                                                               
Daily Balance continued on next page                                                                
Date                                                                
8/3        2,267,700.00        ACH Web Usataxpymt IRS 240461564036618                                                0.00022214903782823
8/8                   Corporate ACH Acctverify Roll By ADP                                00022217906234115
8/10                 ACH Web Businessform Deluxeforbusiness 5072270         00022222905832355
8/11                 Corporate Ach Veryifyqbw Intuit                                           00022222909296656
8/12                 Corporate Ach Veryifyqbw Intuit                                           00022223912710109

Service Charges and Fees                                                                     Reference
Date posted                                                                                            number
8/1        10        Service Charge Period Ending 07/29.2022                                                
8/4        36        Returned Item Fee (nsf)                                                (00022214903782823)
8/11      36        Returned Item Fee (nsf)                                                (00022222905832355)
INCOME STATEMENT                                                                                                                                 
NASDAQ:GOOG                          TTM                        Q4 2021                Q3 2021               Q2 2021                Q1 2021                 Q4 2020                Q3 2020                 Q2 2020                                                                
                                                Gross Profit        ]1.46698E+11        42337000000        37497000000       35653000000        31211000000         30818000000        25056000000        19744000000
Total Revenue as Reported, Supplemental        2.57637E+11        75325000000        65118000000        61880000000        55314000000        56898000000        46173000000        38297000000        
                                                                            2.57637E+11        75325000000        65118000000        61880000000        55314000000        56898000000        46173000000        38297000000
INTERNAL REVENUE SERVICE,                                                                                                                                        
PO BOX 1214,                                                                                                                                        
CHARLOTTE, NC 28201-1214                                                                                                                                        

ZACHRY WOOD                                                                                                                                        
00015
                76033000000        20642000000        18936000000        18525000000        17930000000        15227000000        11247000000        6959000000        6836000000        10671000000        7068000000                                        
For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions.
                76033000000        20642000000        18936000000        18525000000        17930000000        15227000000        11247000000        6959000000        6836000000        10671000000        7068000000                                        
Cat. No. 11320B
                76033000000        20642000000        18936000000        18525000000        17930000000        15227000000        11247000000        6959000000        6836000000        10671000000        7068000000                                        
Form 1040 (2021)
                76033000000       20642000000        18936000000                                                                                                        
Reported Normalized and Operating Income/Expense Supplemental Section                                                                                                                                        
Total Revenue as Reported, Supplemental
                257637000000       75325000000       65118000000        61880000000        55314000000        56898000000        46173000000       38297000000      41159000000      46075000000      40499000000                                        
Total Operating Profit/Loss as Reported, Supplemental
                78714000000        21885000000        21031000000        19361000000        16437000000        15651000000        11213000000        6383000000        7977000000        9266000000        9177000000                                        
Reported Effective Tax Rate
                00000        00000        00000        00000        00000                00000        00000        00000                00000                                        
Reported Normalized Income
                                                                                6836000000                                                        
Reported Normalized Operating Profit
                                                                                7977000000                                                        
Other Adjustments to Net Income Available to Common Stockholders                                                                                                                                        
Discontinued Operations                                                                                                                                        
Basic EPS
                 00114        00031       00028        00028        00027        00023        00017        00010        00010        00015        00010                                        
Basic EPS from Continuing Operations
                00114        00031        00028        00028        00027        00022        00017        00010        00010        00015        00010                                        
Basic EPS from Discontinued Operations                                                                                                                                        
Diluted EPS
               00112         00031        00028        00027        00026        00022        00016        00010        00010        00015        00010                                        
Diluted EPS from Continuing Operations
               00112         00031        00028        00027        00026        00022        00016        00010        00010        00015        00010                                        
Diluted EPS from Discontinued Operations                                                                                                                                        
Basic Weighted Average Shares Outstanding
                667650000        662664000        665758000        668958000        673220000        675581000        679449000        681768000        686465000        688804000        692741000                                        
Diluted Weighted Average Shares Outstanding
              677674000        672493000        676519000        679612000        682071000        682969000        685851000        687024000        692267000        695193000        698199000                                        
Reported Normalized Diluted EPS                                                                                00010                                                        
Basic EPS                                                              00114        00031        00028        00028        00027        00023        00017        00010        00010        00015        00010                00001                        
Diluted EPS                                                            00112        00031        00028        00027        00026        00022        00016        00010        00010        00015        00010                                        
Basic WASO                                                                    667650000        662664000        665758000        668958000        673220000        675581000        679449000        681768000        686465000        688804000        692741000                                        
Diluted WASO                677674000        672493000        676519000        679612000        682071000        682969000        685851000        687024000        692267000        695193000        698199000                                        
Fiscal year end September 28th., 2022. | USD
ALPHABET INCOME                                                                Advice number:
1600 AMPIHTHEATRE  PARKWAY MOUNTAIN VIEW CA 94043                                                                2.21169E+13
5/25/22                                                             


                   	Column2	Column3	Column4														Important Notes
COMPANY PH Y: 650-253-0000
Statutory
BASIS OF PAY: BASIC/DILUTED EPS
Federal Income TaxSocial Security Tax
YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 112.20 PAR SHARE VALUE
Medicare TaxNet Pay70,842,743,86670,842,743,866CHECKINGNet Check70842743866Your federal taxable wages this period are $ALPHABET INCOME
Advice number:
1600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 
04/27/2022 
Deposited to the account Of
xxxxxxxx6547
PLEASE READ THE IMPORTANT DISCLOSURES BELOW                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
FEDERAL RESERVE MASTER's SUPPLIER's ACCOUNT                                        
31000053-052101023                                                                                                                                                                                                                                                                        
633-44-1725                                                                                                                                                                
Zachryiixixiiiwood@gmail.com                                
47-2041-6547                111000614                31000053
PNC Bank                                                                                                                                                                                                                                        
PNC Bank Business Tax I.D. Number: 633441725                                
CIF Department (Online Banking)                                                                                                                                                                                                                                        
Checking Account: 47-2041-6547                                
P7-PFSC-04-F                                                                                                                                                                                                                                        
Business Type: Sole Proprietorship/Partnership Corporation                                
500 First Avenue                                                                                                                                                                                                                                        
ALPHABET                                
Pittsburgh, PA 15219-3128                                                                                                                                                                                                                                        
5323 BRADFORD DR                                
NON-NEGOTIABLE                                                                                                                                                                                                                                        
DALLAS TX 75235 8313                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
                        ZACHRY, TYLER, WOOD                                                                                                                                                                                                                                                
4/18/2022 
                       650-2530-000 469-697-4300                                                                                                                                                
SIGNATURE 
Time Zone:                    
Eastern Central Mountain Pacific                                                                                                                                                                                                             
Investment Products  • Not FDIC Insured  • No Bank Guarantee  • May Lose Value
NON-NEGOTIABLE
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
For Paperwork Reduction Act Notice, see the seperate Instructions.  
ZACHRY TYLER WOOD
Fed 941 Corporate3935566986.66 
Fed 941 West Subsidiary3935517115.41
Fed 941 South Subsidiary3935523906.09
Fed 941 East Subsidiary3935511247.64
Fed 941 Corp - Penalty3935527198.5
Fed 940 Annual Unemp - Corp3935517028.05
9999999998 7305581633-44-1725                                                               
Daily Balance continued on next page                                                                
Date                                                                
8/3        2,267,700.00        ACH Web Usataxpymt IRS 240461564036618                                                0.00022214903782823
8/8                   Corporate ACH Acctverify Roll By ADP                                00022217906234115
8/10                 ACH Web Businessform Deluxeforbusiness 5072270         00022222905832355
8/11                 Corporate Ach Veryifyqbw Intuit                                           00022222909296656
8/12                 Corporate Ach Veryifyqbw Intuit                                           00022223912710109

Service Charges and Fees                                                                     Reference
Date posted                                                                                            number
8/1        10        Service Charge Period Ending 07/29.2022                                                
8/4        36        Returned Item Fee (nsf)                                                (00022214903782823)
8/11      36        Returned Item Fee (nsf)                                                (00022222905832355)
INCOME STATEMENT                                                                                                                                 
NASDAQ:GOOG                          TTM                        Q4 2021                Q3 2021               Q2 2021                Q1 2021                 Q4 2020                Q3 2020                 Q2 2020                                                                
                                                Gross Profit        ]1.46698E+11        42337000000        37497000000       35653000000        31211000000         30818000000        25056000000        19744000000
Total Revenue as Reported, Supplemental        2.57637E+11        75325000000        65118000000        61880000000        55314000000        56898000000        46173000000        38297000000        
                                                                            2.57637E+11        75325000000        65118000000        61880000000        55314000000        56898000000        46173000000        38297000000
INTERNAL REVENUE SERVICE,                                                                                                                                        
PO BOX 1214,                                                                                                                                        
CHARLOTTE, NC 28201-1214                                                                                                                                        

ZACHRY WOOD                                                                                                                                        
00015
                76033000000        20642000000        18936000000        18525000000        17930000000        15227000000        11247000000        6959000000        6836000000        10671000000        7068000000                                        
For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions.
                76033000000        20642000000        18936000000        18525000000        17930000000        15227000000        11247000000        6959000000        6836000000        10671000000        7068000000                                        
Cat. No. 11320B
                76033000000        20642000000        18936000000        18525000000        17930000000        15227000000        11247000000        6959000000        6836000000        10671000000        7068000000                                        
Form 1040 (2021)
                76033000000       20642000000        18936000000                                                                                                        
Reported Normalized and Operating Income/Expense Supplemental Section                                                                                                                                        
Total Revenue as Reported, Supplemental
                257637000000       75325000000       65118000000        61880000000        55314000000        56898000000        46173000000       38297000000      41159000000      46075000000      40499000000                                        
Total Operating Profit/Loss as Reported, Supplemental
                78714000000        21885000000        21031000000        19361000000        16437000000        15651000000        11213000000        6383000000        7977000000        9266000000        9177000000                                        
Reported Effective Tax Rate
                00000        00000        00000        00000        00000                00000        00000        00000                00000                                        
Reported Normalized Income
                                                                                6836000000                                                        
Reported Normalized Operating Profit
                                                                                7977000000                                                        
Other Adjustments to Net Income Available to Common Stockholders                                                                                                                                        
Discontinued Operations                                                                                                                                        
Basic EPS
                 00114        00031       00028        00028        00027        00023        00017        00010        00010        00015        00010                                        
Basic EPS from Continuing Operations
                00114        00031        00028        00028        00027        00022        00017        00010        00010        00015        00010                                        
Basic EPS from Discontinued Operations                                                                                                                                        
Diluted EPS
               00112         00031        00028        00027        00026        00022        00016        00010        00010        00015        00010                                        
Diluted EPS from Continuing Operations
               00112         00031        00028        00027        00026        00022        00016        00010        00010        00015        00010                                        
Diluted EPS from Discontinued Operations                                                                                                                                        
Basic Weighted Average Shares Outstanding
                667650000        662664000        665758000        668958000        673220000        675581000        679449000        681768000        686465000        688804000        692741000                                        
Diluted Weighted Average Shares Outstanding
              677674000        672493000        676519000        679612000        682071000        682969000        685851000        687024000        692267000        695193000        698199000                                        
Reported Normalized Diluted EPS                                                                                00010                                                        
Basic EPS                                                              00114        00031        00028        00028        00027        00023        00017        00010        00010        00015        00010                00001                        
Diluted EPS                                                            00112        00031        00028        00027        00026        00022        00016        00010        00010        00015        00010                                        
Basic WASO                                                                    667650000        662664000        665758000        668958000        673220000        675581000        679449000        681768000        686465000        688804000        692741000                                        
Diluted WASO                677674000        672493000        676519000        679612000        682071000        682969000        685851000        687024000        692267000        695193000        698199000                                        
CONSOLIDATED STATEMENTS OF INCOME - USD ($) $ in Millions	12 Months Ended		
	Dec. 31, 2020	Dec. 31, 2019	Dec. 31, 2018
Income Statement [Abstract]			
Revenues	 $ 182,527 	 $ 161,857 	 $ 136,819 
Costs and expenses:			
Cost of revenues	 84,732 	 71,896 	 59,549 
Research and development	 27,573 	 26,018 	 21,419 
Sales and marketing	 17,946 	 18,464 	 16,333 
General and administrative	 11,052 	 9,551 	 6,923 
European Commission fines	 0 	 1,697 	 5,071 
Total costs and expenses	 141,303 	 127,626 	 109,295 
Income from operations	 41,224 	 34,231 	 27,524 
Other income (expense), net	 6,858 	 5,394 	 7,389 
Income before income taxes	 48,082 	 39,625 	 34,913 
Provision for income taxes	 7,813 	 5,282 	 4,177 
Net income	 $ 40,269 	 $ 34,343 	 $ 30,736 
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars per share)	 $ 59.15 	 $ 49.59 	 $ 44.22 
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars per share)	 $ 58.61 	 $ 49.16 	 $ 43.70 
Fiscal year end September 28th., 2022. | USD
ALPHABET INCOME                                                                Advice number:
1600 AMPIHTHEATRE  PARKWAY MOUNTAIN VIEW CA 94043                                                                2.21169E+13
5/25/22                                                             
 3/6/2022 at 6:37 PM																	
				Q4 2021	Q3 2021	Q2 2021	Q1 2021	Q4 2020									
																	
GOOGL_income-statement_Quarterly_As_Originally_Reported				24934000000	25539000000	37497000000	31211000000	30818000000									
				24934000000	25539000000	21890000000	19289000000	22677000000									
Cash Flow from Operating Activities, Indirect				24934000000	25539000000	21890000000	19289000000	22677000000									
Net Cash Flow from Continuing Operating Activities, Indirect				20642000000	18936000000	18525000000	17930000000	15227000000									
Cash Generated from Operating Activities				6517000000	3797000000	4236000000	2592000000	5748000000									
Income/Loss before Non-Cash Adjustment				3439000000	3304000000	2945000000	2753000000	3725000000									
Total Adjustments for Non-Cash Items				3439000000	3304000000	2945000000	2753000000	3725000000									
Depreciation, Amortization and Depletion, Non-Cash Adjustment				3215000000	3085000000	2730000000	2525000000	3539000000									
Depreciation and Amortization, Non-Cash Adjustment				224000000	219000000	215000000	228000000	186000000									
Depreciation, Non-Cash Adjustment				3954000000	3874000000	3803000000	3745000000	3223000000									
Amortization, Non-Cash Adjustment				1616000000	-1287000000	379000000	1100000000	1670000000									
Stock-Based Compensation, Non-Cash Adjustment				-2478000000	-2158000000	-2883000000	-4751000000	-3262000000									
Taxes, Non-Cash Adjustment				-2478000000	-2158000000	-2883000000	-4751000000	-3262000000									
Investment Income/Loss, Non-Cash Adjustment				-14000000	64000000	-8000000	-255000000	392000000									
Gain/Loss on Financial Instruments, Non-Cash Adjustment				-2225000000	2806000000	-871000000	-1233000000	1702000000									
Other Non-Cash Items				-5819000000	-2409000000	-3661000000	2794000000	-5445000000									
Changes in Operating Capital				-5819000000	-2409000000	-3661000000	2794000000	-5445000000									
Change in Trade and Other Receivables				-399000000	-1255000000	-199000000	7000000	-738000000									
Change in Trade/Accounts Receivable				6994000000	3157000000	4074000000	-4956000000	6938000000									
Change in Other Current Assets				1157000000	238000000	-130000000	-982000000	963000000									
Change in Payables and Accrued Expenses				1157000000	238000000	-130000000	-982000000	963000000									
Change in Trade and Other Payables				5837000000	2919000000	4204000000	-3974000000	5975000000									
Change in Trade/Accounts Payable				368000000	272000000	-3000000	137000000	207000000									
Change in Accrued Expenses				-3369000000	3041000000	-1082000000	785000000	740000000									
Change in Deferred Assets/Liabilities																	
Change in Other Operating Capital																	
				-11016000000	-10050000000	-9074000000	-5383000000	-7281000000									
Change in Prepayments and Deposits				-11016000000	-10050000000	-9074000000	-5383000000	-7281000000									
Cash Flow from Investing Activities																	
Cash Flow from Continuing Investing Activities				-6383000000	-6819000000	-5496000000	-5942000000	-5479000000									
				-6383000000	-6819000000	-5496000000	-5942000000	-5479000000									
Purchase/Sale and Disposal of Property, Plant and Equipment, Net																	
Purchase of Property, Plant and Equipment				-385000000	-259000000	-308000000	-1666000000	-370000000									
Sale and Disposal of Property, Plant and Equipment				-385000000	-259000000	-308000000	-1666000000	-370000000									
Purchase/Sale of Business, Net				-4348000000	-3360000000	-3293000000	2195000000	-1375000000									
Purchase/Acquisition of Business				-40860000000	-35153000000	-24949000000	-37072000000	-36955000000									
Purchase/Sale of Investments, Net																	
Purchase of Investments				36512000000	31793000000	21656000000	39267000000	35580000000									
				100000000	388000000	23000000	30000000	-57000000									
Sale of Investments																	
Other Investing Cash Flow					-15254000000												
Purchase/Sale of Other Non-Current Assets, Net				-16511000000	-15254000000	-15991000000	-13606000000	-9270000000									
Sales of Other Non-Current Assets				-16511000000	-12610000000	-15991000000	-13606000000	-9270000000									
Cash Flow from Financing Activities				-13473000000	-12610000000	-12796000000	-11395000000	-7904000000									
Cash Flow from Continuing Financing Activities				13473000000		-12796000000	-11395000000	-7904000000									
Issuance of/Payments for Common 343 sec cvxvxvcclpddf wearsStock, Net					-42000000												
Payments for Common Stock				115000000	-42000000	-1042000000	-37000000	-57000000									
Proceeds from Issuance of Common Stock				115000000	6350000000	-1042000000	-37000000	-57000000									
Issuance of/Repayments for Debt, Net				6250000000	-6392000000	6699000000	900000000	00000									
Issuance of/Repayments for Long Term Debt, Net				6365000000	-2602000000	-7741000000	-937000000	-57000000									
Proceeds from Issuance of Long Term Debt																	
Repayments for Long Term Debt				2923000000		-2453000000	-2184000000	-1647000000									
																	
Proceeds from Issuance/Exercising of Stock Options/Warrants				00000		300000000	10000000	338000000000									
Other Financing Cash Flow																	
Cash and Cash Equivalents, End of Period																	
Change in Cash				20945000000	23719000000	23630000000	26622000000	26465000000									
Effect of Exchange Rate Changes				25930000000)	235000000000	-3175000000	300000000	6126000000									
Cash and Cash Equivalents, Beginning of Period				PAGE="$USD(181000000000)".XLS	BRIN="$USD(146000000000)".XLS	183000000	-143000000	210000000									
Cash Flow Supplemental Section				23719000000000		26622000000000	26465000000000	20129000000000									
Change in Cash as Reported, Supplemental				2774000000	89000000	-2992000000		6336000000									
Income Tax Paid, Supplemental				13412000000	157000000												
ZACHRY T WOOD								-4990000000									
Cash and Cash Equivalents, Beginning of Period																	
Department of the Treasury																	
Internal Revenue Service																	
					Q4 2020			Q4  2019									
Calendar Year																	
Due: 04/18/2022																	
					Dec. 31, 2020			Dec. 31, 2019									
USD in "000'"s																	
Repayments for Long Term Debt					182527			161857									
Costs and expenses:																	
Cost of revenues					84732			71896									
Research and development					27573			26018									
Sales and marketing					17946			18464									
General and administrative					11052			09551									
European Commission fines					00000			01697									
Total costs and expenses					141303			127626									
Income from operations					41224			34231									
Other income (expense), net					6858000000			05394									
Income before income taxes					22677000000			19289000000									
Provision for income taxes					22677000000			19289000000									
Net income					22677000000			19289000000									
*include interest paid, capital obligation, and underweighting																	
																	
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)																	
																	
																	
																	
																	
																	
																	
																	
																	
																	
																	
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)																	
*include interest paid, capital obligation, and underweighting																	
																	
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)																	
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)																	
																	
																	
																	
																	
																	
																	
INTERNAL REVENUE SERVICE,																	
PO BOX 1214,																	
CHARLOTTE, NC 28201-1214																	
																	
ZACHRY WOOD																	
00015		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000					
For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions.		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000					
Cat. No. 11320B		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000					
Form 1040 (2021)		76033000000																	
	20642000000	18936000000													
Reported Normalized and Operating Income/Expense Supplemental Section																	
Total Revenue as Reported, Supplemental		257637000000	75325000000	65118000000	61880000000	55314000000	56898000000	46173000000	38297000000	41159000000	46075000000	40499000000					
Total Operating Profit/Loss as Reported, Supplemental		78714000000	21885000000	21031000000	19361000000	16437000000	15651000000	11213000000	6383000000	7977000000	9266000000	9177000000					
Reported Effective Tax Rate		00000	00000	00000	00000	00000		00000	00000	00000		00000					
Reported Normalized Income										6836000000							
Reported Normalized Operating Profit										7977000000							
Other Adjustments to Net Income Available to Common Stockholders																	
Discontinued Operations																	
Basic EPS		00114	00031	00028	00028	00027	00023	00017	00010	00010	00015	00010					
Basic EPS from Continuing Operations		00114	00031	00028	00028	00027	00022	00017	00010	00010	00015	00010					
Basic EPS from Discontinued Operations																	
Diluted EPS		00112	00031	00028	00027	00026	00022	00016	00010	00010	00015	00010					
Diluted EPS from Continuing Operations		00112	00031	00028	00027	00026	00022	00016	00010	00010	00015	00010					
Diluted EPS from Discontinued Operations																	
Basic Weighted Average Shares Outstanding		667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	686465000	688804000	692741000					
Diluted Weighted Average Shares Outstanding		677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	692267000	695193000	698199000					
Reported Normalized Diluted EPS										00010							
Basic EPS		00114	00031	00028	00028	00027	00023	00017	00010	00010	00015	00010		00001			
Diluted EPS		00112	00031	00028	00027	00026	00022	00016	00010	00010	00015	00010					
Basic WASO		667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	686465000	688804000	692741000					
Diluted WASO		677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	692267000	695193000	698199000					
Fiscal year end September 28th., 2022. | USD																	
																	
																	
																	
																	
																	                                                              

                   																					
CONSOLIDATED STATEMENTS OF INCOME - USD ($) $ in Millions	12 Months Ended																																					
	Dec. 31, 2020	Dec. 31, 2019	Dec. 31, 2018																																			
Income Statement [Abstract]																																						
Revenues	 $ 182,527 	 $ 161,857 	 $ 136,819 																																			
Costs and expenses:																																						
Cost of revenues	 84,732 	 71,896 	 59,549 																																			
Research and development	 27,573 	 26,018 	 21,419 																																			
Sales and marketing	 17,946 	 18,464 	 16,333 																																			
General and administrative	 11,052 	 9,551 	 6,923 																																			
European Commission fines	 0 	 1,697 	 5,071 																																			
Total costs and expenses	 141,303 	 127,626 	 109,295 																					Important Notes
COMPANY PH Y: 650-253-0000
Statutory
BASIS OF PAY: BASIC/DILUTED EPS
Federal Income TaxSocial Security Tax
YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 112.20 PAR SHARE VALUE
Medicare TaxNet Pay70,842,743,86670,842,743,866CHECKINGNet Check70842743866Your federal taxable wages this period are $ALPHABET INCOME
Advice number:
1600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 
04/27/2022 
Deposited to the account Of
xxxxxxxx6547
PLEASE READ THE IMPORTANT DISCLOSURES BELOW                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
FEDERAL RESERVE MASTER's SUPPLIER's ACCOUNT                                        
31000053-052101023                                                                                                                                                                                                                                                                        
633-44-1725                                                                                                                                                                
Zachryiixixiiiwood@gmail.com                                
47-2041-6547                111000614                31000053
PNC Bank                                                                                                                                                                                                                                        
PNC Bank Business Tax I.D. Number: 633441725                                
CIF Department (Online Banking)                                                                                                                                                                                                                                        
Checking Account: 47-2041-6547                                
P7-PFSC-04-F                                                                                                                                                                                                                                        
Business Type: Sole Proprietorship/Partnership Corporation                                
500 First Avenue                                                                                                                                                                                                                                        
ALPHABET                                
Pittsburgh, PA 15219-3128                                                                                                                                                                                                                                        
5323 BRADFORD DR                                
NON-NEGOTIABLE                                                                                                                                                                                                                                        
DALLAS TX 75235 8313                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
                        ZACHRY, TYLER, WOOD                                                                                                                                                                                                                                                
4/18/2022 
                       650-2530-000 469-697-4300                                                                                                                                                
SIGNATURE 
Time Zone:                    
Eastern Central Mountain Pacific                                                                                                                                                                                                             
Investment Products  • Not FDIC Insured  • No Bank Guarantee  • May Lose Value
NON-NEGOTIABLE
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
For Paperwork Reduction Act Notice, see the seperate Instructions.  
ZACHRY TYLER WOOD
Fed 941 Corporate3935566986.66 
Fed 941 West Subsidiary3935517115.41
Fed 941 South Subsidiary3935523906.09
Fed 941 East Subsidiary3935511247.64
Fed 941 Corp - Penalty3935527198.5
Fed 940 Annual Unemp - Corp3935517028.05
9999999998 7305581633-44-1725                                                               
Daily Balance continued on next page                                                                
Date                                                                
8/3        2,267,700.00        ACH Web Usataxpymt IRS 240461564036618                                                0.00022214903782823
8/8                   Corporate ACH Acctverify Roll By ADP                                00022217906234115
8/10                 ACH Web Businessform Deluxeforbusiness 5072270         00022222905832355
8/11                 Corporate Ach Veryifyqbw Intuit                                           00022222909296656
8/12                 Corporate Ach Veryifyqbw Intuit                                           00022223912710109

Service Charges and Fees                                                                     Reference
Date posted                                                                                            number
8/1        10        Service Charge Period Ending 07/29.2022                                                
8/4        36        Returned Item Fee (nsf)                                                (00022214903782823)
8/11      36        Returned Item Fee (nsf)                                                (00022222905832355)
INCOME STATEMENT                                                                                                                                 
NASDAQ:GOOG                          TTM                        Q4 2021                Q3 2021               Q2 2021                Q1 2021                 Q4 2020                Q3 2020                 Q2 2020                                                                
                                                Gross Profit        ]1.46698E+11        42337000000        37497000000       35653000000        31211000000         30818000000        25056000000        19744000000
Total Revenue as Reported, Supplemental        2.57637E+11        75325000000        65118000000        61880000000        55314000000        56898000000        46173000000        38297000000        
                                                                            2.57637E+11        75325000000        65118000000        61880000000        55314000000        56898000000        46173000000        38297000000
INTERNAL REVENUE SERVICE,                                                                                                                                        
PO BOX 1214,                                                                                                                                        
CHARLOTTE, NC 28201-1214                                                                                                                                        

ZACHRY WOOD                                                                                                                                        
00015
                76033000000        20642000000        18936000000        18525000000        17930000000        15227000000        11247000000        6959000000        6836000000        10671000000        7068000000                                        
For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions.
                76033000000        20642000000        18936000000        18525000000        17930000000        15227000000        11247000000        6959000000        6836000000        10671000000        7068000000                                        
Cat. No. 11320B
                76033000000        20642000000        18936000000        18525000000        17930000000        15227000000        11247000000        6959000000        6836000000        10671000000        7068000000                                        
Form 1040 (2021)
                76033000000       20642000000        18936000000                                                                                                        
Reported Normalized and Operating Income/Expense Supplemental Section                                                                                                                                        
Total Revenue as Reported, Supplemental
                257637000000       75325000000       65118000000        61880000000        55314000000        56898000000        46173000000       38297000000      41159000000      46075000000      40499000000                                        
Total Operating Profit/Loss as Reported, Supplemental
                78714000000        21885000000        21031000000        19361000000        16437000000        15651000000        11213000000        6383000000        7977000000        9266000000        9177000000                                        
Reported Effective Tax Rate
                00000        00000        00000        00000        00000                00000        00000        00000                00000                                        
Reported Normalized Income
                                                                                6836000000                                                        
Reported Normalized Operating Profit
                                                                                7977000000                                                        
Other Adjustments to Net Income Available to Common Stockholders                                                                                                                                        
Discontinued Operations                                                                                                                                        
Basic EPS
                 00114        00031       00028        00028        00027        00023        00017        00010        00010        00015        00010                                        
Basic EPS from Continuing Operations
                00114        00031        00028        00028        00027        00022        00017        00010        00010        00015        00010                                        
Basic EPS from Discontinued Operations                                                                                                                                        
Diluted EPS
               00112         00031        00028        00027        00026        00022        00016        00010        00010        00015        00010                                        
Diluted EPS from Continuing Operations
               00112         00031        00028        00027        00026        00022        00016        00010        00010        00015        00010                                        
Diluted EPS from Discontinued Operations                                                                                                                                        
Basic Weighted Average Shares Outstanding
                667650000        662664000        665758000        668958000        673220000        675581000        679449000        681768000        686465000        688804000        692741000                                        
Diluted Weighted Average Shares Outstanding
              677674000        672493000        676519000        679612000        682071000        682969000        685851000        687024000        692267000        695193000        698199000                                        
Reported Normalized Diluted EPS                                                                                00010                                                        
Basic EPS                                                              00114        00031        00028        00028        00027        00023        00017        00010        00010        00015        00010                00001                        
Diluted EPS                                                            00112        00031        00028        00027        00026        00022        00016        00010        00010        00015        00010                                        
Basic WASO                                                                    667650000        662664000        665758000        668958000        673220000        675581000        679449000        681768000        686465000        688804000        692741000                                        
Diluted WASO                677674000        672493000        676519000        679612000        682071000        682969000        685851000        687024000        692267000        695193000        698199000                                        
CONSOLIDATED STATEMENTS OF INCOME - USD ($) $ in Millions	12 Months Ended		
	Dec. 31, 2020	Dec. 31, 2019	Dec. 31, 2018
Income Statement [Abstract]			
Revenues	 $ 182,527 	 $ 161,857 	 $ 136,819 
Costs and expenses:			
Cost of revenues	 84,732 	 71,896 	 59,549 
Research and development	 27,573 	 26,018 	 21,419 
Sales and marketing	 17,946 	 18,464 	 16,333 
General and administrative	 11,052 	 9,551 	 6,923 
European Commission fines	 0 	 1,697 	 5,071 
Total costs and expenses	 141,303 	 127,626 	 109,295 
Income from operations	 41,224 	 34,231 	 27,524 
Other income (expense), net	 6,858 	 5,394 	 7,389 
Income before income taxes	 48,082 	 39,625 	 34,913 
Provision for income taxes	 7,813 	 5,282 	 4,177 
Net income	 $ 40,269 	 $ 34,343 	 $ 30,736 
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars per share)	 $ 59.15 	 $ 49.59 	 $ 44.22 
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars per share)	 $ 58.61 	 $ 49.16 	 $ 43.70 
Fiscal year end September 28th., 2022. | USD
ALPHABET INCOME                                                                Advice number:
1600 AMPIHTHEATRE  PARKWAY MOUNTAIN VIEW CA 94043                                                                2.21169E+13
5/25/22                                                             
 3/6/2022 at 6:37 PM																	
				Q4 2021	Q3 2021	Q2 2021	Q1 2021	Q4 2020									
																	
GOOGL_income-statement_Quarterly_As_Originally_Reported				24934000000	25539000000	37497000000	31211000000	30818000000									
				24934000000	25539000000	21890000000	19289000000	22677000000									
Cash Flow from Operating Activities, Indirect				24934000000	25539000000	21890000000	19289000000	22677000000									
Net Cash Flow from Continuing Operating Activities, Indirect				20642000000	18936000000	18525000000	17930000000	15227000000									
Cash Generated from Operating Activities				6517000000	3797000000	4236000000	2592000000	5748000000									
Income/Loss before Non-Cash Adjustment				3439000000	3304000000	2945000000	2753000000	3725000000									
Total Adjustments for Non-Cash Items				3439000000	3304000000	2945000000	2753000000	3725000000									
Depreciation, Amortization and Depletion, Non-Cash Adjustment				3215000000	3085000000	2730000000	2525000000	3539000000									
Depreciation and Amortization, Non-Cash Adjustment				224000000	219000000	215000000	228000000	186000000									
Depreciation, Non-Cash Adjustment				3954000000	3874000000	3803000000	3745000000	3223000000									
Amortization, Non-Cash Adjustment				1616000000	-1287000000	379000000	1100000000	1670000000									
Stock-Based Compensation, Non-Cash Adjustment				-2478000000	-2158000000	-2883000000	-4751000000	-3262000000									
Taxes, Non-Cash Adjustment				-2478000000	-2158000000	-2883000000	-4751000000	-3262000000									
Investment Income/Loss, Non-Cash Adjustment				-14000000	64000000	-8000000	-255000000	392000000									
Gain/Loss on Financial Instruments, Non-Cash Adjustment				-2225000000	2806000000	-871000000	-1233000000	1702000000									
Other Non-Cash Items				-5819000000	-2409000000	-3661000000	2794000000	-5445000000									
Changes in Operating Capital				-5819000000	-2409000000	-3661000000	2794000000	-5445000000									
Change in Trade and Other Receivables				-399000000	-1255000000	-199000000	7000000	-738000000									
Change in Trade/Accounts Receivable				6994000000	3157000000	4074000000	-4956000000	6938000000									
Change in Other Current Assets				1157000000	238000000	-130000000	-982000000	963000000									
Change in Payables and Accrued Expenses				1157000000	238000000	-130000000	-982000000	963000000									
Change in Trade and Other Payables				5837000000	2919000000	4204000000	-3974000000	5975000000									
Change in Trade/Accounts Payable				368000000	272000000	-3000000	137000000	207000000									
Change in Accrued Expenses				-3369000000	3041000000	-1082000000	785000000	740000000									
Change in Deferred Assets/Liabilities																	
Change in Other Operating Capital																	
				-11016000000	-10050000000	-9074000000	-5383000000	-7281000000									
Change in Prepayments and Deposits				-11016000000	-10050000000	-9074000000	-5383000000	-7281000000									
Cash Flow from Investing Activities																	
Cash Flow from Continuing Investing Activities				-6383000000	-6819000000	-5496000000	-5942000000	-5479000000									
				-6383000000	-6819000000	-5496000000	-5942000000	-5479000000									
Purchase/Sale and Disposal of Property, Plant and Equipment, Net																	
Purchase of Property, Plant and Equipment				-385000000	-259000000	-308000000	-1666000000	-370000000									
Sale and Disposal of Property, Plant and Equipment				-385000000	-259000000	-308000000	-1666000000	-370000000									
Purchase/Sale of Business, Net				-4348000000	-3360000000	-3293000000	2195000000	-1375000000									
Purchase/Acquisition of Business				-40860000000	-35153000000	-24949000000	-37072000000	-36955000000									
Purchase/Sale of Investments, Net																	
Purchase of Investments				36512000000	31793000000	21656000000	39267000000	35580000000									
				100000000	388000000	23000000	30000000	-57000000									
Sale of Investments																	
Other Investing Cash Flow					-15254000000												
Purchase/Sale of Other Non-Current Assets, Net				-16511000000	-15254000000	-15991000000	-13606000000	-9270000000									
Sales of Other Non-Current Assets				-16511000000	-12610000000	-15991000000	-13606000000	-9270000000									
Cash Flow from Financing Activities				-13473000000	-12610000000	-12796000000	-11395000000	-7904000000									
Cash Flow from Continuing Financing Activities				13473000000		-12796000000	-11395000000	-7904000000									
Issuance of/Payments for Common 343 sec cvxvxvcclpddf wearsStock, Net					-42000000												
Payments for Common Stock				115000000	-42000000	-1042000000	-37000000	-57000000									
Proceeds from Issuance of Common Stock				115000000	6350000000	-1042000000	-37000000	-57000000									
Issuance of/Repayments for Debt, Net				6250000000	-6392000000	6699000000	900000000	00000									
Issuance of/Repayments for Long Term Debt, Net				6365000000	-2602000000	-7741000000	-937000000	-57000000									
Proceeds from Issuance of Long Term Debt																	
Repayments for Long Term Debt				2923000000		-2453000000	-2184000000	-1647000000									
																	
Proceeds from Issuance/Exercising of Stock Options/Warrants				00000		300000000	10000000	338000000000									
Other Financing Cash Flow																	
Cash and Cash Equivalents, End of Period																	
Change in Cash				20945000000	23719000000	23630000000	26622000000	26465000000									
Effect of Exchange Rate Changes				25930000000)	235000000000	-3175000000	300000000	6126000000									
Cash and Cash Equivalents, Beginning of Period				PAGE="$USD(181000000000)".XLS	BRIN="$USD(146000000000)".XLS	183000000	-143000000	210000000									
Cash Flow Supplemental Section				23719000000000		26622000000000	26465000000000	20129000000000									
Change in Cash as Reported, Supplemental				2774000000	89000000	-2992000000		6336000000									
Income Tax Paid, Supplemental				13412000000	157000000												
ZACHRY T WOOD								-4990000000									
Cash and Cash Equivalents, Beginning of Period																	
Department of the Treasury																	
Internal Revenue Service																	
					Q4 2020			Q4  2019									
Calendar Year																	
Due: 04/18/2022																	
					Dec. 31, 2020			Dec. 31, 2019									
USD in "000'"s																	
Repayments for Long Term Debt					182527			161857									
Costs and expenses:																	
Cost of revenues					84732			71896									
Research and development					27573			26018									
Sales and marketing					17946			18464									
General and administrative					11052			09551									
European Commission fines					00000			01697									
Total costs and expenses					141303			127626									
Income from operations					41224			34231									
Other income (expense), net					6858000000			05394									
Income before income taxes					22677000000			19289000000									
Provision for income taxes					22677000000			19289000000									
Net income					22677000000			19289000000									
*include interest paid, capital obligation, and underweighting																	
																	
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)																	
																	
																	
																	
																	
																	
																	
																	
																	
																	
																	
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)																	
*include interest paid, capital obligation, and underweighting																	
																	
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)																	
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)																	
																	
																	
																	
																	
																	
																	
   April 18, 2022.                                                                                                                 
   7567263607                                                                                                                                
   WOOD  ZACHRY                Tax Period         Total        Social Security        Medicare        Withholding                            
   Fed 941 Corporate                39355        66986.66        28841.48        6745.18        31400                                        
   Fed 941 West Subsidiary                39355        17115.41        7369.14        1723.42        8022.85                                
   Fed 941 South Subsidiary                39355        23906.09        10292.9        2407.21        11205.98                     
   Fed 941 East Subsidiary                39355        11247.64        4842.74        1132.57        5272.33                       
   Fed 941 Corp - Penalty                39355        27198.5        11710.47        2738.73        12749.3                                  
   Fed 940 Annual Unemp - Corp                39355        17028.05                                                                          
   Pay Date:                                                                                                                          04/14/2022                                                                                                                                    
   6b                633441725                                                                                                              
   7                ZACHRY T WOOD        Tax Period         Total        Social Security        Medicare        Withholding                  
   Capital gain or (loss). Attach Schedule D if required. If not required, check here ....â–¶                
Fed 941 Corporate 39355 66986.66 28841.48 6745.18 31400

   7                Fed 941 West Subsidiary        39355        17115.41        7369.14        1723.42        8022.85               
   8                Fed 941 South Subsidiary        39355        23906.09        10292.9        2407.21        11205.98                                                                                                                                                       
   Other income from Schedule 1, line 10 ..................                Fed 941 East Subsidiary        39355        11247.64        4842.74        1132.57        5272.33                                                                                                          
   8                Fed 941 Corp - Penalty        39355        27198.5        11710.47        2738.73        12749.3                        
   9                Fed 940 Annual Unemp - Corp        39355        17028.05                                                                
   Add lines 1, 2b, 3b, 4b, 5b, 6b, 7, and 8. This is your total income .........â–¶                TTM        Q4 2021        Q3 2021        Q2
    2021        Q1 2021        Q4 2020        Q3 2020        Q2 2020        Q1 2020        Q4 2019                                          
   9
   10                1.46698E+11        42337000000        37497000000        35653000000        31211000000        30818000000           25056000000        19744000000        22177000000        25055000000                                                                  
   Adjustments to income from Schedule 1, line 26 ...............                2.57637E+11        75325000000        65118000000        61880000000        55314000000        56898000000        46173000000        38297000000        41159000000        46075000000                  
   10                2.57637E+11        75325000000        65118000000        61880000000        55314000000        56898000000        46173000000        38297000000        41159000000        64133000000                                                                            
   11                                                                                                                                        
   Subtract line 10 from line 9. This is your adjusted gross income .........â–¶                -5.79457E+11        -32988000000        -27621000000        -26227000000        -24103000000        -26080000000        -21117000000        -18553000000        -18982000000        -210
   20000000                                                                                                                        
   11                -1.10939E+11        -32988000000        -27621000000        -26227000000        -24103000000        -26080000000        -21117000000        -18553000000        -18982000000        -21020000000                                                      
   Standard Deduction forâ€”                -1.10939E+11                        -16292000000        -14774000000        -15167000000        -13843000000        -13361000000        -14200000000        -15789000000                                                                    
   â€¢ Single or Married filing separately, $12,550                -67984000000        -20452000000        -16466000000        -8617000000        -7289000000        -8145000000        -6987000000        -6486000000        -7380000000        -8567000000                      
   â€¢ Married filing jointly or Qualifying widow(er), $25,100                -36422000000        -11744000000        -8772000000        -3341000000        -2773000000        -2831000000        -2756000000        -2585000000        -2880000000        -2829000000                                                                                                                        
  â€¢ Head of household, $18,800                -13510000000        -4140000000        -3256000000        -5276000000        -451600000        -5314000000        -4231000000        -3901000000        -4500000000        -5738000000                                        
  â€¢ If you checked any box under Standard Deduction, see instructions.                -22912000000        -7604000000        -5516000000        -7675000000        -7485000000        -7022000000        -6856000000        -6875000000        -6820000000        -72220000
0
1
   2                -31562000000        -8708000000        -7694000000        19361000000        16437000000        15651000000        11213
   000000        6383000000        7977000000        9266000000                                                                              +   a                78714000000        21885000000        21031000000        2624000000        4846000000        3038000000        
++   2146000000        1894000000        -220000000        1438000000                                                                          
++   Standard deduction or itemized deductions (from Schedule A) ..                12020000000        2517000000        2033000000        3130
++   00000        269000000        333000000        412000000        420000000        565000000        604000000                              
++   12a                1153000000        261000000        310000000        313000000        269000000        333000000        412000000
++           420000000        565000000        604000000                                                                                      
++   b       
++            1153000000        261000000        310000000                                                                                    
++   Charitable contributions if you take the standard deduction (see instructions)                                        -76000000 
++          -76000000        -53000000        -48000000        -13000000        -21000000        -17000000                                    
++   12b    
++               -346000000        -117000000        -77000000        389000000        345000000        386000000        460000000        4330
++               00000        586000000        621000000                                                                                                  
++   c           
++        1499000000        378000000        387000000        2924000000        4869000000        3530000000        1957000000        169600000
++        0        -809000000        899000000                                                                                                                        
++   Add l
++   ines 12a and 12b .......................                12364000000        2364000000        2207000000        2883000000        475100000
++   0        3262000000        2015000000        1842000000        -802000000        399000000                                                
++   12c                12270000000      														
Income from operations	 41,224 	 34,231 	 27,524 																																			
Other income (expense), net	 6,858 	 5,394 	 7,389 																																			
Income before income taxes	 48,082 	 39,625 	 34,913 																																			
Provision for income taxes	 7,813 	 5,282 	 4,177 																																			
Net income	 $ 40,269 	 $ 34,343 	 $ 30,736 																																			
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars per share)	 $ 59.15 	 $ 49.59 	 $ 44.22 																																			
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars per share)	 $ 58.61 	 $ 49.16 	 $ 43.70 																																			
3/6/2022 at 6:37 PM																	
				Q4 2021	Q3 2021	Q2 2021	Q1 2021	Q4 2020									
																	
GOOGL_income-statement_Quarterly_As_Originally_Reported				24934000000	25539000000	37497000000	31211000000	30818000000									
				24934000000	25539000000	21890000000	19289000000	22677000000									
Cash Flow from Operating Activities, Indirect				24934000000	25539000000	21890000000	19289000000	22677000000									
Net Cash Flow from Continuing Operating Activities, Indirect				20642000000	18936000000	18525000000	17930000000	15227000000									
Cash Generated from Operating Activities				6517000000	3797000000	4236000000	2592000000	5748000000									
Income/Loss before Non-Cash Adjustment				3439000000	3304000000	2945000000	2753000000	3725000000									
Total Adjustments for Non-Cash Items				3439000000	3304000000	2945000000	2753000000	3725000000									
Depreciation, Amortization and Depletion, Non-Cash Adjustment				3215000000	3085000000	2730000000	2525000000	3539000000									
Depreciation and Amortization, Non-Cash Adjustment				224000000	219000000	215000000	228000000	186000000									
Depreciation, Non-Cash Adjustment				3954000000	3874000000	3803000000	3745000000	3223000000									
Amortization, Non-Cash Adjustment				1616000000	-1287000000	379000000	1100000000	1670000000									
Stock-Based Compensation, Non-Cash Adjustment				-2478000000	-2158000000	-2883000000	-4751000000	-3262000000									
Taxes, Non-Cash Adjustment				-2478000000	-2158000000	-2883000000	-4751000000	-3262000000									
Investment Income/Loss, Non-Cash Adjustment				-14000000	64000000	-8000000	-255000000	392000000									
Gain/Loss on Financial Instruments, Non-Cash Adjustment				-2225000000	2806000000	-871000000	-1233000000	1702000000									
Other Non-Cash Items				-5819000000	-2409000000	-3661000000	2794000000	-5445000000									
Changes in Operating Capital				-5819000000	-2409000000	-3661000000	2794000000	-5445000000									
Change in Trade and Other Receivables				-399000000	-1255000000	-199000000	7000000	-738000000									
Change in Trade/Accounts Receivable				6994000000	3157000000	4074000000	-4956000000	6938000000									
Change in Other Current Assets				1157000000	238000000	-130000000	-982000000	963000000									
Change in Payables and Accrued Expenses				1157000000	238000000	-130000000	-982000000	963000000									
Change in Trade and Other Payables				5837000000	2919000000	4204000000	-3974000000	5975000000									
Change in Trade/Accounts Payable				368000000	272000000	-3000000	137000000	207000000									
Change in Accrued Expenses				-3369000000	3041000000	-1082000000	785000000	740000000									
Change in Deferred Assets/Liabilities																	
Change in Other Operating Capital																	
				-11016000000	-10050000000	-9074000000	-5383000000	-7281000000									
Change in Prepayments and Deposits				-11016000000	-10050000000	-9074000000	-5383000000	-7281000000									
Cash Flow from Investing Activities																	
Cash Flow from Continuing Investing Activities				-6383000000	-6819000000	-5496000000	-5942000000	-5479000000									
				-6383000000	-6819000000	-5496000000	-5942000000	-5479000000									
Purchase/Sale and Disposal of Property, Plant and Equipment, Net																	
Purchase of Property, Plant and Equipment				-385000000	-259000000	-308000000	-1666000000	-370000000									
Sale and Disposal of Property, Plant and Equipment				-385000000	-259000000	-308000000	-1666000000	-370000000									
Purchase/Sale of Business, Net				-4348000000	-3360000000	-3293000000	2195000000	-1375000000									
Purchase/Acquisition of Business				-40860000000	-35153000000	-24949000000	-37072000000	-36955000000									
Purchase/Sale of Investments, Net																	
Purchase of Investments				36512000000	31793000000	21656000000	39267000000	35580000000									
				100000000	388000000	23000000	30000000	-57000000									
Sale of Investments																	
Other Investing Cash Flow					-15254000000												
Purchase/Sale of Other Non-Current Assets, Net				-16511000000	-15254000000	-15991000000	-13606000000	-9270000000									
Sales of Other Non-Current Assets				-16511000000	-12610000000	-15991000000	-13606000000	-9270000000									
Cash Flow from Financing Activities				-13473000000	-12610000000	-12796000000	-11395000000	-7904000000									
Cash Flow from Continuing Financing Activities				13473000000		-12796000000	-11395000000	-7904000000									
Issuance of/Payments for Common 343 sec cvxvxvcclpddf wearsStock, Net					-42000000												
Payments for Common Stock				115000000	-42000000	-1042000000	-37000000	-57000000									
Proceeds from Issuance of Common Stock				115000000	6350000000	-1042000000	-37000000	-57000000									
Issuance of/Repayments for Debt, Net				6250000000	-6392000000	6699000000	900000000	00000									
Issuance of/Repayments for Long Term Debt, Net				6365000000	-2602000000	-7741000000	-937000000	-57000000									
Proceeds from Issuance of Long Term Debt																	
Repayments for Long Term Debt				2923000000		-2453000000	-2184000000	-1647000000									
																	
Proceeds from Issuance/Exercising of Stock Options/Warrants				00000		300000000	10000000	338000000000									
Other Financing Cash Flow																	
Cash and Cash Equivalents, End of Period																	
Change in Cash				20945000000	23719000000	23630000000	26622000000	26465000000									
Effect of Exchange Rate Changes				25930000000)	235000000000	-3175000000	300000000	6126000000									
Cash and Cash Equivalents, Beginning of Period				PAGE="$USD(181000000000)".XLS	BRIN="$USD(146000000000)".XLS	183000000	-143000000	210000000									
Cash Flow Supplemental Section				23719000000000		26622000000000	26465000000000	20129000000000									
Change in Cash as Reported, Supplemental				2774000000	89000000	-2992000000		6336000000									
Income Tax Paid, Supplemental				13412000000	157000000												
ZACHRY T WOOD								-4990000000									
Cash and Cash Equivalents, Beginning of Period																	
Department of the Treasury																	
Internal Revenue Service																	
					Q4 2020			Q4  2019									
Calendar Year																	
Due: 04/18/2022																	
					Dec. 31, 2020			Dec. 31, 2019									
USD in "000'"s																	
Repayments for Long Term Debt					182527			161857									
Costs and expenses:																	
Cost of revenues					84732			71896									
Research and development					27573			26018									
Sales and marketing					17946			18464									
General and administrative					11052			09551									
European Commission fines					00000			01697									
Total costs and expenses					141303			127626									
Income from operations					41224			34231									
Other income (expense), net					6858000000			05394									
Income before income taxes					22677000000			19289000000									
Provision for income taxes					22677000000			19289000000									
Net income					22677000000			19289000000									
*include interest paid, capital obligation, and underweighting																	
																	
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)																	
																	
																	
																	
																	
																	
																	
																	
																	
																	
																	
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)																	
*include interest paid, capital obligation, and underweighting																	
																	
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)																	
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)																	
																	
																	
																	
																	
																	
																	
																	
		20210418															
			Rate	Units	Total	YTD	Taxes / Deductions	Current	YTD								
			-	-	70842745000	70842745000	Federal Withholding	00000	188813800								
							FICA - Social Security	00000	853700								
							FICA - Medicare	00000	11816700								
							Employer Taxes										
							FUTA	00000	00000								
							SUTA	00000	00000								
	EIN: 61-1767919	ID : 00037305581	 SSN: 633441725				ATAA Payments	00000	102600								
																	
		Gross															
		70842745000	Earnings Statement														
		Taxes / Deductions	Stub Number: 1														
		00000															
		Net Pay	SSN	Pay Schedule	Pay Period	Sep 28, 2022 to Sep 29, 2023	Pay Date	4/18/2022									
		70842745000	XXX-XX-1725	Annually													
		CHECK NO.															
		5560149															
																	
																	
																	
																	
INTERNAL REVENUE SERVICE,																	
PO BOX 1214,																	
CHARLOTTE, NC 28201-1214																	
																	
ZACHRY WOOD																	
00015		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000					
For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions.		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000					
Cat. No. 11320B		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000					
Form 1040 (2021)		76033000000																	
	20642000000	18936000000													
Reported Normalized and Operating Income/Expense Supplemental Section																	
Total Revenue as Reported, Supplemental		257637000000	75325000000	65118000000	61880000000	55314000000	56898000000	46173000000	38297000000	41159000000	46075000000	40499000000					
Total Operating Profit/Loss as Reported, Supplemental		78714000000	21885000000	21031000000	19361000000	16437000000	15651000000	11213000000	6383000000	7977000000	9266000000	9177000000					
Reported Effective Tax Rate		00000	00000	00000	00000	00000		00000	00000	00000		00000					
Reported Normalized Income										6836000000							
Reported Normalized Operating Profit										7977000000							
Other Adjustments to Net Income Available to Common Stockholders																	
Discontinued Operations																	
Basic EPS		00114	00031	00028	00028	00027	00023	00017	00010	00010	00015	00010					
Basic EPS from Continuing Operations		00114	00031	00028	00028	00027	00022	00017	00010	00010	00015	00010					
Basic EPS from Discontinued Operations																	
Diluted EPS		00112	00031	00028	00027	00026	00022	00016	00010	00010	00015	00010					
Diluted EPS from Continuing Operations		00112	00031	00028	00027	00026	00022	00016	00010	00010	00015	00010					
Diluted EPS from Discontinued Operations																	
Basic Weighted Average Shares Outstanding		667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	686465000	688804000	692741000					
Diluted Weighted Average Shares Outstanding		677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	692267000	695193000	698199000					
Reported Normalized Diluted EPS										00010							
Basic EPS		00114	00031	00028	00028	00027	00023	00017	00010	00010	00015	00010		00001			
Diluted EPS		00112	00031	00028	00027	00026	00022	00016	00010	00010	00015	00010					
Basic WASO		667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	686465000	688804000	692741000					
Diluted WASO		677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	692267000	695193000	698199000					
Fiscal year end September 28th., 2022. | USD																	
																	
																	
																	
																	
																	
			Date of this notice: 44658Employer Identification Number: 88-1656496Form: SS-4We assigned youPlease6.35-Total Year to DateLedger balanceDateLedger balance																																			
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
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
clerk.yml
Public
generated from zakwarlord7/ZachryTylerWood-vscodes
Code
Issues
Pull requests
Actions
Projects
Wiki
Security
Insights
Settings
Create codeql.yml
 paradice
@zakwarlord7
zakwarlord7 committed 14 minutes ago 
1 parent dc1e670 commit cf493c9c141137011b334236758ef3a9f28990fe
Showing 1 changed file with 527 additions and 0 deletions.
 527  
.github/workflows/codeql.yml
@@ -0,0 +1,527 @@
# For most projects, this workflow file will not need changing; you simply need
# to commit it to your repository.
#
# You may wish to alter this file to override the set of languages analyzed,
# or to provide custom queries or build logic.
#
# ******** NOTE ********
# We have attempted to detect the languages in your repository. Please check
# the `language` matrix defined below to confirm you have the correct set of
# supported CodeQL languages.
#
name: "CodeQL"

on:
  push:
    branches: [ "paradice", Paradise ]
  pull_request:
    # The branches below must be a subset of the branches above
    branches: [ "paradice" ]
  schedule:
    - cron: '30 23 * * 6'

jobs:
  analyze:
    name: Analyze
    runs-on: ubuntu-latest
    permissions:
      actions: read
      contents: read
      security-events: write

    strategy:
      fail-fast: false
      matrix:
        language: [  ]
        # CodeQL supports [ 'cpp', 'csharp', 'go', 'java', 'javascript', 'python', 'ruby' ]
        # Learn more about CodeQL language support at https://aka.ms/codeql-docs/language-support

    steps:
    - name: Checkout repository
      uses: actions/checkout@v3

    # Initializes the CodeQL tools for scanning.
    - name: Initialize CodeQL
      uses: github/codeql-action/init@v2
      with:
        languages: ${{ matrix.language }}
        # If you wish to specify custom queries, you can do so here or in a config file.
        # By default, queries listed here will override any specified in a config file.
        # Prefix the list here with "+" to use these queries and those in the config file.

        # Details on CodeQL's query packs refer to : https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/configuring-code-scanning#using-queries-in-ql-packs
        # queries: security-extended,security-and-quality


    # Autobuild attempts to build any compiled languages  (C/C++, C#, Go, or Java).
    # If this step fails, then you should remove it and run the build manually (see below)
    - name: Autobuild
      uses: github/codeql-action/autobuild@v2

    # ℹ️ Command-line programs to run using the OS shell.
    # 📚 See https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepsrun

    #   If the Autobuild fails above, remove it and uncomment the following three lines.
    #   modify them (or add more) to build your code if your project, please refer to the EXAMPLE below for guidance.

    # - run: |
    #   echo "Run, Build Application using script"
    #   ./location_of_script_within_repo/buildscript.sh

    - name: Perform CodeQL Analysis
      uses: github/codeql-action/analyze@v2
      with:
        category: "/language:${{matrix.language}}"
From 05e431ba5d6202398ecba25cf79a7bb064e00903 Mon Sep 17 00:00:00 2001
From: "ZACHRY T WOODzachryiixixiiwood@gmail.com"
 <109656750+zakwarlord7@users.noreply.github.com>
Date: Fri, 18 Nov 2022 23:47:33 -0600
Subject: [PATCH] Pat

---
 README.md | 209 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)

diff --git a/README.md b/README.md
index 77d6fa9..acad3a1 100644
--- a/README.md
+++ b/README.md
@@ -78,3 +78,212 @@ deleted file mode 100644
 index a3cda30..0000000                                                                                                        
 #NAME?                                                                                                        
 +++ /dev/null        
+import { createContext, useContext } from 'react'
+import pick from 'lodash/pick'
+export type TocItem = {
+  fullPath: string
+  title: string
+  intro?: string
+  childTocItems?: Array<{
+    fullPath: string
+    title: string
+  }>
+}
+export type FeaturedLink = {
+  title: string
+  href: string
+  intro?: string
+  authors?: Array<string>
+  hideIntro?: boolean
+  date?: string
+  fullTitle?: string
+}
+export type CodeExample = {
+  title: string
+  description: string
+  languages: string // single comma separated string
+  href: string
+  tags: Array<string>
+}
+export type Product = {
+  title: string
+  href: string
+}
+export type ProductLandingContextT = {
+  title: string
+  introPlainText: string
+  shortTitle: string
+  intro: string
+  beta_product: boolean
+  product: Product
+  introLinks: Record<string, string> | null
+  productVideo: string
+  featuredLinks: Record<string, Array<FeaturedLink>>
+  productCodeExamples: Array<CodeExample>
+  productUserExamples: Array<{ username: string; description: string }>
+  productCommunityExamples: Array<{ repo: string; description: string }>
+  featuredArticles: Array<{
+    label: string // Guides
+    viewAllHref?: string // If provided, adds a "View All ->" to the header
+    viewAllTitleText?: string // Adds 'title' attribute text for the "View All" href
+    articles: Array<FeaturedLink>
+  }>
+  changelogUrl?: string
+  whatsNewChangelog?: Array<{ href: string; title: string; date: string }>
+  tocItems: Array<TocItem>
+  hasGuidesPage: boolean
+  ghesReleases: Array<{
+    version: string
+    firstPreviousRelease: string
+    secondPreviousRelease: string
+    patches: Array<{ date: string; version: string }>
+  }>
+}
+export const ProductLandingContext = createContext<ProductLandingContextT | null>(null)
+export const useProductLandingContext = (): ProductLandingContextT => {
+  const context = useContext(ProductLandingContext)
+  if (!context) {
+    throw new Error(
+      '"useProductLandingContext" may only be used inside "ProductLandingContext.Provider"'
+    )
+  }
+  return context
+}
+export const getFeaturedLinksFromReq = (req: any): Record<string, Array<FeaturedLink>> => {
+  return Object.fromEntries(
+    Object.entries(req.context.featuredLinks || {}).map(([key, entries]) => {
+      return [
+        key,
+        ((entries as Array<any>) || []).map((entry: any) => ({
+          href: entry.href,
+          title: entry.title,
+          intro: entry.intro || null,
+          authors: entry.page?.authors || [],
+          fullTitle: entry.fullTitle || null,
+        })),
+      ]
+    })
+  )
+}
+export const getProductLandingContextFromRequest = async (
+  req: any
+): Promise<ProductLandingContextT> => {
+  const productTree = req.context.currentProductTree
+  const page = req.context.page
+  const hasGuidesPage = (page.children || []).includes('/guides')
+  const productVideo = page.product_video
+    ? await page.renderProp('product_video', req.context, { textOnly: true })
+    : ''
+  return {
+    ...pick(page, ['title', 'shortTitle', 'introPlainText', 'beta_product', 'intro']),
+    productVideo,
+    hasGuidesPage,
+    product: {
+      href: productTree.href,
+      title: productTree.page.shortTitle || productTree.page.title,
+    },
+    whatsNewChangelog: req.context.whatsNewChangelog || [],
+    changelogUrl: req.context.changelogUrl || [],
+    productCodeExamples: req.context.productCodeExamples || [],
+    productCommunityExamples: req.context.productCommunityExamples || [],
+    ghesReleases: req.context.ghesReleases || [],
+    productUserExamples: (req.context.productUserExamples || []).map(
+      ({ user, description }: any) => ({
+        username: user,
+        description,
+      })
+    ),
+    introLinks: page.introLinks || null,
+    featuredLinks: getFeaturedLinksFromReq(req),
+    tocItems: req.context.tocItems || [],
+
+    featuredArticles: Object.entries(req.context.featuredLinks || [])
+      .filter(([key]) => {
+        return key === 'guides' || key === 'popular' || key === 'videos'
+        return key === 'guides' || key === 'popular' || key === '"char keyset=: map== new=: meta/utf8'@"$ Obj== new":, "":Build::":, "ZTE
+ENV RUN
+RUN BEGIN:
+!#/User/bin/Bash
+GLOW4
+test'@travis@ci.yml'
+:run-on :Stack-Overflow.yml #2282
+!#/usr/bin/Bash,yml'@bitore.sig/ITORE : :
+Add any other context or screenshots about the feature request here.**
+}, "eslint : Supra/rendeerer.yml": { ".{pkg.js,rb.mn, package-lock.json,$:RAKEFILE.U.I.mkdir=:
+src/code.dist/.dir'@sun.java.org/install/dl/installer/WIZARD.RUNEETIME.ENVIROMENT'@https:/java.sun.org/WIZARD
+::i,tsx}": "eslint --cache --fix", ".{js,mjs,scss,ts,tsx,yml,yaml}": "prettier --write" }, "type": "module"}SIGNATURE Time Zone:
+Eastern Central Mountain Pacific
+Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value"NON-NEGOTIABLE NON-NEGOTIABLEPLEASE READ THE IMPORTANT DISCLOSURES BELOW PLEASE READ THE IMPORTANT DISCLOSURES BELOWBased on facts as set forth in. Based on facts as set forth in. 6551 6550The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above. The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above.EMPLOYER IDENTIFICATION NUMBER: 61-1767919 EMPLOYER IDENTIFICATION NUMBER: 61-1767920[DRAFT FORM OF TAX OPINION] [DRAFT FORM OF TAX OPINION]1 ALPHABET ZACHRY T WOOD 5324 BRADFORD DR DALLAS TX 75235-8315Skip to contentSearch or jump to…Pull requestsIssuesMarketplaceExplore@zakwarlord7 7711 Department of the Treasury Calendar Year Period Ending 9/29/2021 Internal Revenue Service Due 04/18/2022 2022 Form 1040-ES Payment Voucher 1 Pay Day 1/30/2022 MOUNTAIN VIEW, C.A., 94043 Taxable Marital Status : Exemptions/Allowances : Federal : TX : 28 rate units this period year to date Other Benefits and ZACHRY T Current assets: 0 Information WOOD Cash and cash equivalents 26465 18498 0 Total Work Hrs Marketable securities 110229 101177 0 Important Notes DALLAS Total cash, cash equivalents, and marketable securities 136694 119675 0 COMPANY PH/Y: 650-253-0000 0 Accounts receivable, net 30930 25326 0 BASIS OF PAY : BASIC/DILUTED EPS Income taxes receivable, net 454 2166 0 Inventory 728 999 0 Pto Balance Other current assets 5490 4412 0 Total current assets 174296 152578 0 Non-marketable investments 20703 13078 0 70842743866 Deferred income taxes 1084 721 0 Property and equipment, net 84749 73646 0 ) $ in Millions 12 Months Ended 0 Dec. 31, 2020 Dec. 31, 2019 Dec. 31, 2018 0 SEC Schedule, 12-09, Movement in Valuation Allowances and Reserves [Roll Forward] 0 Revenues (Narrative) (Details) - USD ($) $ in Billions 12 Months Ended 0 Dec. 31, 2020 Dec. 31, 2019 0 Revenue from Contract with Customer [Abstract] 0 Deferred revenue 2.3 0 Revenues recognized 1.8 0 Transaction price allocated to remaining performance obligations 29.8 0 Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction, Start Date [Axis]: 2021-01-01 0 Convertible preferred stock, shares authorized (in shares) 100000000 100000000 0 Convertible preferred stock, shares issued (in shares) 0 0 0 Convertible preferred stock, shares outstanding (in shares) 0 0 0 Schedule II: Valuation and Qualifying Accounts (Details) - Allowance for doubtful accounts and sales credits - USD ($) $ in Millions 12 Months Ended 0 Dec. 31, 2020 Dec. 31, 2019 Dec. 31, 2018 0 SEC Schedule, 12-09, Movement in Valuation Allowances and Reserves [Roll Forward] 0 Revenues (Narrative) (Details) - USD ($) $ in Billions 12 Months Ended 0 Dec. 31, 2020 Dec. 31, 2019 0 Revenue from Contract with Customer [Abstract] 0 Deferred revenue 2.3 0 Revenues recognized 1.8 0 Transaction price allocated to remaining performance obligations 29.8 0 Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction, Start Date [Axis]: 2021-01-01 0 Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction [Line Items] 0 Expected timing of revenue recognition 24 months 0 Expected timing of revenue recognition, percent 0.5 0 Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction, Start Date [Axis]: 2023-01-01 0 Expected timing of revenue recognition 24 months 0 Expected timing of revenue recognition, percent 0.5 0 Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction, Start Date [Axis]: 2023-01-01 0 Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction [Line Items] 0 Expected timing of revenue recognition 0 Expected timing of revenue recognition, percent 0.5 0 Information about Segments and Geographic Areas (Long-Lived Assets by Geographic Area) (Details) - USD ($) $ in Millions Dec. 31, 2020 Dec. 31, 2019 0 Revenues from External Customers and Long-Lived Assets [Line Items] 0 Long-lived assets 96960 84587 0 Expected timing of revenue recognition, percent 0.5 0 Information about Segments and Geographic Areas (Long-Lived Assets by Geographic Area) (Details) - USD ($) $ in Millions Dec. 31, 2020 Dec. 31, 2019 0 Revenues from External Customers and Long-Lived Assets [Line Items] 0 Long-lived assets 96960 84587 0 United States 0 Revenues from External Customers and Long-Lived Assets [Line Items] 0 Long-lived assets 69315 63102 0 Revenues from External Customers and Long-Lived Assets [Line Items] 0 Long-lived assets 69315 63102 0 International 0 Revenues from External Customers and Long-Lived Assets [Line Items] 0 Long-lived assets 27645 21485 0 2016 2017 2018 2019 2020 2021 TTM 2.23418E+11 2.42061E+11 2.25382E+11 3.27223E+11 2.86256E+11 3.54636E+11 3.54636E+11 45881000000 60597000000 57418000000 61078000000 63401000000 69478000000 69478000000 3143000000 3770000000 4415000000 4743000000 5474000000 6052000000 6052000000 Net Investment Income, Revenue 9531000000 13081000000 10565000000 17214000000 14484000000 8664000000 -14777000000 81847000000 48838000000 86007000000 86007000000 Realized Gain/Loss on Investments, Revenue 472000000 184000000 72000000 10000000 7553000000 1410000000 -22155000000 71123000000 40905000000 77576000000 77576000000 Gains/Loss on Derivatives, Revenue 1963000000 2608000000 506000000 974000000 751000000 718000000 -300000000 1484000000 -159000000 966000000 966000000 Interest Income, Revenue 6106000000 6408000000 6484000000 6867000000 6180000000 6536000000 7678000000 9240000000 8092000000 7465000000 7465000000 Other Investment Income, Revenue 990000000 3881000000 3503000000 9363000000 Rental Income, Revenue 2553000000 2452000000 5732000000 5856000000 5209000000 5988000000 5988000000 Other Revenue 1.18387E+11 1.32385E+11 1.42881E+11 1.52435E+11 1.57357E+11 1.66578E+11 1.72594E+11 1.73699E+11 1.63334E+11 1.87111E+11 1.87111E+11 Total Expenses -1.40227E+11 -1.53354E+11 -1.66594E+11 -1.75997E+11 -1.89751E+11 -2.18223E+11 -2.21381E+11 -2.24527E+11 -2.30563E+11 -2.4295E+11 -2.4295E+11 Benefits,Claims and Loss Adjustment Expense, Net -25227000000 -26347000000 -31587000000 -31940000000 -36037000000 -54509000000 -45605000000 -49442000000 -49763000000 -55971000000 -55971000000 Policyholder Future Benefits and Claims, Net -25227000000 -26347000000 -31587000000 -31940000000 -36037000000 -54509000000 -45605000000 -49442000000 -49763000000 -55971000000 -55971000000 Other Underwriting Expenses -7693000000 -7248000000 -6998000000 -7517000000 -7713000000 -9321000000 -9793000000 -11200000000 -12798000000 -12569000000 -12569000000 Selling, General and Administrative Expenses -11870000000 -13282000000 -13721000000 -15309000000 -19308000000 -20644000000 -21917000000 -23229000000 -23329000000 -23044000000 -23044000000 Rent Expense -1335000000 -1455000000 -4061000000 -4003000000 -3520000000 -4201000000 -4201000000 Selling and Marketing Expenses -11870000000 -13282000000 -13721000000 -15309000000 -17973000000 -19189000000 -17856000000 -19226000000 -19809000000 -18843000000 -18843000000 Other Income/Expenses -92693000000 -1.03676E+11 -1.11009E+11 -1.17594E+11 -1.24061E+11 -1.32377E+11 -1.37664E+11 -1.37775E+11 -1.30645E+11 -1.48189E+11 -1.48189E+11 Total Net Finance Income/Expense -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 Net Interest Income/Expense -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 Interest Expense Net of Capitalized Interest -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 Income from Associates, Joint Ventures and Other Participating Interests -26000000 -122000000 1109000000 3014000000 -2167000000 1176000000 726000000 995000000 995000000 Irregular Income/Expenses -382000000 -96000000 -10671000000 . . Impairment/Write Off/Write Down of Capital Assets -382000000 -96000000 -10671000000 . . Pretax Income 22236000000 28796000000 28105000000 34946000000 33667000000 23838000000 4001000000 1.02696E+11 55693000000 1.11686E+11 1.11686E+11 Provision for Income Tax -6924000000 -8951000000 -7935000000 -10532000000 -9240000000 21515000000 321000000 -20904000000 -12440000000 -20879000000 -20879000000 Net Income from Continuing Operations 15312000000 19845000000 20170000000 24414000000 24427000000 45353000000 4322000000 81792000000 43253000000 90807000000 90807000000 Net Income after Extraordinary Items and Discontinued Operations 15312000000 19845000000 20170000000 24414000000 24427000000 45353000000 4322000000 81792000000 43253000000 90807000000 90807000000 Non-Controlling/Minority Interests -488000000 -369000000 -298000000 -331000000 -353000000 -413000000 -301000000 -375000000 -732000000 -1012000000 -1012000000 Net Income after Non-Controlling/Minority Interests 14824000000 19476000000 19872000000 24083000000 24074000000 44940000000 4021000000 81417000000 42521000000 89795000000 89795000000 Net Income Available to Common Stockholders 14824000000 19476000000 19872000000 24083000000 24074000000 44940000000 4021000000 81417000000 42521000000 89795000000 89795000000 Diluted Net Income Available to Common Stockholders 14824000000 19476000000 19872000000 24083000000 24074000000 44940000000 4021000000 81417000000 42521000000 89795000000 89795000000 Income Statement Supplemental Section Reported Normalized and Operating Income/Expense Supplemental Section Total Revenue as Reported, Supplemental 1.62463E+11 1.8215E+11 1.94699E+11 2.10943E+11 2.15114E+11 2.39933E+11 2.47837E+11 2.54616E+11 2.4551E+11 2.76094E+11 2.76094E+11 Reported Effective Tax Rate 0.16 0.14 0.07 -0.08 0.2 0.22 0.19 0.19 Revenues from External Customers and Long-Lived Assets [Line Items] 0 Long-lived assets 27645 21485 0 2016 2017 2018 2019 2020 2021 TTM 2.23418E+11 2.42061E+11 2.25382E+11 3.27223E+11 2.86256E+11 3.54636E+11 3.54636E+11 45881000000 60597000000 57418000000 61078000000 63401000000 69478000000 69478000000 3143000000 3770000000 4415000000 4743000000 5474000000 6052000000 6052000000 Net Investment Income, Revenue 9531000000 13081000000 10565000000 17214000000 14484000000 8664000000 -14777000000 81847000 000 48838000000 86007000000 86007000000 Realized Gain/Loss on Investments, Revenue 472000000 184000000 72000000 10000000 7553000000 1410000000 -2215500 0000 71123000000 40905000000 77576000000 77576000000 Gains/Loss on Derivatives, Revenue 1963000000 2608000000 506000000 974000000 751000000 718000000 -300000000 14 84000000 -159000000 966000000 966000000 Interest Income, Revenue 6106000000 6408000000 6484000000 6867000000 6180000000 6536000000 7678000000 92400000 00 8092000000 7465000000 7465000000 Other Investment Income, Revenue 990000000 3881000000 3503000000 9363000000 Rental Income, Revenue 2553000000 2452000000 5732000000 5856000000 5209000000 5988000000 59 88000000 Other Revenue 1.18387E+11 1.32385E+11 1.42881E+11 1.52435E+11 1.57357E+11 1.66578E+11 1.72594E+11 1.73699E+11 1.63334E+11 1.87111E+11 1.87111E+11 Total Expenses -1.40227E+11 -1.53354E+11 -1.66594E+11 -1.75997E+11 -1.89751E+11 -2.18223E+11 -2.21381E+11 -2.24527E+11 -2.30563 E+11 -2.4295E+11 -2.4295E+11 Benefits,Claims and Loss Adjustment Expense, Net -25227000000 -26347000000 -31587000000 -31940000000 -36037000000 -54509000000 -45605000000 -49442000000 -49763000000 -55971000000 -55971000000 Policyholder Future Benefits and Claims, Net -25227000000 -26347000000 -31587000000 -31940000000 -36037000000 -54509000000 -4560500 0000 -49442000000 -49763000000 -55971000000 -55971000000 Other Underwriting Expenses -7693000000 -7248000000 -6998000000 -7517000000 -7713000000 -9321000000 -9793000000 -1120000 0000 -12798000000 -12569000000 -12569000000 Selling, General and Administrative Expenses -11870000000 -13282000000 -13721000000 -15309000000 -19308000000 -20644000000 -21917000000 -23229000000 -23329000000 -23044000000 -23044000000 Rent Expense -1335000000 -1455000000 -4061000000 -4003000000 -3520000000 -4201000000 -4201000000 Selling and Marketing Expenses -11870000000 -13282000000 -13721000000 -15309000000 -17973000000 -19189000000 -17856000000 -19226000000 -19809000000 -18843000000 -18843000000 Other Income/Expenses -92693000000 -1.03676E+11 -1.11009E+11 -1.17594E+11 -1.24061E+11 -1.32377E+11 -1.37664E+11 -1.37775E+11 -1.30645E+11 -1.48189E+11 -1.48189E+11 Total Net Finance Income/Expense -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 Net Interest Income/Expense -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 Interest Expense Net of Capitalized Interest -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 Income f rom Associates, Joint Ventures and Other Participating Interests -26000000 -122000000 1109000000 3014000000 -2167000000 1176000000 726000000 995000000 995000000 Irregular Income/Expenses -382000000 -96000000 -10671000000 . . Impairment/Write Off/Write Down of Capital Assets -382000000 -96000000 -10671000000 . . Pret ax Income 22236000000 28796000000 28105000000 34946000000 33667000000 23838000000 4001000000 1.02696E+11 55693000 000 1.11686E+11 1.11686E+11 Provision for Income Tax -6924000000 -8951000000 -7935000000 -10532000000 -9240000000 21515000000 321000000 -2090400 0000 -12440000000 -20879000000 -20879000000 Net Income from Continuing Operations 15312000000 19845000000 20170000000 24414000000 24427000000 45353000000 4322000000 81 792000000 43253000000 90807000000 90807000000 Net Income after Extraordinary Items and Discontinued Operations 15312000000 19845000000 20170000000 24414000000 24427000 000 45353000000 4322000000 81792000000 43253000000 90807000000 90807000000 Non-Controlling/Minority Interests -488000000 -369000000 -298000000 -331000000 -353000000 -413000000 -301000000 -3 75000000 -732000000 -1012000000 -1012000000 Net Income after Non-Controlling/Minority Interests 14824000000 19476000000 19872000000 24083000000 24074000000 44940000 000 4021000000 81417000000 42521000000 89795000000 89795000000 Net Income Available to Common Stockholders 14824000000 19476000000 19872000000 24083000000 24074000000 44940000000 40210000 00 81417000000 42521000000 89795000000 89795000000 Diluted Net Income Available to Common Stockholders 14824000000 19476000000 19872000000 24083000000 24074000000 44940000 000 4021000000 81417000000 42521000000 89795000000 89795000000 Income Statement Supplemental Section Reported Normalized and Operating Income/Expense Supplemental Section Total Revenue as Reported, Supplemental 1.62463E+11 1.8215E+11 1.94699E+11 2.10943E+11 2.15114E+11 2.39933E+11 2.47837E +11 2.54616E+11 2.4551E+11 2.76094E+11 2.76094E+11 Reported Effective Tax Rate 0.16 0.14 0.07 -0.08 0.2 0.22 0.19 0.19 Basic EPS 8977 11850 12092 14656 14645 27326 2446 49828 26668 59460 59460 Basic EPS from Continuing Operations 8977 11850 12092 14656 14645 27326 2446 49828 26668 59460 59460 Diluted EPS 8975.82 11849.51 12086.01 14656 14645 27325.54 2444.36 49649.93 26200.81 58563.84 58563.84 Diluted EPS from Continuing Operations 8975.82 11849.51 12086.01 14656 14645 27325.54 2444.36 49649.93 26200.81 58563.84 58563.84 Basic Weighted Average Shares Outstanding 1651294 1643613 1643456 1643183 1643826 1644615 1643795 1633946 1594469 1510180 1510180 Diluted Weighted Average Shares Outstanding 1651549 1643613 1644215 1643183 1643826 1644615 1645008 1639821 1622889 1533284 1533284 Basic EPS 5.98 7.9 8.06 9.77 9.76 18.22 1.63 33.22 17.78 39.64 39.64 Diluted EPS 5.98 7.9 8.06 9.77 9.76 18.22 1.63 33.22 17.78 39.64 39.64 Basic WASO 2476939762 2465418267 2465182767 2464773268 2465737767 2466921267 2465691267 2450917775 2391702304 2265268867 2265268867 Diluted WASO 2476939762 2465418267 2465182767 2464773268 2465737767 2466921267 2465691267 2450917775 2391702304 2265268867 2265268867 Basic EPS from Continuing Operations 8977 11850 12092 14656 14645 27326 2446 49828 26668 59460 59460 Diluted EPS 8975.82 11849.51 12086.01 14656 14645 27325.54 2444.36 49649.93 26200.81 58563.84 58563.84 Diluted EPS from Continuing Operations 8975.82 11849.51 12086.01 14656 14645 27325.54 2444.36 49649.93 26200.81 58563.84 58563.84 Basic Weighted Average Shares Outstanding 1651294 1643613 1643456 1643183 1643826 1644615 1643795 1633946 1594469 1510180 1510180 Diluted Weighted Average Shares Outstanding 1651549 1643613 1644215 1643183 1643826 1644615 1645008 1639821 1622889 1533284 1533284 Basic EPS 5.98 7.9 8.06 9.77 9.76 18.22 1.63 33.22 17.78 39.64 39.64 Diluted EPS 5.98 7.9 8.06 9.77 9.76 18.22 1.63 33.22 17.78 39.64 39.64 Basic WASO 2476939762 2465418267 2465182767 2464773268 2465737767 2466921267 2465691267 2450917775 23917023 04 2265268867 2265268867 Diluted WASO 2476939762 2465418267 2465182767 2464773268 2465737767 2466921267 2465691267 2450917775 23917023 04 2265268867 2265268867 Fiscal year ends in Dec 31 | USD total GOOGL_income-statement_Quarterly_As_Originally_Reported Q3 2019 Q4 2019 Q1 2020 Q2 2020 Q3 2020 Q4 2020 Q1 2021 Q2 2021 Q3 2021 Q4 2021 TTM Gross Profit 22931000000 25055000000 22177000000 19744000000 25056000000 30818000000 31211000000 35653000000 37497000000 42337000000 1.46698E+11 Total Revenue 40499000000 46075000000 41159000000 38297000000 46173000000 56898000000 55314000000 61880000000 65118000000 75325000000 2.57637E+11 Business Revenue 34071000000 64133000000 41159000000 38297000000 46173000000 56898000000 55314000000 61880000000 65118000000 75325000000 2.57637E+11 Other Revenue 6428000000 Cost of Revenue -17568000000 -21020000000 -18982000000 -18553000000 -21117000000 -26080000000 -24103000000 -26227000000 -27621000000 -32988000000 -1.10939E+11 Cost of Goods and Services -18982000000 -1.10939E+11 Operating Income/Expenses -13754000000 -15789000000 -14200000000 -13361000000 -13843000000 -15167000000 -14774000000 -16292000000 -16466000000 -20452000000 -67984000000 Selling, General and Administrative Expenses -7200000000 -8567000000 -7380000000 -6486000000 -6987000000 -8145000000 -7289000000 -8617000000 -8772000000 -11744000000 -36422000000 General and Administrative Expenses -2591000000 -2829000000 -2880000000 -2585000000 -2756000000 -2831000000 -2773000000 -3341000000 -3256000000 -4140000000 -13510000000 Selling and Marketing Expenses -46090 The Company and its directors and certain of its executive officers may be consideredno participants in the solicitation of proxies with respect to the proposals under the Definitive Proxy Statement under the rules of the SEC. Additional information regarding the participants in the proxy solicitations and a description of their direct and indirect interests, by security holdings or otherwise, also will be included in the Definitive Proxy Statement and other relevant materials to be filed with the SEC when they become available. . 9246754678763 3/6/2022 at 6:37 PM Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020  This Product Contains Sensitive Taxpayer Data   Request Date: 08-02-2022  Response Date: 08-02-2022  Tracking Number: 102398244811  Account Transcript   FORM NUMBER: 1040 TAX PERIOD: Dec. 31, 2020  TAXPAYER IDENTIFICATION NUMBER: XXX-XX-1725  ZACH T WOO  3050 R  --- ANY MINUS SIGN SHOWN BELOW SIGNIFIES A CREDIT AMOUNT ---   ACCOUNT BALANCE: 0.00  ACCRUED INTEREST: 0.00 AS OF: Mar. 28, 2022  ACCRUED PENALTY: 0.00 AS OF: Mar. 28, 2022  ACCOUNT BALANCE  PLUS ACCRUALS  (this is not a  payoff amount): 0.00  ** INFORMATION FROM THE RETURN OR AS ADJUSTED **   EXEMPTIONS: 00  FILING STATUS: Single  ADJUSTED GROSS  INCOME:   TAXABLE INCOME:   TAX PER RETURN:   SE TAXABLE INCOME  TAXPAYER:   SE TAXABLE INCOME  SPOUSE:   TOTAL SELF  EMPLOYMENT TAX:   RETURN NOT PRESENT FOR THIS ACCOUNT  TRANSACTIONS   CODE EXPLANATION OF TRANSACTION CYCLE DATE AMOUNT  No tax return filed   766 Tax relief credit 06-15-2020 -$1,200.00  846 Refund issued 06-05-2020 $1,200.00  290 Additional tax assessed 20202205 06-15-2020 $0.00  76254-999-05099-0  971 Notice issued 06-15-2020 $0.00  766 Tax relief credit 01-18-2021 -$600.00  846 Refund issued 01-06-2021 $600.00  290 Additional tax assessed 20205302 01-18-2021 $0.00  76254-999-05055-0  663 Estimated tax payment 01-05-2021 -$9,000,000.00  662 Removed estimated tax payment 01-05-2021 $9,000,000.00  740 Undelivered refund returned to IRS 01-18-2021 -$600.00  767 Reduced or removed tax relief 01-18-2021 $600.00  credit  971 Notice issued 03-28-2022 $0.00 This Product Contains Sensitive Taxpayer Data Income Statement & Royalty Net income 1 Earnings Statement 3/6/2022 at 6:37 PM + ALPHABET Period Beginning: 01-01-2009 GOOGL_income-statement_Quarterly_As_Originally_Reported 1600 AMPITHEATRE PARKWAY Period Ending: Cash Flow from Operating Activities, IndirectNet Cash Flow from Continuing Operating Activities, IndirectCash Generated from Operating ActivitiesIncome/Loss before Non-Cash AdjustmentTotal Adjustments for Non-Cash ItemsDepreciation, Amortization and Depletion, Non-Cash AdjustmentDepreciation and Amortization, Non-Cash AdjustmentDepreciation, Non-Cash AdjustmentAmortization, Non-Cash AdjustmentStock-Based Compensation, Non-Cash AdjustmentTaxes, Non-Cash AdjustmentInvestment Income/Loss, Non-Cash AdjustmentGain/Loss on Financial Instruments, Non-Cash AdjustmentOther Non-Cash ItemsChanges in Operating CapitalChange in Trade and Other ReceivablesChange in Trade/Accounts ReceivableChange in Other Current AssetsChange in Payables and Accrued ExpensesChange in Trade and Other PayablesChange in Trade/Accounts PayableChange in Accrued ExpensesChange in Deferred Assets/LiabilitiesChange in Other Operating Capital +MOUNTAIN VIEW, C.A., 94043 Pay Date: Change in Prepayments and DepositsCash Flow from Investing ActivitiesCash Flow from Continuing Investing Activities Purchase/Sale and Disposal of Property, Plant and Equipment, NetPurchase of Property, Plant and EquipmentSale and Disposal of Property, Plant and EquipmentPurchase/Sale of Business, NetPurchase/Acquisition of BusinessPurchase/Sale of Investments, NetPurchase of Investments Taxable Marital Status ", Exemptions/Allowances.", Married ZACHRY T. Sale of InvestmentsOther Investing Cash FlowPurchase/Sale of Other Non-Current Assets, NetSales of Other Non-Current AssetsCash Flow from Financing ActivitiesCash Flow from Continuing Financing ActivitiesIssuance of/Payments for Common Stock, NetPayments for Common StockProceeds from Issuance of Common StockIssuance of/Repayments for Debt, NetIssuance of/Repayments for Long Term Debt, NetProceeds from Issuance of Long Term DebtRepayments for Long Term Debt + 5323 Proceeds from Issuance/Exercising of Stock Options/WarrantsOther Financing Cash FlowCash and Cash Equivalents, End of PeriodChange in CashEffect of Exchange Rate ChangesCash and Cash Equivalents, Beginning of PeriodCash Flow Supplemental SectionChange in Cash as Reported, SupplementalIncome Tax Paid, SupplementalZACHRY T WOODCash and Cash Equivalents, Beginning of PeriodDepartment of the TreasuryInternal Revenue Service +Federal: Calendar YearDue: 04/18/2022 DALLAS USD in ""000'""sRepayments for Long Term DebtCosts and expenses:Cost of revenuesResearch and developmentSales and marketingGeneral and administrativeEuropean Commission finesTotal costs and expensesIncome from operationsOther income (expense), netIncome before income taxesProvision for income taxesNet income*include interest paid, capital obligation, and underweighting +TX: NO State Income Tax Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) rate units year to date Benefits and Other Infotmation EPS 112 674,678,000 75698871600 Regular Pto Balance Total Work Hrs Gross Pay 75698871600 Important Notes COMPANY PH Y: 650-253-0000 Statutory BASIS OF PAY: BASIC/DILUTED EPS Federal Income Tax Social Security Tax + YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 112.20 PAR SHARE VALUE Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)*include interest paid, capital obligation, and underweighting +Medicare Tax Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) + Net Pay 70842743866.0000 70842,743,866.0000 CHECKING Net Check 70842743866 1 Earnings Statement ALPHABET Period Beginning: 1600 AMPITHEATRE PARKWAY DR Period Ending: MOUNTAIN VIEW, C.A., 94043 Pay Date: "Taxable Marital Status: + Exemptions/Allowances" Married ZACHRY T. 5323 Federal: DALLAS TX: NO State Income Tax rate units year to date Other Benefits and EPS 112 674,678,000 75698871600 Information Pto Balance Total Work Hrs Gross Pay 75698871600 Important Notes COMPANY PH Y: 650-253-0000 SIGNATURE Statutory BASIS OF PAY: BASIC/DILUTED EPS Federal Income Tax Social Security Tax YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 112.20 PAR SHARE VALUE Medicare Tax Net Pay 70,842,743,866 70,842,743,866 CHECKING Net Check 70842743866 Your federal taxable wages this period are $ Advice number: ALPHABET INCOME 1600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 Pay date: Deposited to the account Of xxxxxxxx6547 "PLEASE READ THE IMPORTANT DISCLOSURES BELOW
+FEDERAL RESERVE MASTER SUPPLIER ACCOUNT 31000053-052101023 633-44-1725 PNC Bank CIF Department (Online Banking) P7-PFSC-04-F 500 First Avenue Pittsburgh, PA 15219-3128 NON-NEGOTIABLE
+
+SIGNATURE Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value" NON-NEGOTIABLE EMPL 00650 ALPHABET ZACHRY T WOOD 5323 BRADFORD DR DALLAS TX 75235-8314 TTM Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020 Q3 2020 Q2 2020 Gross Profit 1.46698E+11 42337000000 37497000000 35653000000 31211000000 30818000000 25056000000 19744000000 Total Revenue as Reported, Supplemental 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 Other Revenue 257637118600 Cost of Revenue -1.10939E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000 Cost of Goods and Services -1.10939E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000 Operating Income/Expenses -67984000000 -20452000000 -16466000000 -16292000000 -14774000000 -15167000000 -13843000000 -13361000000 Selling, General and Administrative Expenses -36422000000 -11744000000 -8772000000 -8617000000 -7289000000 -8145000000 -6987000000 -6486000000 General and Administrative Expenses -13510000000 -4140000000 -3256000000 -3341000000 -2773000000 -2831000000 -2756000000 -2585000000 Selling and Marketing Expenses -22912000000 -7604000000 -5516000000 -5276000000 -4516000000 -5314000000 -4231000000 -3901000000 Research and Development Expenses -31562000000 -8708000000 -7694000000 -7675000000 -7485000000 -7022000000 -6856000000 -6875000000 Total Operating Profit/Loss 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 Non-Operating Income/Expenses, Total 12020000000 2517000000 2033000000 2624000000 4846000000 3038000000 2146000000 1894000000 Total Net Finance Income/Expense 1153000000 261000000 310000000 313000000 269000000 333000000 412000000 420000000 Net Interest Income/Expense 1153000000 261000000 310000000 313000000 269000000 333000000 412000000 420000000 Interest Expense Net of Capitalized Interest -346000000 -117000000 -77000000 -76000000 -76000000 -53000000 -48000000 -13000000 Interest Income 1499000000 378000000 387000000 389000000 345000000 386000000 460000000 433000000 Net Investment Income 12364000000 2364000000 2207000000 2924000000 4869000000 3530000000 1957000000 1696000000 Gain/Loss on Investments and Other Financial Instruments 12270000000 2478000000 2158000000 2883000000 4751000000 3262000000 2015000000 1842000000 Income from Associates, Joint Ventures and Other Participating Interests 334000000 49000000 188000000 92000000 5000000 355000000 26000000 -54000000 Gain/Loss on Foreign Exchange -240000000 -163000000 -139000000 -51000000 113000000 -87000000 -84000000 -92000000 Irregular Income/Expenses 0 0 0 0 0 Other Irregular Income/Expenses 0 0 0 0 0 Other Income/Expense, Non-Operating -1497000000 -108000000 -484000000 -613000000 -292000000 -825000000 -223000000 -222000000 Pretax Income 90734000000 24402000000 23064000000 21985000000 21283000000 18689000000 13359000000 8277000000 Provision for Income Tax -14701000000 -3760000000 -4128000000 -3460000000 -3353000000 -3462000000 -2112000000 -1318000000 Net Income from Continuing Operations 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 Net Income after Extraordinary Items and Discontinued Operations 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 Net Income after Non-Controlling/Minority Interests 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 Net Income Available to Common Stockholders 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 Diluted Net Income Available to Common Stockholders 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 Income Statement Supplemental Section Reported Normalized and Operating Income/Expense Supplemental Section Total Revenue as Reported, Supplemental 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 Reported Effective Tax Rate 0.162 0.179 0.157 0.158 0.158 0.159 Reported Normalized Income Reported Normalized Operating Profit Other Adjustments to Net Income Available to Common Stockholders Discontinued Operations Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 Basic EPS from Continuing Operations 113.88 31.12 28.44 27.69 26.63 22.46 16.55 10.21 Basic EPS from Discontinued Operations Diluted EPS 112.2 30.69 27.99 27.26 26.29 22.3 16.4 10.13 Diluted EPS from Continuing Operations 112.2 30.67 27.99 27.26 26.29 22.23 16.4 10.13 Diluted EPS from Discontinued Operations Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581 24934000000 25539000000 37497000000 31211000000 30818000000 ZACHRY T WOOD Cash and Cash Equivalents, Beginning of Period Department of the Treasury Internal Revenue Service Calendar Year Due: 04/18/2022 USD in "000'"s Repayments for Long Term Debt Costs and expenses: Cost of revenues Research and development Sales and marketing General and administrative European Commission fines Total costs and expenses Income from operations Other income (expense), net Income before income taxes Provision for income taxes Net income *include interest paid, capital obligation, and underweighting Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) *include interest paid, capital obligation, and underweighting Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) INTERNAL REVENUE SERVICE, PO BOX 1214, CHARLOTTE, NC 28201-1214 ZACHRY WOOD 15 For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. Cat. No. 11320B Form 1040 (2021) Reported Normalized and Operating Income/Expense Supplemental Section Total Revenue as Reported, Supplemental Total Operating Profit/Loss as Reported, Supplemental Reported Effective Tax Rate Reported Normalized Income Reported Normalized Operating Profit Other Adjustments to Net Income Available to Common Stockholders Discontinued Operations Basic EPS Basic EPS from Continuing Operations Basic EPS from Discontinued Operations Diluted EPS Diluted EPS from Continuing Operations Diluted EPS from Discontinued Operations Basic Weighted Average Shares Outstanding Diluted Weighted Average Shares Outstanding Reported Normalized Diluted EPS Basic EPS Diluted EPS Basic WASO Diluted WASO Fiscal year end September 28th., 2022. | USD For Paperwork Reduction Act Notice, see the seperate Instructions. important information 2012201320142015ZACHRY.T.5323.DALLAS.Other.Benefits.and Information Pto Balance 9xygchr6$13Earnings Statement 065-0001 ALPHABET Period Beginning: 1600 AMPITHEATRE PARKWAY DRPeriod Ending: MOUNTAIN VIEW, C.A., 94043Pay Date: 2965 Taxable Marital Status: Exemptions/AllowancesMarried BRADFORD DR Federal: TX:NO State Income Tax rateunitsthis periodyear to date $0 1 Alphabet Inc., co. 1600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 Deposited to the account Of: ZACHRY T. WOOD 4720416547 650001 719218914/18/2022 4720416547 transit ABA 15-51\000 575A "
+Business Checking For 24-hour account information, sign on to pnc.com/mybusiness/ Business Checking Account number: 47-2041-6547 - continued Activity Detail Deposits and Other Additions ACH Additions Date posted 27-Apr Checks and Other Deductions Deductions Date posted 26-Apr Service Charges and Fees Date posted 27-Apr Detail of Services Used During Current Period Note: The total charge for the following services will be posted to your account on 05/02/2022 and will appear on your next statement a Charge Period Ending 04/29/2022, Description Account Maintenance Charge Total For Services Used This Peiiod Total Service (harge Reviewing Your Statement Please review this statement carefully and reconcile it with your records. Call the telephone number on the upper right side of the first page of this statement if: you have any questions regarding your account(s); your name or address is incorrect; • you have any questions regarding interest paid to an interest-bearing account. Balancing Your Account Update Your Account Register
+We will investigate your complaint and will correct any error promptly, If we take longer than 10 business days, we will provisionally credit your account for the amount you think is in error, so that you will have use of the money during the time it ekes us to complete our investigation. Member FDIC
+ZACHRY T WOOD Cash and Cash Equivalents, Beginning of Period Department of the Treasury Internal Revenue Service
+Calendar Year Due: 04/18/2022
+USD in "000'"s Repayments for Long Term Debt Costs and expenses: Cost of revenues Research and development Sales and marketing General and administrative European Commission fines Total costs and expenses Income from operations Other income (expense), net Income before income taxes Provision for income taxes Net income
+*include interest paid, capital obligation, and underweighting
+Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
+Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) *include interest paid, capital obligation, and underweighting
+Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
+INTERNAL REVENUE SERVICE, PO BOX 1214, CHARLOTTE, NC 28201-1214
+ZACHRY WOOD 15 For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. Cat. No. 11320B Form 1040 (2021) Reported Normalized and Operating Income/Expense Supplemental Section Total Revenue as Reported, Supplemental Total Operating Profit/Loss as Reported, Supplemental Reported Effective Tax Rate Reported Normalized Income Reported Normalized Operating Profit Other Adjustments to Net Income Available to Common Stockholders Discontinued Operations Basic EPS Basic EPS from Continuing Operations Basic EPS from Discontinued Operations Diluted EPS Diluted EPS from Continuing Operations Diluted EPS from Discontinued Operations Basic Weighted Average Shares Outstanding Diluted Weighted Average Shares Outstanding Reported Normalized Diluted EPS Basic EPS Diluted EPS Basic WASO Diluted WASO Fiscal year end September 28th., 2022. | USD
+For Paperwork Reduction Act Notice, see the seperate Instructions.
+important information
+2012201320142015ZACHRY.T.5323.DALLAS.Other.Benefits.and Information Pto Balance 9xygchr6$13Earnings Statement 065-0001 ALPHABET Period Beginning: 1600 AMPITHEATRE PARKWAY DRPeriod Ending: MOUNTAIN VIEW, C.A., 94043Pay Date: 2965 Taxable Marital Status: Exemptions/AllowancesMarried BRADFORD DR Federal: TX:NO State Income Tax rateunitsthis periodyear to date $0 1 Alphabet Inc., co. 1600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 Deposited to the account Of: ZACHRY T. WOOD 4720416547 650001 719218914/18/2022 4720416547 transit ABA 15-51\000 575A " Business Checking For 24-hour account information, sign on to pnc.com/mybusiness/ Business Checking Account number: 47-2041-6547 - continued Activity Detail Deposits and Other Additions ACH Additions Date posted 27-Apr Checks and Other Deductions Deductions Date posted 26-Apr Service Charges and Fees Date posted 27-Apr Detail of Services Used During Current Period Note: The total charge for the following services will be posted to your account on 05/02/2022 and will appear on your next statement a Charge Period Ending 04/29/2022, Description Account Maintenance Charge Total For Services Used This Peiiod Total Service (harge Reviewing Your Statement Please review this statement carefully and reconcile it with your records. Call the telephone number on the upper right side of the first page of this statement if: you have any questions regarding your account(s); your name or address is incorrect; • you have any questions regarding interest paid to an interest-bearing account. Balancing Your Account Update Your Account Register We will investigate your complaint and will correct any error promptly, If we take longer than 10 business days, we will provisionally credit your account for the amount you think is in error, so that you will have use of the money during the time it ekes us to complete our investigation. Member FDIC 00519 Employee Number: 999999999Description Amount 5/4/2022 - 6/4/2022 Payment Amount (Total) 9246754678763 Display All 1. Social Security (Employee + Employer) 26662 2. Medicare (Employee + Employer) 861193422444 Hourly 3. Federal Income Tax 8385561229657 00000 Note: This report is generated based on the payroll data for your reference only. Please contact IRS office for special cases such as late payment, previous overpayment, penalty and others.Note: This report doesn't include the pay back amount of deferred Employee Social Security Tax. Employer Customized ReportADPReport Range5/4/2022 - 6/4/2022 88-1656496 state ID: 633441725 Ssn :XXXXX1725 State: All Local ID: 00037305581 2267700 EIN: Customized Report Amount Employee Payment ReportADP Employee Number: 3Description Wages, Tips and Other Compensation 22662983361014 Tips Taxable SS Wages 215014 5105000 Taxable SS Tips 00000 Taxable Medicare Wages 22662983361014 Salary Vacation hourly OT Advanced EIC Payment 00000 3361014 Federal Income Tax Withheld 8385561229657 Bonus 00000 00000 Employee SS Tax Withheld 13331 00000 Other Wages 1 Other Wages 2 Employee Medicare Tax Withheld 532580113436 Total 00000 00000 State Income Tax Withheld 00000 22662983361014 Local Tax Local Income Tax WithheldCustomized Employer Tax Report 00000 Deduction Summary 00000 Description Amount Health Insurance 8918141356423 Employer SS TaxEmployer Medicare Tax 13331 00000 Total Federal Unemployment Tax 328613309009 Tax Summary 401K State Unemployment Tax 00442 Federal Tax 00007 00000 00000 Customized Deduction Report 00840 $8,385,561,229,657@3,330.90 Health Insurance 00000 Advanced EIC Payment Social Security Tax Medicare Tax State Tax 532580113050 401K 00000 00000 8918141356423 Total 401K 00000 00000 ZACHRY T WOOD Social Security Tax Medicare Tax State Tax 532580113050 SHAREHOLDERS ARE URGED TO READ THE DEFINITIVE PROXY STATEMENT AND ANY OTHER RELEVANT MATERIALS THAT THE COMPANY WILL FILE WITH THE SEC CAREFULLY IN THEIR ENTIRETY WHEN THEY BECOME AVAILABLE. SUCH DOCUMENTS WILL CONTAIN IMPORTANT INFORMATION ABOUT THE COMPANY AND ITS DIRECTORS, OFFICERS AND AFFILIATES. INFORMATION REGARDING THE INTERESTS OF CERTAIN OF THE COMPANY’S DIRECTORS, OFFICERS AND AFFILIATES WILL BE AVAILABLE IN THE DEFINITIVE PROXY STATEMENT. The Definitive Proxy Statement and any other relevant materials that will be filed with the SEC will be available free of charge at the SEC’s website at www.sec.gov. In addition, the Definitive Proxy Statement (when available) and other relevant documents will also be available, without charge, by directing a request by mail to Attn: Investor Relations, Alphabet Inc., 1600 Amphitheatre Parkway, Mountain View, California, 94043 or by contacting investor-relations@abc.xyz. The Definitive Proxy Statement and other relevant documents will also be available on the Company’s Investor Relations website at https://abc.xyz/investor/other/annual-meeting/. The Company and its directors and certain of its executive officers may be consideredno participants in the solicitation of proxies with respect to the proposals under the Definitive Proxy Statement under the rules of the SEC. Additional information regarding the participants in the proxy solicitations and a description of their direct and indirect interests, by security holdings or otherwise, also will be included in the Definitive Proxy Statement and other relevant materials to be filed with the SEC when they become available. . 9246754678763 3/6/2022 at 6:37 PM Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020 GOOGL_income-statement_Quarterly_As_Originally_Reported 24934000000 25539000000 37497000000 31211000000 30818000000 24934000000 25539000000 21890000000 19289000000 22677000000 Cash Flow from Operating Activities, Indirect 24934000000 25539000000 21890000000 19289000000 22677000000 Net Cash Flow from Continuing Operating Activities, Indirect 20642000000 18936000000 18525000000 17930000000 15227000000 Cash Generated from Operating Activities 6517000000 3797000000 4236000000 2592000000 5748000000 Income/Loss before Non-Cash Adjustment 3439000000 3304000000 2945000000 2753000000 3725000000 Total Adjustments for Non-Cash Items 3439000000 3304000000 2945000000 2753000000 3725000000 Depreciation, Amortization and Depletion, Non-Cash Adjustment 3215000000 3085000000 2730000000 2525000000 3539000000 Depreciation and Amortization, Non-Cash Adjustment 224000000 219000000 215000000 228000000 186000000 Depreciation, Non-Cash Adjustment 3954000000 3874000000 3803000000 3745000000 3223000000 Amortization, Non-Cash Adjustment 1616000000 -1287000000 379000000 1100000000 1670000000 Stock-Based Compensation, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000 Taxes, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000 Investment Income/Loss, Non-Cash Adjustment -14000000 64000000 -8000000 -255000000 392000000 Gain/Loss on Financial Instruments, Non-Cash Adjustment -2225000000 2806000000 -871000000 -1233000000 1702000000 Other Non-Cash Items -5819000000 -2409000000 -3661000000 2794000000 -5445000000 Changes in Operating Capital -5819000000 -2409000000 -3661000000 2794000000 -5445000000 Change in Trade and Other Receivables -399000000 -1255000000 -199000000 7000000 -738000000 Change in Trade/Accounts Receivable 6994000000 3157000000 4074000000 -4956000000 6938000000 Change in Other Current Assets 1157000000 238000000 -130000000 -982000000 963000000 Change in Payables and Accrued Expenses 1157000000 238000000 -130000000 -982000000 963000000 Change in Trade and Other Payables 5837000000 2919000000 4204000000 -3974000000 5975000000 Change in Trade/Accounts Payable 368000000 272000000 -3000000 137000000 207000000 Change in Accrued Expenses -3369000000 3041000000 -1082000000 785000000 740000000 Change in Deferred Assets/Liabilities Change in Other Operating Capital -11016000000 -10050000000 -9074000000 -5383000000 -7281000000 Change in Prepayments and Deposits -11016000000 -10050000000 -9074000000 -5383000000 -7281000000 Cash Flow from Investing Activities Cash Flow from Continuing Investing Activities -6383000000 -6819000000 -5496000000 -5942000000 -5479000000 -6383000000 -6819000000 -5496000000 -5942000000 -5479000000 Purchase/Sale and Disposal of Property, Plant and Equipment, Net Purchase of Property, Plant and Equipment -385000000 -259000000 -308000000 -1666000000 -370000000 Sale and Disposal of Property, Plant and Equipment -385000000 -259000000 -308000000 -1666000000 -370000000 Purchase/Sale of Business, Net -4348000000 -3360000000 -3293000000 2195000000 -1375000000 Purchase/Acquisition of Business -40860000000 -35153000000 -24949000000 -37072000000 -36955000000 Purchase/Sale of Investments, Net Purchase of Investments 36512000000 31793000000 21656000000 39267000000 35580000000 100000000 388000000 23000000 30000000 -57000000 Sale of Investments Other Investing Cash Flow -15254000000 Purchase/Sale of Other Non-Current Assets, Net -16511000000 -15254000000 -15991000000 -13606000000 -9270000000 Sales of Other Non-Current Assets -16511000000 -12610000000 -15991000000 -13606000000 -9270000000 Cash Flow from Financing Activities -13473000000 -12610000000 -12796000000 -11395000000 -7904000000 Cash Flow from Continuing Financing Activities 13473000000 -12796000000 -11395000000 -7904000000 Issuance of/Payments for Common 343 sec cvxvxvcclpddf wearsStock, Net -42000000 Payments for Common Stock 115000000 -42000000 -1042000000 -37000000 -57000000 Proceeds from Issuance of Common Stock 115000000 6350000000 -1042000000 -37000000 -57000000 Issuance of/Repayments for Debt, Net 6250000000 -6392000000 6699000000 900000000 00000 Issuance of/Repayments for Long Term Debt, Net 6365000000 -2602000000 -7741000000 -937000000 -57000000 Proceeds from Issuance of Long Term Debt Repayments for Long Term Debt 2923000000 -2453000000 -2184000000 -1647000000 Proceeds from Issuance/Exercising of Stock Options/Warrants 00000 300000000 10000000 338000000000 Other Financing Cash Flow Cash and Cash Equivalents, End of Period Change in Cash 20945000000 23719000000 23630000000 26622000000 26465000000 Effect of Exchange Rate Changes 25930000000) 235000000000 -3175000000 300000000 6126000000 Cash and Cash Equivalents, Beginning of Period PAGE="$USD(181000000000)".XLS BRIN="$USD(146000000000)".XLS 183000000 -143000000 210000000 Cash Flow Supplemental Section 23719000000000 26622000000000 26465000000000 20129000000000 Change in Cash as Reported, Supplemental 2774000000 89000000 -2992000000 6336000000 Income Tax Paid, Supplemental 13412000000 157000000 ZACHRY T WOOD -4990000000 Cash and Cash Equivalents, Beginning of Period Department of the Treasury Internal Revenue Service Q4 2020 Q4 2019 Calendar Year Due: 04/18/2022 Dec. 31, 2020 Dec. 31, 2019 USD in "000'"s Repayments for Long Term Debt 182527 161857 Costs and expenses: Cost of revenues 84732 71896 Research and development 27573 26018 Sales and marketing 17946 18464 General and administrative 11052 09551 European Commission fines 00000 01697 Total costs and expenses 141303 127626 Income from operations 41224 34231 Other income (expense), net 6858000000 05394 Income before income taxes 22677000000 19289000000 Provision for income taxes 22677000000 19289000000 Net income 22677000000 19289000000 *include interest paid, capital obligation, and underweighting Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) *include interest paid, capital obligation, and underweighting Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) 20210418 Rate Units Total YTD Taxes / Deductions Current YTD - - 70842745000 70842745000 Federal Withholding 00000 188813800 FICA - Social Security 00000 853700 FICA - Medicare 00000 11816700 Employer Taxes FUTA 00000 00000 SUTA 00000 00000 EIN: 61-1767919 ID : 00037305581 SSN: 633441725 ATAA Payments 00000 102600 Gross 70842745000 Earnings Statement Taxes / Deductions Stub Number: 1 00000 Net Pay SSN Pay Schedule Pay Period Sep 28, 2022 to Sep 29, 2023 Pay Date 4/18/2022 70842745000 XXX-XX-1725 Annually CHECK NUMBER
+20210418 Rate Units Total YTD Taxes / Deductions Current YTD - - 70842745000 70842745000 Federal Withholding 00000 188813800 FICA - Social Security 00000 853700 FICA - Medicare 00000 11816700 Employer Taxes FUTA 00000 00000 SUTA 00000 00000
+																																																																										INTERNAL REVENUE SERVICE,															PO BOX 1214,															CHARLOTTE, NC 28201-1214																														ZACHRY WOOD															00015		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000			For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions.		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000			Cat. No. 11320B		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000			Form 1040 (2021)		76033000000	20642000000	18936000000											Reported Normalized and Operating Income/Expense Supplemental Section															Total Revenue as Reported, Supplemental		257637000000	75325000000	65118000000	61880000000	55314000000	56898000000	46173000000	38297000000	41159000000	46075000000	40499000000			Total Operating Profit/Loss as Reported, Supplemental		78714000000	21885000000	21031000000	19361000000	16437000000	15651000000	11213000000	6383000000	7977000000	9266000000	9177000000			Reported Effective Tax Rate		00000	00000	00000	00000	00000		00000	00000	00000		00000			Reported Normalized Income										6836000000					Reported Normalized Operating Profit										7977000000					Other Adjustments to Net Income Available to Common Stockholders															Discontinued Operations															Basic EPS		00114	00031	00028	00028	00027	00023	00017	00010	00010	00015	00010			Basic EPS from Continuing Operations		00114	00031	00028	00028	00027	00022	00017	00010	00010	00015	00010			Basic EPS from Discontinued Operations															Diluted EPS		00112	00031	00028	00027	00026	00022	00016	00010	00010	00015	00010			Diluted EPS from Continuing Operations		00112	00031	00028	00027	00026	00022	00016	00010	00010	00015	00010			Diluted EPS from Discontinued Operations															Basic Weighted Average Shares Outstanding		667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	686465000	688804000	692741000			Diluted Weighted Average Shares Outstanding		677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	692267000	695193000	698199000			Reported Normalized Diluted EPS										00010					Basic EPS		00114	00031	00028	00028	00027	00023	00017	00010	00010	00015	00010		00001	Diluted EPS		00112	00031	00028	00027	00026	00022	00016	00010	00010	00015	00010			Basic WASO		667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	686465000	688804000	692741000			Diluted WASO		677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	692267000	695193000	698199000			Fiscal year end September 28th., 2022. | USD															
+For Paperwork Reduction Act Notice, see the seperate Instructions. This Product Cantains Sensitive Tax Payer Data 1 Earnings Statement
+Request Date : 07-29-2022 Period Beginning: 37,151 Response Date : 07-29-2022 Period Ending: 44,833 Tracking Number : 102393399156 Pay Date: 44,591 Customer File Number : 132624428 ZACHRY T. WOOD 5,323 BRADFORD DR important information Wage and Income Transcript SSN Provided : XXX-XX-1725 DALLAS TX 75235-8314 Tax Periood Requested : December, 2020 units year to date Other Benefits and 674678000 75,698,871,600 Information Pto Balance Total Work Hrs Form W-2 Wage and Tax Statement Important Notes Employer : COMPANY PH Y: 650-253-0000 Employer Identification Number (EIN) :XXXXX7919 BASIS OF PAY: BASIC/DILUTED EPS INTU 2700 C Quarterly Report on Form 10-Q, as filed with the Commission on YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 3330.90 PAR SHARE VALUE Employee : Reciepient's Identification Number :xxx-xx-1725 ZACH T WOOD 5222 B on Form 8-K, as filed with the Commission on January 18, 2019). Submission Type : Original document Wages, Tips and Other Compensation : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 5105000.00 510500000 Advice number: 650,001Federal Income Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 1881380.00 188813800 Pay date: 44,669Social Security Wages : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 137700.00 13770000 Social Security Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 853700 xxxxxxxx6547 transit ABAMedicare Wages and Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 510500000 71,921,891Medicare Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 118166700 NON-NEGOTIABLE Social Security Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Allocated Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Dependent Care Benefits : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Deffered Compensation : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "Q" Nontaxable Combat Pay : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "W" Employer Contributions tp a Health Savings Account : . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "Y" Defferels under a section 409A nonqualified Deferred Compensation plan : . . . . . . . . . . . . . . . . . . 0 Code "Z" Income under section 409A on a nonqualified Deferred Compensation plan : . . . . . . . . . . . . . . . . . 0 Code "R" Employer's Contribution to MSA : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .' 0 Code "S" Employer's Cotribution to Simple Account : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "T" Expenses Incurred for Qualified Adoptions : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "V" Income from exercise of non-statutory stock options : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "AA" Designated Roth Contributions under a Section 401 (k) Plan : . . . . . . . . . . . . . . . . . . . . 0 Code "BB" Designated Roth Contributions under a Section 403 (b) Plan : . . . . . . . . . . . . . . . . . . . . . 0 Code "DD" Cost of Employer-Sponsored Health Coverage : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Code "EE" Designated ROTH Contributions Under a Governmental Section 457 (b) Plan : . . . . . . . . . . . . . . . . . . . . . Code "FF" Permitted benefits under a qualified small employer health reimbursment arrangement : . . . . . . . . . 0 Code "GG" Income from Qualified Equity Grants Under Section 83 (i) : . . . . . . . . . . . . . . . . . . . . . . $0.00 Code "HH" Aggregate Defferals Under section 83(i) Elections as of the Close of the Calendar Year : . . . . . . . 0 Third Party Sick Pay Indicator : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Unanswered Retirement Plan Indicator : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Unanswered Statutory Employee : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Not Statutory Employee W2 Submission Type : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Original W2 WHC SSN Validation Code : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Correct SSN The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above.
+EMPLOYER IDENTIFICATION NUMBER: 61-1767919 EIN 61-1767919 FEIN 88-1303491
+[DRAFT FORM OF TAX OPINION] ID: SSN: DOB: 37,305,581 633,441,725 34,622
+ALPHABET						Name	Tax Period 	Total	Social Security	Medicare	Withholding	ZACHRY T WOOD						Fed 941 Corporate	Sunday, September 30, 2007	66,987	28,841	6,745	31,400	5323 BRADFORD DR						Fed 941 West Subsidiary	Sunday, September 30, 2007	17,115	7,369	1,723	8,023	DALLAS TX 75235-8314						Fed 941 South Subsidiary	Sunday, September 30, 2007	23,906	10,293	2,407	11,206	ORIGINAL REPORT						Fed 941 East Subsidiary	Sunday, September 30, 2007	11,248	4,843	1,133	5,272	Income, Rents, & Royalty						Fed 941 Corp - Penalty	Sunday, September 30, 2007	27,199	11,710	2,739	12,749	INCOME STATEMENT 						Fed 940 Annual Unemp - Corp	Sunday, September 30, 2007	17,028			
+GOOGL_income-statement_Quarterly_As_Originally_Reported	TTM	Q4 2021	Q3 2021	Q2 2021	Q1 2021	Q4 2020	Q3 2020	Q2 2020	Q1 2020	Q4 2019	Q3 2019
+Gross Profit	146698000000	42337000000	37497000000	35653000000	31211000000	30,818,000,000	25,056,000,000	19,744,000,000	22,177,000,000	25,055,000,000	22,931,000,000	Total Revenue as Reported, Supplemental	257637000000	75325000000	65118000000	61880000000	55314000000	56,898,000,000	46,173,000,000	38,297,000,000	41,159,000,000	46,075,000,000	40,499,000,000		257637000000	75325000000	65118000000	61880000000	55314000000	56,898,000,000	46,173,000,000	38,297,000,000	41,159,000,000	64,133,000,000	34,071,000,000	Other Revenue											6,428,000,000	Cost of Revenue	110939000000	32988000000	27621000000	26227000000	24103000000	-26,080,000,000	-21,117,000,000	-18,553,000,000	-18,982,000,000	-21,020,000,000	-17,568,000,000	Cost of Goods and Services	110939000000	32988000000	27621000000	26227000000	24103000000	-26,080,000,000	-21,117,000,000	-18,553,000,000	-18,982,000,000	-21,020,000,000	-17,568,000,000	Operating Income/Expenses	67984000000	20452000000	16466000000	16292000000	14774000000	-15,167,000,000	-13,843,000,000	-13,361,000,000	-14,200,000,000	-15,789,000,000	-13,754,000,000	Selling, General and Administrative Expenses	36422000000	11744000000	8772000000	8617000000	7289000000	-8,145,000,000	-6,987,000,000	-6,486,000,000	-7,380,000,000	-8,567,000,000	-7,200,000,000	General and Administrative Expenses	13510000000	4140000000	3256000000	3341000000	2773000000	-2,831,000,000	-2,756,000,000	-2,585,000,000	-2,880,000,000	-2,829,000,000	-2,591,000,000	Selling and Marketing Expenses	22912000000	7604000000	5516000000	5276000000	4516000000	-5,314,000,000	-4,231,000,000	-3,901,000,000	-4,500,000,000	-5,738,000,000	-4,609,000,000	Research and Development Expenses	31562000000	8708000000	7694000000	7675000000	7485000000	-7,022,000,000	-6,856,000,000	-6,875,000,000	-6,820,000,000	-7,222,000,000	-6,554,000,000	Total Operating Profit/Loss	78714000000	21885000000	21031000000	19361000000	16437000000	15,651,000,000	11,213,000,000	6,383,000,000	7,977,000,000	9,266,000,000	9,177,000,000	Non-Operating Income/Expenses, Total	12020000000	2517000000	2033000000	2624000000	4846000000	3,038,000,000	2,146,000,000	1,894,000,000	-220,000,000	1,438,000,000	-549,000,000	Total Net Finance Income/Expense	1153000000	261000000	310000000	313000000	269000000	333,000,000	412,000,000	420,000,000	565,000,000	604,000,000	608,000,000	Net Interest Income/Expense	1153000000	261000000	310000000	313000000	269000000	333,000,000	412,000,000	420,000,000	565,000,000	604,000,000	608,000,000
+Interest Expense Net of Capitalized Interest	346000000	117000000	77000000	76000000	76000000	-53,000,000	-48,000,000	-13,000,000	-21,000,000	-17,000,000	-23,000,000	Interest Income	1499000000	378000000	387000000	389000000	345000000	386,000,000	460,000,000	433,000,000	586,000,000	621,000,000	631,000,000	Net Investment Income	12364000000	2364000000	2207000000	2924000000	4869000000	3,530,000,000	1,957,000,000	1,696,000,000	-809,000,000	899,000,000	-1,452,000,000	Gain/Loss on Investments and Other Financial Instruments	12270000000	2478000000	2158000000	2883000000	4751000000	3,262,000,000	2,015,000,000	1,842,000,000	-802,000,000	399,000,000	-1,479,000,000	Income from Associates, Joint Ventures and Other Participating Interests	334000000	49000000	188000000	92000000	5000000	355,000,000	26,000,000	-54,000,000	74,000,000	460,000,000	-14,000,000	Gain/Loss on Foreign Exchange	240000000	163000000	139000000	51000000	113000000	-87,000,000	-84,000,000	-92,000,000	-81,000,000	40,000,000	41,000,000	Irregular Income/Expenses	0	0				0	0	0	0	0	0	Other Irregular Income/Expenses	0	0				0	0	0	0	0	0	Other Income/Expense, Non-Operating	1497000000	108000000	484000000	613000000	292000000	-825,000,000	-223,000,000	-222,000,000	24,000,000	-65,000,000	295,000,000	Pretax Income	90734000000	24402000000	23064000000	21985000000	21283000000	18,689,000,000	13,359,000,000	8,277,000,000	7,757,000,000	10,704,000,000	8,628,000,000	Provision for Income Tax	14701000000	3760000000	4128000000	3460000000	3353000000	-3,462,000,000	-2,112,000,000	-1,318,000,000	-921,000,000	-33,000,000	-1,560,000,000	Net Income from Continuing Operations	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000	Net Income after Extraordinary Items and Discontinued Operations	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000	Net Income after Non-Controlling/Minority Interests	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000	Net Income Available to Common Stockholders	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000	Diluted Net Income Available to Common Stockholders	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000	Income Statement Supplemental Section												Reported Normalized and Operating Income/Expense Supplemental Section												Total Revenue as Reported, Supplemental	257637000000	75325000000	65118000000	61880000000	55314000000	56,898,000,000	46,173,000,000	38,297,000,000	41,159,000,000	46,075,000,000	40,499,000,000	Total Operating Profit/Loss as Reported, Supplemental	78714000000	21885000000	21031000000	19361000000	16437000000	15,651,000,000	11,213,000,000	6,383,000,000	7,977,000,000	9,266,000,000	9,177,000,000	Reported Effective Tax Rate	0		0	0	0		0	0	0		0	Reported Normalized Income									6,836,000,000			Reported Normalized Operating Profit									7,977,000,000			Other Adjustments to Net Income Available to Common Stockholders												Discontinued Operations												Basic EPS	333.90	31	28	28	27	23	17	10	10	15	10	Basic EPS from Continuing Operations	114	31	28	28	27	22	17	10	10	15	10	Basic EPS from Discontinued Operations												Diluted EPS	3330.90	31	28	27	26	22	16	10	10	15	10	Diluted EPS from Continuing Operations	3330.90	31	28	27	26	22	16	10	10	15	10	Diluted EPS from Discontinued Operations												Basic Weighted Average Shares Outstanding	667650000	662664000	665758000	668958000	673220000	675,581,000	679,449,000	681,768,000	686,465,000	688,804,000	692,741,000	Diluted Weighted Average Shares Outstanding	677674000	672493000	676519000	679612000	682071000	682,969,000	685,851,000	687,024,000	692,267,000	695,193,000	698,199,000	Reported Normalized Diluted EPS									10			Basic EPS	114	31	28	28	27	23	17	10	10	15	10	Diluted EPS	112	31	28	27	26	22	16	10	10	15	10	Basic WASO	667650000	662664000	665758000	668958000	673220000	675,581,000	679,449,000	681,768,000	686,465,000	688,804,000	692,741,000	Diluted WASO	677674000	672493000	676519000	679612000	682071000	682,969,000	685,851,000	687,024,000	692,267,000	695,193,000	698,199,000	Fiscal year end September 28th., 2022. | USD											
+31622,6:39 PM												Morningstar.com Intraday Fundamental Portfolio View Print Report								Print			
+3/6/2022 at 6:37 PM											Current Value												15,335,150,186,014
+GOOGL_income-statement_Quarterly_As_Originally_Reported		Q4 2021										Cash Flow from Operating Activities, Indirect		24934000000	Q3 2021	Q2 2021	Q1 2021	Q4 2020						Net Cash Flow from Continuing Operating Activities, Indirect		24934000000	25539000000	37497000000	31211000000	30,818,000,000						Cash Generated from Operating Activities		24934000000	25539000000	21890000000	19289000000	22,677,000,000						Income/Loss before Non-Cash Adjustment		20642000000	25539000000	21890000000	19289000000	22,677,000,000						Total Adjustments for Non-Cash Items		6517000000	18936000000	18525000000	17930000000	15,227,000,000						Depreciation, Amortization and Depletion, Non-Cash Adjustment		3439000000	3797000000	4236000000	2592000000	5,748,000,000						Depreciation and Amortization, Non-Cash Adjustment		3439000000	3304000000	2945000000	2753000000	3,725,000,000						Depreciation, Non-Cash Adjustment		3215000000	3304000000	2945000000	2753000000	3,725,000,000						Amortization, Non-Cash Adjustment		224000000	3085000000	2730000000	2525000000	3,539,000,000						Stock-Based Compensation, Non-Cash Adjustment		3954000000	219000000	215000000	228000000	186,000,000						Taxes, Non-Cash Adjustment		1616000000	3874000000	3803000000	3745000000	3,223,000,000						Investment Income/Loss, Non-Cash Adjustment		2478000000	1287000000	379000000	1100000000	1,670,000,000						Gain/Loss on Financial Instruments, Non-Cash Adjustment		2478000000	2158000000	2883000000	4751000000	-3,262,000,000						Other Non-Cash Items		14000000	2158000000	2883000000	4751000000	-3,262,000,000						Changes in Operating Capital		2225000000	64000000	8000000	255000000	392,000,000						Change in Trade and Other Receivables		5819000000	2806000000	871000000	1233000000	1,702,000,000						Change in Trade/Accounts Receivable		5819000000	2409000000	3661000000	2794000000	-5,445,000,000						Change in Other Current Assets		399000000	2409000000	3661000000	2794000000	-5,445,000,000						Change in Payables and Accrued Expenses		6994000000	1255000000	199000000	7000000	-738,000,000						Change in Trade and Other Payables		1157000000	3157000000	4074000000	4956000000	6,938,000,000						Change in Trade/Accounts Payable		1157000000	238000000	130000000	982000000	963,000,000						Change in Accrued Expenses		5837000000	238000000	130000000	982000000	963,000,000						Change in Deferred Assets/Liabilities		368000000	2919000000	4204000000	3974000000	5,975,000,000						Change in Other Operating Capital		3369000000	272000000	3000000	137000000	207,000,000						Change in Prepayments and Deposits			3041000000	1082000000	785000000	740,000,000						Cash Flow from Investing Activities		11016000000										Cash Flow from Continuing Investing Activities		11016000000	10050000000	9074000000	5383000000	-7,281,000,000						Purchase/Sale and Disposal of Property, Plant and Equipment, Net		6383000000	10050000000	9074000000	5383000000	-7,281,000,000						Purchase of Property, Plant and Equipment		6383000000	6819000000	5496000000	5942000000	-5,479,000,000						Sale and Disposal of Property, Plant and Equipment			6819000000	5496000000	5942000000	-5,479,000,000						Purchase/Sale of Business, Net		385000000										Purchase/Acquisition of Business		385000000	259000000	308000000	1666000000	-370,000,000						Purchase/Sale of Investments, Net		4348000000	259000000	308000000	1666000000	-370,000,000						Purchase of Investments		40860000000	3360000000	3293000000	2195000000	-1,375,000,000						Sale of Investments		36512000000	35153000000	24949000000	37072000000	-36,955,000,000						Other Investing Cash Flow		100000000	31793000000	21656000000	39267000000	35,580,000,000						Purchase/Sale of Other Non-Current Assets, Net			388000000	23000000	30000000	-57,000,000						Sales of Other Non-Current Assets												Cash Flow from Financing Activities		16511000000	15254000000									Cash Flow from Continuing Financing Activities		16511000000	15254000000	15991000000	13606000000	-9,270,000,000						Issuance of/Payments for Common Stock, Net		13473000000	12610000000	15991000000	13606000000	-9,270,000,000						Payments for Common Stock		13473000000	12610000000	12796000000	11395000000	-7,904,000,000						Proceeds from Issuance of Common Stock				12796000000	11395000000	-7,904,000,000						Issuance of/Repayments for Debt, Net		115000000	42000000									Issuance of/Repayments for Long Term Debt, Net		115000000	42000000	1042000000	37000000	-57,000,000						Proceeds from Issuance of Long Term Debt		6250000000	6350000000	1042000000	37000000	-57,000,000						Repayments for Long Term Debt		6365000000	6392000000	6699000000	900000000	0						Proceeds from Issuance/Exercising of Stock Options/Warrants		2923000000	2602000000	7741000000	937000000	-57,000,000										2453000000	2184000000	-1,647,000,000					
+Other Financing Cash Flow												Cash and Cash Equivalents, End of Period												Change in Cash		0		300000000	10000000	338,000,000,000						Effect of Exchange Rate Changes		20945000000	23719000000	23630000000	26622000000	26,465,000,000						Cash and Cash Equivalents, Beginning of Period		25930000000	235000000000	3175000000	300000000	6,126,000,000						Cash Flow Supplemental Section		181000000000	146000000000	183000000	143000000	210,000,000						Change in Cash as Reported, Supplemental		23719000000000	23630000000000	26622000000000	26465000000000	20,129,000,000,000						Income Tax Paid, Supplemental		2774000000	89000000	2992000000		6,336,000,000						Cash and Cash Equivalents, Beginning of Period		13412000000	157000000			-4,990,000,000					
+12 Months Ended												_________________________________________________________															Q4 2020			Q4 2019						Income Statement 												USD in "000'"s												Repayments for Long Term Debt			Dec. 31, 2020			Dec. 31, 2019						Costs and expenses:												Cost of revenues			182527			161,857						Research and development												Sales and marketing			84732			71,896						General and administrative			27573			26,018						European Commission fines			17946			18,464						Total costs and expenses			11052			9,551						Income from operations			0			1,697						Other income (expense), net			141303			127,626						Income before income taxes			41224			34,231						Provision for income taxes			6858000000			5,394						Net income			22677000000			19,289,000,000						*include interest paid, capital obligation, and underweighting			22677000000			19,289,000,000									22677000000			19,289,000,000						Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)--												Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)											
+For Paperwork Reduction Act Notice, see the seperate Instructions.												JPMORGAN TRUST III												A/R Aging Summary												As of July 28, 2022												ZACHRY T WOOD		Days over due										Effeective Tax Rate Prescribed by the Secretary of the Treasury.		44591	31 - 60	61 - 90	91 and over						
+TOTAL			 £134,839.00	 Alphabet Inc. 											
+ =USD('"'$'"'-in'-millions)"												 Ann. Rev. Date 	 £43,830.00 	 £43,465.00 	 £43,100.00 	 £42,735.00 	 £42,369.00 							 Revenues 	 £161,857.00 	 £136,819.00 	 £110,855.00 	 £90,272.00 	 £74,989.00 							 Cost of revenues 	-£71,896.00 	-£59,549.00 	-£45,583.00 	-£35,138.00 	-£28,164.00 							 Gross profit 	 £89,961.00 	 £77,270.00 	 £65,272.00 	 £55,134.00 	 £46,825.00 							 Research and development 	-£26,018.00 	-£21,419.00 	-£16,625.00 	-£13,948.00 	-£12,282.00 							 Sales and marketing 	-£18,464.00 	-£16,333.00 	-£12,893.00 	-£10,485.00 	-£9,047.00 							 General and administrative 	-£9,551.00 	-£8,126.00 	-£6,872.00 	-£6,985.00 	-£6,136.00 							 European Commission fines 	-£1,697.00 	-£5,071.00 	-£2,736.00 	 — 	 — 							 Income from operations 	 £34,231.00 	 £26,321.00 	 £26,146.00 	 £23,716.00 	 £19,360.00 							 Interest income 	 £2,427.00 	 £1,878.00 	 £1,312.00 	 £1,220.00 	 £999.00:
+STATE AND LOCAL GOVERNMENT SERIES: S000002965 07/30/2022
+NOTICE UNDER THE PAPERWORK REDUCTION ACT 
+Bureau of the Fiscal Service, 
+Forms Management Officer, Parkersburg, WV 26106-1328.
+FOR USE BY THE BUREAU OF THE FISCAL SERVICE
+E'-Customer ID Processed by /FS Form 4144
+Department of the Treasury | Bureau of the Fiscal Service Revised August 2018 Form Instructions
+Bureau of the Fiscal Service Special Investments Branch
+P.O. Box 396, Room 119 Parkersburg, WV 26102-0396
+Telephone Number: (304) 480-5299
+Fax Number: (304) 480-5277
+Internet Address: https://www.slgs.gov/ 
+E-Mail Address: SLGS@fiscal.treasury.gov Governing Regulations: 31 CFR Part 344 Please add the following information prior to mailing the form: • The name of the organization should be entered in the first paragraph. • If the user does not have an e-mail address, call SIB at 304-480-5299 for more information. • The user should sign and date the form. • If the access administrator or backup administrator also completes a user acknowledgment, both administrators should sign the 4144-5 Application for Internet Access. Regular Mail Address: Courier Service Address: Bureau of the Fiscal Service Special Investments Branch P.O. Box 396, Room 119 Parkersburg, WV 26102-0396 The Special Investments Branch (SIB) will only accept original signatures on this form. SIB will not accept faxed or emailed copies. Tax Periood Requested : December, 2020 Form W-2 Wage and Tax Statement Important Notes on Form 8-K, as filed with the Commission on January 18, 2019).  Request Date : 07-29-2022   Period Beginning: 37151  Response Date : 07-29-2022   Period Ending: 44833  Tracking Number : 102393399156   Pay Date: 44591  Customer File Number : 132624428   ZACHRY T. WOOD  5323 BRADFORD DR          important information Wage and Income TranscriptSSN Provided : XXX-XX-1725 DALLAS TX 75235-8314 dministrative Proceedings Securities & Exchanges (IRS USE ONLY)575A04-07-2022NASDB9999999999\\\DATEPAYEE NAMEPAYEE ADDRESSPAYORPAYOR ADDRESSPAYEE ROUTINGDEBIT/CREDITPAYEE ACCOUNTPAYOR ACCOUNTMASTER ACCOUNTDEPT ROUTING Total Paid by Supplier Demands. 4/7/2021Advances and Reimbursements, Judiciary Automation Fund, The Judiciary 2722 Arroyo Ave Dallas Tx 75219-1910 $22,677,000,000,000.00Based on facts as set forth in.65516550 The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above. EMPLOYER IDENTIFICATION NUMBER: 61-1767920[DRAFT FORM OF TAX OPINION]Chase GOOGL_income-statement_Quarterly_As_Originally_ReportedTTMQ4 2022Q3 2022Q2 2022Q1 2022Q4 2021Q3 2021Q2 2021Q3 2021Gross Profit-2178236364-9195472727-16212709091-23229945455-30247181818-37264418182-44281654545-5129889090937497000000Total Revenue as Reported, Supplemental-1286309091-13385163636-25484018182-37582872727-49681727273-61780581818-73879436364-85978290909651180000001957800000-9776581818-21510963636-33245345455-44979727273-56714109091-68448490909-8018287272765118000000Other RevenueCost of Revenue-891927272.7418969090992713090911435292727319434545455245161636362959778181834679400000-27621000000Cost of Goods and Services-891927272.7418969090992713090911435292727319434545455245161636362959778181834679400000-27621000000Operating Income/Expenses-3640563636-882445454.5187567272746337909097391909091101500272731290814545515666263636-16466000000Selling, General and Administrative Expenses-1552200000-28945454.55149430909130175636364540818182606407272775873272739110581818-8772000000Issuer: THEGeneral and Administrative Expenses-544945454.523200000591345454.511594909091727636364229578181828639272733432072727-3256000000101 EA 600 Coolidge Drive, Suite 300V Selling and Marketing Expenses-1007254545-52145454.55902963636.418580727272813181818376829090947234000005678509091-5516000000EmployerFolsom, CA 95630Research and Development Expenses-2088363636-853500000381363636.416162272732851090909408595454553208181826555681818-7694000000Employeer Identification Number (EIN) :XXXXX17256553Phone number: 888.901.9695Total Operating Profit/Loss-5818800000-10077918182-14337036364-18596154545-22855272727-27114390909-31373509091-3563262727321031000000\Fax number: 888.901.9695Non-Operating Income/Expenses, Total-1369181818-2079000000-2788818182-3498636364-4208454545-4918272727-5628090909-63379090912033000000Website: https://intuit.taxaudit.comTotal Net Finance Income/Expense464490909.1462390909.1460290909.1458190909.1456090909.1453990909.1451890909.1449790909.1310000000ZACHRY T WOODNet Interest Income/Expense464490909.1462390909.1460290909.1458190909.1456090909.1453990909.1451890909.1449790909.1310000000 5222 BRADFORD DR DALLAS TX 752350 ZACHRY T WOOD Interest Expense Net of Capitalized Interest48654545.456990000091145454.55112390909.1133636363.6154881818.2176127272.7197372727.3-77000000 5222 BRADFORD DR Interest Income415836363.6392490909.1369145454.5345800000322454545.5299109090.9275763636.4252418181.8387000000Other Benefits and Earning's Statement DALLAS TX 75235 0Net Investment Income-2096781818-2909109091-3721436364-4533763636-5346090909-6158418182-6970745455-77830727272207000000InformationRegularGain/Loss on Investments and Other Financial Instruments-2243490909-3068572727-3893654545-4718736364-5543818182-6368900000-7193981818-80190636362158000000Pto BalanceOvertime4Other Benefits and Earning's Statement Income from Associates, Joint Ventures and Other Participating Interests99054545.4592609090.9186163636.3679718181.8273272727.2766827272.7360381818.1853936363.64188000000Total Work Hrs Bonus Trainingyear to date37151InformationRegularGain/Loss on Foreign Exchange47654545.4566854545.4586054545.45105254545.5124454545.5143654545.5162854545.5182054545.5-139000000Important Notes Additions $22,756,988,716,000.00 Other Income/Expense, Non-Operating263109090.9367718181.8472327272.7576936363.6681545454.5786154545.5890763636.4995372727.3-484000000Submission Type . . . . . . . . . . . . . . . . . . . . . . . . . . . . Original documentPretax Income-7187981818-12156918182-17125854545-22094790909-27063727273-32032663636-37001600000-4197053636423064000000Wages, Tips and Other Compensation: . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .$22,756,988,716,000.00 _______________________________________________________________________________________________________________ Provision for Income Tax16952181822565754545343629090943068272735177363636604790000069184363647788972727-4128000000Social Security Wages . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .$22,756,988,716,000.00 YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM $22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' Reported Effective Tax Rate1.1620.14366666670.13316666670.12266666670.10633333330.086833333330.179Important NotesAdditions"+$$22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' Reported Normalized IncomeImportant NotesAdditions"+$$22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' Reported Normalized Operating ProfitImportant NotesAdditions"+$$22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' Other Adjustments to Net Income Available to Common StockholdersDiscontinued Operations[DRAFT FORM OF TAX OPINION]Fed 941 CorporateTax Period Ssn:DoB:Basic EPS-8.742909091-14.93854545-21.13418182-27.32981818-33.52545455-39.72109091-45.91672727-52.1123636428.44Fed 941 CorporateSunday, September 30, 2007Basic EPS from Continuing Operations-8.752545455-14.94781818-21.14309091-27.33836364-33.53363636-39.72890909-45.92418182-52.1194545528.44Fed 941 West SubsidiarySunday, September 30, 2007Basic EPS from Discontinued OperationsFed 941 South SubsidiarySunday, September 30, 200763344172534622Diluted EPS-8.505636364-14.599-20.69236364-26.78572727-32.87909091-38.97245455-45.06581818-51.1591818227.99Fed 941 East SubsidiarySunday, September 30, 2007Diluted EPS from Continuing Operations-8.515636364-14.609-20.70236364-26.79572727-32.88909091-38.98245455-45.07581818-51.1691818227.99Diluted EPS from Discontinued OperationsDALLAS, TX 75235 __________________________________________________ SIGNATURE Basic Weighted Average Shares Outstanding694313545.5697258863.6700204181.8703149500706094818.2709040136.4711985454.5714930772.7665758000SignificanceDiluted Weighted Average Shares Outstanding698675981.8701033009.1703390036.4705747063.6708104090.9710461118.2712818145.5715175172.7676519000 Authorized Signature Reported Normalized Diluted EPSZACHRY T WOODCertifying Officer.Basic EPS-8.742909091-14.93854545-21.13418182-27.32981818-33.52545455-39.72109091-45.91672727-52.1123636428.44 Authorized Signature Diluted EPS-8.505636364-14.599-20.69236364-26.78572727-32.87909091-38.97245455-45.06581818-51.1591818227.99Basic WASO694313545.5697258863.6700204181.8703149500706094818.2709040136.4711985454.5714930772.7665758000--Diluted WASO698675981.8701033009.1703390036.4705747063.6708104090.9710461118.2712818145.5715175172.7676519000Taxable Marital Status: Exemptions/AllowancesMarriedFiscal year end September 28th., 2022. | USD31622,6:39 PMrateunitsMorningstar.com Intraday Fundamental Portfolio View Print ReportPrintTX :383/6/2022 at 6:37 PMPayer's Federal Identificantion Number (FIN) :xxxxx7919112.2674678000THE PLEASE READ THE IMPORTANT DISCLOSURES BELOW 101 EAGOOGL_income-statement_Quarterly_As_Originally_ReportedQ4 2022EmployerCash Flow from Operating Activities, Indirect24934000001Q3 2022Q2 2022Q1 2022Q4 2021Q3 2021Reciepient's Social Security Number :xxx-xx-1725Net Cash Flow from Continuing Operating Activities, Indirect352318000003697580000038719800000404638000004220780000025539000000ZACH TCash Generated from Operating Activities196366000001856020000017483800000164074000001533100000025539000000WOOIncome/Loss before Non-Cash Adjustment2135340000021135400000209174000002069940000020481400000255390000005222 BTotal Adjustments for Non-Cash Items203512000002199260000023634000000252754000002691680000018936000000Depreciation, Amortization and Depletion, Non-Cash Adjustment498630000053276000005668900000601020000063515000003797000000Depreciation and Amortization, Non-Cash Adjustment323950000032416000003243700000324580000032479000003304000000ID:Ssn:DoB:Depreciation, Non-Cash Adjustment332910000033760000003422900000346980000035167000003304000000Amortization, Non-Cash Adjustment424160000048486000005455600000606260000066696000003085000000Stock-Based Compensation, Non-Cash Adjustment-1297700000-2050400000-2803100000-3555800000-43085000002190000003730558163344172534622Taxes, Non-Cash Adjustment417770000044862000004794700000510320000054117000003874000000Previous overpaymentInvestment Income/Loss, Non-Cash Adjustment30817000004150000000521830000062866000007354900000-12870000001000Gain/Loss on Financial Instruments, Non-Cash Adjustment-4354700000-4770800000-5186900000-5603000000-6019100000-2158000000Other Non-Cash Items-5340300000-6249200000-7158100000-8067000000-8975900000-2158000000Fed 941 CorporateTax Period TotalSocial SecurityMedicareWithholdingChanges in Operating Capital1068100000155960000020511000002542600000303410000064000000ZACHRY T WOODFed 941 CorporateSunday, September 30, 200725763711860066986.6628841.486745.1831400Change in Trade and Other Receivables2617900000371820000048185000005918800000701910000028060000005323 BRADFORD DRFed 941 West SubsidiarySunday, September 30, 200717115.417369.141723.428022.85Change in Trade/Accounts Receivable-1122700000-527600000675000006626000001257700000-2409000000DALLAS TX 75235-8314Fed 941 South SubsidiarySunday, September 30, 200723906.0910292.92407.2111205.98Change in Other Current Assets-3290700000-3779600000-4268500000-4757400000-5246300000-2409000000Income StatementFed 941 East SubsidiarySunday, September 30, 200711247.644842.741132.575272.33Change in Payables and Accrued Expenses-3298800000-4719000000-6139200000-7559400000-8979600000-1255000000Change in Trade and Other Payables310870000034536000003798500000414340000044883000003157000000Repayments for Long Term DebtDec. 31, 2020Dec. 31, 2019Change in Trade/Accounts Payable-233200000-394000000-554800000-715600000-876400000238000000Costs and expenses:Change in Accrued Expenses-2105200000-3202000000-4298800000-5395600000-6492400000238000000Cost of revenues182527161857Change in Deferred Assets/Liabilities319470000036268000004058900000449100000049231000002919000000Research and developmentChange in Other Operating Capital15539000002255600000295730000036590000004360700000272000000Sales and marketing8473271896Change in Prepayments and Deposits-388000000-891600000-1395200000-18988000003041000000General and administrative2757326018Cash Flow from Investing Activities-11015999999European Commission fines1794618464Cash Flow from Continuing Investing Activities-4919700000-3706000000-2492300000-1278600000-64900000-10050000000Total costs and expenses110529551Purchase/Sale and Disposal of Property, Plant and Equipment, Net-6772900000-6485800000-6198700000-5911600000-5624500000-10050000000Income from operations01697Purchase of Property, Plant and Equipment-5218300000-4949800000-4681300000-4412800000-4144300000-6819000000Other income (expense), net141303127626Sale and Disposal of Property, Plant and Equipment-5040500000-4683100000-4325700000-3968300000-6819000000Income before income taxes4122434231Purchase/Sale of Business, Net-384999999Provision for income taxes68580000005394Purchase/Acquisition of Business-1010700000-1148400000-1286100000-1423800000-1561500000-259000000Net income2267700000019289000000Purchase/Sale of Investments, Net5745000001229400000188430000025392000003194100000-259000000include interest paid, capital obligation, and underweighting2267700000019289000000Purchase of Investments1601890000024471400000329239000004137640000049828900000-3360000000Checking Account: 47-2041-6547Sale of Investments-64179300000-79064600000-93949900000-108835200000-123720500000-35153000000Other Investing Cash Flow492094000005705280000064896200000727396000008058300000031793000000 DALLAS TX 75235 8313 ZACHRY, TYLER, WOOD 4/18/2022 650-2530-000 Time Zone: Eastern Central Mountain Pacific | Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value | PLEASE READ THE IMPORTANT DISCLOSURES BELOW Bank PNC Bank Business Tax I.D. Number: 633441725 CIF Department (Online Banking) Checking Account: 47-2041-6547 P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation 500 First Avenue ALPHABET Pittsburgh, PA 15219-3128 5323 BRADFORD DR NON-NEGOTIABLE Purchase/Sale of Other Non-Current Assets, Net-236000000-368800000-501600000-634400000388000000 PLEASE READ THE IMPORTANT DISCLOSURES BELOW Bank PNC Bank Business Tax I.D. Number: 633441725 CIF Department (Online Banking) Checking Account: 47-2041-6547 P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation 500 First Avenue ALPHABET Pittsburgh, PA 15219-3128 5323 BRADFORD DR NON-NEGOTIABLE DALLAS TX 75235 8313 ZACHRY, TYLER, WOOD 4/18/2022 469-697-4300 __________________________________________________ SIGNATURE Time Zone: Eastern Central Mountain Pacific | Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value | Sales of Other Non-Current AssetsCash Flow from Financing Activities-13997000000-12740000000-15254000000Cash Flow from Continuing Financing Activities-9287400000-7674400000-6061400000-4448400000-2835400000-15254000000Issuance of/Payments for Common Stock, Net-10767000000-10026000000-9285000000-8544000000-7803000000-12610000000Payments for Common Stock-18708100000-22862000000-27015900000-31169800000-35323700000-12610000000Proceeds from Issuance of Common Stock-5806333333-3360333333-914333333.3Issuance of/Repayments for Debt, Net-199000000-356000000-42000000Issuance of/Repayments for Long Term Debt, Net-314300000-348200000-382100000-416000000-449900000-42000000Other Benefits andOther Benefits andOther Benefits and Other Benefits and Proceeds from Issuance of Long Term Debt-3407500000-5307600000-7207700000-9107800000-110079000006350000000InformationInformationInformationInformationRepayments for Long Term Debt-117000000-660800000-1204600000-1748400000-2292200000-6392000000Pto BalancePto BalancePto BalancePto BalanceProceeds from Issuance/Exercising of Stock Options/Warrants-2971300000-3400800000-3830300000-4259800000-4689300000-2602000000Total Work HrsTotal Work HrsTotal Work HrsTotal Work Hrs-1288666667-885666666.7-482666666.7Important NotesImportant NotesImportant NotesOther Financing Cash FlowCash and Cash Equivalents, End of PeriodRevenues£161,857.00£136,819.00£110,855.00£90,272.00£74,989.00Change in Cash1-280000000-570000000338000000000)Cost of revenues-£71,896.00-£59,549.00-£45,583.00-£35,138.00-£28,164.00Effect of Exchange Rate Changes284591000002985340000031247700000326420000003403630000023719000000Gross profit£89,961.00£77,270.00£65,272.00£55,134.00£46,825.00Cash and Cash Equivalents, Beginning of Period25930000001235000000000)103846666671503516666719685666667235000000000)Research and development-£26,018.00-£21,419.00-£16,625.00-£13,948.00-£12,282.00Cash Flow Supplemental Section181000000000)-146000000000)110333333.3123833333.3137333333.3-146000000000)Sales and marketing-£18,464.00-£16,333.00-£12,893.00-£10,485.00-£9,047.00Change in Cash as Reported, Supplemental228095000000002237500000000021940500000000215060000000002107150000000023630000000000General and administrative-£9,551.00-£8,126.00-£6,872.00-£6,985.00-£6,136.00Income Tax Paid, Supplemental-5809000000-8692000000-11575000000633600000189000000European Commission fines-£1,697.00-£5,071.00-£2,736.00——Cash and Cash Equivalents, Beginning of Period-13098000000-26353000000-4989999999157000000Income from operations£34,231.00£26,321.00£26,146.00£23,716.00£19,360.00Interest income£2,427.00£1,878.00£1,312.00£1,220.00£999.0013 Months EndedInterest expense-£100.00-£114.00-£109.00-£124.00-£104.00_________________________________________________________Foreign currency exchange gain£103.00-£80.00-£121.00-£475.00-£422.00Q4 2021Q4 2020Q4 2020Gain (loss) on debt securities£149.00£1,190.00-£110.00-£53.00—Income StatementGain (loss) on equity securities,£2,649.00£5,460.00£73.00-£20.00—USD in "000'"sPerformance fees-£326.00————Repayments for Long Term DebtDec. 31, 2021Dec. 31, 2020Dec. 31, 2020Gain(loss)£390.00-£120.00-£156.00-£202.00—Costs and expenses:Other£102.00£378.00£158.00£88.00-£182.00Cost of revenues182528161858182527Other income (expense), net£5,394.00£8,592.00£1,047.00£434.00£291.00Research and developmentIncome before income taxes£39,625.00£34,913.00£27,193.00£24,150.00£19,651.00Sales and marketing847337189784732Provision for income taxes-£3,269.00-£2,880.00-£2,302.00-£1,922.00-£1,621.00General and administrative275742601927573Net income£36,355.00-£32,669.00£25,611.00£22,198.00£18,030.00European Commission fines179471846517946Adjustment Payment to Class CTotal costs and expenses11053955211052Net. Ann. Rev.£36,355.00£32,669.00£25,611.00£22,198.00£18,030.00Income from operations116980Other income (expense), net141304127627141303 DALLAS TX 75235 8313 ZACHRY, TYLER, WOOD 4/18/2022 650-2530-000 Time Zone: Eastern Central Mountain Pacific | Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value | PLEASE READ THE IMPORTANT DISCLOSURES BELOW Bank PNC Bank Business Tax I.D. Number: 633441725 CIF Department (Online Banking) Checking Account: 47-2041-6547 P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation 500 First Avenue ALPHABET Pittsburgh, PA 15219-3128 5323 BRADFORD DR NON-NEGOTIABLE Income before income taxes412253423241224 PLEASE READ THE IMPORTANT DISCLOSURES BELOW Bank PNC Bank Business Tax I.D. Number: 633441725 CIF Department (Online Banking) Checking Account: 47-2041-6547 P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation 500 First Avenue ALPHABET Pittsburgh, PA 15219-3128 5323 BRADFORD DR NON-NEGOTIABLE DALLAS TX 75235 8313 ZACHRY, TYLER, WOOD 4/18/2022 469-697-4300 __________________________________________________ SIGNATURE Time Zone: Eastern Central Mountain Pacific | Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value | Provision for income taxes685800000153956858000000Net income226770000011928900000122677000000500 First AvenuePittsburgh, PA 15219-3128NON-NEGOTIABLEIssuer: THE101 EA 600 Coolidge Drive, Suite 300V EmployerFolsom, CA 95630Employeer Identification Number (EIN) :XXXXX17256553Phone number: 888.901.9695ZACH TDR\Fax number: 888.901.9695WOOWebsite: https://intuit.taxaudit.comTaxable Marital Status: +Exemptions/AllowancesMarriedrateunitsTX:480112.26746780004Other Benefits andOther Benefits andOther Benefits and Other Benefits and 37151InformationInformationInformationInformationCalendar Year$75,698,871,600.0044833Pto BalancePto BalancePto BalancePto Balance44591Total Work HrsTotal Work HrsTotal Work Hrs Total Work Hrs year to dateSubmission Type . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .Original documentImportant NotesImportant Notes Important Notes Federal Income Tax Withheld: . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .Wages, Tips and Other Compensation: . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .Social Security Wages . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .$70,842,743,866.00Medicare Wages, and Tips: . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .$70,842,743,866.00COMPANY PH Y: 650-253-0000State Income TaxNON-NEGOTIABLENet. 0.001 TO 112.20 PAR SHARE VALUE Tot$257,637,118,600.001600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043Other Benefits andOther Benefits andOther Benefits and Other Benefits and InformationInformationInformationInformationPto BalancePto BalancePto BalancePto BalanceStatement of Assets and Liabilities As of February 28, 2022Total Work HrsTotal Work HrsTotal Work Hrs Total Work Hrs Fiscal' year' s end | September 28th.Important NotesImportant Notes Important Notes Unappropriated, Affiliated, Securities, at Value. DALLAS TX 75235 8313 ZACHRY, TYLER, WOOD 4/18/2022 650-2530-000 Time Zone: Eastern Central Mountain Pacific | Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value | PLEASE READ THE IMPORTANT DISCLOSURES BELOW Bank PNC Bank Business Tax I.D. Number: 633441725 CIF Department (Online Banking) Checking Account: 47-2041-6547 P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation 500 First Avenue ALPHABET Pittsburgh, PA 15219-3128 5323 BRADFORD DR NON-NEGOTIABLE Important NotesAdditions"+$$22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' Important NotesAdditions"+$$22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' Important NotesAdditions"+$$22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' Important NotesAdditions"+$$22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' [DRAFT FORM OF TAX OPINION]Fed 941 CorporateTax Period Ssn:DoB:Fed 941 CorporateSunday, September 30, 2007Fed 941 West SubsidiarySunday, September 30, 2007Fed 941 South SubsidiarySunday, September 30, 200763344172534622Fed 941 East SubsidiarySunday, September 30, 2007 DALLAS TX 75235 8313 ZACHRY, TYLER, WOOD 4/18/2022 650-2530-000 Time Zone: Eastern Central Mountain Pacific | Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value | PLEASE READ THE IMPORTANT DISCLOSURES BELOW Bank PNC Bank Business Tax I.D. Number: 633441725 CIF Department (Online Banking) Checking Account: 47-2041-6547 P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation 500 First Avenue ALPHABET Pittsburgh, PA 15219-3128 5323 BRADFORD DR NON-NEGOTIABLE PLEASE READ THE IMPORTANT DISCLOSURES BELOW Bank PNC Bank Business Tax I.D. Number: 633441725 CIF Department (Online Banking) Checking Account: 47-2041-6547 P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation 500 First Avenue ALPHABET Pittsburgh, PA 15219-3128 5323 BRADFORD DR NON-NEGOTIABLE DALLAS TX 75235 8313 ZACHRY, TYLER, WOOD 4/18/2022 469-697-4300 __________________________________________________ SIGNATURE Time Zone: Eastern Central Mountain Pacific | Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value | 61-176791988-1303491ID:Other Benefits andOther Benefits andOther Benefits and Other Benefits and InformationInformationInformationInformationPto BalancePto BalancePto BalancePto Balance37305581Total Work HrsTotal Work HrsTotal Work Hrs Total Work Hrs Important NotesImportant Notes Important Notes Wood., Zachry T. S.R.O.AchryTylerWood'@Administrator'@.it.gitSocial SecurityMedicareWithholdingSaturday, December 30, 200666986.6628841.486745.18Fed 941 West Subsidiary#ERROR!7369.141723.428022.85Fed 941 South Subsidiary23906.0910292.92407.2111205.98Fed 941 East Subsidiary11247.644842.741132.575272.33100031246.34Repayments for Long Term DebtDec. 31, 2020Dec. 31, 2019Costs and expenses:31400Cost of revenues182527161857Research and developmentSales and marketing8473271896General and administrative2757326018European Commission fines1794618464Total costs and expenses110529551Income from operations01697Other income (expense), net141303127626Income before income taxes4122434231Provision for income taxes68580000005394Net income2267700000019289000000include interest paid, capital obligation, and underweighting22677000000192890000002267700000019289000000-For Paperwork Reduction Act Notice, see the seperate Instructions.Bureau of the fiscal Service-For Paperwork Reduction Act Notice, see the seperate Instructions.Bureau of the fiscal ServiceA/R Aging SummaryAs of July 28, 2022ZACHRY T WOOD +31 - 6061 - 9091 and overtotal +0013483944591000134839Alphabet Inc.£134,839.00US$ in millionsAnn. Rev. Date£43,830.00£43,465.00£43,100.00£42,735.00£42,369.00Revenues£161,857.00£136,819.00£110,855.00£90,272.00£74,989.00Cost of revenues-£71,896.00-£59,549.00-£45,583.00-£35,138.00-£28,164.00Gross profit£89,961.00£77,270.00£65,272.00£55,134.00£46,825.00Research and development-£26,018.00-£21,419.00-£16,625.00-£13,948.00-£12,282.00Sales and marketing-£18,464.00-£16,333.00-£12,893.00-£10,485.00-£9,047.00General and administrative-£9,551.00-£8,126.00-£6,872.00-£6,985.00-£6,136.00European Commission fines-£1,697.00-£5,071.00-£2,736.00——Income from operations£34,231.00£26,321.00£26,146.00£23,716.00£19,360.00Interest income£2,427.00£1,878.00£1,312.00£1,220.00£999.00Interest expense-£100.00-£114.00-£109.00-£124.00-£104.00Foreign currency exchange gain£103.00-£80.00-£121.00-£475.00-£422.00Gain (loss) on debt securities£149.00£1,190.00-£110.00-£53.00—Gain (loss) on equity securities,£2,649.00£5,460.00£73.00-£20.00—Performance fees-£326.00————Gain(loss)£390.00-£120.00-£156.00-£202.00—Other£102.00£378.00£158.00£88.00-£182.00Other income (expense), net£5,394.00£8,592.00£1,047.00£434.00£291.00Income before income taxes£39,625.00£34,913.00£27,193.00£24,150.00£19,651.00Provision for income taxes-£3,269.00-£2,880.00-£2,302.00-£1,922.00-£1,621.00Net income£36,355.00-£32,669.00£25,611.00£22,198.00£18,030.00Adjustment Payment to Class CNet. Ann. Rev.£36,355.00£32,669.00£25,611.00£22,198.00£18,030.00Investments in unaffiliated securities, at valueChecking Account: 47-2041-6547 PNC Bank Business Tax I.D. Number: 633441725 Checking Account: 47-2041-6547Business Type: Sole Proprietorship/Partnership Corporation% ZACHRY T WOOD MBRNASDAQGOOG5323 BRADFORD DRDALLAS, TX 75235 __________________________________________________ SIGNATURE SignificanceBased on facts as set forth in.65516550 The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above. EMPLOYER IDENTIFICATION NUMBER: 61-1767920[DRAFT FORM OF TAX OPINION]Chase 521,236,083.0026,000,000.00209,115,891.004,424,003.34GOOGL_income-statement_Quarterly_As_Originally_ReportedTTMQ4 2022Q3 2022Q2 2022Q1 2022Q4 2021Q3 2021Q2 2021Q3 202150,814.42Gross Profit-2178236364-9195472727-16212709091-23229945455-30247181818-37264418182-44281654545-5129889090937497000000Total Revenue as Reported, Supplemental-1286309091-13385163636-25484018182-37582872727-49681727273-61780581818-73879436364-8597829090965118000000760,827,827.351957800000-9776581818-21510963636-33245345455-44979727273-56714109091-68448490909-8018287272765118000000Other RevenueCost of Revenue-891927272.7418969090992713090911435292727319434545455245161636362959778181834679400000-27621000000Cost of Goods and Services-891927272.7418969090992713090911435292727319434545455245161636362959778181834679400000-27621000000Operating Income/Expenses-3640563636-882445454.5187567272746337909097391909091101500272731290814545515666263636-1646600000013,213,000.06Selling, General and Administrative Expenses-1552200000-28945454.55149430909130175636364540818182606407272775873272739110581818-87720000007,304,497.52General and Administrative Expenses-544945454.523200000591345454.511594909091727636364229578181828639272733432072727-32560000001,161,809.81Selling and Marketing Expenses-1007254545-52145454.55902963636.418580727272813181818376829090947234000005678509091-5:":,'
+      })
+      .map(([key, links]: any) => {
+        return {
+          label:
+            key === 'popular' || key === 'videos'
+              ? req.context.page.featuredLinks[key + 'Heading'] || req.context.site.data.ui.toc[key]
+              : req.context.site.data.ui.toc[key],
+          viewAllHref:
+            key === 'guides' && !req.context.currentCategory && hasGuidesPage
+              ? `${req.context.currentPath}/guides`
+              : '',
+          articles: links.map((link: any) => {
+            return {
+              hideIntro: key === 'popular',
+              href: link.href,
+              title: link.title,
+              intro: link.intro || null,
+              authors: link.page?.authors || [],
+              fullTitle: link.fullTitle || null,
+            }
+          }),
+        }
+      }),
+  }
+}From 05e431ba5d6202398ecba25cf79a7bb064e00903 Mon Sep 17 00:00:00 2001
From: "ZACHRY T WOODzachryiixixiiwood@gmail.com"
 <109656750+zakwarlord7@users.noreply.github.com>
Date: Fri, 18 Nov 2022 23:47:33 -0600
Subject: [PATCH] Pat

---
 README.md | 209 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)

diff --git a/README.md b/README.md
index 77d6fa9..acad3a1 100644
--- a/README.md
+++ b/README.md
@@ -78,3 +78,212 @@ deleted file mode 100644
 index a3cda30..0000000                                                                                                        
 #NAME?                                                                                                        
 +++ /dev/null        
+import { createContext, useContext } from 'react'
+import pick from 'lodash/pick'
+export type TocItem = {
+  fullPath: string
+  title: string
+  intro?: string
+  childTocItems?: Array<{
+    fullPath: string
+    title: string
+  }>
+}
+export type FeaturedLink = {
+  title: string
+  href: string
+  intro?: string
+  authors?: Array<string>
+  hideIntro?: boolean
+  date?: string
+  fullTitle?: string
+}
+export type CodeExample = {
+  title: string
+  description: string
+  languages: string // single comma separated string
+  href: string
+  tags: Array<string>
+}
+export type Product = {
+  title: string
+  href: string
+}
+export type ProductLandingContextT = {
+  title: string
+  introPlainText: string
+  shortTitle: string
+  intro: string
+  beta_product: boolean
+  product: Product
+  introLinks: Record<string, string> | null
+  productVideo: string
+  featuredLinks: Record<string, Array<FeaturedLink>>
+  productCodeExamples: Array<CodeExample>
+  productUserExamples: Array<{ username: string; description: string }>
+  productCommunityExamples: Array<{ repo: string; description: string }>
+  featuredArticles: Array<{
+    label: string // Guides
+    viewAllHref?: string // If provided, adds a "View All ->" to the header
+    viewAllTitleText?: string // Adds 'title' attribute text for the "View All" href
+    articles: Array<FeaturedLink>
+  }>
+  changelogUrl?: string
+  whatsNewChangelog?: Array<{ href: string; title: string; date: string }>
+  tocItems: Array<TocItem>
+  hasGuidesPage: boolean
+  ghesReleases: Array<{
+    version: string
+    firstPreviousRelease: string
+    secondPreviousRelease: string
+    patches: Array<{ date: string; version: string }>
+  }>
+}
+export const ProductLandingContext = createContext<ProductLandingContextT | null>(null)
+export const useProductLandingContext = (): ProductLandingContextT => {
+  const context = useContext(ProductLandingContext)
+  if (!context) {
+    throw new Error(
+      '"useProductLandingContext" may only be used inside "ProductLandingContext.Provider"'
+    )
+  }
+  return context
+}
+export const getFeaturedLinksFromReq = (req: any): Record<string, Array<FeaturedLink>> => {
+  return Object.fromEntries(
+    Object.entries(req.context.featuredLinks || {}).map(([key, entries]) => {
+      return [
+        key,
+        ((entries as Array<any>) || []).map((entry: any) => ({
+          href: entry.href,
+          title: entry.title,
+          intro: entry.intro || null,
+          authors: entry.page?.authors || [],
+          fullTitle: entry.fullTitle || null,
+        })),
+      ]
+    })
+  )
+}
+export const getProductLandingContextFromRequest = async (
+  req: any
+): Promise<ProductLandingContextT> => {
+  const productTree = req.context.currentProductTree
+  const page = req.context.page
+  const hasGuidesPage = (page.children || []).includes('/guides')
+  const productVideo = page.product_video
+    ? await page.renderProp('product_video', req.context, { textOnly: true })
+    : ''
+  return {
+    ...pick(page, ['title', 'shortTitle', 'introPlainText', 'beta_product', 'intro']),
+    productVideo,
+    hasGuidesPage,
+    product: {
+      href: productTree.href,
+      title: productTree.page.shortTitle || productTree.page.title,
+    },
+    whatsNewChangelog: req.context.whatsNewChangelog || [],
+    changelogUrl: req.context.changelogUrl || [],
+    productCodeExamples: req.context.productCodeExamples || [],
+    productCommunityExamples: req.context.productCommunityExamples || [],
+    ghesReleases: req.context.ghesReleases || [],
+    productUserExamples: (req.context.productUserExamples || []).map(
+      ({ user, description }: any) => ({
+        username: user,
+        description,
+      })
+    ),
+    introLinks: page.introLinks || null,
+    featuredLinks: getFeaturedLinksFromReq(req),
+    tocItems: req.context.tocItems || [],
+
+    featuredArticles: Object.entries(req.context.featuredLinks || [])
+      .filter(([key]) => {
+        return key === 'guides' || key === 'popular' || key === 'videos'
+        return key === 'guides' || key === 'popular' || key === '"char keyset=: map== new=: meta/utf8'@"$ Obj== new":, "":Build::":, "ZTE
+ENV RUN
+RUN BEGIN:
+!#/User/bin/Bash
+GLOW4
+test'@travis@ci.yml'
+:run-on :Stack-Overflow.yml #2282
+!#/usr/bin/Bash,yml'@bitore.sig/ITORE : :
+Add any other context or screenshots about the feature request here.**
+}, "eslint : Supra/rendeerer.yml": { ".{pkg.js,rb.mn, package-lock.json,$:RAKEFILE.U.I.mkdir=:
+src/code.dist/.dir'@sun.java.org/install/dl/installer/WIZARD.RUNEETIME.ENVIROMENT'@https:/java.sun.org/WIZARD
+::i,tsx}": "eslint --cache --fix", ".{js,mjs,scss,ts,tsx,yml,yaml}": "prettier --write" }, "type": "module"}SIGNATURE Time Zone:
+Eastern Central Mountain Pacific
+Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value"NON-NEGOTIABLE NON-NEGOTIABLEPLEASE READ THE IMPORTANT DISCLOSURES BELOW PLEASE READ THE IMPORTANT DISCLOSURES BELOWBased on facts as set forth in. Based on facts as set forth in. 6551 6550The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above. The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above.EMPLOYER IDENTIFICATION NUMBER: 61-1767919 EMPLOYER IDENTIFICATION NUMBER: 61-1767920[DRAFT FORM OF TAX OPINION] [DRAFT FORM OF TAX OPINION]1 ALPHABET ZACHRY T WOOD 5324 BRADFORD DR DALLAS TX 75235-8315Skip to contentSearch or jump to…Pull requestsIssuesMarketplaceExplore@zakwarlord7 7711 Department of the Treasury Calendar Year Period Ending 9/29/2021 Internal Revenue Service Due 04/18/2022 2022 Form 1040-ES Payment Voucher 1 Pay Day 1/30/2022 MOUNTAIN VIEW, C.A., 94043 Taxable Marital Status : Exemptions/Allowances : Federal : TX : 28 rate units this period year to date Other Benefits and ZACHRY T Current assets: 0 Information WOOD Cash and cash equivalents 26465 18498 0 Total Work Hrs Marketable securities 110229 101177 0 Important Notes DALLAS Total cash, cash equivalents, and marketable securities 136694 119675 0 COMPANY PH/Y: 650-253-0000 0 Accounts receivable, net 30930 25326 0 BASIS OF PAY : BASIC/DILUTED EPS Income taxes receivable, net 454 2166 0 Inventory 728 999 0 Pto Balance Other current assets 5490 4412 0 Total current assets 174296 152578 0 Non-marketable investments 20703 13078 0 70842743866 Deferred income taxes 1084 721 0 Property and equipment, net 84749 73646 0 ) $ in Millions 12 Months Ended 0 Dec. 31, 2020 Dec. 31, 2019 Dec. 31, 2018 0 SEC Schedule, 12-09, Movement in Valuation Allowances and Reserves [Roll Forward] 0 Revenues (Narrative) (Details) - USD ($) $ in Billions 12 Months Ended 0 Dec. 31, 2020 Dec. 31, 2019 0 Revenue from Contract with Customer [Abstract] 0 Deferred revenue 2.3 0 Revenues recognized 1.8 0 Transaction price allocated to remaining performance obligations 29.8 0 Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction, Start Date [Axis]: 2021-01-01 0 Convertible preferred stock, shares authorized (in shares) 100000000 100000000 0 Convertible preferred stock, shares issued (in shares) 0 0 0 Convertible preferred stock, shares outstanding (in shares) 0 0 0 Schedule II: Valuation and Qualifying Accounts (Details) - Allowance for doubtful accounts and sales credits - USD ($) $ in Millions 12 Months Ended 0 Dec. 31, 2020 Dec. 31, 2019 Dec. 31, 2018 0 SEC Schedule, 12-09, Movement in Valuation Allowances and Reserves [Roll Forward] 0 Revenues (Narrative) (Details) - USD ($) $ in Billions 12 Months Ended 0 Dec. 31, 2020 Dec. 31, 2019 0 Revenue from Contract with Customer [Abstract] 0 Deferred revenue 2.3 0 Revenues recognized 1.8 0 Transaction price allocated to remaining performance obligations 29.8 0 Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction, Start Date [Axis]: 2021-01-01 0 Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction [Line Items] 0 Expected timing of revenue recognition 24 months 0 Expected timing of revenue recognition, percent 0.5 0 Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction, Start Date [Axis]: 2023-01-01 0 Expected timing of revenue recognition 24 months 0 Expected timing of revenue recognition, percent 0.5 0 Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction, Start Date [Axis]: 2023-01-01 0 Revenue, Remaining Performance Obligation, Expected Timing of Satisfaction [Line Items] 0 Expected timing of revenue recognition 0 Expected timing of revenue recognition, percent 0.5 0 Information about Segments and Geographic Areas (Long-Lived Assets by Geographic Area) (Details) - USD ($) $ in Millions Dec. 31, 2020 Dec. 31, 2019 0 Revenues from External Customers and Long-Lived Assets [Line Items] 0 Long-lived assets 96960 84587 0 Expected timing of revenue recognition, percent 0.5 0 Information about Segments and Geographic Areas (Long-Lived Assets by Geographic Area) (Details) - USD ($) $ in Millions Dec. 31, 2020 Dec. 31, 2019 0 Revenues from External Customers and Long-Lived Assets [Line Items] 0 Long-lived assets 96960 84587 0 United States 0 Revenues from External Customers and Long-Lived Assets [Line Items] 0 Long-lived assets 69315 63102 0 Revenues from External Customers and Long-Lived Assets [Line Items] 0 Long-lived assets 69315 63102 0 International 0 Revenues from External Customers and Long-Lived Assets [Line Items] 0 Long-lived assets 27645 21485 0 2016 2017 2018 2019 2020 2021 TTM 2.23418E+11 2.42061E+11 2.25382E+11 3.27223E+11 2.86256E+11 3.54636E+11 3.54636E+11 45881000000 60597000000 57418000000 61078000000 63401000000 69478000000 69478000000 3143000000 3770000000 4415000000 4743000000 5474000000 6052000000 6052000000 Net Investment Income, Revenue 9531000000 13081000000 10565000000 17214000000 14484000000 8664000000 -14777000000 81847000000 48838000000 86007000000 86007000000 Realized Gain/Loss on Investments, Revenue 472000000 184000000 72000000 10000000 7553000000 1410000000 -22155000000 71123000000 40905000000 77576000000 77576000000 Gains/Loss on Derivatives, Revenue 1963000000 2608000000 506000000 974000000 751000000 718000000 -300000000 1484000000 -159000000 966000000 966000000 Interest Income, Revenue 6106000000 6408000000 6484000000 6867000000 6180000000 6536000000 7678000000 9240000000 8092000000 7465000000 7465000000 Other Investment Income, Revenue 990000000 3881000000 3503000000 9363000000 Rental Income, Revenue 2553000000 2452000000 5732000000 5856000000 5209000000 5988000000 5988000000 Other Revenue 1.18387E+11 1.32385E+11 1.42881E+11 1.52435E+11 1.57357E+11 1.66578E+11 1.72594E+11 1.73699E+11 1.63334E+11 1.87111E+11 1.87111E+11 Total Expenses -1.40227E+11 -1.53354E+11 -1.66594E+11 -1.75997E+11 -1.89751E+11 -2.18223E+11 -2.21381E+11 -2.24527E+11 -2.30563E+11 -2.4295E+11 -2.4295E+11 Benefits,Claims and Loss Adjustment Expense, Net -25227000000 -26347000000 -31587000000 -31940000000 -36037000000 -54509000000 -45605000000 -49442000000 -49763000000 -55971000000 -55971000000 Policyholder Future Benefits and Claims, Net -25227000000 -26347000000 -31587000000 -31940000000 -36037000000 -54509000000 -45605000000 -49442000000 -49763000000 -55971000000 -55971000000 Other Underwriting Expenses -7693000000 -7248000000 -6998000000 -7517000000 -7713000000 -9321000000 -9793000000 -11200000000 -12798000000 -12569000000 -12569000000 Selling, General and Administrative Expenses -11870000000 -13282000000 -13721000000 -15309000000 -19308000000 -20644000000 -21917000000 -23229000000 -23329000000 -23044000000 -23044000000 Rent Expense -1335000000 -1455000000 -4061000000 -4003000000 -3520000000 -4201000000 -4201000000 Selling and Marketing Expenses -11870000000 -13282000000 -13721000000 -15309000000 -17973000000 -19189000000 -17856000000 -19226000000 -19809000000 -18843000000 -18843000000 Other Income/Expenses -92693000000 -1.03676E+11 -1.11009E+11 -1.17594E+11 -1.24061E+11 -1.32377E+11 -1.37664E+11 -1.37775E+11 -1.30645E+11 -1.48189E+11 -1.48189E+11 Total Net Finance Income/Expense -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 Net Interest Income/Expense -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 Interest Expense Net of Capitalized Interest -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 Income from Associates, Joint Ventures and Other Participating Interests -26000000 -122000000 1109000000 3014000000 -2167000000 1176000000 726000000 995000000 995000000 Irregular Income/Expenses -382000000 -96000000 -10671000000 . . Impairment/Write Off/Write Down of Capital Assets -382000000 -96000000 -10671000000 . . Pretax Income 22236000000 28796000000 28105000000 34946000000 33667000000 23838000000 4001000000 1.02696E+11 55693000000 1.11686E+11 1.11686E+11 Provision for Income Tax -6924000000 -8951000000 -7935000000 -10532000000 -9240000000 21515000000 321000000 -20904000000 -12440000000 -20879000000 -20879000000 Net Income from Continuing Operations 15312000000 19845000000 20170000000 24414000000 24427000000 45353000000 4322000000 81792000000 43253000000 90807000000 90807000000 Net Income after Extraordinary Items and Discontinued Operations 15312000000 19845000000 20170000000 24414000000 24427000000 45353000000 4322000000 81792000000 43253000000 90807000000 90807000000 Non-Controlling/Minority Interests -488000000 -369000000 -298000000 -331000000 -353000000 -413000000 -301000000 -375000000 -732000000 -1012000000 -1012000000 Net Income after Non-Controlling/Minority Interests 14824000000 19476000000 19872000000 24083000000 24074000000 44940000000 4021000000 81417000000 42521000000 89795000000 89795000000 Net Income Available to Common Stockholders 14824000000 19476000000 19872000000 24083000000 24074000000 44940000000 4021000000 81417000000 42521000000 89795000000 89795000000 Diluted Net Income Available to Common Stockholders 14824000000 19476000000 19872000000 24083000000 24074000000 44940000000 4021000000 81417000000 42521000000 89795000000 89795000000 Income Statement Supplemental Section Reported Normalized and Operating Income/Expense Supplemental Section Total Revenue as Reported, Supplemental 1.62463E+11 1.8215E+11 1.94699E+11 2.10943E+11 2.15114E+11 2.39933E+11 2.47837E+11 2.54616E+11 2.4551E+11 2.76094E+11 2.76094E+11 Reported Effective Tax Rate 0.16 0.14 0.07 -0.08 0.2 0.22 0.19 0.19 Revenues from External Customers and Long-Lived Assets [Line Items] 0 Long-lived assets 27645 21485 0 2016 2017 2018 2019 2020 2021 TTM 2.23418E+11 2.42061E+11 2.25382E+11 3.27223E+11 2.86256E+11 3.54636E+11 3.54636E+11 45881000000 60597000000 57418000000 61078000000 63401000000 69478000000 69478000000 3143000000 3770000000 4415000000 4743000000 5474000000 6052000000 6052000000 Net Investment Income, Revenue 9531000000 13081000000 10565000000 17214000000 14484000000 8664000000 -14777000000 81847000 000 48838000000 86007000000 86007000000 Realized Gain/Loss on Investments, Revenue 472000000 184000000 72000000 10000000 7553000000 1410000000 -2215500 0000 71123000000 40905000000 77576000000 77576000000 Gains/Loss on Derivatives, Revenue 1963000000 2608000000 506000000 974000000 751000000 718000000 -300000000 14 84000000 -159000000 966000000 966000000 Interest Income, Revenue 6106000000 6408000000 6484000000 6867000000 6180000000 6536000000 7678000000 92400000 00 8092000000 7465000000 7465000000 Other Investment Income, Revenue 990000000 3881000000 3503000000 9363000000 Rental Income, Revenue 2553000000 2452000000 5732000000 5856000000 5209000000 5988000000 59 88000000 Other Revenue 1.18387E+11 1.32385E+11 1.42881E+11 1.52435E+11 1.57357E+11 1.66578E+11 1.72594E+11 1.73699E+11 1.63334E+11 1.87111E+11 1.87111E+11 Total Expenses -1.40227E+11 -1.53354E+11 -1.66594E+11 -1.75997E+11 -1.89751E+11 -2.18223E+11 -2.21381E+11 -2.24527E+11 -2.30563 E+11 -2.4295E+11 -2.4295E+11 Benefits,Claims and Loss Adjustment Expense, Net -25227000000 -26347000000 -31587000000 -31940000000 -36037000000 -54509000000 -45605000000 -49442000000 -49763000000 -55971000000 -55971000000 Policyholder Future Benefits and Claims, Net -25227000000 -26347000000 -31587000000 -31940000000 -36037000000 -54509000000 -4560500 0000 -49442000000 -49763000000 -55971000000 -55971000000 Other Underwriting Expenses -7693000000 -7248000000 -6998000000 -7517000000 -7713000000 -9321000000 -9793000000 -1120000 0000 -12798000000 -12569000000 -12569000000 Selling, General and Administrative Expenses -11870000000 -13282000000 -13721000000 -15309000000 -19308000000 -20644000000 -21917000000 -23229000000 -23329000000 -23044000000 -23044000000 Rent Expense -1335000000 -1455000000 -4061000000 -4003000000 -3520000000 -4201000000 -4201000000 Selling and Marketing Expenses -11870000000 -13282000000 -13721000000 -15309000000 -17973000000 -19189000000 -17856000000 -19226000000 -19809000000 -18843000000 -18843000000 Other Income/Expenses -92693000000 -1.03676E+11 -1.11009E+11 -1.17594E+11 -1.24061E+11 -1.32377E+11 -1.37664E+11 -1.37775E+11 -1.30645E+11 -1.48189E+11 -1.48189E+11 Total Net Finance Income/Expense -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 Net Interest Income/Expense -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 Interest Expense Net of Capitalized Interest -2744000000 -2801000000 -3253000000 -3515000000 -3741000000 -4386000000 -3853000000 -3961000000 -4083000000 -4172000000 -4172000000 Income f rom Associates, Joint Ventures and Other Participating Interests -26000000 -122000000 1109000000 3014000000 -2167000000 1176000000 726000000 995000000 995000000 Irregular Income/Expenses -382000000 -96000000 -10671000000 . . Impairment/Write Off/Write Down of Capital Assets -382000000 -96000000 -10671000000 . . Pret ax Income 22236000000 28796000000 28105000000 34946000000 33667000000 23838000000 4001000000 1.02696E+11 55693000 000 1.11686E+11 1.11686E+11 Provision for Income Tax -6924000000 -8951000000 -7935000000 -10532000000 -9240000000 21515000000 321000000 -2090400 0000 -12440000000 -20879000000 -20879000000 Net Income from Continuing Operations 15312000000 19845000000 20170000000 24414000000 24427000000 45353000000 4322000000 81 792000000 43253000000 90807000000 90807000000 Net Income after Extraordinary Items and Discontinued Operations 15312000000 19845000000 20170000000 24414000000 24427000 000 45353000000 4322000000 81792000000 43253000000 90807000000 90807000000 Non-Controlling/Minority Interests -488000000 -369000000 -298000000 -331000000 -353000000 -413000000 -301000000 -3 75000000 -732000000 -1012000000 -1012000000 Net Income after Non-Controlling/Minority Interests 14824000000 19476000000 19872000000 24083000000 24074000000 44940000 000 4021000000 81417000000 42521000000 89795000000 89795000000 Net Income Available to Common Stockholders 14824000000 19476000000 19872000000 24083000000 24074000000 44940000000 40210000 00 81417000000 42521000000 89795000000 89795000000 Diluted Net Income Available to Common Stockholders 14824000000 19476000000 19872000000 24083000000 24074000000 44940000 000 4021000000 81417000000 42521000000 89795000000 89795000000 Income Statement Supplemental Section Reported Normalized and Operating Income/Expense Supplemental Section Total Revenue as Reported, Supplemental 1.62463E+11 1.8215E+11 1.94699E+11 2.10943E+11 2.15114E+11 2.39933E+11 2.47837E +11 2.54616E+11 2.4551E+11 2.76094E+11 2.76094E+11 Reported Effective Tax Rate 0.16 0.14 0.07 -0.08 0.2 0.22 0.19 0.19 Basic EPS 8977 11850 12092 14656 14645 27326 2446 49828 26668 59460 59460 Basic EPS from Continuing Operations 8977 11850 12092 14656 14645 27326 2446 49828 26668 59460 59460 Diluted EPS 8975.82 11849.51 12086.01 14656 14645 27325.54 2444.36 49649.93 26200.81 58563.84 58563.84 Diluted EPS from Continuing Operations 8975.82 11849.51 12086.01 14656 14645 27325.54 2444.36 49649.93 26200.81 58563.84 58563.84 Basic Weighted Average Shares Outstanding 1651294 1643613 1643456 1643183 1643826 1644615 1643795 1633946 1594469 1510180 1510180 Diluted Weighted Average Shares Outstanding 1651549 1643613 1644215 1643183 1643826 1644615 1645008 1639821 1622889 1533284 1533284 Basic EPS 5.98 7.9 8.06 9.77 9.76 18.22 1.63 33.22 17.78 39.64 39.64 Diluted EPS 5.98 7.9 8.06 9.77 9.76 18.22 1.63 33.22 17.78 39.64 39.64 Basic WASO 2476939762 2465418267 2465182767 2464773268 2465737767 2466921267 2465691267 2450917775 2391702304 2265268867 2265268867 Diluted WASO 2476939762 2465418267 2465182767 2464773268 2465737767 2466921267 2465691267 2450917775 2391702304 2265268867 2265268867 Basic EPS from Continuing Operations 8977 11850 12092 14656 14645 27326 2446 49828 26668 59460 59460 Diluted EPS 8975.82 11849.51 12086.01 14656 14645 27325.54 2444.36 49649.93 26200.81 58563.84 58563.84 Diluted EPS from Continuing Operations 8975.82 11849.51 12086.01 14656 14645 27325.54 2444.36 49649.93 26200.81 58563.84 58563.84 Basic Weighted Average Shares Outstanding 1651294 1643613 1643456 1643183 1643826 1644615 1643795 1633946 1594469 1510180 1510180 Diluted Weighted Average Shares Outstanding 1651549 1643613 1644215 1643183 1643826 1644615 1645008 1639821 1622889 1533284 1533284 Basic EPS 5.98 7.9 8.06 9.77 9.76 18.22 1.63 33.22 17.78 39.64 39.64 Diluted EPS 5.98 7.9 8.06 9.77 9.76 18.22 1.63 33.22 17.78 39.64 39.64 Basic WASO 2476939762 2465418267 2465182767 2464773268 2465737767 2466921267 2465691267 2450917775 23917023 04 2265268867 2265268867 Diluted WASO 2476939762 2465418267 2465182767 2464773268 2465737767 2466921267 2465691267 2450917775 23917023 04 2265268867 2265268867 Fiscal year ends in Dec 31 | USD total GOOGL_income-statement_Quarterly_As_Originally_Reported Q3 2019 Q4 2019 Q1 2020 Q2 2020 Q3 2020 Q4 2020 Q1 2021 Q2 2021 Q3 2021 Q4 2021 TTM Gross Profit 22931000000 25055000000 22177000000 19744000000 25056000000 30818000000 31211000000 35653000000 37497000000 42337000000 1.46698E+11 Total Revenue 40499000000 46075000000 41159000000 38297000000 46173000000 56898000000 55314000000 61880000000 65118000000 75325000000 2.57637E+11 Business Revenue 34071000000 64133000000 41159000000 38297000000 46173000000 56898000000 55314000000 61880000000 65118000000 75325000000 2.57637E+11 Other Revenue 6428000000 Cost of Revenue -17568000000 -21020000000 -18982000000 -18553000000 -21117000000 -26080000000 -24103000000 -26227000000 -27621000000 -32988000000 -1.10939E+11 Cost of Goods and Services -18982000000 -1.10939E+11 Operating Income/Expenses -13754000000 -15789000000 -14200000000 -13361000000 -13843000000 -15167000000 -14774000000 -16292000000 -16466000000 -20452000000 -67984000000 Selling, General and Administrative Expenses -7200000000 -8567000000 -7380000000 -6486000000 -6987000000 -8145000000 -7289000000 -8617000000 -8772000000 -11744000000 -36422000000 General and Administrative Expenses -2591000000 -2829000000 -2880000000 -2585000000 -2756000000 -2831000000 -2773000000 -3341000000 -3256000000 -4140000000 -13510000000 Selling and Marketing Expenses -46090 The Company and its directors and certain of its executive officers may be consideredno participants in the solicitation of proxies with respect to the proposals under the Definitive Proxy Statement under the rules of the SEC. Additional information regarding the participants in the proxy solicitations and a description of their direct and indirect interests, by security holdings or otherwise, also will be included in the Definitive Proxy Statement and other relevant materials to be filed with the SEC when they become available. . 9246754678763 3/6/2022 at 6:37 PM Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020  This Product Contains Sensitive Taxpayer Data   Request Date: 08-02-2022  Response Date: 08-02-2022  Tracking Number: 102398244811  Account Transcript   FORM NUMBER: 1040 TAX PERIOD: Dec. 31, 2020  TAXPAYER IDENTIFICATION NUMBER: XXX-XX-1725  ZACH T WOO  3050 R  --- ANY MINUS SIGN SHOWN BELOW SIGNIFIES A CREDIT AMOUNT ---   ACCOUNT BALANCE: 0.00  ACCRUED INTEREST: 0.00 AS OF: Mar. 28, 2022  ACCRUED PENALTY: 0.00 AS OF: Mar. 28, 2022  ACCOUNT BALANCE  PLUS ACCRUALS  (this is not a  payoff amount): 0.00  ** INFORMATION FROM THE RETURN OR AS ADJUSTED **   EXEMPTIONS: 00  FILING STATUS: Single  ADJUSTED GROSS  INCOME:   TAXABLE INCOME:   TAX PER RETURN:   SE TAXABLE INCOME  TAXPAYER:   SE TAXABLE INCOME  SPOUSE:   TOTAL SELF  EMPLOYMENT TAX:   RETURN NOT PRESENT FOR THIS ACCOUNT  TRANSACTIONS   CODE EXPLANATION OF TRANSACTION CYCLE DATE AMOUNT  No tax return filed   766 Tax relief credit 06-15-2020 -$1,200.00  846 Refund issued 06-05-2020 $1,200.00  290 Additional tax assessed 20202205 06-15-2020 $0.00  76254-999-05099-0  971 Notice issued 06-15-2020 $0.00  766 Tax relief credit 01-18-2021 -$600.00  846 Refund issued 01-06-2021 $600.00  290 Additional tax assessed 20205302 01-18-2021 $0.00  76254-999-05055-0  663 Estimated tax payment 01-05-2021 -$9,000,000.00  662 Removed estimated tax payment 01-05-2021 $9,000,000.00  740 Undelivered refund returned to IRS 01-18-2021 -$600.00  767 Reduced or removed tax relief 01-18-2021 $600.00  credit  971 Notice issued 03-28-2022 $0.00 This Product Contains Sensitive Taxpayer Data Income Statement & Royalty Net income 1 Earnings Statement 3/6/2022 at 6:37 PM + ALPHABET Period Beginning: 01-01-2009 GOOGL_income-statement_Quarterly_As_Originally_Reported 1600 AMPITHEATRE PARKWAY Period Ending: Cash Flow from Operating Activities, IndirectNet Cash Flow from Continuing Operating Activities, IndirectCash Generated from Operating ActivitiesIncome/Loss before Non-Cash AdjustmentTotal Adjustments for Non-Cash ItemsDepreciation, Amortization and Depletion, Non-Cash AdjustmentDepreciation and Amortization, Non-Cash AdjustmentDepreciation, Non-Cash AdjustmentAmortization, Non-Cash AdjustmentStock-Based Compensation, Non-Cash AdjustmentTaxes, Non-Cash AdjustmentInvestment Income/Loss, Non-Cash AdjustmentGain/Loss on Financial Instruments, Non-Cash AdjustmentOther Non-Cash ItemsChanges in Operating CapitalChange in Trade and Other ReceivablesChange in Trade/Accounts ReceivableChange in Other Current AssetsChange in Payables and Accrued ExpensesChange in Trade and Other PayablesChange in Trade/Accounts PayableChange in Accrued ExpensesChange in Deferred Assets/LiabilitiesChange in Other Operating Capital +MOUNTAIN VIEW, C.A., 94043 Pay Date: Change in Prepayments and DepositsCash Flow from Investing ActivitiesCash Flow from Continuing Investing Activities Purchase/Sale and Disposal of Property, Plant and Equipment, NetPurchase of Property, Plant and EquipmentSale and Disposal of Property, Plant and EquipmentPurchase/Sale of Business, NetPurchase/Acquisition of BusinessPurchase/Sale of Investments, NetPurchase of Investments Taxable Marital Status ", Exemptions/Allowances.", Married ZACHRY T. Sale of InvestmentsOther Investing Cash FlowPurchase/Sale of Other Non-Current Assets, NetSales of Other Non-Current AssetsCash Flow from Financing ActivitiesCash Flow from Continuing Financing ActivitiesIssuance of/Payments for Common Stock, NetPayments for Common StockProceeds from Issuance of Common StockIssuance of/Repayments for Debt, NetIssuance of/Repayments for Long Term Debt, NetProceeds from Issuance of Long Term DebtRepayments for Long Term Debt + 5323 Proceeds from Issuance/Exercising of Stock Options/WarrantsOther Financing Cash FlowCash and Cash Equivalents, End of PeriodChange in CashEffect of Exchange Rate ChangesCash and Cash Equivalents, Beginning of PeriodCash Flow Supplemental SectionChange in Cash as Reported, SupplementalIncome Tax Paid, SupplementalZACHRY T WOODCash and Cash Equivalents, Beginning of PeriodDepartment of the TreasuryInternal Revenue Service +Federal: Calendar YearDue: 04/18/2022 DALLAS USD in ""000'""sRepayments for Long Term DebtCosts and expenses:Cost of revenuesResearch and developmentSales and marketingGeneral and administrativeEuropean Commission finesTotal costs and expensesIncome from operationsOther income (expense), netIncome before income taxesProvision for income taxesNet income*include interest paid, capital obligation, and underweighting +TX: NO State Income Tax Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) rate units year to date Benefits and Other Infotmation EPS 112 674,678,000 75698871600 Regular Pto Balance Total Work Hrs Gross Pay 75698871600 Important Notes COMPANY PH Y: 650-253-0000 Statutory BASIS OF PAY: BASIC/DILUTED EPS Federal Income Tax Social Security Tax + YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 112.20 PAR SHARE VALUE Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)*include interest paid, capital obligation, and underweighting +Medicare Tax Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) + Net Pay 70842743866.0000 70842,743,866.0000 CHECKING Net Check 70842743866 1 Earnings Statement ALPHABET Period Beginning: 1600 AMPITHEATRE PARKWAY DR Period Ending: MOUNTAIN VIEW, C.A., 94043 Pay Date: "Taxable Marital Status: + Exemptions/Allowances" Married ZACHRY T. 5323 Federal: DALLAS TX: NO State Income Tax rate units year to date Other Benefits and EPS 112 674,678,000 75698871600 Information Pto Balance Total Work Hrs Gross Pay 75698871600 Important Notes COMPANY PH Y: 650-253-0000 SIGNATURE Statutory BASIS OF PAY: BASIC/DILUTED EPS Federal Income Tax Social Security Tax YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 112.20 PAR SHARE VALUE Medicare Tax Net Pay 70,842,743,866 70,842,743,866 CHECKING Net Check 70842743866 Your federal taxable wages this period are $ Advice number: ALPHABET INCOME 1600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 Pay date: Deposited to the account Of xxxxxxxx6547 "PLEASE READ THE IMPORTANT DISCLOSURES BELOW
+FEDERAL RESERVE MASTER SUPPLIER ACCOUNT 31000053-052101023 633-44-1725 PNC Bank CIF Department (Online Banking) P7-PFSC-04-F 500 First Avenue Pittsburgh, PA 15219-3128 NON-NEGOTIABLE
+
+SIGNATURE Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value" NON-NEGOTIABLE EMPL 00650 ALPHABET ZACHRY T WOOD 5323 BRADFORD DR DALLAS TX 75235-8314 TTM Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020 Q3 2020 Q2 2020 Gross Profit 1.46698E+11 42337000000 37497000000 35653000000 31211000000 30818000000 25056000000 19744000000 Total Revenue as Reported, Supplemental 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 Other Revenue 257637118600 Cost of Revenue -1.10939E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000 Cost of Goods and Services -1.10939E+11 -32988000000 -27621000000 -26227000000 -24103000000 -26080000000 -21117000000 -18553000000 Operating Income/Expenses -67984000000 -20452000000 -16466000000 -16292000000 -14774000000 -15167000000 -13843000000 -13361000000 Selling, General and Administrative Expenses -36422000000 -11744000000 -8772000000 -8617000000 -7289000000 -8145000000 -6987000000 -6486000000 General and Administrative Expenses -13510000000 -4140000000 -3256000000 -3341000000 -2773000000 -2831000000 -2756000000 -2585000000 Selling and Marketing Expenses -22912000000 -7604000000 -5516000000 -5276000000 -4516000000 -5314000000 -4231000000 -3901000000 Research and Development Expenses -31562000000 -8708000000 -7694000000 -7675000000 -7485000000 -7022000000 -6856000000 -6875000000 Total Operating Profit/Loss 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 Non-Operating Income/Expenses, Total 12020000000 2517000000 2033000000 2624000000 4846000000 3038000000 2146000000 1894000000 Total Net Finance Income/Expense 1153000000 261000000 310000000 313000000 269000000 333000000 412000000 420000000 Net Interest Income/Expense 1153000000 261000000 310000000 313000000 269000000 333000000 412000000 420000000 Interest Expense Net of Capitalized Interest -346000000 -117000000 -77000000 -76000000 -76000000 -53000000 -48000000 -13000000 Interest Income 1499000000 378000000 387000000 389000000 345000000 386000000 460000000 433000000 Net Investment Income 12364000000 2364000000 2207000000 2924000000 4869000000 3530000000 1957000000 1696000000 Gain/Loss on Investments and Other Financial Instruments 12270000000 2478000000 2158000000 2883000000 4751000000 3262000000 2015000000 1842000000 Income from Associates, Joint Ventures and Other Participating Interests 334000000 49000000 188000000 92000000 5000000 355000000 26000000 -54000000 Gain/Loss on Foreign Exchange -240000000 -163000000 -139000000 -51000000 113000000 -87000000 -84000000 -92000000 Irregular Income/Expenses 0 0 0 0 0 Other Irregular Income/Expenses 0 0 0 0 0 Other Income/Expense, Non-Operating -1497000000 -108000000 -484000000 -613000000 -292000000 -825000000 -223000000 -222000000 Pretax Income 90734000000 24402000000 23064000000 21985000000 21283000000 18689000000 13359000000 8277000000 Provision for Income Tax -14701000000 -3760000000 -4128000000 -3460000000 -3353000000 -3462000000 -2112000000 -1318000000 Net Income from Continuing Operations 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 Net Income after Extraordinary Items and Discontinued Operations 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 Net Income after Non-Controlling/Minority Interests 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 Net Income Available to Common Stockholders 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 Diluted Net Income Available to Common Stockholders 76033000000 20642000000 18936000000 18525000000 17930000000 15227000000 11247000000 6959000000 Income Statement Supplemental Section Reported Normalized and Operating Income/Expense Supplemental Section Total Revenue as Reported, Supplemental 2.57637E+11 75325000000 65118000000 61880000000 55314000000 56898000000 46173000000 38297000000 Total Operating Profit/Loss as Reported, Supplemental 78714000000 21885000000 21031000000 19361000000 16437000000 15651000000 11213000000 6383000000 Reported Effective Tax Rate 0.162 0.179 0.157 0.158 0.158 0.159 Reported Normalized Income Reported Normalized Operating Profit Other Adjustments to Net Income Available to Common Stockholders Discontinued Operations Basic EPS 113.88 31.15 28.44 27.69 26.63 22.54 16.55 10.21 Basic EPS from Continuing Operations 113.88 31.12 28.44 27.69 26.63 22.46 16.55 10.21 Basic EPS from Discontinued Operations Diluted EPS 112.2 30.69 27.99 27.26 26.29 22.3 16.4 10.13 Diluted EPS from Continuing Operations 112.2 30.67 27.99 27.26 26.29 22.23 16.4 10.13 Diluted EPS from Discontinued Operations Basic Weighted Average Shares Outstanding 667650000 662664000 665758000 668958000 673220000 675581 24934000000 25539000000 37497000000 31211000000 30818000000 ZACHRY T WOOD Cash and Cash Equivalents, Beginning of Period Department of the Treasury Internal Revenue Service Calendar Year Due: 04/18/2022 USD in "000'"s Repayments for Long Term Debt Costs and expenses: Cost of revenues Research and development Sales and marketing General and administrative European Commission fines Total costs and expenses Income from operations Other income (expense), net Income before income taxes Provision for income taxes Net income *include interest paid, capital obligation, and underweighting Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) *include interest paid, capital obligation, and underweighting Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) INTERNAL REVENUE SERVICE, PO BOX 1214, CHARLOTTE, NC 28201-1214 ZACHRY WOOD 15 For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. Cat. No. 11320B Form 1040 (2021) Reported Normalized and Operating Income/Expense Supplemental Section Total Revenue as Reported, Supplemental Total Operating Profit/Loss as Reported, Supplemental Reported Effective Tax Rate Reported Normalized Income Reported Normalized Operating Profit Other Adjustments to Net Income Available to Common Stockholders Discontinued Operations Basic EPS Basic EPS from Continuing Operations Basic EPS from Discontinued Operations Diluted EPS Diluted EPS from Continuing Operations Diluted EPS from Discontinued Operations Basic Weighted Average Shares Outstanding Diluted Weighted Average Shares Outstanding Reported Normalized Diluted EPS Basic EPS Diluted EPS Basic WASO Diluted WASO Fiscal year end September 28th., 2022. | USD For Paperwork Reduction Act Notice, see the seperate Instructions. important information 2012201320142015ZACHRY.T.5323.DALLAS.Other.Benefits.and Information Pto Balance 9xygchr6$13Earnings Statement 065-0001 ALPHABET Period Beginning: 1600 AMPITHEATRE PARKWAY DRPeriod Ending: MOUNTAIN VIEW, C.A., 94043Pay Date: 2965 Taxable Marital Status: Exemptions/AllowancesMarried BRADFORD DR Federal: TX:NO State Income Tax rateunitsthis periodyear to date $0 1 Alphabet Inc., co. 1600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 Deposited to the account Of: ZACHRY T. WOOD 4720416547 650001 719218914/18/2022 4720416547 transit ABA 15-51\000 575A "
+Business Checking For 24-hour account information, sign on to pnc.com/mybusiness/ Business Checking Account number: 47-2041-6547 - continued Activity Detail Deposits and Other Additions ACH Additions Date posted 27-Apr Checks and Other Deductions Deductions Date posted 26-Apr Service Charges and Fees Date posted 27-Apr Detail of Services Used During Current Period Note: The total charge for the following services will be posted to your account on 05/02/2022 and will appear on your next statement a Charge Period Ending 04/29/2022, Description Account Maintenance Charge Total For Services Used This Peiiod Total Service (harge Reviewing Your Statement Please review this statement carefully and reconcile it with your records. Call the telephone number on the upper right side of the first page of this statement if: you have any questions regarding your account(s); your name or address is incorrect; • you have any questions regarding interest paid to an interest-bearing account. Balancing Your Account Update Your Account Register
+We will investigate your complaint and will correct any error promptly, If we take longer than 10 business days, we will provisionally credit your account for the amount you think is in error, so that you will have use of the money during the time it ekes us to complete our investigation. Member FDIC
+ZACHRY T WOOD Cash and Cash Equivalents, Beginning of Period Department of the Treasury Internal Revenue Service
+Calendar Year Due: 04/18/2022
+USD in "000'"s Repayments for Long Term Debt Costs and expenses: Cost of revenues Research and development Sales and marketing General and administrative European Commission fines Total costs and expenses Income from operations Other income (expense), net Income before income taxes Provision for income taxes Net income
+*include interest paid, capital obligation, and underweighting
+Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)
+Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) *include interest paid, capital obligation, and underweighting
+Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)
+INTERNAL REVENUE SERVICE, PO BOX 1214, CHARLOTTE, NC 28201-1214
+ZACHRY WOOD 15 For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions. Cat. No. 11320B Form 1040 (2021) Reported Normalized and Operating Income/Expense Supplemental Section Total Revenue as Reported, Supplemental Total Operating Profit/Loss as Reported, Supplemental Reported Effective Tax Rate Reported Normalized Income Reported Normalized Operating Profit Other Adjustments to Net Income Available to Common Stockholders Discontinued Operations Basic EPS Basic EPS from Continuing Operations Basic EPS from Discontinued Operations Diluted EPS Diluted EPS from Continuing Operations Diluted EPS from Discontinued Operations Basic Weighted Average Shares Outstanding Diluted Weighted Average Shares Outstanding Reported Normalized Diluted EPS Basic EPS Diluted EPS Basic WASO Diluted WASO Fiscal year end September 28th., 2022. | USD
+For Paperwork Reduction Act Notice, see the seperate Instructions.
+important information
+2012201320142015ZACHRY.T.5323.DALLAS.Other.Benefits.and Information Pto Balance 9xygchr6$13Earnings Statement 065-0001 ALPHABET Period Beginning: 1600 AMPITHEATRE PARKWAY DRPeriod Ending: MOUNTAIN VIEW, C.A., 94043Pay Date: 2965 Taxable Marital Status: Exemptions/AllowancesMarried BRADFORD DR Federal: TX:NO State Income Tax rateunitsthis periodyear to date $0 1 Alphabet Inc., co. 1600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 Deposited to the account Of: ZACHRY T. WOOD 4720416547 650001 719218914/18/2022 4720416547 transit ABA 15-51\000 575A " Business Checking For 24-hour account information, sign on to pnc.com/mybusiness/ Business Checking Account number: 47-2041-6547 - continued Activity Detail Deposits and Other Additions ACH Additions Date posted 27-Apr Checks and Other Deductions Deductions Date posted 26-Apr Service Charges and Fees Date posted 27-Apr Detail of Services Used During Current Period Note: The total charge for the following services will be posted to your account on 05/02/2022 and will appear on your next statement a Charge Period Ending 04/29/2022, Description Account Maintenance Charge Total For Services Used This Peiiod Total Service (harge Reviewing Your Statement Please review this statement carefully and reconcile it with your records. Call the telephone number on the upper right side of the first page of this statement if: you have any questions regarding your account(s); your name or address is incorrect; • you have any questions regarding interest paid to an interest-bearing account. Balancing Your Account Update Your Account Register We will investigate your complaint and will correct any error promptly, If we take longer than 10 business days, we will provisionally credit your account for the amount you think is in error, so that you will have use of the money during the time it ekes us to complete our investigation. Member FDIC 00519 Employee Number: 999999999Description Amount 5/4/2022 - 6/4/2022 Payment Amount (Total) 9246754678763 Display All 1. Social Security (Employee + Employer) 26662 2. Medicare (Employee + Employer) 861193422444 Hourly 3. Federal Income Tax 8385561229657 00000 Note: This report is generated based on the payroll data for your reference only. Please contact IRS office for special cases such as late payment, previous overpayment, penalty and others.Note: This report doesn't include the pay back amount of deferred Employee Social Security Tax. Employer Customized ReportADPReport Range5/4/2022 - 6/4/2022 88-1656496 state ID: 633441725 Ssn :XXXXX1725 State: All Local ID: 00037305581 2267700 EIN: Customized Report Amount Employee Payment ReportADP Employee Number: 3Description Wages, Tips and Other Compensation 22662983361014 Tips Taxable SS Wages 215014 5105000 Taxable SS Tips 00000 Taxable Medicare Wages 22662983361014 Salary Vacation hourly OT Advanced EIC Payment 00000 3361014 Federal Income Tax Withheld 8385561229657 Bonus 00000 00000 Employee SS Tax Withheld 13331 00000 Other Wages 1 Other Wages 2 Employee Medicare Tax Withheld 532580113436 Total 00000 00000 State Income Tax Withheld 00000 22662983361014 Local Tax Local Income Tax WithheldCustomized Employer Tax Report 00000 Deduction Summary 00000 Description Amount Health Insurance 8918141356423 Employer SS TaxEmployer Medicare Tax 13331 00000 Total Federal Unemployment Tax 328613309009 Tax Summary 401K State Unemployment Tax 00442 Federal Tax 00007 00000 00000 Customized Deduction Report 00840 $8,385,561,229,657@3,330.90 Health Insurance 00000 Advanced EIC Payment Social Security Tax Medicare Tax State Tax 532580113050 401K 00000 00000 8918141356423 Total 401K 00000 00000 ZACHRY T WOOD Social Security Tax Medicare Tax State Tax 532580113050 SHAREHOLDERS ARE URGED TO READ THE DEFINITIVE PROXY STATEMENT AND ANY OTHER RELEVANT MATERIALS THAT THE COMPANY WILL FILE WITH THE SEC CAREFULLY IN THEIR ENTIRETY WHEN THEY BECOME AVAILABLE. SUCH DOCUMENTS WILL CONTAIN IMPORTANT INFORMATION ABOUT THE COMPANY AND ITS DIRECTORS, OFFICERS AND AFFILIATES. INFORMATION REGARDING THE INTERESTS OF CERTAIN OF THE COMPANY’S DIRECTORS, OFFICERS AND AFFILIATES WILL BE AVAILABLE IN THE DEFINITIVE PROXY STATEMENT. The Definitive Proxy Statement and any other relevant materials that will be filed with the SEC will be available free of charge at the SEC’s website at www.sec.gov. In addition, the Definitive Proxy Statement (when available) and other relevant documents will also be available, without charge, by directing a request by mail to Attn: Investor Relations, Alphabet Inc., 1600 Amphitheatre Parkway, Mountain View, California, 94043 or by contacting investor-relations@abc.xyz. The Definitive Proxy Statement and other relevant documents will also be available on the Company’s Investor Relations website at https://abc.xyz/investor/other/annual-meeting/. The Company and its directors and certain of its executive officers may be consideredno participants in the solicitation of proxies with respect to the proposals under the Definitive Proxy Statement under the rules of the SEC. Additional information regarding the participants in the proxy solicitations and a description of their direct and indirect interests, by security holdings or otherwise, also will be included in the Definitive Proxy Statement and other relevant materials to be filed with the SEC when they become available. . 9246754678763 3/6/2022 at 6:37 PM Q4 2021 Q3 2021 Q2 2021 Q1 2021 Q4 2020 GOOGL_income-statement_Quarterly_As_Originally_Reported 24934000000 25539000000 37497000000 31211000000 30818000000 24934000000 25539000000 21890000000 19289000000 22677000000 Cash Flow from Operating Activities, Indirect 24934000000 25539000000 21890000000 19289000000 22677000000 Net Cash Flow from Continuing Operating Activities, Indirect 20642000000 18936000000 18525000000 17930000000 15227000000 Cash Generated from Operating Activities 6517000000 3797000000 4236000000 2592000000 5748000000 Income/Loss before Non-Cash Adjustment 3439000000 3304000000 2945000000 2753000000 3725000000 Total Adjustments for Non-Cash Items 3439000000 3304000000 2945000000 2753000000 3725000000 Depreciation, Amortization and Depletion, Non-Cash Adjustment 3215000000 3085000000 2730000000 2525000000 3539000000 Depreciation and Amortization, Non-Cash Adjustment 224000000 219000000 215000000 228000000 186000000 Depreciation, Non-Cash Adjustment 3954000000 3874000000 3803000000 3745000000 3223000000 Amortization, Non-Cash Adjustment 1616000000 -1287000000 379000000 1100000000 1670000000 Stock-Based Compensation, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000 Taxes, Non-Cash Adjustment -2478000000 -2158000000 -2883000000 -4751000000 -3262000000 Investment Income/Loss, Non-Cash Adjustment -14000000 64000000 -8000000 -255000000 392000000 Gain/Loss on Financial Instruments, Non-Cash Adjustment -2225000000 2806000000 -871000000 -1233000000 1702000000 Other Non-Cash Items -5819000000 -2409000000 -3661000000 2794000000 -5445000000 Changes in Operating Capital -5819000000 -2409000000 -3661000000 2794000000 -5445000000 Change in Trade and Other Receivables -399000000 -1255000000 -199000000 7000000 -738000000 Change in Trade/Accounts Receivable 6994000000 3157000000 4074000000 -4956000000 6938000000 Change in Other Current Assets 1157000000 238000000 -130000000 -982000000 963000000 Change in Payables and Accrued Expenses 1157000000 238000000 -130000000 -982000000 963000000 Change in Trade and Other Payables 5837000000 2919000000 4204000000 -3974000000 5975000000 Change in Trade/Accounts Payable 368000000 272000000 -3000000 137000000 207000000 Change in Accrued Expenses -3369000000 3041000000 -1082000000 785000000 740000000 Change in Deferred Assets/Liabilities Change in Other Operating Capital -11016000000 -10050000000 -9074000000 -5383000000 -7281000000 Change in Prepayments and Deposits -11016000000 -10050000000 -9074000000 -5383000000 -7281000000 Cash Flow from Investing Activities Cash Flow from Continuing Investing Activities -6383000000 -6819000000 -5496000000 -5942000000 -5479000000 -6383000000 -6819000000 -5496000000 -5942000000 -5479000000 Purchase/Sale and Disposal of Property, Plant and Equipment, Net Purchase of Property, Plant and Equipment -385000000 -259000000 -308000000 -1666000000 -370000000 Sale and Disposal of Property, Plant and Equipment -385000000 -259000000 -308000000 -1666000000 -370000000 Purchase/Sale of Business, Net -4348000000 -3360000000 -3293000000 2195000000 -1375000000 Purchase/Acquisition of Business -40860000000 -35153000000 -24949000000 -37072000000 -36955000000 Purchase/Sale of Investments, Net Purchase of Investments 36512000000 31793000000 21656000000 39267000000 35580000000 100000000 388000000 23000000 30000000 -57000000 Sale of Investments Other Investing Cash Flow -15254000000 Purchase/Sale of Other Non-Current Assets, Net -16511000000 -15254000000 -15991000000 -13606000000 -9270000000 Sales of Other Non-Current Assets -16511000000 -12610000000 -15991000000 -13606000000 -9270000000 Cash Flow from Financing Activities -13473000000 -12610000000 -12796000000 -11395000000 -7904000000 Cash Flow from Continuing Financing Activities 13473000000 -12796000000 -11395000000 -7904000000 Issuance of/Payments for Common 343 sec cvxvxvcclpddf wearsStock, Net -42000000 Payments for Common Stock 115000000 -42000000 -1042000000 -37000000 -57000000 Proceeds from Issuance of Common Stock 115000000 6350000000 -1042000000 -37000000 -57000000 Issuance of/Repayments for Debt, Net 6250000000 -6392000000 6699000000 900000000 00000 Issuance of/Repayments for Long Term Debt, Net 6365000000 -2602000000 -7741000000 -937000000 -57000000 Proceeds from Issuance of Long Term Debt Repayments for Long Term Debt 2923000000 -2453000000 -2184000000 -1647000000 Proceeds from Issuance/Exercising of Stock Options/Warrants 00000 300000000 10000000 338000000000 Other Financing Cash Flow Cash and Cash Equivalents, End of Period Change in Cash 20945000000 23719000000 23630000000 26622000000 26465000000 Effect of Exchange Rate Changes 25930000000) 235000000000 -3175000000 300000000 6126000000 Cash and Cash Equivalents, Beginning of Period PAGE="$USD(181000000000)".XLS BRIN="$USD(146000000000)".XLS 183000000 -143000000 210000000 Cash Flow Supplemental Section 23719000000000 26622000000000 26465000000000 20129000000000 Change in Cash as Reported, Supplemental 2774000000 89000000 -2992000000 6336000000 Income Tax Paid, Supplemental 13412000000 157000000 ZACHRY T WOOD -4990000000 Cash and Cash Equivalents, Beginning of Period Department of the Treasury Internal Revenue Service Q4 2020 Q4 2019 Calendar Year Due: 04/18/2022 Dec. 31, 2020 Dec. 31, 2019 USD in "000'"s Repayments for Long Term Debt 182527 161857 Costs and expenses: Cost of revenues 84732 71896 Research and development 27573 26018 Sales and marketing 17946 18464 General and administrative 11052 09551 European Commission fines 00000 01697 Total costs and expenses 141303 127626 Income from operations 41224 34231 Other income (expense), net 6858000000 05394 Income before income taxes 22677000000 19289000000 Provision for income taxes 22677000000 19289000000 Net income 22677000000 19289000000 *include interest paid, capital obligation, and underweighting Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) *include interest paid, capital obligation, and underweighting Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share) Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share) 20210418 Rate Units Total YTD Taxes / Deductions Current YTD - - 70842745000 70842745000 Federal Withholding 00000 188813800 FICA - Social Security 00000 853700 FICA - Medicare 00000 11816700 Employer Taxes FUTA 00000 00000 SUTA 00000 00000 EIN: 61-1767919 ID : 00037305581 SSN: 633441725 ATAA Payments 00000 102600 Gross 70842745000 Earnings Statement Taxes / Deductions Stub Number: 1 00000 Net Pay SSN Pay Schedule Pay Period Sep 28, 2022 to Sep 29, 2023 Pay Date 4/18/2022 70842745000 XXX-XX-1725 Annually CHECK NUMBER
+20210418 Rate Units Total YTD Taxes / Deductions Current YTD - - 70842745000 70842745000 Federal Withholding 00000 188813800 FICA - Social Security 00000 853700 FICA - Medicare 00000 11816700 Employer Taxes FUTA 00000 00000 SUTA 00000 00000
+																																																																										INTERNAL REVENUE SERVICE,															PO BOX 1214,															CHARLOTTE, NC 28201-1214																														ZACHRY WOOD															00015		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000			For Disclosure, Privacy Act, and Paperwork Reduction Act Notice, see separate instructions.		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000			Cat. No. 11320B		76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000			Form 1040 (2021)		76033000000	20642000000	18936000000											Reported Normalized and Operating Income/Expense Supplemental Section															Total Revenue as Reported, Supplemental		257637000000	75325000000	65118000000	61880000000	55314000000	56898000000	46173000000	38297000000	41159000000	46075000000	40499000000			Total Operating Profit/Loss as Reported, Supplemental		78714000000	21885000000	21031000000	19361000000	16437000000	15651000000	11213000000	6383000000	7977000000	9266000000	9177000000			Reported Effective Tax Rate		00000	00000	00000	00000	00000		00000	00000	00000		00000			Reported Normalized Income										6836000000					Reported Normalized Operating Profit										7977000000					Other Adjustments to Net Income Available to Common Stockholders															Discontinued Operations															Basic EPS		00114	00031	00028	00028	00027	00023	00017	00010	00010	00015	00010			Basic EPS from Continuing Operations		00114	00031	00028	00028	00027	00022	00017	00010	00010	00015	00010			Basic EPS from Discontinued Operations															Diluted EPS		00112	00031	00028	00027	00026	00022	00016	00010	00010	00015	00010			Diluted EPS from Continuing Operations		00112	00031	00028	00027	00026	00022	00016	00010	00010	00015	00010			Diluted EPS from Discontinued Operations															Basic Weighted Average Shares Outstanding		667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	686465000	688804000	692741000			Diluted Weighted Average Shares Outstanding		677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	692267000	695193000	698199000			Reported Normalized Diluted EPS										00010					Basic EPS		00114	00031	00028	00028	00027	00023	00017	00010	00010	00015	00010		00001	Diluted EPS		00112	00031	00028	00027	00026	00022	00016	00010	00010	00015	00010			Basic WASO		667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	686465000	688804000	692741000			Diluted WASO		677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	692267000	695193000	698199000			Fiscal year end September 28th., 2022. | USD															
+For Paperwork Reduction Act Notice, see the seperate Instructions. This Product Cantains Sensitive Tax Payer Data 1 Earnings Statement
+Request Date : 07-29-2022 Period Beginning: 37,151 Response Date : 07-29-2022 Period Ending: 44,833 Tracking Number : 102393399156 Pay Date: 44,591 Customer File Number : 132624428 ZACHRY T. WOOD 5,323 BRADFORD DR important information Wage and Income Transcript SSN Provided : XXX-XX-1725 DALLAS TX 75235-8314 Tax Periood Requested : December, 2020 units year to date Other Benefits and 674678000 75,698,871,600 Information Pto Balance Total Work Hrs Form W-2 Wage and Tax Statement Important Notes Employer : COMPANY PH Y: 650-253-0000 Employer Identification Number (EIN) :XXXXX7919 BASIS OF PAY: BASIC/DILUTED EPS INTU 2700 C Quarterly Report on Form 10-Q, as filed with the Commission on YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 3330.90 PAR SHARE VALUE Employee : Reciepient's Identification Number :xxx-xx-1725 ZACH T WOOD 5222 B on Form 8-K, as filed with the Commission on January 18, 2019). Submission Type : Original document Wages, Tips and Other Compensation : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 5105000.00 510500000 Advice number: 650,001Federal Income Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 1881380.00 188813800 Pay date: 44,669Social Security Wages : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 137700.00 13770000 Social Security Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 853700 xxxxxxxx6547 transit ABAMedicare Wages and Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 510500000 71,921,891Medicare Tax Withheld : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 118166700 NON-NEGOTIABLE Social Security Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Allocated Tips : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Dependent Care Benefits : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Deffered Compensation : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "Q" Nontaxable Combat Pay : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "W" Employer Contributions tp a Health Savings Account : . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "Y" Defferels under a section 409A nonqualified Deferred Compensation plan : . . . . . . . . . . . . . . . . . . 0 Code "Z" Income under section 409A on a nonqualified Deferred Compensation plan : . . . . . . . . . . . . . . . . . 0 Code "R" Employer's Contribution to MSA : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .' 0 Code "S" Employer's Cotribution to Simple Account : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "T" Expenses Incurred for Qualified Adoptions : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "V" Income from exercise of non-statutory stock options : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 0 Code "AA" Designated Roth Contributions under a Section 401 (k) Plan : . . . . . . . . . . . . . . . . . . . . 0 Code "BB" Designated Roth Contributions under a Section 403 (b) Plan : . . . . . . . . . . . . . . . . . . . . . 0 Code "DD" Cost of Employer-Sponsored Health Coverage : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Code "EE" Designated ROTH Contributions Under a Governmental Section 457 (b) Plan : . . . . . . . . . . . . . . . . . . . . . Code "FF" Permitted benefits under a qualified small employer health reimbursment arrangement : . . . . . . . . . 0 Code "GG" Income from Qualified Equity Grants Under Section 83 (i) : . . . . . . . . . . . . . . . . . . . . . . $0.00 Code "HH" Aggregate Defferals Under section 83(i) Elections as of the Close of the Calendar Year : . . . . . . . 0 Third Party Sick Pay Indicator : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Unanswered Retirement Plan Indicator : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Unanswered Statutory Employee : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Not Statutory Employee W2 Submission Type : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Original W2 WHC SSN Validation Code : . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Correct SSN The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above.
+EMPLOYER IDENTIFICATION NUMBER: 61-1767919 EIN 61-1767919 FEIN 88-1303491
+[DRAFT FORM OF TAX OPINION] ID: SSN: DOB: 37,305,581 633,441,725 34,622
+ALPHABET						Name	Tax Period 	Total	Social Security	Medicare	Withholding	ZACHRY T WOOD						Fed 941 Corporate	Sunday, September 30, 2007	66,987	28,841	6,745	31,400	5323 BRADFORD DR						Fed 941 West Subsidiary	Sunday, September 30, 2007	17,115	7,369	1,723	8,023	DALLAS TX 75235-8314						Fed 941 South Subsidiary	Sunday, September 30, 2007	23,906	10,293	2,407	11,206	ORIGINAL REPORT						Fed 941 East Subsidiary	Sunday, September 30, 2007	11,248	4,843	1,133	5,272	Income, Rents, & Royalty						Fed 941 Corp - Penalty	Sunday, September 30, 2007	27,199	11,710	2,739	12,749	INCOME STATEMENT 						Fed 940 Annual Unemp - Corp	Sunday, September 30, 2007	17,028			
+GOOGL_income-statement_Quarterly_As_Originally_Reported	TTM	Q4 2021	Q3 2021	Q2 2021	Q1 2021	Q4 2020	Q3 2020	Q2 2020	Q1 2020	Q4 2019	Q3 2019
+Gross Profit	146698000000	42337000000	37497000000	35653000000	31211000000	30,818,000,000	25,056,000,000	19,744,000,000	22,177,000,000	25,055,000,000	22,931,000,000	Total Revenue as Reported, Supplemental	257637000000	75325000000	65118000000	61880000000	55314000000	56,898,000,000	46,173,000,000	38,297,000,000	41,159,000,000	46,075,000,000	40,499,000,000		257637000000	75325000000	65118000000	61880000000	55314000000	56,898,000,000	46,173,000,000	38,297,000,000	41,159,000,000	64,133,000,000	34,071,000,000	Other Revenue											6,428,000,000	Cost of Revenue	110939000000	32988000000	27621000000	26227000000	24103000000	-26,080,000,000	-21,117,000,000	-18,553,000,000	-18,982,000,000	-21,020,000,000	-17,568,000,000	Cost of Goods and Services	110939000000	32988000000	27621000000	26227000000	24103000000	-26,080,000,000	-21,117,000,000	-18,553,000,000	-18,982,000,000	-21,020,000,000	-17,568,000,000	Operating Income/Expenses	67984000000	20452000000	16466000000	16292000000	14774000000	-15,167,000,000	-13,843,000,000	-13,361,000,000	-14,200,000,000	-15,789,000,000	-13,754,000,000	Selling, General and Administrative Expenses	36422000000	11744000000	8772000000	8617000000	7289000000	-8,145,000,000	-6,987,000,000	-6,486,000,000	-7,380,000,000	-8,567,000,000	-7,200,000,000	General and Administrative Expenses	13510000000	4140000000	3256000000	3341000000	2773000000	-2,831,000,000	-2,756,000,000	-2,585,000,000	-2,880,000,000	-2,829,000,000	-2,591,000,000	Selling and Marketing Expenses	22912000000	7604000000	5516000000	5276000000	4516000000	-5,314,000,000	-4,231,000,000	-3,901,000,000	-4,500,000,000	-5,738,000,000	-4,609,000,000	Research and Development Expenses	31562000000	8708000000	7694000000	7675000000	7485000000	-7,022,000,000	-6,856,000,000	-6,875,000,000	-6,820,000,000	-7,222,000,000	-6,554,000,000	Total Operating Profit/Loss	78714000000	21885000000	21031000000	19361000000	16437000000	15,651,000,000	11,213,000,000	6,383,000,000	7,977,000,000	9,266,000,000	9,177,000,000	Non-Operating Income/Expenses, Total	12020000000	2517000000	2033000000	2624000000	4846000000	3,038,000,000	2,146,000,000	1,894,000,000	-220,000,000	1,438,000,000	-549,000,000	Total Net Finance Income/Expense	1153000000	261000000	310000000	313000000	269000000	333,000,000	412,000,000	420,000,000	565,000,000	604,000,000	608,000,000	Net Interest Income/Expense	1153000000	261000000	310000000	313000000	269000000	333,000,000	412,000,000	420,000,000	565,000,000	604,000,000	608,000,000
+Interest Expense Net of Capitalized Interest	346000000	117000000	77000000	76000000	76000000	-53,000,000	-48,000,000	-13,000,000	-21,000,000	-17,000,000	-23,000,000	Interest Income	1499000000	378000000	387000000	389000000	345000000	386,000,000	460,000,000	433,000,000	586,000,000	621,000,000	631,000,000	Net Investment Income	12364000000	2364000000	2207000000	2924000000	4869000000	3,530,000,000	1,957,000,000	1,696,000,000	-809,000,000	899,000,000	-1,452,000,000	Gain/Loss on Investments and Other Financial Instruments	12270000000	2478000000	2158000000	2883000000	4751000000	3,262,000,000	2,015,000,000	1,842,000,000	-802,000,000	399,000,000	-1,479,000,000	Income from Associates, Joint Ventures and Other Participating Interests	334000000	49000000	188000000	92000000	5000000	355,000,000	26,000,000	-54,000,000	74,000,000	460,000,000	-14,000,000	Gain/Loss on Foreign Exchange	240000000	163000000	139000000	51000000	113000000	-87,000,000	-84,000,000	-92,000,000	-81,000,000	40,000,000	41,000,000	Irregular Income/Expenses	0	0				0	0	0	0	0	0	Other Irregular Income/Expenses	0	0				0	0	0	0	0	0	Other Income/Expense, Non-Operating	1497000000	108000000	484000000	613000000	292000000	-825,000,000	-223,000,000	-222,000,000	24,000,000	-65,000,000	295,000,000	Pretax Income	90734000000	24402000000	23064000000	21985000000	21283000000	18,689,000,000	13,359,000,000	8,277,000,000	7,757,000,000	10,704,000,000	8,628,000,000	Provision for Income Tax	14701000000	3760000000	4128000000	3460000000	3353000000	-3,462,000,000	-2,112,000,000	-1,318,000,000	-921,000,000	-33,000,000	-1,560,000,000	Net Income from Continuing Operations	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000	Net Income after Extraordinary Items and Discontinued Operations	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000	Net Income after Non-Controlling/Minority Interests	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000	Net Income Available to Common Stockholders	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000	Diluted Net Income Available to Common Stockholders	76033000000	20642000000	18936000000	18525000000	17930000000	15,227,000,000	11,247,000,000	6,959,000,000	6,836,000,000	10,671,000,000	7,068,000,000	Income Statement Supplemental Section												Reported Normalized and Operating Income/Expense Supplemental Section												Total Revenue as Reported, Supplemental	257637000000	75325000000	65118000000	61880000000	55314000000	56,898,000,000	46,173,000,000	38,297,000,000	41,159,000,000	46,075,000,000	40,499,000,000	Total Operating Profit/Loss as Reported, Supplemental	78714000000	21885000000	21031000000	19361000000	16437000000	15,651,000,000	11,213,000,000	6,383,000,000	7,977,000,000	9,266,000,000	9,177,000,000	Reported Effective Tax Rate	0		0	0	0		0	0	0		0	Reported Normalized Income									6,836,000,000			Reported Normalized Operating Profit									7,977,000,000			Other Adjustments to Net Income Available to Common Stockholders												Discontinued Operations												Basic EPS	333.90	31	28	28	27	23	17	10	10	15	10	Basic EPS from Continuing Operations	114	31	28	28	27	22	17	10	10	15	10	Basic EPS from Discontinued Operations												Diluted EPS	3330.90	31	28	27	26	22	16	10	10	15	10	Diluted EPS from Continuing Operations	3330.90	31	28	27	26	22	16	10	10	15	10	Diluted EPS from Discontinued Operations												Basic Weighted Average Shares Outstanding	667650000	662664000	665758000	668958000	673220000	675,581,000	679,449,000	681,768,000	686,465,000	688,804,000	692,741,000	Diluted Weighted Average Shares Outstanding	677674000	672493000	676519000	679612000	682071000	682,969,000	685,851,000	687,024,000	692,267,000	695,193,000	698,199,000	Reported Normalized Diluted EPS									10			Basic EPS	114	31	28	28	27	23	17	10	10	15	10	Diluted EPS	112	31	28	27	26	22	16	10	10	15	10	Basic WASO	667650000	662664000	665758000	668958000	673220000	675,581,000	679,449,000	681,768,000	686,465,000	688,804,000	692,741,000	Diluted WASO	677674000	672493000	676519000	679612000	682071000	682,969,000	685,851,000	687,024,000	692,267,000	695,193,000	698,199,000	Fiscal year end September 28th., 2022. | USD											
+31622,6:39 PM												Morningstar.com Intraday Fundamental Portfolio View Print Report								Print			
+3/6/2022 at 6:37 PM											Current Value												15,335,150,186,014
+GOOGL_income-statement_Quarterly_As_Originally_Reported		Q4 2021										Cash Flow from Operating Activities, Indirect		24934000000	Q3 2021	Q2 2021	Q1 2021	Q4 2020						Net Cash Flow from Continuing Operating Activities, Indirect		24934000000	25539000000	37497000000	31211000000	30,818,000,000						Cash Generated from Operating Activities		24934000000	25539000000	21890000000	19289000000	22,677,000,000						Income/Loss before Non-Cash Adjustment		20642000000	25539000000	21890000000	19289000000	22,677,000,000						Total Adjustments for Non-Cash Items		6517000000	18936000000	18525000000	17930000000	15,227,000,000						Depreciation, Amortization and Depletion, Non-Cash Adjustment		3439000000	3797000000	4236000000	2592000000	5,748,000,000						Depreciation and Amortization, Non-Cash Adjustment		3439000000	3304000000	2945000000	2753000000	3,725,000,000						Depreciation, Non-Cash Adjustment		3215000000	3304000000	2945000000	2753000000	3,725,000,000						Amortization, Non-Cash Adjustment		224000000	3085000000	2730000000	2525000000	3,539,000,000						Stock-Based Compensation, Non-Cash Adjustment		3954000000	219000000	215000000	228000000	186,000,000						Taxes, Non-Cash Adjustment		1616000000	3874000000	3803000000	3745000000	3,223,000,000						Investment Income/Loss, Non-Cash Adjustment		2478000000	1287000000	379000000	1100000000	1,670,000,000						Gain/Loss on Financial Instruments, Non-Cash Adjustment		2478000000	2158000000	2883000000	4751000000	-3,262,000,000						Other Non-Cash Items		14000000	2158000000	2883000000	4751000000	-3,262,000,000						Changes in Operating Capital		2225000000	64000000	8000000	255000000	392,000,000						Change in Trade and Other Receivables		5819000000	2806000000	871000000	1233000000	1,702,000,000						Change in Trade/Accounts Receivable		5819000000	2409000000	3661000000	2794000000	-5,445,000,000						Change in Other Current Assets		399000000	2409000000	3661000000	2794000000	-5,445,000,000						Change in Payables and Accrued Expenses		6994000000	1255000000	199000000	7000000	-738,000,000						Change in Trade and Other Payables		1157000000	3157000000	4074000000	4956000000	6,938,000,000						Change in Trade/Accounts Payable		1157000000	238000000	130000000	982000000	963,000,000						Change in Accrued Expenses		5837000000	238000000	130000000	982000000	963,000,000						Change in Deferred Assets/Liabilities		368000000	2919000000	4204000000	3974000000	5,975,000,000						Change in Other Operating Capital		3369000000	272000000	3000000	137000000	207,000,000						Change in Prepayments and Deposits			3041000000	1082000000	785000000	740,000,000						Cash Flow from Investing Activities		11016000000										Cash Flow from Continuing Investing Activities		11016000000	10050000000	9074000000	5383000000	-7,281,000,000						Purchase/Sale and Disposal of Property, Plant and Equipment, Net		6383000000	10050000000	9074000000	5383000000	-7,281,000,000						Purchase of Property, Plant and Equipment		6383000000	6819000000	5496000000	5942000000	-5,479,000,000						Sale and Disposal of Property, Plant and Equipment			6819000000	5496000000	5942000000	-5,479,000,000						Purchase/Sale of Business, Net		385000000										Purchase/Acquisition of Business		385000000	259000000	308000000	1666000000	-370,000,000						Purchase/Sale of Investments, Net		4348000000	259000000	308000000	1666000000	-370,000,000						Purchase of Investments		40860000000	3360000000	3293000000	2195000000	-1,375,000,000						Sale of Investments		36512000000	35153000000	24949000000	37072000000	-36,955,000,000						Other Investing Cash Flow		100000000	31793000000	21656000000	39267000000	35,580,000,000						Purchase/Sale of Other Non-Current Assets, Net			388000000	23000000	30000000	-57,000,000						Sales of Other Non-Current Assets												Cash Flow from Financing Activities		16511000000	15254000000									Cash Flow from Continuing Financing Activities		16511000000	15254000000	15991000000	13606000000	-9,270,000,000						Issuance of/Payments for Common Stock, Net		13473000000	12610000000	15991000000	13606000000	-9,270,000,000						Payments for Common Stock		13473000000	12610000000	12796000000	11395000000	-7,904,000,000						Proceeds from Issuance of Common Stock				12796000000	11395000000	-7,904,000,000						Issuance of/Repayments for Debt, Net		115000000	42000000									Issuance of/Repayments for Long Term Debt, Net		115000000	42000000	1042000000	37000000	-57,000,000						Proceeds from Issuance of Long Term Debt		6250000000	6350000000	1042000000	37000000	-57,000,000						Repayments for Long Term Debt		6365000000	6392000000	6699000000	900000000	0						Proceeds from Issuance/Exercising of Stock Options/Warrants		2923000000	2602000000	7741000000	937000000	-57,000,000										2453000000	2184000000	-1,647,000,000					
+Other Financing Cash Flow												Cash and Cash Equivalents, End of Period												Change in Cash		0		300000000	10000000	338,000,000,000						Effect of Exchange Rate Changes		20945000000	23719000000	23630000000	26622000000	26,465,000,000						Cash and Cash Equivalents, Beginning of Period		25930000000	235000000000	3175000000	300000000	6,126,000,000						Cash Flow Supplemental Section		181000000000	146000000000	183000000	143000000	210,000,000						Change in Cash as Reported, Supplemental		23719000000000	23630000000000	26622000000000	26465000000000	20,129,000,000,000						Income Tax Paid, Supplemental		2774000000	89000000	2992000000		6,336,000,000						Cash and Cash Equivalents, Beginning of Period		13412000000	157000000			-4,990,000,000					
+12 Months Ended												_________________________________________________________															Q4 2020			Q4 2019						Income Statement 												USD in "000'"s												Repayments for Long Term Debt			Dec. 31, 2020			Dec. 31, 2019						Costs and expenses:												Cost of revenues			182527			161,857						Research and development												Sales and marketing			84732			71,896						General and administrative			27573			26,018						European Commission fines			17946			18,464						Total costs and expenses			11052			9,551						Income from operations			0			1,697						Other income (expense), net			141303			127,626						Income before income taxes			41224			34,231						Provision for income taxes			6858000000			5,394						Net income			22677000000			19,289,000,000						*include interest paid, capital obligation, and underweighting			22677000000			19,289,000,000									22677000000			19,289,000,000						Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)--												Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)											
+For Paperwork Reduction Act Notice, see the seperate Instructions.												JPMORGAN TRUST III												A/R Aging Summary												As of July 28, 2022												ZACHRY T WOOD		Days over due										Effeective Tax Rate Prescribed by the Secretary of the Treasury.		44591	31 - 60	61 - 90	91 and over						
+TOTAL			 £134,839.00	 Alphabet Inc. 											
+ =USD('"'$'"'-in'-millions)"												 Ann. Rev. Date 	 £43,830.00 	 £43,465.00 	 £43,100.00 	 £42,735.00 	 £42,369.00 							 Revenues 	 £161,857.00 	 £136,819.00 	 £110,855.00 	 £90,272.00 	 £74,989.00 							 Cost of revenues 	-£71,896.00 	-£59,549.00 	-£45,583.00 	-£35,138.00 	-£28,164.00 							 Gross profit 	 £89,961.00 	 £77,270.00 	 £65,272.00 	 £55,134.00 	 £46,825.00 							 Research and development 	-£26,018.00 	-£21,419.00 	-£16,625.00 	-£13,948.00 	-£12,282.00 							 Sales and marketing 	-£18,464.00 	-£16,333.00 	-£12,893.00 	-£10,485.00 	-£9,047.00 							 General and administrative 	-£9,551.00 	-£8,126.00 	-£6,872.00 	-£6,985.00 	-£6,136.00 							 European Commission fines 	-£1,697.00 	-£5,071.00 	-£2,736.00 	 — 	 — 							 Income from operations 	 £34,231.00 	 £26,321.00 	 £26,146.00 	 £23,716.00 	 £19,360.00 							 Interest income 	 £2,427.00 	 £1,878.00 	 £1,312.00 	 £1,220.00 	 £999.00:
+STATE AND LOCAL GOVERNMENT SERIES: S000002965 07/30/2022
+NOTICE UNDER THE PAPERWORK REDUCTION ACT 
+Bureau of the Fiscal Service, 
+Forms Management Officer, Parkersburg, WV 26106-1328.
+FOR USE BY THE BUREAU OF THE FISCAL SERVICE
+E'-Customer ID Processed by /FS Form 4144
+Department of the Treasury | Bureau of the Fiscal Service Revised August 2018 Form Instructions
+Bureau of the Fiscal Service Special Investments Branch
+P.O. Box 396, Room 119 Parkersburg, WV 26102-0396
+Telephone Number: (304) 480-5299
+Fax Number: (304) 480-5277
+Internet Address: https://www.slgs.gov/ 
+E-Mail Address: SLGS@fiscal.treasury.gov Governing Regulations: 31 CFR Part 344 Please add the following information prior to mailing the form: • The name of the organization should be entered in the first paragraph. • If the user does not have an e-mail address, call SIB at 304-480-5299 for more information. • The user should sign and date the form. • If the access administrator or backup administrator also completes a user acknowledgment, both administrators should sign the 4144-5 Application for Internet Access. Regular Mail Address: Courier Service Address: Bureau of the Fiscal Service Special Investments Branch P.O. Box 396, Room 119 Parkersburg, WV 26102-0396 The Special Investments Branch (SIB) will only accept original signatures on this form. SIB will not accept faxed or emailed copies. Tax Periood Requested : December, 2020 Form W-2 Wage and Tax Statement Important Notes on Form 8-K, as filed with the Commission on January 18, 2019).  Request Date : 07-29-2022   Period Beginning: 37151  Response Date : 07-29-2022   Period Ending: 44833  Tracking Number : 102393399156   Pay Date: 44591  Customer File Number : 132624428   ZACHRY T. WOOD  5323 BRADFORD DR          important information Wage and Income TranscriptSSN Provided : XXX-XX-1725 DALLAS TX 75235-8314 dministrative Proceedings Securities & Exchanges (IRS USE ONLY)575A04-07-2022NASDB9999999999\\\DATEPAYEE NAMEPAYEE ADDRESSPAYORPAYOR ADDRESSPAYEE ROUTINGDEBIT/CREDITPAYEE ACCOUNTPAYOR ACCOUNTMASTER ACCOUNTDEPT ROUTING Total Paid by Supplier Demands. 4/7/2021Advances and Reimbursements, Judiciary Automation Fund, The Judiciary 2722 Arroyo Ave Dallas Tx 75219-1910 $22,677,000,000,000.00Based on facts as set forth in.65516550 The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above. EMPLOYER IDENTIFICATION NUMBER: 61-1767920[DRAFT FORM OF TAX OPINION]Chase GOOGL_income-statement_Quarterly_As_Originally_ReportedTTMQ4 2022Q3 2022Q2 2022Q1 2022Q4 2021Q3 2021Q2 2021Q3 2021Gross Profit-2178236364-9195472727-16212709091-23229945455-30247181818-37264418182-44281654545-5129889090937497000000Total Revenue as Reported, Supplemental-1286309091-13385163636-25484018182-37582872727-49681727273-61780581818-73879436364-85978290909651180000001957800000-9776581818-21510963636-33245345455-44979727273-56714109091-68448490909-8018287272765118000000Other RevenueCost of Revenue-891927272.7418969090992713090911435292727319434545455245161636362959778181834679400000-27621000000Cost of Goods and Services-891927272.7418969090992713090911435292727319434545455245161636362959778181834679400000-27621000000Operating Income/Expenses-3640563636-882445454.5187567272746337909097391909091101500272731290814545515666263636-16466000000Selling, General and Administrative Expenses-1552200000-28945454.55149430909130175636364540818182606407272775873272739110581818-8772000000Issuer: THEGeneral and Administrative Expenses-544945454.523200000591345454.511594909091727636364229578181828639272733432072727-3256000000101 EA 600 Coolidge Drive, Suite 300V Selling and Marketing Expenses-1007254545-52145454.55902963636.418580727272813181818376829090947234000005678509091-5516000000EmployerFolsom, CA 95630Research and Development Expenses-2088363636-853500000381363636.416162272732851090909408595454553208181826555681818-7694000000Employeer Identification Number (EIN) :XXXXX17256553Phone number: 888.901.9695Total Operating Profit/Loss-5818800000-10077918182-14337036364-18596154545-22855272727-27114390909-31373509091-3563262727321031000000\Fax number: 888.901.9695Non-Operating Income/Expenses, Total-1369181818-2079000000-2788818182-3498636364-4208454545-4918272727-5628090909-63379090912033000000Website: https://intuit.taxaudit.comTotal Net Finance Income/Expense464490909.1462390909.1460290909.1458190909.1456090909.1453990909.1451890909.1449790909.1310000000ZACHRY T WOODNet Interest Income/Expense464490909.1462390909.1460290909.1458190909.1456090909.1453990909.1451890909.1449790909.1310000000 5222 BRADFORD DR DALLAS TX 752350 ZACHRY T WOOD Interest Expense Net of Capitalized Interest48654545.456990000091145454.55112390909.1133636363.6154881818.2176127272.7197372727.3-77000000 5222 BRADFORD DR Interest Income415836363.6392490909.1369145454.5345800000322454545.5299109090.9275763636.4252418181.8387000000Other Benefits and Earning's Statement DALLAS TX 75235 0Net Investment Income-2096781818-2909109091-3721436364-4533763636-5346090909-6158418182-6970745455-77830727272207000000InformationRegularGain/Loss on Investments and Other Financial Instruments-2243490909-3068572727-3893654545-4718736364-5543818182-6368900000-7193981818-80190636362158000000Pto BalanceOvertime4Other Benefits and Earning's Statement Income from Associates, Joint Ventures and Other Participating Interests99054545.4592609090.9186163636.3679718181.8273272727.2766827272.7360381818.1853936363.64188000000Total Work Hrs Bonus Trainingyear to date37151InformationRegularGain/Loss on Foreign Exchange47654545.4566854545.4586054545.45105254545.5124454545.5143654545.5162854545.5182054545.5-139000000Important Notes Additions $22,756,988,716,000.00 Other Income/Expense, Non-Operating263109090.9367718181.8472327272.7576936363.6681545454.5786154545.5890763636.4995372727.3-484000000Submission Type . . . . . . . . . . . . . . . . . . . . . . . . . . . . Original documentPretax Income-7187981818-12156918182-17125854545-22094790909-27063727273-32032663636-37001600000-4197053636423064000000Wages, Tips and Other Compensation: . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .$22,756,988,716,000.00 _______________________________________________________________________________________________________________ Provision for Income Tax16952181822565754545343629090943068272735177363636604790000069184363647788972727-4128000000Social Security Wages . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .$22,756,988,716,000.00 YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM $22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' Reported Effective Tax Rate1.1620.14366666670.13316666670.12266666670.10633333330.086833333330.179Important NotesAdditions"+$$22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' Reported Normalized IncomeImportant NotesAdditions"+$$22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' Reported Normalized Operating ProfitImportant NotesAdditions"+$$22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' Other Adjustments to Net Income Available to Common StockholdersDiscontinued Operations[DRAFT FORM OF TAX OPINION]Fed 941 CorporateTax Period Ssn:DoB:Basic EPS-8.742909091-14.93854545-21.13418182-27.32981818-33.52545455-39.72109091-45.91672727-52.1123636428.44Fed 941 CorporateSunday, September 30, 2007Basic EPS from Continuing Operations-8.752545455-14.94781818-21.14309091-27.33836364-33.53363636-39.72890909-45.92418182-52.1194545528.44Fed 941 West SubsidiarySunday, September 30, 2007Basic EPS from Discontinued OperationsFed 941 South SubsidiarySunday, September 30, 200763344172534622Diluted EPS-8.505636364-14.599-20.69236364-26.78572727-32.87909091-38.97245455-45.06581818-51.1591818227.99Fed 941 East SubsidiarySunday, September 30, 2007Diluted EPS from Continuing Operations-8.515636364-14.609-20.70236364-26.79572727-32.88909091-38.98245455-45.07581818-51.1691818227.99Diluted EPS from Discontinued OperationsDALLAS, TX 75235 __________________________________________________ SIGNATURE Basic Weighted Average Shares Outstanding694313545.5697258863.6700204181.8703149500706094818.2709040136.4711985454.5714930772.7665758000SignificanceDiluted Weighted Average Shares Outstanding698675981.8701033009.1703390036.4705747063.6708104090.9710461118.2712818145.5715175172.7676519000 Authorized Signature Reported Normalized Diluted EPSZACHRY T WOODCertifying Officer.Basic EPS-8.742909091-14.93854545-21.13418182-27.32981818-33.52545455-39.72109091-45.91672727-52.1123636428.44 Authorized Signature Diluted EPS-8.505636364-14.599-20.69236364-26.78572727-32.87909091-38.97245455-45.06581818-51.1591818227.99Basic WASO694313545.5697258863.6700204181.8703149500706094818.2709040136.4711985454.5714930772.7665758000--Diluted WASO698675981.8701033009.1703390036.4705747063.6708104090.9710461118.2712818145.5715175172.7676519000Taxable Marital Status: Exemptions/AllowancesMarriedFiscal year end September 28th., 2022. | USD31622,6:39 PMrateunitsMorningstar.com Intraday Fundamental Portfolio View Print ReportPrintTX :383/6/2022 at 6:37 PMPayer's Federal Identificantion Number (FIN) :xxxxx7919112.2674678000THE PLEASE READ THE IMPORTANT DISCLOSURES BELOW 101 EAGOOGL_income-statement_Quarterly_As_Originally_ReportedQ4 2022EmployerCash Flow from Operating Activities, Indirect24934000001Q3 2022Q2 2022Q1 2022Q4 2021Q3 2021Reciepient's Social Security Number :xxx-xx-1725Net Cash Flow from Continuing Operating Activities, Indirect352318000003697580000038719800000404638000004220780000025539000000ZACH TCash Generated from Operating Activities196366000001856020000017483800000164074000001533100000025539000000WOOIncome/Loss before Non-Cash Adjustment2135340000021135400000209174000002069940000020481400000255390000005222 BTotal Adjustments for Non-Cash Items203512000002199260000023634000000252754000002691680000018936000000Depreciation, Amortization and Depletion, Non-Cash Adjustment498630000053276000005668900000601020000063515000003797000000Depreciation and Amortization, Non-Cash Adjustment323950000032416000003243700000324580000032479000003304000000ID:Ssn:DoB:Depreciation, Non-Cash Adjustment332910000033760000003422900000346980000035167000003304000000Amortization, Non-Cash Adjustment424160000048486000005455600000606260000066696000003085000000Stock-Based Compensation, Non-Cash Adjustment-1297700000-2050400000-2803100000-3555800000-43085000002190000003730558163344172534622Taxes, Non-Cash Adjustment417770000044862000004794700000510320000054117000003874000000Previous overpaymentInvestment Income/Loss, Non-Cash Adjustment30817000004150000000521830000062866000007354900000-12870000001000Gain/Loss on Financial Instruments, Non-Cash Adjustment-4354700000-4770800000-5186900000-5603000000-6019100000-2158000000Other Non-Cash Items-5340300000-6249200000-7158100000-8067000000-8975900000-2158000000Fed 941 CorporateTax Period TotalSocial SecurityMedicareWithholdingChanges in Operating Capital1068100000155960000020511000002542600000303410000064000000ZACHRY T WOODFed 941 CorporateSunday, September 30, 200725763711860066986.6628841.486745.1831400Change in Trade and Other Receivables2617900000371820000048185000005918800000701910000028060000005323 BRADFORD DRFed 941 West SubsidiarySunday, September 30, 200717115.417369.141723.428022.85Change in Trade/Accounts Receivable-1122700000-527600000675000006626000001257700000-2409000000DALLAS TX 75235-8314Fed 941 South SubsidiarySunday, September 30, 200723906.0910292.92407.2111205.98Change in Other Current Assets-3290700000-3779600000-4268500000-4757400000-5246300000-2409000000Income StatementFed 941 East SubsidiarySunday, September 30, 200711247.644842.741132.575272.33Change in Payables and Accrued Expenses-3298800000-4719000000-6139200000-7559400000-8979600000-1255000000Change in Trade and Other Payables310870000034536000003798500000414340000044883000003157000000Repayments for Long Term DebtDec. 31, 2020Dec. 31, 2019Change in Trade/Accounts Payable-233200000-394000000-554800000-715600000-876400000238000000Costs and expenses:Change in Accrued Expenses-2105200000-3202000000-4298800000-5395600000-6492400000238000000Cost of revenues182527161857Change in Deferred Assets/Liabilities319470000036268000004058900000449100000049231000002919000000Research and developmentChange in Other Operating Capital15539000002255600000295730000036590000004360700000272000000Sales and marketing8473271896Change in Prepayments and Deposits-388000000-891600000-1395200000-18988000003041000000General and administrative2757326018Cash Flow from Investing Activities-11015999999European Commission fines1794618464Cash Flow from Continuing Investing Activities-4919700000-3706000000-2492300000-1278600000-64900000-10050000000Total costs and expenses110529551Purchase/Sale and Disposal of Property, Plant and Equipment, Net-6772900000-6485800000-6198700000-5911600000-5624500000-10050000000Income from operations01697Purchase of Property, Plant and Equipment-5218300000-4949800000-4681300000-4412800000-4144300000-6819000000Other income (expense), net141303127626Sale and Disposal of Property, Plant and Equipment-5040500000-4683100000-4325700000-3968300000-6819000000Income before income taxes4122434231Purchase/Sale of Business, Net-384999999Provision for income taxes68580000005394Purchase/Acquisition of Business-1010700000-1148400000-1286100000-1423800000-1561500000-259000000Net income2267700000019289000000Purchase/Sale of Investments, Net5745000001229400000188430000025392000003194100000-259000000include interest paid, capital obligation, and underweighting2267700000019289000000Purchase of Investments1601890000024471400000329239000004137640000049828900000-3360000000Checking Account: 47-2041-6547Sale of Investments-64179300000-79064600000-93949900000-108835200000-123720500000-35153000000Other Investing Cash Flow492094000005705280000064896200000727396000008058300000031793000000 DALLAS TX 75235 8313 ZACHRY, TYLER, WOOD 4/18/2022 650-2530-000 Time Zone: Eastern Central Mountain Pacific | Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value | PLEASE READ THE IMPORTANT DISCLOSURES BELOW Bank PNC Bank Business Tax I.D. Number: 633441725 CIF Department (Online Banking) Checking Account: 47-2041-6547 P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation 500 First Avenue ALPHABET Pittsburgh, PA 15219-3128 5323 BRADFORD DR NON-NEGOTIABLE Purchase/Sale of Other Non-Current Assets, Net-236000000-368800000-501600000-634400000388000000 PLEASE READ THE IMPORTANT DISCLOSURES BELOW Bank PNC Bank Business Tax I.D. Number: 633441725 CIF Department (Online Banking) Checking Account: 47-2041-6547 P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation 500 First Avenue ALPHABET Pittsburgh, PA 15219-3128 5323 BRADFORD DR NON-NEGOTIABLE DALLAS TX 75235 8313 ZACHRY, TYLER, WOOD 4/18/2022 469-697-4300 __________________________________________________ SIGNATURE Time Zone: Eastern Central Mountain Pacific | Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value | Sales of Other Non-Current AssetsCash Flow from Financing Activities-13997000000-12740000000-15254000000Cash Flow from Continuing Financing Activities-9287400000-7674400000-6061400000-4448400000-2835400000-15254000000Issuance of/Payments for Common Stock, Net-10767000000-10026000000-9285000000-8544000000-7803000000-12610000000Payments for Common Stock-18708100000-22862000000-27015900000-31169800000-35323700000-12610000000Proceeds from Issuance of Common Stock-5806333333-3360333333-914333333.3Issuance of/Repayments for Debt, Net-199000000-356000000-42000000Issuance of/Repayments for Long Term Debt, Net-314300000-348200000-382100000-416000000-449900000-42000000Other Benefits andOther Benefits andOther Benefits and Other Benefits and Proceeds from Issuance of Long Term Debt-3407500000-5307600000-7207700000-9107800000-110079000006350000000InformationInformationInformationInformationRepayments for Long Term Debt-117000000-660800000-1204600000-1748400000-2292200000-6392000000Pto BalancePto BalancePto BalancePto BalanceProceeds from Issuance/Exercising of Stock Options/Warrants-2971300000-3400800000-3830300000-4259800000-4689300000-2602000000Total Work HrsTotal Work HrsTotal Work HrsTotal Work Hrs-1288666667-885666666.7-482666666.7Important NotesImportant NotesImportant NotesOther Financing Cash FlowCash and Cash Equivalents, End of PeriodRevenues£161,857.00£136,819.00£110,855.00£90,272.00£74,989.00Change in Cash1-280000000-570000000338000000000)Cost of revenues-£71,896.00-£59,549.00-£45,583.00-£35,138.00-£28,164.00Effect of Exchange Rate Changes284591000002985340000031247700000326420000003403630000023719000000Gross profit£89,961.00£77,270.00£65,272.00£55,134.00£46,825.00Cash and Cash Equivalents, Beginning of Period25930000001235000000000)103846666671503516666719685666667235000000000)Research and development-£26,018.00-£21,419.00-£16,625.00-£13,948.00-£12,282.00Cash Flow Supplemental Section181000000000)-146000000000)110333333.3123833333.3137333333.3-146000000000)Sales and marketing-£18,464.00-£16,333.00-£12,893.00-£10,485.00-£9,047.00Change in Cash as Reported, Supplemental228095000000002237500000000021940500000000215060000000002107150000000023630000000000General and administrative-£9,551.00-£8,126.00-£6,872.00-£6,985.00-£6,136.00Income Tax Paid, Supplemental-5809000000-8692000000-11575000000633600000189000000European Commission fines-£1,697.00-£5,071.00-£2,736.00——Cash and Cash Equivalents, Beginning of Period-13098000000-26353000000-4989999999157000000Income from operations£34,231.00£26,321.00£26,146.00£23,716.00£19,360.00Interest income£2,427.00£1,878.00£1,312.00£1,220.00£999.0013 Months EndedInterest expense-£100.00-£114.00-£109.00-£124.00-£104.00_________________________________________________________Foreign currency exchange gain£103.00-£80.00-£121.00-£475.00-£422.00Q4 2021Q4 2020Q4 2020Gain (loss) on debt securities£149.00£1,190.00-£110.00-£53.00—Income StatementGain (loss) on equity securities,£2,649.00£5,460.00£73.00-£20.00—USD in "000'"sPerformance fees-£326.00————Repayments for Long Term DebtDec. 31, 2021Dec. 31, 2020Dec. 31, 2020Gain(loss)£390.00-£120.00-£156.00-£202.00—Costs and expenses:Other£102.00£378.00£158.00£88.00-£182.00Cost of revenues182528161858182527Other income (expense), net£5,394.00£8,592.00£1,047.00£434.00£291.00Research and developmentIncome before income taxes£39,625.00£34,913.00£27,193.00£24,150.00£19,651.00Sales and marketing847337189784732Provision for income taxes-£3,269.00-£2,880.00-£2,302.00-£1,922.00-£1,621.00General and administrative275742601927573Net income£36,355.00-£32,669.00£25,611.00£22,198.00£18,030.00European Commission fines179471846517946Adjustment Payment to Class CTotal costs and expenses11053955211052Net. Ann. Rev.£36,355.00£32,669.00£25,611.00£22,198.00£18,030.00Income from operations116980Other income (expense), net141304127627141303 DALLAS TX 75235 8313 ZACHRY, TYLER, WOOD 4/18/2022 650-2530-000 Time Zone: Eastern Central Mountain Pacific | Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value | PLEASE READ THE IMPORTANT DISCLOSURES BELOW Bank PNC Bank Business Tax I.D. Number: 633441725 CIF Department (Online Banking) Checking Account: 47-2041-6547 P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation 500 First Avenue ALPHABET Pittsburgh, PA 15219-3128 5323 BRADFORD DR NON-NEGOTIABLE Income before income taxes412253423241224 PLEASE READ THE IMPORTANT DISCLOSURES BELOW Bank PNC Bank Business Tax I.D. Number: 633441725 CIF Department (Online Banking) Checking Account: 47-2041-6547 P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation 500 First Avenue ALPHABET Pittsburgh, PA 15219-3128 5323 BRADFORD DR NON-NEGOTIABLE DALLAS TX 75235 8313 ZACHRY, TYLER, WOOD 4/18/2022 469-697-4300 __________________________________________________ SIGNATURE Time Zone: Eastern Central Mountain Pacific | Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value | Provision for income taxes685800000153956858000000Net income226770000011928900000122677000000500 First AvenuePittsburgh, PA 15219-3128NON-NEGOTIABLEIssuer: THE101 EA 600 Coolidge Drive, Suite 300V EmployerFolsom, CA 95630Employeer Identification Number (EIN) :XXXXX17256553Phone number: 888.901.9695ZACH TDR\Fax number: 888.901.9695WOOWebsite: https://intuit.taxaudit.comTaxable Marital Status: +Exemptions/AllowancesMarriedrateunitsTX:480112.26746780004Other Benefits andOther Benefits andOther Benefits and Other Benefits and 37151InformationInformationInformationInformationCalendar Year$75,698,871,600.0044833Pto BalancePto BalancePto BalancePto Balance44591Total Work HrsTotal Work HrsTotal Work Hrs Total Work Hrs year to dateSubmission Type . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .Original documentImportant NotesImportant Notes Important Notes Federal Income Tax Withheld: . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .Wages, Tips and Other Compensation: . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .Social Security Wages . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .$70,842,743,866.00Medicare Wages, and Tips: . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .$70,842,743,866.00COMPANY PH Y: 650-253-0000State Income TaxNON-NEGOTIABLENet. 0.001 TO 112.20 PAR SHARE VALUE Tot$257,637,118,600.001600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043Other Benefits andOther Benefits andOther Benefits and Other Benefits and InformationInformationInformationInformationPto BalancePto BalancePto BalancePto BalanceStatement of Assets and Liabilities As of February 28, 2022Total Work HrsTotal Work HrsTotal Work Hrs Total Work Hrs Fiscal' year' s end | September 28th.Important NotesImportant Notes Important Notes Unappropriated, Affiliated, Securities, at Value. DALLAS TX 75235 8313 ZACHRY, TYLER, WOOD 4/18/2022 650-2530-000 Time Zone: Eastern Central Mountain Pacific | Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value | PLEASE READ THE IMPORTANT DISCLOSURES BELOW Bank PNC Bank Business Tax I.D. Number: 633441725 CIF Department (Online Banking) Checking Account: 47-2041-6547 P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation 500 First Avenue ALPHABET Pittsburgh, PA 15219-3128 5323 BRADFORD DR NON-NEGOTIABLE Important NotesAdditions"+$$22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' Important NotesAdditions"+$$22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' Important NotesAdditions"+$$22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' Important NotesAdditions"+$$22,756,988,716,000.00":,''Important NotesAdditions"+$$22,756,988,716,000.00":,''Important Notes Additions"+$$22,756,988,716,000.00":,'' [DRAFT FORM OF TAX OPINION]Fed 941 CorporateTax Period Ssn:DoB:Fed 941 CorporateSunday, September 30, 2007Fed 941 West SubsidiarySunday, September 30, 2007Fed 941 South SubsidiarySunday, September 30, 200763344172534622Fed 941 East SubsidiarySunday, September 30, 2007 DALLAS TX 75235 8313 ZACHRY, TYLER, WOOD 4/18/2022 650-2530-000 Time Zone: Eastern Central Mountain Pacific | Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value | PLEASE READ THE IMPORTANT DISCLOSURES BELOW Bank PNC Bank Business Tax I.D. Number: 633441725 CIF Department (Online Banking) Checking Account: 47-2041-6547 P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation 500 First Avenue ALPHABET Pittsburgh, PA 15219-3128 5323 BRADFORD DR NON-NEGOTIABLE PLEASE READ THE IMPORTANT DISCLOSURES BELOW Bank PNC Bank Business Tax I.D. Number: 633441725 CIF Department (Online Banking) Checking Account: 47-2041-6547 P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation 500 First Avenue ALPHABET Pittsburgh, PA 15219-3128 5323 BRADFORD DR NON-NEGOTIABLE DALLAS TX 75235 8313 ZACHRY, TYLER, WOOD 4/18/2022 469-697-4300 __________________________________________________ SIGNATURE Time Zone: Eastern Central Mountain Pacific | Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value | 61-176791988-1303491ID:Other Benefits andOther Benefits andOther Benefits and Other Benefits and InformationInformationInformationInformationPto BalancePto BalancePto BalancePto Balance37305581Total Work HrsTotal Work HrsTotal Work Hrs Total Work Hrs Important NotesImportant Notes Important Notes Wood., Zachry T. S.R.O.AchryTylerWood'@Administrator'@.it.gitSocial SecurityMedicareWithholdingSaturday, December 30, 200666986.6628841.486745.18Fed 941 West Subsidiary#ERROR!7369.141723.428022.85Fed 941 South Subsidiary23906.0910292.92407.2111205.98Fed 941 East Subsidiary11247.644842.741132.575272.33100031246.34Repayments for Long Term DebtDec. 31, 2020Dec. 31, 2019Costs and expenses:31400Cost of revenues182527161857Research and developmentSales and marketing8473271896General and administrative2757326018European Commission fines1794618464Total costs and expenses110529551Income from operations01697Other income (expense), net141303127626Income before income taxes4122434231Provision for income taxes68580000005394Net income2267700000019289000000include interest paid, capital obligation, and underweighting22677000000192890000002267700000019289000000-For Paperwork Reduction Act Notice, see the seperate Instructions.Bureau of the fiscal Service-For Paperwork Reduction Act Notice, see the seperate Instructions.Bureau of the fiscal ServiceA/R Aging SummaryAs of July 28, 2022ZACHRY T WOOD +31 - 6061 - 9091 and overtotal +0013483944591000134839Alphabet Inc.£134,839.00US$ in millionsAnn. Rev. Date£43,830.00£43,465.00£43,100.00£42,735.00£42,369.00Revenues£161,857.00£136,819.00£110,855.00£90,272.00£74,989.00Cost of revenues-£71,896.00-£59,549.00-£45,583.00-£35,138.00-£28,164.00Gross profit£89,961.00£77,270.00£65,272.00£55,134.00£46,825.00Research and development-£26,018.00-£21,419.00-£16,625.00-£13,948.00-£12,282.00Sales and marketing-£18,464.00-£16,333.00-£12,893.00-£10,485.00-£9,047.00General and administrative-£9,551.00-£8,126.00-£6,872.00-£6,985.00-£6,136.00European Commission fines-£1,697.00-£5,071.00-£2,736.00——Income from operations£34,231.00£26,321.00£26,146.00£23,716.00£19,360.00Interest income£2,427.00£1,878.00£1,312.00£1,220.00£999.00Interest expense-£100.00-£114.00-£109.00-£124.00-£104.00Foreign currency exchange gain£103.00-£80.00-£121.00-£475.00-£422.00Gain (loss) on debt securities£149.00£1,190.00-£110.00-£53.00—Gain (loss) on equity securities,£2,649.00£5,460.00£73.00-£20.00—Performance fees-£326.00————Gain(loss)£390.00-£120.00-£156.00-£202.00—Other£102.00£378.00£158.00£88.00-£182.00Other income (expense), net£5,394.00£8,592.00£1,047.00£434.00£291.00Income before income taxes£39,625.00£34,913.00£27,193.00£24,150.00£19,651.00Provision for income taxes-£3,269.00-£2,880.00-£2,302.00-£1,922.00-£1,621.00Net income£36,355.00-£32,669.00£25,611.00£22,198.00£18,030.00Adjustment Payment to Class CNet. Ann. Rev.£36,355.00£32,669.00£25,611.00£22,198.00£18,030.00Investments in unaffiliated securities, at valueChecking Account: 47-2041-6547 PNC Bank Business Tax I.D. Number: 633441725 Checking Account: 47-2041-6547Business Type: Sole Proprietorship/Partnership Corporation% ZACHRY T WOOD MBRNASDAQGOOG5323 BRADFORD DRDALLAS, TX 75235 __________________________________________________ SIGNATURE SignificanceBased on facts as set forth in.65516550 The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect. No opinion is expressed on any matters other than those specifically referred to above. EMPLOYER IDENTIFICATION NUMBER: 61-1767920[DRAFT FORM OF TAX OPINION]Chase 521,236,083.0026,000,000.00209,115,891.004,424,003.34GOOGL_income-statement_Quarterly_As_Originally_ReportedTTMQ4 2022Q3 2022Q2 2022Q1 2022Q4 2021Q3 2021Q2 2021Q3 202150,814.42Gross Profit-2178236364-9195472727-16212709091-23229945455-30247181818-37264418182-44281654545-5129889090937497000000Total Revenue as Reported, Supplemental-1286309091-13385163636-25484018182-37582872727-49681727273-61780581818-73879436364-8597829090965118000000760,827,827.351957800000-9776581818-21510963636-33245345455-44979727273-56714109091-68448490909-8018287272765118000000Other RevenueCost of Revenue-891927272.7418969090992713090911435292727319434545455245161636362959778181834679400000-27621000000Cost of Goods and Services-891927272.7418969090992713090911435292727319434545455245161636362959778181834679400000-27621000000Operating Income/Expenses-3640563636-882445454.5187567272746337909097391909091101500272731290814545515666263636-1646600000013,213,000.06Selling, General and Administrative Expenses-1552200000-28945454.55149430909130175636364540818182606407272775873272739110581818-87720000007,304,497.52General and Administrative Expenses-544945454.523200000591345454.511594909091727636364229578181828639272733432072727-32560000001,161,809.81Selling and Marketing Expenses-1007254545-52145454.55902963636.418580727272813181818376829090947234000005678509091-5:":,'
+      })
+      .map(([key, links]: any) => {
+        return {
+          label:
+            key === 'popular' || key === 'videos'
+              ? req.context.page.featuredLinks[key + 'Heading'] || req.context.site.data.ui.toc[key]
+              : req.context.site.data.ui.toc[key],
+          viewAllHref:
+            key === 'guides' && !req.context.currentCategory && hasGuidesPage
+              ? `${req.context.currentPath}/guides`
+              : '',
+          articles: links.map((link: any) => {
+            return {
+              hideIntro: key === 'popular',
+              href: link.href,
+              title: link.title,
+              intro: link.intro || null,
+              authors: link.page?.authors || [],
+              fullTitle: link.fullTitle || null,
+            }
+          }),
+        }
+      }),
+  }
+}
0 comments on commit cf493c9
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
Create codeql.yml · zakwarlord7/clerk.yml@cf493c9
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
																																						
#NAME?Runs::/:'::Run :'::run-on :'::On "::starts-on, "'Run":,''
++++ /dev/null        
 6,086  
.github/workflows/slash-command-dispatch.yml
Large diffs are not rendered by default.

 1,720  
README.md
Large diffs are not rendered by default.

 47  
bite.sig
@@ -0,0 +1,47 @@
# This workflow uses actions that are not certified by GitHub.
# They are provided by a third-party and are governed by
# separate terms of service, privacy policy, and support
# documentation.

# This workflow will install Deno then run `deno lint` and `deno test`.
# For more information see: https://github.com/denoland/setup-deno

name: Deno

on:
  push:
    branches: ["master"]
  pull_request:
    branches: ["master"]

permissions:
  contents: read

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Setup repo
        uses: actions/checkout@v3

      - name: Setup Deno
        # uses: denoland/setup-deno@v1
        uses: denoland/setup-deno@9db7f66e8e16b5699a514448ce994936c63f0d54
        with:
          deno-version: v1.x

      # Uncomment this step to verify the use of 'deno fmt' on each commit.
      # - name: Verify formatting
      #   run: deno fmt --check

      - name: Run linter
        run: deno lint
;Close ::
diff --git "a/EMPLOYEE PAYMENT REPORT ADP/CI/CLI/Federal 941/Deposit/Report/ADP/Report/Range/2022-05-04 - 2022-06-04/Local ID :TxDL :00037305581/Employer Identification Number (EIN) :63-3441725/State ID : SSN 633441725/\"Employee Numbeer :3  Description\"/Amount/Display/All/Payment/Amount/(Total)/$9246754678763.00/Display All/1. Social Security (Employee + Employer) $26661.80/2.Medicare (EMployee + Employer) Hourly $3855661229657.00Federal Income Tax $8385561229657.00/net, pay. $ 2266298000000800.00.ach.xls.xlsx.xls.pdf" "b/EMPLOYEE PAYMENT REPORT ADP/CI/CLI/Federal 941/Deposit/Report/ADP/Report/Range/2022-05-04 - 2022-06-04/Local ID :TxDL :00037305581/Employer Identification Number (EIN) :63-3441725/State ID : SSN 633441725/\"Employee Numbeer :3  Description\"/Amount/Display/All/Payment/Amount/(Total)/$9246754678763.00/Display All/1. Social Security (Employee + Employer) $26661.80/2.Medicare (EMployee + Employer) Hourly $3855661229657.00Federal Income Tax $8385561229657.00/net, pay. $ 2266298000000800.00.ach.xls.xlsx.xls.pdf"
index 5816d95..c0afda1 100644
Binary files "a/EMPLOYEE PAYMENT REPORT ADP/CI/CLI/Federal 941/Deposit/Report/ADP/Report/Range/2022-05-04 - 2022-06-04/Local ID :TxDL :00037305581/Employer Identification Number (EIN) :63-3441725/State ID : SSN 633441725/\"Employee Numbeer :3  Description\"/Amount/Display/All/Payment/Amount/(Total)/$9246754678763.00/Display All/1. Social Security (Employee + Employer) $26661.80/2.Medicare (EMployee + Employer) Hourly $3855661229657.00Federal Income Tax $8385561229657.00/net, pay. $ 2266298000000800.00.ach.xls.xlsx.xls.pdf" and "b/EMPLOYEE PAYMENT REPORT ADP/CI/CLI/Federal 941/Deposit/Report/ADP/Report/Range/2022-05-04 - 2022-06-04/Local ID :TxDL :00037305581/Employer Identification Number (EIN) :63-3441725/State ID : SSN 633441725/\"Employee Numbeer :3  Description\"/Amount/Display/All/Payment/Amount/(Total)/$9246754678763.00/Display All/1. Social Security (Employee + Employer) $26661.80/2.Medicare (EMployee + Employer) Hourly $3855661229657.00Federal Income Tax $8385561229657.00/net, pay. $ 2266298000000800.00.ach.xls.xlsx.xls.pdf" differ:Bu
ild::- name: Run tests
 run: deno test -Automates :AUTOMATE AUTOMATES ::Automatically-on :starts-on :Run::Runs::':Run::':Build:-and-::DEPLOYEE-frameowrks/windows-latest/pop-kernal/deployement/dispatch/install/framework/parameters-on :dipatch :=exit :== :':''
 ::Build::

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
Comparing master@{1day}...Base · zakwarlord7/User-bin-env-Bash
