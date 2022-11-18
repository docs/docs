# Welcome to GitHub docs contributing guide <!-- omit in toc -->

Thank you for investing your time in contributing to our project! Any contribution you make will be reflected on [docs.github.com](https://docs.github.com/en) :sparkles:. 

Read our [Code of Conduct](./CODE_OF_CONDUCT.md) to keep our community approachable and respectable.

In this guide you will get an overview of the contribution workflow from opening an issue, creating a PR, reviewing, and merging the PR.

Use the table of contents icon <img src="./assets/images/table-of-contents.png" width="25" height="25" /> on the top left corner of this document to get to a specific section of this guide quickly.

## New contributor guide

To get an overview of the project, read the [README](README.md). Here are some resources to help you get started with open source contributions:

- [Finding ways to contribute to open source on GitHub](https://docs.github.com/en/get-started/exploring-projects-on-github/finding-ways-to-contribute-to-open-source-on-github)
- [Set up Git](https://docs.github.com/en/get-started/quickstart/set-up-git)
- [GitHub flow](https://docs.github.com/en/get-started/quickstart/github-flow)
- [Collaborating with pull requests](https://docs.github.com/en/github/collaborating-with-pull-requests)


## Getting started

To navigate our codebase with confidence, see [the introduction to working in the docs repository](/contributing/working-in-docs-repository.md) :confetti_ball:. For more information on how we write our markdown files, see [the GitHub Markdown reference](contributing/content-markup-reference.md).

Check to see what [types of contributions](/contributing/types-of-contributions.md) we accept before making changes. Some of them don't even require writing a single line of code :sparkles:.

### Issues

#### Create a new issue

If you spot a problem with the docs, [search if an issue already exists](https://docs.github.com/en/github/searching-for-information-on-github/searching-on-github/searching-issues-and-pull-requests#search-by-the-title-body-or-comments). If a related issue doesn't exist, you can open a new issue using a relevant [issue form](https://github.com/github/docs/issues/new/choose). 

#### Solve an issue

Scan through our [existing issues](https://github.com/github/docs/issues) to find one that interests you. You can narrow down the search using `labels` as filters. See [Labels](/contributing/how-to-use-labels.md) for more information. As a general rule, we don’t assign issues to anyone. If you find an issue to work on, you are welcome to open a PR with a fix.

### Make Changes

#### Make changes in the UI

Click **Make a contribution** at the bottom of any docs page to make small changes such as a typo, sentence fix, or a broken link. This takes you to the `.md` file where you can make your changes and [create a pull request](#pull-request) for a review. 

 <img src="./assets/images/contribution_cta.png" width="300" height="150" /> 

#### Make changes in a codespace

For more information about using a codespace for working on GitHub documentation, see "[Working in a codespace](https://github.com/github/docs/blob/main/contributing/codespace.md)."

#### Make changes locally

1. [Install Git LFS](https://docs.github.com/en/github/managing-large-files/versioning-large-files/installing-git-large-file-storage).

2. Fork the repository.
- Using GitHub Desktop:
  - [Getting started with GitHub Desktop](https://docs.github.com/en/desktop/installing-and-configuring-github-desktop/getting-started-with-github-desktop) will guide you through setting up Desktop.
  - Once Desktop is set up, you can use it to [fork the repo](https://docs.github.com/en/desktop/contributing-and-collaborating-using-github-desktop/cloning-and-forking-repositories-from-github-desktop)!

- Using the command line:
  - [Fork the repo](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo#fork-an-example-repository) so that you can make your changes without affecting the original project until you're ready to merge them.

3. Install or update to **Node.js v16**. For more information, see [the development guide](contributing/development.md).

4. Create a working branch and start with your changes!

### Commit your update

Commit the changes once you are happy with them. Don't forget to [self-review](/contributing/self-review.md) to speed up the review process:zap:.

### Pull Request

When you're finished with the changes, create a pull request, also known as a PR.
- Fill the "Ready for review" template so that we can review your PR. This template helps reviewers understand your changes as well as the purpose of your pull request. 
- Don't forget to [link PR to issue](https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue) if you are solving one.
- Enable the checkbox to [allow maintainer edits](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/allowing-changes-to-a-pull-request-branch-created-from-a-fork) so the branch can be updated for a merge.
Once you submit your PR, a Docs team member will review your proposal. We may ask questions or request additional information.
- We may ask for changes to be made before a PR can be merged, either using [suggested changes](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/incorporating-feedback-in-your-pull-request) or pull request comments. You can apply suggested changes directly through the UI. You can make any other changes in your fork, then commit them to your branch.
- As you update your PR and apply changes, mark each conversation as [resolved](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/commenting-on-a-pull-request#resolving-conversations).
- If you run into any merge issues, checkout this [git tutorial](https://github.com/skills/resolve-merge-conflicts) to help you resolve merge conflicts and other issues.

### Your PR is merged!

Congratulations :tada::tada: The GitHub team thanks you :sparkles:. 

Once your PR is merged, your contributions will be publicly visible on the [GitHub docs](https://docs.github.com/en). 

Now that you are part of the GitHub docs community, see how else you can [contribute to the docs](/contributing/types-of-contributions.md).

## Windows

This site can be developed on Windows, however a few potential gotchas need to be kept in mind:

1. Regular Expressions: Windows uses `\r\n` for line endings, while Unix-based systems use `\n`. Therefore, when working on Regular Expressions, use `\r?\n` instead of `\n` in order to support both environments. The Node.js [`os.EOL`](https://nodejs.org/api/os.html#os_os_eol) property can be used to get an OS-specific end-of-line marker.
2. Paths: Windows systems use `\` for the path separator, which would be returned by `path.join` and others. You could use `path.posix`, `path.posix.join` etc and the [slash](https://ghub.io/slash) module, if you need forward slashes - like for constructing URLs - or ensure your code works with either.
3. Bash: Not every Windows developer has a terminal that fully supports Bash, so it's generally preferred to write [scripts](/script) in JavaScript instead of Bash.
4. Filename too long error: There is a 260 character limit for a filename when Git is compiled with `msys`. While the suggestions below are not guaranteed to work and could cause other issues, a few workarounds include:
    - Update Git configuration: `git config --system core.longpaths true`
    - Consider using a different Git client on Windows
Net Pay		70842743866		70842743866																																																																						
CHECKING				        																																																																						
Net Check		70842743866		        																																																																						
Your federal taxable wages this period are $																																																																										
ALPHABET INCOME								Advice number:			650001																																																															
1600 AMPIHTHEATRE  PARKWAY MOUNTAIN VIEW CA 94043								Pay date:			Monday, April 18, 2022																																																															
																																																																										
Deposited to the account Of: ZACHRY T. WOOD								xxxxxxxx6547			transit ABA			amount																																																												
PLEASE READ THE IMPORTANT DISCLOSURES BELOW		Bank																													PNC Bank Business Tax I.D. Number: 633441725				
CIF Department (Online Banking) Checking Account: 47-2041-6547
P7-PFSC-04-F Business Type: Sole Proprietorship/Partnership Corporation
500 First Avenue ALPHABET
Pittsburgh, PA 15219-3128 5323 BRADFORD DR
NON-NEGOTIABLE DALLAS TX 75235 8313
ZACHRY, TYLER, WOOD
4/18/2022 650-2530-000 469-697-4300
SIGNATURE Time Zone: Eastern Central Mountain Pacific
Investment Products • Not FDIC Insured • No Bank Guarantee • May Lose Value 71921891 70842743866
NON-NEGOTIABLE
PLEASE READ THE IMPORTANT DISCLOSURES BELOW

Based on facts as set forth in.			6550																																																																							
The U.S. Internal Revenue Code of 1986, as amended, the Treasury Regulations promulgated thereunder, published pronouncements of the Internal Revenue Service, which may be cited or used as precedents, and case law, any of which may be changed at any time with retroactive effect.  No opinion is expressed on any matters other than those specifically referred to above.																																																																										
																																																																										
EMPLOYER IDENTIFICATION NUMBER:       61-1767919					EIN	61-1767919																																																																				
					FIN	88-1303491																																																																				
																																																																										
						ID:		Ssn: 		DoB:  																																																																
						37305581		633441725		34622																																																																
																																																																										
												1																																																														
																																																																										
ALPHABET						Name	Tax Period 	Other Benefits and	Social Security	Medicare	Withholding																																																															
ZACHRY T WOOD						Fed 941 Corporate	Sunday, September 30, 2007	66987	28841	6745	31400																																																															
5323 BRADFORD DR						Fed 941 West Subsidiary	Sunday, September 30, 2007	17115	7369	1723	8023																																																															
DALLAS TX 75235-8314						Fed 941 South Subsidiary	Sunday, September 30, 2007	23906	10293	2407	11206																																																															
ORIGINAL REPORT						Fed 941 East Subsidiary	Sunday, September 30, 2007	11248	4843	1133	5272																																																															
Income, Rents, & Royalty						Fed 941 Corp - Penalty	Sunday, September 30, 2007	27199	11710	2739	12749																																																															
INCOME STATEMENT 						Fed 940 Annual Unemp - Corp	Sunday, September 30, 2007	17028																																																																		
																																																																										
GOOGL_income-statement_Quarterly_As_Originally_Reported	TTM	Q4 2021	Q3 2021	Q2 2021	Q1 2021	Q4 2020	Q3 2020	Q2 2020	Q1 2020	Q4 2019	Q3 2019																																																															
																																																																										
Gross Profit	146698000000	42337000000	37497000000	35653000000	31211000000	30818000000	25056000000	19744000000	22177000000	25055000000	22931000000																																																															
Total Revenue as Reported, Supplemental	257637000000	75325000000	65118000000	61880000000	55314000000	56898000000	46173000000	38297000000	41159000000	46075000000	40499000000																																																															
	257637000000	75325000000	65118000000	61880000000	55314000000	56898000000	46173000000	38297000000	41159000000	64133000000	34071000000																																																															
Other Revenue											6428000000																																																															
Cost of Revenue	-110939000000	-32988000000	-27621000000	-26227000000	-24103000000	-26080000000	-21117000000	-18553000000	-18982000000	-21020000000	-17568000000																																																															
Cost of Goods and Services	-110939000000	-32988000000	-27621000000	-26227000000	-24103000000	-26080000000	-21117000000	-18553000000	-18982000000	-21020000000	-17568000000																																																															
Operating Income/Expenses	-67984000000	-20452000000	-16466000000	-16292000000	-14774000000	-15167000000	-13843000000	-13361000000	-14200000000	-15789000000	-13754000000																																																															
Selling, General and Administrative Expenses	-36422000000	-11744000000	-8772000000	-8617000000	-7289000000	-8145000000	-6987000000	-6486000000	-7380000000	-8567000000	-7200000000																																																															
General and Administrative Expenses	-13510000000	-4140000000	-3256000000	-3341000000	-2773000000	-2831000000	-2756000000	-2585000000	-2880000000	-2829000000	-2591000000																																																															
Selling and Marketing Expenses	-22912000000	-7604000000	-5516000000	-5276000000	-4516000000	-5314000000	-4231000000	-3901000000	-4500000000	-5738000000	-4609000000																																																															
Research and Development Expenses	-31562000000	-8708000000	-7694000000	-7675000000	-7485000000	-7022000000	-6856000000	-6875000000	-6820000000	-7222000000	-6554000000																																																															
Total Operating Profit/Loss	78714000000	21885000000	21031000000	19361000000	16437000000	15651000000	11213000000	6383000000	7977000000	9266000000	9177000000																																																															
Non-Operating Income/Expenses, Total	12020000000	2517000000	2033000000	2624000000	4846000000	3038000000	2146000000	1894000000	-220000000	1438000000	-549000000																																																															
Total Net Finance Income/Expense	1153000000	261000000	310000000	313000000	269000000	333000000	412000000	420000000	565000000	604000000	608000000																																																															
Net Interest Income/Expense	1153000000	261000000	310000000	313000000	269000000	333000000	412000000	420000000	565000000	604000000	608000000																																																															
																																																																										
Interest Expense Net of Capitalized Interest	-346000000	-117000000	-77000000	-76000000	-76000000	-53000000	-48000000	-13000000	-21000000	-17000000	-23000000																																																															
Interest Income	1499000000	378000000	387000000	389000000	345000000	386000000	460000000	433000000	586000000	621000000	631000000																																																															
Net Investment Income	12364000000	2364000000	2207000000	2924000000	4869000000	3530000000	1957000000	1696000000	-809000000	899000000	-1452000000																																																															
Gain/Loss on Investments and Other Financial Instruments	12270000000	2478000000	2158000000	2883000000	4751000000	3262000000	2015000000	1842000000	-802000000	399000000	-1479000000																																																															
Income from Associates, Joint Ventures and Other Participating Interests	334000000	49000000	188000000	92000000	5000000	355000000	26000000	-54000000	74000000	460000000	-14000000																																																															
Gain/Loss on Foreign Exchange	-240000000	-163000000	-139000000	-51000000	113000000	-87000000	-84000000	-92000000	-81000000	40000000	41000000																																																															
Irregular Income/Expenses	0	0				0	0	0	0	0	0																																																															
Other Irregular Income/Expenses	0	0				0	0	0	0	0	0																																																															
Other Income/Expense, Non-Operating	-1497000000	-108000000	-484000000	-613000000	-292000000	-825000000	-223000000	-222000000	24000000	-65000000	295000000																																																															
Pretax Income	90734000000	24402000000	23064000000	21985000000	21283000000	18689000000	13359000000	8277000000	7757000000	10704000000	8628000000																																																															
Provision for Income Tax	-14701000000	-3760000000	-4128000000	-3460000000	-3353000000	-3462000000	-2112000000	-1318000000	-921000000	-33000000	-1560000000																																																															
Net Income from Continuing Operations	76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000																																																															
Net Income after Extraordinary Items and Discontinued Operations	76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000																																																															
Net Income after Non-Controlling/Minority Interests	76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000																																																															
Net Income Available to Common Stockholders	76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000																																																															
Diluted Net Income Available to Common Stockholders	76033000000	20642000000	18936000000	18525000000	17930000000	15227000000	11247000000	6959000000	6836000000	10671000000	7068000000																																																															
Income Statement Supplemental Section																																																																										
Reported Normalized and Operating Income/Expense Supplemental Section																																																																										
Total Revenue as Reported, Supplemental	257637000000	75325000000	65118000000	61880000000	55314000000	56898000000	46173000000	38297000000	41159000000	46075000000	40499000000																																																															
Total Operating Profit/Loss as Reported, Supplemental	78714000000	21885000000	21031000000	19361000000	16437000000	15651000000	11213000000	6383000000	7977000000	9266000000	9177000000																																																															
Reported Effective Tax Rate	0		0	0	0		0	0	0		0																																																															
Reported Normalized Income									6836000000																																																																	
Reported Normalized Operating Profit									7977000000																																																																	
Other Adjustments to Net Income Available to Common Stockholders																																																																										
Discontinued Operations																																																																										
Basic EPS	114	31	28	28	27	23	17	10	10	15	10																																																															
Basic EPS from Continuing Operations	114	31	28	28	27	22	17	10	10	15	10																																																															
Basic EPS from Discontinued Operations																																																																										
Diluted EPS	112	31	28	27	26	22	16	10	10	15	10																																																															
Diluted EPS from Continuing Operations	112	31	28	27	26	22	16	10	10	15	10																																																															
Diluted EPS from Discontinued Operations																																																																										
Basic Weighted Average Shares Outstanding	667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	686465000	688804000	692741000																																																															
Diluted Weighted Average Shares Outstanding	677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	692267000	695193000	698199000																																																															
Reported Normalized Diluted EPS									10																																																																	
Basic EPS	114	31	28	28	27	23	17	10	10	15	10																																																															
Diluted EPS	112	31	28	27	26	22	16	10	10	15	10																																																															
Basic WASO	667650000	662664000	665758000	668958000	673220000	675581000	679449000	681768000	686465000	688804000	692741000																																																															
Diluted WASO	677674000	672493000	676519000	679612000	682071000	682969000	685851000	687024000	692267000	695193000	698199000																																																															
Fiscal year end September 28th., 2022. | USD																																																																										
																																																																										
31622,6:39 PM																																																																										
Morningstar.com Intraday Fundamental Portfolio View Print Report								Print																																																																		
																																																																										
3/6/2022 at 6:37 PM											Current Value																																																															
											15335150186014																																																															
																																																																										
GOOGL_income-statement_Quarterly_As_Originally_Reported		Q4 2021																																																																								
Cash Flow from Operating Activities, Indirect		24934000000	Q3 2021	Q2 2021	Q1 2021	Q4 2020																																																																				
Net Cash Flow from Continuing Operating Activities, Indirect		24934000000	25539000000	37497000000	31211000000	30818000000																																																																				
Cash Generated from Operating Activities		24934000000	25539000000	21890000000	19289000000	22677000000																																																																				
Income/Loss before Non-Cash Adjustment		20642000000	25539000000	21890000000	19289000000	22677000000																																																																				
Total Adjustments for Non-Cash Items		6517000000	18936000000	18525000000	17930000000	15227000000																																																																				
Depreciation, Amortization and Depletion, Non-Cash Adjustment		3439000000	3797000000	4236000000	2592000000	5748000000																																																																				
Depreciation and Amortization, Non-Cash Adjustment		3439000000	3304000000	2945000000	2753000000	3725000000																																																																				
Depreciation, Non-Cash Adjustment		3215000000	3304000000	2945000000	2753000000	3725000000																																																																				
Amortization, Non-Cash Adjustment		224000000	3085000000	2730000000	2525000000	3539000000																																																																				
Stock-Based Compensation, Non-Cash Adjustment		3954000000	219000000	215000000	228000000	186000000																																																																				
Taxes, Non-Cash Adjustment		1616000000	3874000000	3803000000	3745000000	3223000000																																																																				
Investment Income/Loss, Non-Cash Adjustment		-2478000000	-1287000000	379000000	1100000000	1670000000																																																																				
Gain/Loss on Financial Instruments, Non-Cash Adjustment		-2478000000	-2158000000	-2883000000	-4751000000	-3262000000																																																																				
Other Non-Cash Items		-14000000	-2158000000	-2883000000	-4751000000	-3262000000																																																																				
Changes in Operating Capital		-2225000000	64000000	-8000000	-255000000	392000000																																																																				
Change in Trade and Other Receivables		-5819000000	2806000000	-871000000	-1233000000	1702000000																																																																				
Change in Trade/Accounts Receivable		-5819000000	-2409000000	-3661000000	2794000000	-5445000000																																																																				
Change in Other Current Assets		-399000000	-2409000000	-3661000000	2794000000	-5445000000																																																																				
Change in Payables and Accrued Expenses		6994000000	-1255000000	-199000000	7000000	-738000000																																																																				
Change in Trade and Other Payables		1157000000	3157000000	4074000000	-4956000000	6938000000																																																																				
Change in Trade/Accounts Payable		1157000000	238000000	-130000000	-982000000	963000000																																																																				
Change in Accrued Expenses		5837000000	238000000	-130000000	-982000000	963000000																																																																				
Change in Deferred Assets/Liabilities		368000000	2919000000	4204000000	-3974000000	5975000000																																																																				
Change in Other Operating Capital		-3369000000	272000000	-3000000	137000000	207000000																																																																				
Change in Prepayments and Deposits			3041000000	-1082000000	785000000	740000000																																																																				
Cash Flow from Investing Activities		-11016000000																																																																								
Cash Flow from Continuing Investing Activities		-11016000000	-10050000000	-9074000000	-5383000000	-7281000000																																																																				
Purchase/Sale and Disposal of Property, Plant and Equipment, Net		-6383000000	-10050000000	-9074000000	-5383000000	-7281000000																																																																				
Purchase of Property, Plant and Equipment		-6383000000	-6819000000	-5496000000	-5942000000	-5479000000																																																																				
Sale and Disposal of Property, Plant and Equipment			-6819000000	-5496000000	-5942000000	-5479000000																																																																				
Purchase/Sale of Business, Net		-385000000																																																																								
Purchase/Acquisition of Business		-385000000	-259000000	-308000000	-1666000000	-370000000																																																																				
Purchase/Sale of Investments, Net		-4348000000	-259000000	-308000000	-1666000000	-370000000																																																																				
Purchase of Investments		-40860000000	-3360000000	-3293000000	2195000000	-1375000000																																																																				
Sale of Investments		36512000000	-35153000000	-24949000000	-37072000000	-36955000000																																																																				
Other Investing Cash Flow		100000000	31793000000	21656000000	39267000000	35580000000																																																																				
Purchase/Sale of Other Non-Current Assets, Net			388000000	23000000	30000000	-57000000																																																																				
Sales of Other Non-Current Assets																																																																										
Cash Flow from Financing Activities		-16511000000	-15254000000																																																																							
Cash Flow from Continuing Financing Activities		-16511000000	-15254000000	-15991000000	-13606000000	-9270000000																																																																				
Issuance of/Payments for Common Stock, Net		-13473000000	-12610000000	-15991000000	-13606000000	-9270000000																																																																				
Payments for Common Stock		13473000000	-12610000000	-12796000000	-11395000000	-7904000000																																																																				
Proceeds from Issuance of Common Stock				-12796000000	-11395000000	-7904000000																																																																				
Issuance of/Repayments for Debt, Net		115000000	-42000000																																																																							
Issuance of/Repayments for Long Term Debt, Net		115000000	-42000000	-1042000000	-37000000	-57000000																																																																				
Proceeds from Issuance of Long Term Debt		6250000000	6350000000	-1042000000	-37000000	-57000000																																																																				
Repayments for Long Term Debt		6365000000	-6392000000	6699000000	900000000	0																																																																				
Proceeds from Issuance/Exercising of Stock Options/Warrants		2923000000	-2602000000	-7741000000	-937000000	-57000000																																																																				
				-2453000000	-2184000000	-1647000000																																																																				
																																																																										
Other Financing Cash Flow																																																																										
Cash and Cash Equivalents, End of Period																																																																										
Change in Cash		0		300000000	10000000	338000000000																																																																				
Effect of Exchange Rate Changes		20945000000	23719000000	23630000000	26622000000	26465000000																																																																				
Cash and Cash Equivalents, Beginning of Period		25930000000	235000000000	-3175000000	300000000	6126000000																																																																				
Cash Flow Supplemental Section		181000000000	-146000000000	183000000	-143000000	210000000																																																																				
Change in Cash as Reported, Supplemental		23719000000000	23630000000000	26622000000000	26465000000000	20129000000000																																																																				
Income Tax Paid, Supplemental		2774000000	89000000	-2992000000		6336000000																																																																				
Cash and Cash Equivalents, Beginning of Period		13412000000	157000000			-4990000000																																																																				
																																																																										
12 Months Ended																																																																										
_________________________________________________________																																																																										
			Q4 2020			Q4  2019																																																																				
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
*include interest paid, capital obligation, and underweighting			22677000000			19289000000																																																																				
			22677000000			19289000000																																																																				
Basic net income per share of Class A and B common stock and Class C capital stock (in dollars par share)																																																																										
Diluted net income per share of Class A and Class B common stock and Class C capital stock (in dollars par share)																																																																										
																																																																										
																																																																										
For Paperwork Reduction Act Notice, see the seperate Instructions.																																																																										
JPMORGAN TRUST III																																																																										
A/R Aging Summary																																																																										
As of July 28, 2022																																																																										
ZACHRY T WOOD
		Interest Rate, as prescribed by The Secretary of The Treasury.																																																																							
Effeective Tax Rate Prescribed by the Secretary of the Treasury.		44591	31 - 60	61 - 90	91 and over	Total																																																																				

0					0																																																																				
TOTAL	134839	0	0	0	0	134839																																																																				
 Alphabet Inc.  																																																																										
 P
				 £134,839.00 																																																																					
																																																																										
 US$ in millions 																																																																										
 Ann. Rev. Date 	 £43,830.00 	 £43,465.00 	 £43,100.00 	 £42,735.00 	 £42,369.00 																																																																					
 Revenues 	 £161,857.00 	 £136,819.00 	 £110,855.00 	 £90,272.00 	 £74,989.00 																																																																					
 Cost of revenues 	-£71,896.00 	-£59,549.00 	-£45,583.00 	-£35,138.00 	-£28,164.00 																																																																					
 Gross profit 	 £89,961.00 	 £77,270.00 	 £65,272.00 	 £55,134.00 	 £46,825.00
 :Build::
 :Run|'Run ''
