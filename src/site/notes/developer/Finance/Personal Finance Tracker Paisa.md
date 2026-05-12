---
{"dg-publish":true,"tags":["finance","selfhosted","plaintext"],"permalink":"/developer/finance/personal-finance-tracker-paisa/","dgPassFrontmatter":true}
---

## Ledger Paisa
Tracking all financial assets with https://paisa.fyi/ like a coder.

Store and edit your finances in #plaintext !!!! View them with highly available graphs and charts in a browser. 
### Importing Data
I've tried other financial trackers (like [Firefly-iii](https://www.firefly-iii.org/)) but found it's many menus a bit clunky and breaking updates very frustrating. Even with a small bit of coding knowledge and working with templating languages like [Handlebars](https://handlebarsjs.com/) will take you much further and faster.

It's importing tool has a powerful `predictAccount` that can take from previous ledger items and fill in certain source and destinations such as

- Accounts
- Expenses
- Liabilities
- Equity

The problem being, you need to have something in your ledger for it to learn from
## Lots of if else statements
#todo 
- [ ] show how i scrape CSV data from HTML tables

I started with a handful of statements (exported as csv) that spanned 3 years. To comb through this quickly and get `predictAccount` working it's magic, start with a years worth (or about 100 transaction lines).

### Import Template

http://localhost:7500/ledger/import

Here is the import template used for my Chase Checking Account CSV. It's big and ugly. Don't worry I'll break down the important parts.

```js
{{!-- checking date ignores headers or incomplete rows --}}

{{#if (isDate ROW.B "M/D/YYYY")}}
  {{!-- Create DESCRIPTION variable with cleaned whitespace --}}
  {{#with (replace (replace (replace (replace (trim ROW.C) "    " " ") "   " " ") "  " " ") "  " " ") as |DESCRIPTION|}}
    {{date ../ROW.B "M/D/YYYY"}} {{DESCRIPTION}}
    {{#if (eq (trim ../ROW.A) "DEBIT")}}
      Assets:Checking:Chase                                     {{../ROW.D}} USD
      {{!-- Check if Investment --}}
      {{#if (regexpTest DESCRIPTION "(Stock Trading|Retirement Contribution)")}}
  		{{predictAccount prefix="Assets:Investments"}}   
      {{!-- Check if Liability --}}
      {{else if (regexpTest DESCRIPTION "(BARCLAYCARD|AMERICAN EXPRESS)")}}
  		{{predictAccount prefix="Liabilities:CreditCard"}}      	 {{negate ../ROW.D}} USD
      {{!-- Check if it's a PayPal transaction --}}
      {{else if (regexpTest DESCRIPTION "PAYPAL")}}
        {{!-- Extract the merchant name between "XFER" and "WEB" --}}
        Expenses:PayPal:{{replace (replace (trim (regexpMatch DESCRIPTION "XFER(.+?)WEB" group=1)) " " "_") "__" "_"}}  {{negate ../ROW.D}} USD
      {{else if (regexpTest DESCRIPTION "ATM WITHDRAWAL")}}
        Assets:Cash                     		 	     {{negate ../ROW.D}} USD
      {{else}}
        {{!-- non-PayPal transactions, use prediction --}}
        {{predictAccount DESCRIPTION prefix="Expenses"}} {{negate ../ROW.D}} USD
      {{/if}}
    {{else if (eq (trim ../ROW.A) "CREDIT")}}
      {{!-- Reimbersments --}}
      {{#if (regexpTest DESCRIPTION "Zelle payment from (BILLY BOB|OTHER ROOMMATE)")}}
    	  {{predictAccount DESCRIPTION prefix="Expenses"}}   {{negate ../ROW.D}} USD
      {{else}}
        {{predictAccount DESCRIPTION prefix="Income"}}     	 {{negate ../ROW.D}} USD
      {{/if}}
      Assets:Checking:Chase                           		    	{{../ROW.D}} USD
    {{else if (eq (trim ../ROW.A) "DSLIP")}}
      Income:CheckDeposit:Unknown   					 	 {{negate ../ROW.D}} USD
      Assets:Checking:Chase                           		        {{../ROW.D}} USD
    {{else if (eq (trim ../ROW.A) "EQUITY")}}
      Equity:OpeningBalance    					 		 	 {{negate ../ROW.D}} USD
      Assets:Checking:Chase                           		    	{{../ROW.D}} USD
    {{else}}
      --- Transaction not supported ---
    {{/if}}
  {{/with}}
{{/if}}
{{!-- immediatly spend cash (for poorly tracked Assets:Cash) --}}
{{#if (isDate ROW.B "M/D/YYYY")}}
{{#if (regexpTest ROW.C "ATM WITHDRAWAL")}}

{{date ROW.B "M/D/YYYY"}} SPENT {{replace (replace (replace (replace ROW.C "    " " ") "   " " ") "  " " ") "  " " "}}
  	Assets:Cash                     		 	{{ROW.D}} USD
    Expenses:Cash:Untracked              {{negate ROW.D}} USD
  {{/if}}
{{/if}}
```

### DEBIT Investments
These are any contributions you'd make to a stock, retirement fund, etc. Money that is not leaving your wallet, but changing accounts.

the `"(Stock Trading|Retirement Contribution)"` is an or statement. It looks at the `DESCRIPTION` to see if there is a `Stock Trading` or `Retirement Contribution` string match. If so it sets the account type to `Assets:Investments` and predicts the rest.

```js
{{!-- Check if Investment --}}
      {{#if (regexpTest DESCRIPTION "(Stock Trading|Retirement Contribution)")}}
  		{{predictAccount prefix="Assets:Investments"}}
```
### DEBIT Liabilities
Using the same logic above, I use search terms for credit card company names and label them as Liabilities. 

It searches the description for a match of `BARCLAYCARD` or `AMERICAN EXPRESS` and gives it a account prefix of `Liabilities:CreditCard`. `predictAccount` will handle the rest. 

```js
{{!-- Check if Liability --}}
      {{else if (regexpTest DESCRIPTION "(BARCLAYCARD|AMERICAN EXPRESS)")}}
  		{{predictAccount prefix="Liabilities:CreditCard"}}      	 {{negate ../ROW.D}} USD
```

#### Organizing Paypal transactions
Paypal is a special one because Paypal is usually the middle man between an Asset account and another business. For now we are just getting some basic category and tags in that we can later make better.

Here this line extracts the text between `"XFER"` and `"WEB"`. Common description prefix and suffix given to Paypal transactions.

```js
...
{{!-- Check if it's a PayPal transaction --}}
      {{else if (regexpTest DESCRIPTION "PAYPAL")}}
        {{!-- Extract the merchant name between "XFER" and "WEB" --}}
        Expenses:PayPal:{{replace (replace (trim (regexpMatch DESCRIPTION "XFER(.+?)WEB" group=1)) " " "_") "__" "_"}}  {{negate ../ROW.D}} USD
...
```

Then I add the prefix `Expenses:PayPal:` and append the shortened regex'd `DESCRIPTION`.  A very common one looking like 

```txt
Expenses:PayPal:Ebay
```

> [!note] don't forget to save the import template file!
> We will name it "Chase Checking Importer" for this example.

##### Paypal Updates

Not every PayPal description has the merchant name between "XFER" and "WEB" but it gets most of them. As the `predictAccount` becomes smarter, we will update the paypal line to replace the `regexpMatch`. This will removes the regex match pattern and uses the predict instead.

```js
{{else if (regexpTest DESCRIPTION "PAYPAL")}}
		{{predictAccount prefix="Expenses:PayPal"}}  {{negate ../ROW.D}} USD
```
### Save it
Export the ledger. Give it a descriptive name like `checking-2025-debug-v1.ledger`. Don't forget to add it to the `main.ledger`so that the app ingests the file.

http://ice.lan:7500/ledger/editor/main.ledger

```ledger
checking-2025-debug-v1.ledger
```

> [!tip] It's ok if it's not perfect
> There will be plenty of `Unknown` lines. This is ok. We will need to do a bit of manual editing to define our Categories and Companies

## Manual Edits
Go to http://localhost:7500/ledger/editor/checking-2025-debug-v1.ledger and comb through and fix as many lines as you see fit. Here is a small example of various edits I had to do that incorporated

```ledger
2025/12/29 Zelle payment from ROOMATE H50272155172
    Expenses:Rent:Appartment305                 -550 USD
    Assets:Checking:Chase                     550.00 USD

2025/12/26 PAYPAL INST XFER GOOGLE YOUTUBE WEB ID: PAYPALSI77
    Assets:Checking:Chase                      -6.99 USD
    Expenses:PayPal:GOOGLE_YOUTUBE              6.99 USD

2025/12/22 PAYPAL INST XFER HAYWYRETOUR WEB ID: PAYPALSI77
    Assets:Checking:Chase                     -15.00 USD
    Expenses:PayPal:HAYWYRETOUR                   15 USD

2025/12/19 FULL_TIME_JOB
    Income:Salary:FULL_TIME_JOB  -1424.85 USD
    Assets:Checking:Chase                     424.85 USD

2025/12/17 AMERICAN EXPRESS ACH PMT 
    Assets:Checking:Chase                    -679.81 USD
    Liabilities:CreditCard:AMEXBLUE           679.81 USD

2025/12/16 State Retirment Fund
    Assets:Checking:Chase                     -10.00 USD
    Assets:Investments:StateRetirmentFund         10 USD

2025/12/11 PAYPAL INST XFER BANDCAMP WEB ID: PAYPALSI77
    Assets:Checking:Chase                      -7.00 USD
    Expenses:PayPal:BANDCAMP                       7 USD
```
### Rerun
Head back to http://localhost:7500/ledger/import and select your saved template "Chase Checking Importer" and repeat the process. This time we can save the new ledger as `checking-2025-debug-v2.ledger`. 

> [!note] remember to replace it in the `main.ledger`

You can continue this process of 
1. tweaking importer config http://localhost:7500/ledger/import
2. importing .csv as .ledger
3. updating `main.ledger`

This will continue to make the `predictAccount` more accurate and descriptive.

#todo 
- [ ] Set tax payment and tax refund appropriately [claude chat](https://claude.ai/chat/1ca6adef-3767-422c-bee9-cd6f5945912a)

## handle paying tax and tax return
```txt
{{else if (regexpTest DESCRIPTION "IRS.*TREAS.*TAX REF")}}
  Expenses:Taxes:Federal                               {{negate ../ROW.D}} USD
```

This makes your tax expense show the **net amount** you paid (taxes paid minus refund).

**Example:**
```
// Tax payment (from paycheck withholding throughout year)
2025/04/15 Federal Tax Payment
    Expenses:Taxes:Federal                          5000 USD
    Assets:Checking:Chase                          -5000 USD

// Refund
2025/10/16 IRS TREAS 310 TAX REF PPD ID: 9111036170
    Expenses:Taxes:Federal                          -729 USD  ← Reduces tax expense
    Assets:Checking:Chase                            729 USD

// Net result: Expenses:Taxes:Federal = 4271 USD (actual taxes paid)
```

## Sanity Check - How to Double the import balance
1. Go to postings http://ice.lan:7500/ledger/posting
2. filter for account `account = assets:checking:chase`
3. view `Balance` on far right column to match up with Ending balance on the `.csv`
4. If the numbers don't match, follow back further into past to see where the numbers fall out of sync.

## Find and replace quickly
fix and categories in bulk with the built in [editor](http://localhost:7500/ledger/editor)

- find `^(\d{4}/\d{2}/\d{2}\s+MARIANOS[^\n]*)\n(\s+Liabilities:[^\n]+\n)\s+Expenses:Groceries:Unknown`
- replace `$1\n$2    Expenses:Groceries:MARIANOS`