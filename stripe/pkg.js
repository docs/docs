- '

Find anything
/
Introduction
Authentication
Connected Accounts
Errors
Expanding Responses
Idempotent Requests
Metadata
Pagination
Request IDs
Versioning
CORE RESOURCES
Balance
Balance Transactions
Charges
Customers
Disputes
Events
Files
File Links
Mandates
PaymentIntents
SetupIntents
SetupAttempts
Payouts
Refunds
Tokens
PAYMENT METHODS
PaymentMethods
Bank Accounts
Cash Balance
Cards
Sources
PRODUCTS
Products
Prices
Coupons
Promotion Codes
Discounts
Tax Codes
Tax Rates
Shipping Rates
CHECKOUT
Checkout Sessions
PAYMENT LINKS
Payment Links
BILLING
Credit Notes
Customer Balance Transactions
Customer Portal
Customer Tax IDs
Invoices
Invoice Items
Plans
Quotes
Subscriptions
Subscription Items
Subscription Schedules
Test Clocks
Usage Records
CONNECT
Accounts
Account Links
Account Sessions
Application Fees
Application Fee Refunds
Capabilities
Country Specs
External Accounts
Persons
Top-ups
Transfers
Transfer Reversals
Secret Management
FRAUD
ISSUING
TERMINAL
TREASURY
SIGMA
REPORTING
Report Runs
Report Types
FINANCIAL CONNECTIONS
Accounts
Account Ownership
Sessions
Transactions
IDENTITY
VerificationSessions
VerificationReports
WEBHOOKS
Webhook Endpoints
Sign In →
API reference
Docs
Support
Sign in →
API Reference
The Stripe API is organized around REST. Our API has predictable resource-oriented URLs, accepts form-encoded request bodies, returns JSON-encoded responses, and uses standard HTTP response codes, authentication, and verbs.

You can use the Stripe API in test mode, which doesn't affect your live data or interact with the banking networks. The API key you use to authenticate the request determines whether the request is live mode or test mode.

The Stripe API doesn't support bulk updates. You can work on only one object per request.

The Stripe API differs for every account as we release new versions and tailor functionality. Log in to see docs customized to your version of the API, with your test key and data.

Was this section helpful?YesNo

JUST GETTING STARTED?
Check out our development quickstart guide.

NOT A DEVELOPER?
Use Stripe’s no-code options or apps from our partners to get started with Stripe and to do more with your Stripe account—no code required.

https://api.stripe.com
Ruby
Python
PHP
Java
Node.js
Go
.NET
By default, the Stripe API Docs demonstrate using curl to interact with the API over HTTP. Select one of our official client libraries to see examples in code.

Authentication
The Stripe API uses API keys to authenticate requests. You can view and manage your API keys in the Stripe Dashboard.

Test mode secret keys have the prefix sk_test_ and live mode secret keys have the prefix sk_live_. Alternatively, you can use restricted API keys for granular permissions.

Your API keys carry many privileges, so be sure to keep them secure! Do not share your secret API keys in publicly accessible areas such as GitHub, client-side code, and so forth.

Authentication to the API is performed via HTTP Basic Auth. Provide your API key as the basic auth username value. You do not need to provide a password.

If you need to authenticate via bearer auth (e.g., for a cross-origin request), use -H "Authorization: Bearer sk_test_4eC39HqLyjWDarjtT1zdp7dc" instead of -u sk_test_4eC39HqLyjWDarjtT1zdp7dc.

All API requests must be made over HTTPS. Calls made over plain HTTP will fail. API requests without authentication will also fail.

Related video: Authentication.

Was this section helpful?YesNo


Select library

curl https://api.stripe.com/v1/charges \
  -u sk_test_4eC39HqLyjWDarjtT1zdp7dc:
# The colon prevents curl from asking for a password.
A sample test API key is included in all the examples here, so you can test any example right away. Do not submit any personally identifiable information in requests made with this key.

To test requests using your account, replace the sample API key with your actual API key or sign in.

Connected Accounts
Clients can make requests as connected accounts using the special header Stripe-Account which should contain a Stripe account ID (usually starting with the prefix acct_).

See also Making API calls for connected accounts.

Was this section helpful?YesNo


Select library

curl https://api.stripe.com/v1/charges/ch_3MSbao2eZvKYlo2C0616qIlT \
  -u sk_test_4eC39HqLyjWDarjtT1zdp7dc: \
  -H "Stripe-Account: acct_1032D82eZvKYlo2C" \
  -G
Errors
Stripe uses conventional HTTP response codes to indicate the success or failure of an API request. In general: Codes in the 2xx range indicate success. Codes in the 4xx range indicate an error that failed given the information provided (e.g., a required parameter was omitted, a charge failed, etc.). Codes in the 5xx range indicate an error with Stripe's servers (these are rare).

Some 4xx errors that could be handled programmatically (e.g., a card is declined) include an error code that briefly explains the error reported.

Was this section helpful?YesNo

Attributes
type
string
The type of error returned. One of api_error, card_error, idempotency_error, or invalid_request_error

code
string
For some errors that could be handled programmatically, a short string indicating the error code reported.

decline_code
string
For card errors resulting from a card issuer decline, a short string indicating the card issuer’s reason for the decline if they provide one.

message
string
A human-readable message providing more details about the error. For card errors, these messages can be shown to your users.

param
string
If the error is parameter-specific, the parameter related to the error. For example, you can use this to display a message near the correct form field.

payment_intent
hash
The PaymentIntent object for errors returned on a request involving a PaymentIntent.

Show child attributes
More attributes
Expand all
charge
string
doc_url
string
payment_method
hash
payment_method_type
string
request_log_url
string
setup_intent
hash
source
hash
200 - OK	Everything worked as expected.
400 - Bad Request	The request was unacceptable, often due to missing a required parameter.
401 - Unauthorized	No valid API key provided.
402 - Request Failed	The parameters were valid but the request failed.
403 - Forbidden	The API key doesn't have permissions to perform the request.
404 - Not Found	The requested resource doesn't exist.
409 - Conflict	The request conflicts with another request (perhaps due to using the same idempotent key).
429 - Too Many Requests	Too many requests hit the API too quickly. We recommend an exponential backoff of your requests.
500, 502, 503, 504 - Server Errors	Something went wrong on Stripe's end. (These are rare.)
api_error	API errors cover any other type of problem (e.g., a temporary problem with Stripe's servers), and are extremely uncommon.
card_error	Card errors are the most common type of error you should expect to handle. They result when the user enters a card that can't be charged for some reason.
idempotency_error	Idempotency errors occur when an Idempotency-Key is re-used on a request that does not match the first request's API endpoint and parameters.
invalid_request_error	Invalid request errors arise when your request has invalid parameters.
Handling errors
Our Client libraries raise exceptions for many reasons, such as a failed charge, invalid parameters, authentication errors, and network unavailability. We recommend writing code that gracefully handles all possible API exceptions.

Related guide: Error Handling.


Select library

# Select a client library to see examples of handling different kinds of errors.
Expanding Responses
Many objects allow you to request additional information as an expanded response by using the expand request parameter. This parameter is available on all API requests, and applies to the response of that request only. Responses can be expanded in two ways.

In many cases, an object contains the ID of a related object in its response properties. For example, a Charge may have an associated Customer ID. Those objects can be expanded inline with the expand request parameter. ID fields that can be expanded into objects are noted in this documentation with theexpandable label.

In some cases, such as the Issuing Card object's number and cvc fields, there are available fields that are not included in responses by default. You can request these fields as an expanded response by using the expand request parameter. Fields that can be included in an expanded response are noted in this documentation with the expandable label.

You can expand recursively by specifying nested fields after a dot (.). For example, requesting invoice.subscription on a charge will expand the invoice property into a full Invoice object, and will then expand the subscription property on that invoice into a full Subscription object.

You can use the expand param on any endpoint which returns expandable fields, including list, create, and update endpoints.

Expansions on list requests start with the data property. For example, you would expand data.customers on a request to list charges and associated customers. Many deep expansions on list requests can be slow.

Expansions have a maximum depth of four levels (so for example, when listing charges,data.invoice.subscription.default_source is the deepest allowed).

You can expand multiple objects at once by identifying multiple items in the expand array.

Related Guide: Expanding responses

Related video: Expand.

Was this section helpful?YesNo


Select library

curl https://api.stripe.com/v1/charges/ch_3MSbao2eZvKYlo2C0616qIlT \
  -u sk_test_4eC39HqLyjWDarjtT1zdp7dc: \
  -d "expand[]"=customer \
  -d "expand[]"="invoice.subscription" \
  -G
{
  "id": "ch_3MSbao2eZvKYlo2C0616qIlT",
  "object": "charge",
  "customer": {
    "id": "cu_14HOtK2eZvKYlo2CPM0hlYU6",
    "object": "customer",
    ...
  },
  "invoice": {
    "id": "in_1MSbao2eZvKYlo2CSLG4Vc3a",
    "object": "invoice",
    "subscription": {
      "id": "su_1MSVaC2eZvKYlo2CP03IbSDE",
      "object": "subscription",
      ...
    },
    ...
  },
  ...
}
Idempotent Requests
The API supports idempotency for safely retrying requests without accidentally performing the same operation twice. When creating or updating an object, use an idempotency key. Then, if a connection error occurs, you can safely repeat the request without risk of creating a second object or performing the update twice.

To perform an idempotent request, provide an additional Idempotency-Key: <key> header to the request.

Stripe's idempotency works by saving the resulting status code and body of the first request made for any given idempotency key, regardless of whether it succeeded or failed. Subsequent requests with the same key return the same result, including 500 errors.

An idempotency key is a unique value generated by the client which the server uses to recognize subsequent retries of the same request. How you create unique keys is up to you, but we suggest using V4 UUIDs, or another random string with enough entropy to avoid collisions. Idempotency keys can be up to 255 characters long.

Keys are eligible to be removed from the system automatically after they're at least 24 hours old, and a new request is generated if a key is reused after the original has been pruned. The idempotency layer compares incoming parameters to those of the original request and errors unless they're the same to prevent accidental misuse.

Results are only saved if an API endpoint started executing. If incoming parameters failed validation, or the request conflicted with another that was executing concurrently, no idempotent result is saved because no API endpoint began execution. It is safe to retry these requests. For more information on when it is safe to retry idempotent requests, see this page.

All POST requests accept idempotency keys. Sending idempotency keys in GET and DELETE requests has no effect and should be avoided, as these requests are idempotent by definition.

Related video: Idempotency and retries.

Was this section helpful?YesNo


Select library

curl https://api.stripe.com/v1/charges \
  -u sk_test_4eC39HqLyjWDarjtT1zdp7dc: \
  -H "Idempotency-Key: Dphk89tsZ2sLPNQu" \
  -d amount=2000 \
  -d currency=usd \
  -d description="My First Test Charge (created for API docs at https://www.stripe.com/docs/api)" \
  -d source=tok_mastercard
Metadata
Most updatable Stripe objects—including Account, Charge, Customer, PaymentIntent, Refund, Subscription, and Transfer—have a metadata parameter. You can use this parameter to attach arbitrary key-value data to these Stripe objects.

You can specify up to 50 keys, with key names up to 40 characters long and values up to 500 characters long.

Metadata is useful for storing additional, structured information on an object. For example, you could store your user's corresponding unique identifier from your system on a Stripe Customer object. By default, metadata isn't used by Stripe—for example, it's not used to authorize or decline a charge—but metadata is supported by the Search API and custom Radar rules. Your users won't see metadata unless you show it to them.

Some of the objects listed above also support a description parameter. You can use the description parameter to annotate a charge—with, for example, a human-readable description like 2 shirts for test@example.com. Unlike metadata, description is a single string, and your users may see it (e.g., in email receipts Stripe sends on your behalf).

Don't store any sensitive information (bank account numbers, card details, and so on) in metadata or in the description parameter.

Related video: Metadata.

Was this section helpful?YesNo

Sample metadata use cases
Link IDs
Attach your system's unique IDs to a Stripe object, for easy lookups. For example, add your order number to a charge, your user ID to a customer or recipient, or a unique receipt number to a transfer.

Refund papertrails
Store information about why a refund was created, and by whom.

Customer details
Annotate a customer by storing an internal ID for your later use.


Select library

curl https://api.stripe.com/v1/charges \
  -u sk_test_4eC39HqLyjWDarjtT1zdp7dc: \
  -d amount=2000 \
  -d currency=usd \
  -d source=tok_mastercard \
  -d "metadata[order_id]"=6735
{
  "id": "ch_3MSbao2eZvKYlo2C0616qIlT",
  "object": "charge",
  "amount": 100,
  "amount_captured": 0,
  "amount_refunded": 0,
  "application": null,
  "application_fee": null,
  "application_fee_amount": null,
  "balance_transaction": "txn_1032HU2eZvKYlo2CEPtcnUvl",
  "billing_details": {
    "address": {
      "city": null,
      "country": null,
      "line1": null,
      "line2": null,
      "postal_code": null,
      "state": null
    },
    "email": null,
    "name": null,
    "phone": null
  },
  "calculated_statement_descriptor": null,
  "captured": false,
  "created": 1674286466,
  "currency": "usd",
  "customer": null,
  "description": "My First Test Charge (created for API docs)",
  "disputed": false,
  "failure_balance_transaction": null,
  "failure_code": null,
  "failure_message": null,
  "fraud_details": {},
  "invoice": null,
  "livemode": false,
  "metadata": {
    "order_id": "6735"
  },
  "on_behalf_of": null,
  "outcome": null,
  "paid": true,
  "payment_intent": null,
  "payment_method": "card_1MSbaZ2eZvKYlo2CRmVJokbm",
  "payment_method_details": {
    "card": {
      "brand": "visa",
      "checks": {
        "address_line1_check": null,
        "address_postal_code_check": null,
        "cvc_check": "pass"
      },
      "country": "US",
      "exp_month": 8,
      "exp_year": 2024,
      "fingerprint": "Xt5EWLLDS7FJjR1c",
      "funding": "credit",
      "installments": null,
      "last4": "4242",
      "mandate": null,
      "moto": null,
      "network": "visa",
      "three_d_secure": null,
      "wallet": null
    },
    "type": "card"
  },
  "receipt_email": null,
  "receipt_number": null,
  "receipt_url": "https://pay.stripe.com/receipts/payment/CAcaFwoVYWNjdF8xMDMyRDgyZVp2S1lsbzJDKIKrrp4GMga9y3kogwQ6LBZY-qUL6gukEsfP47CNBNuD7Ha8lnOuibaYQpGMCXRxBZBwYy6GelJK6Ntd",
  "redaction": null,
  "refunded": false,
  "refunds": {
    "object": "list",
    "data": [],
    "has_more": false,
    "url": "/v1/charges/ch_3MSbao2eZvKYlo2C0616qIlT/refunds"
  },
  "review": null,
  "shipping": null,
  "source_transfer": null,
  "statement_descriptor": null,
  "statement_descriptor_suffix": null,
  "status": "succeeded",
  "transfer_data": null,
  "transfer_group": null
}
Pagination
All top-level API resources have support for bulk fetches via "list" API methods. For instance, you can list charges, list customers, and list invoices. These list API methods share a common structure, taking at least these three parameters: limit, starting_after, and ending_before.

The response of a list API method represents a single page in a reverse chronological stream of objects. If you do not specify starting_after or ending_before, you will receive the first page of this stream, containing the newest objects. You can specify starting_after equal to the object ID value (see below) of an item to retrieve the page of older objects occurring immediately after the named object in the reverse chronological stream. Similarly, you can specifyending_before to receive a page of newer objects occurring immediately before the named object in the stream. Objects in a page always appear in reverse chronological order. Only one of starting_after or ending_before may be used.

Our client libraries offer auto-pagination helpers to easily traverse all pages of a list.

Related video: Pagination and auto-pagination.

Was this section helpful?YesNo

Parameters
limit
optional, default is 10
A limit on the number of objects to be returned, between 1 and 100.

starting_after
optional
A cursor for use in pagination. starting_after is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include starting_after=obj_foo in order to fetch the next page of the list.

ending_before
optional
A cursor for use in pagination. ending_before is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_bar, your subsequent call can include ending_before=obj_bar in order to fetch the previous page of the list.

List Response Format
object
string, value is "list"
A string describing the object type returned.

data
array
An array containing the actual response elements, paginated by any request parameters.

has_more
boolean
Whether or not there are more elements available after this set. If false, this set comprises the end of the list.

url
string
The URL for accessing this list.

{
  "object": "list",
  "url": "/v1/customers",
  "has_more": false,
  "data": [
    {
      "id": "cus_4QFOF3xrvBT2nU",
      "object": "customer",
      "address": null,
      "balance": 0,
      "created": 1405641986,
      "currency": "usd",
      "default_source": "card_14HOtJ2eZvKYlo2CD2lt4r4W",
      "delinquent": true,
      "description": "someone@example.com for Coderwall",
      "discount": null,
      "email": "name3c99e4df-9ff0-4b77-95ba-10cb2027ad44@test.com",
      "invoice_prefix": "93EC0E1",
      "invoice_settings": {
        "custom_fields": null,
        "default_payment_method": null,
        "footer": null,
        "rendering_options": null
      },
      "livemode": false,
      "metadata": {
        "CustomerReferenceId": "16527612",
        "CustomerReferenceType": "reedonline",
        "tag-key": "tag-value",
        "meta-key": "meta-value"
      },
      "name": "name3c99e4df-9ff0-4b77-95ba-10cb2027ad44",
      "next_invoice_sequence": 441632,
      "phone": null,
      "preferred_locales": [],
      "shipping": null,
      "tax_exempt": "none",
      "test_clock": null
    },
    {...},
    {...}
  ]
}
Search
Some top-level API resource have support for retrieval via "search" API methods. For example, you can search charges, search customers, and search subscriptions.

Stripe's search API methods utilize cursor-based pagination via the page request parameter and next_page response parameter. For example, if you make a search request and receive "next_page": "pagination_key" in the response, your subsequent call can include page=pagination_key to fetch the next page of results.

Our client libraries offer auto-pagination helpers to easily traverse all pages of a search result.

Search request format
query
REQUIRED
The search query string. See search query language.

limit
optional
A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.

page
optional
A cursor for pagination across multiple pages of results. Don’t include this parameter on the first call. Use the next_page value returned in a previous response to request subsequent results.

Search response format
object
string, value is "search_result"
A string describing the object type returned.

url
string
The URL for accessing this list.

has_more
boolean
Whether or not there are more elements available after this set. If false, this set comprises the end of the list.

data
array
An array containing the actual response elements, paginated by any request parameters.

next_page
string
A cursor for use in pagination. If has_more is true, you can pass the value of next_page to a subsequent call to fetch the next page of results.

total_count
optional positive integer or zero
EXPANDABLE
The total number of objects that match the query, only accurate up to 10,000. This field is not included by default. To include it in the response, expand the total_count field.

{
  "object": "search_result",
  "url": "/v1/customers/search",
  "has_more": false,
  "data": [
    {
      "id": "cus_4QFOF3xrvBT2nU",
      "object": "customer",
      "address": null,
      "balance": 0,
      "created": 1405641986,
      "currency": "usd",
      "default_source": "card_14HOtJ2eZvKYlo2CD2lt4r4W",
      "delinquent": true,
      "description": "someone@example.com for Coderwall",
      "discount": null,
      "email": "name3c99e4df-9ff0-4b77-95ba-10cb2027ad44@test.com",
      "invoice_prefix": "93EC0E1",
      "invoice_settings": {
        "custom_fields": null,
        "default_payment_method": null,
        "footer": null,
        "rendering_options": null
      },
      "livemode": false,
      "metadata": {
        "foo": "bar"
      },
      "name": "fakename",
      "next_invoice_sequence": 441632,
      "phone": null,
      "preferred_locales": [],
      "shipping": null,
      "tax_exempt": "none",
      "test_clock": null
    },
    {...},
    {...}
  ]
}
Auto-pagination
Our libraries support auto-pagination. This feature easily handles fetching large lists of resources without having to manually paginate results and perform subsequent requests.

Auto-paginating without ending_before will iterate in reverse chronological order. Auto-paginating with ending_before will iterate in forwards chronological order, despite the fact that the order of items in a list API response is always reverse chronological.

Since curl simply emits raw HTTP requests, it doesn't support auto-pagination.


Select library

# The auto-pagination feature is specific to Stripe's
  # libraries and cannot be used directly with curl.
Request IDs
Each API request has an associated request identifier. You can find this value in the response headers, under Request-Id. You can also find request identifiers in the URLs of individual request logs in your Dashboard. If you need to contact us about a specific request, providing the request identifier will ensure the fastest possible resolution.

Was this section helpful?YesNo


Select library

curl https://api.stripe.com/v1/customers \
  -u sk_test_4eC39HqLyjWDarjtT1zdp7dc: \
  -D "-" \
  -X POST
Versioning
When backwards-incompatible changes are made to the API, a new, dated version is released. The current version is 2022-11-15. Read our API upgrades guide to learn more about backwards compatibility. For all API updates, view our API changelog.

All requests use your account API settings, unless you override the API version. The upgrades guide lists every available version. Note that by default webhook events are structured according to your account API version, unless you set an API version during endpoint creation.

To set the API version on a specific request, send a Stripe-Version header.

You can visit your Dashboard to upgrade your API version. As a precaution, use API versioning to test a new API version before committing to an upgrade.

Related video: Versioning.

Was this section helpful?YesNo


Select library

curl https://api.stripe.com/v1/charges \
  -u sk_test_4eC39HqLyjWDarjtT1zdp7dc: \
  -H "Stripe-Version: 2022-11-15"
Balance
This is an object representing your Stripe balance. You can retrieve it to see the balance currently on your Stripe account…

   GET 
/v1/balance
SHOW
Balance Transactions
Balance transactions represent funds moving through your Stripe account. They're created for every type of transaction that comes into or flows out of your Stripe account balance…

   GET 
/v1/balance_transactions/:id
   GET 
/v1/balance_transactions
SHOW
Charges
To charge a credit or a debit card, you create a Charge object. You can retrieve and refund individual charges as well as list all charges. Charges are identified by a unique, random ID…

  POST 
/v1/charges
   GET 
/v1/charges/:id
  POST 
/v1/charges/:id
  POST 
/v1/charges/:id/capture
   GET 
/v1/charges
   GET 
/v1/charges/search
SHOW
Customers
This object represents a customer of your business. It lets you create recurring charges and track payments that belong to the same customer…

  POST 
/v1/customers
   GET 
/v1/customers/:id
  POST 
/v1/customers/:id
DELETE 
/v1/customers/:id
   GET 
/v1/customers
   GET 
/v1/customers/search
SHOW
Disputes
A dispute occurs when a customer questions your charge with their card issuer. When this happens, you're given the opportunity to respond to the dispute with evidence that shows that the charge is legitimate. You can find more information about the dispute process in our Disputes and Fraud documentation…

   GET 
/v1/disputes/:id
  POST 
/v1/disputes/:id
  POST 
/v1/disputes/:id/close
   GET 
/v1/disputes
SHOW
Events
Events are our way of letting you know when something interesting happens in your account. When an interesting event occurs, we create a new Event object. For example, when a charge succeeds, we create a charge.succeeded event; and when an invoice payment attempt fails, we create an invoice.payment_failed event. Note that many API requests may cause multiple events to be created. For example, if you create a new subscription for a customer, you will receive both a customer.subscription.created event and a charge.succeeded event…

   GET 
/v1/events/:id
   GET 
/v1/events
SHOW
Files
This is an object representing a file hosted on Stripe's servers. The file may have been uploaded by yourself using the create file request (for example, when uploading dispute evidence) or it may have been created by Stripe (for example, the results of a Sigma scheduled query)…

  POST 
https://files.stripe.com/v1/files
   GET 
/v1/files/:id
   GET 
/v1/files
SHOW
File Links
To share the contents of a File object with non-Stripe users, you can create a FileLink. FileLinks contain a URL that can be used to retrieve the contents of the file without authentication.

  POST 
/v1/file_links
   GET 
/v1/file_links/:id
  POST 
/v1/file_links/:id
   GET 
/v1/file_links
SHOW
Mandates
A Mandate is a record of the permission a customer has given you to debit their payment method.

   GET 
/v1/mandates/:id
SHOW
PaymentIntents
A PaymentIntent guides you through the process of collecting a payment from your customer. We recommend that you create exactly one PaymentIntent for each order or customer session in your system. You can reference the PaymentIntent later to see the history of payment attempts for a particular session…

  POST 
/v1/payment_intents
   GET 
/v1/payment_intents/:id
  POST 
/v1/payment_intents/:id
  POST 
/v1/payment_intents/:id/confirm
  POST 
/v1/payment_intents/:id/capture
  POST 
/v1/payment_intents/:id/cancel
   GET 
/v1/payment_intents
  POST 
/v1/payment_intents/:id/increment_authorization
   GET 
/v1/payment_intents/search
  POST 
/v1/payment_intents/:id/verify_microdeposits
  POST 
/v1/payment_intents/:id/apply_customer_balance
SHOW
SetupIntents
A SetupIntent guides you through the process of setting up and saving a customer's payment credentials for future payments. For example, you could use a SetupIntent to set up and save your customer's card without immediately collecting a payment. Later, you can use PaymentIntents to drive the payment flow…

  POST 
/v1/setup_intents
   GET 
/v1/setup_intents/:id
  POST 
/v1/setup_intents/:id
  POST 
/v1/setup_intents/:id/confirm
  POST 
/v1/setup_intents/:id/cancel
   GET 
/v1/setup_intents
  POST 
/v1/setup_intents/:id/verify_microdeposits
SHOW
SetupAttempts
A SetupAttempt describes one attempted confirmation of a SetupIntent, whether that confirmation was successful or unsuccessful. You can use SetupAttempts to inspect details of a specific attempt at setting up a payment method using a SetupIntent.

   GET 
/v1/setup_attempts
SHOW
Payouts
A Payout object is created when you receive funds from Stripe, or when you initiate a payout to either a bank account or debit card of a connected Stripe account. You can retrieve individual payouts, as well as list all payouts. Payouts are made on varying schedules, depending on your country and industry…

  POST 
/v1/payouts
   GET 
/v1/payouts/:id
  POST 
/v1/payouts/:id
   GET 
/v1/payouts
  POST 
/v1/payouts/:id/cancel
  POST 
/v1/payouts/:id/reverse
SHOW
Refunds
Refund objects allow you to refund a charge that has previously been created but not yet refunded. Funds will be refunded to the credit or debit card that was originally charged…

  POST 
/v1/refunds
   GET 
/v1/refunds/:id
  POST 
/v1/refunds/:id
  POST 
/v1/refunds/:id/cancel
   GET 
/v1/refunds
SHOW
Tokens
Tokenization is the process Stripe uses to collect sensitive card or bank account details, or personally identifiable information (PII), directly from your customers in a secure manner. A token representing this information is returned to your server to use. You should use our recommended payments integrations to perform this process client-side. This ensures that no sensitive card data touches your server, and allows your integration to operate in a PCI-compliant way…

  POST 
/v1/tokens
  POST 
/v1/tokens
  POST 
/v1/tokens
  POST 
/v1/tokens
  POST 
/v1/tokens
  POST 
/v1/tokens
   GET 
/v1/tokens/:id
SHOW
PaymentMethods
PaymentMethod objects represent your customer's payment instruments. You can use them with PaymentIntents to collect payments or save them to Customer objects to store instrument details for future payments…

  POST 
/v1/payment_methods
   GET 
/v1/payment_methods/:id
   GET 
/v1/customers/:customer/payment_methods/:payment_method
  POST 
/v1/payment_methods/:id
   GET 
/v1/payment_methods
   GET 
/v1/customers/:customer/payment_methods
  POST 
/v1/payment_methods/:id/attach
  POST 
/v1/payment_methods/:id/detach
SHOW
Bank Accounts
These bank accounts are payment methods on Customer objects…

  POST 
/v1/customers/:id/sources
   GET 
/v1/customers/:id/sources/:id
  POST 
/v1/customers/:id/sources/:id
  POST 
/v1/customers/:id/sources/:id/verify
DELETE 
/v1/customers/:id/sources/:id
   GET 
/v1/customers/:id/sources?object=bank_account
SHOW
Cash balance
A customer's Cash balance represents real funds. Customers can add funds to their cash balance by sending a bank transfer. These funds can be used for payment and can eventually be paid out to your bank account.

   GET 
/v1/customers/:id/cash_balance
  POST 
/v1/customers/:id/cash_balance
   GET 
/v1/customers/:id/cash_balance_transactions/:id
   GET 
/v1/customers/:id/cash_balance_transactions
  POST 
/v1/test_helpers/customers/{:customer}/fund_cash_balance
SHOW
Cards
You can store multiple cards on a customer in order to charge the customer later. You can also store multiple debit cards on a recipient in order to transfer to those cards later…

  POST 
/v1/customers/:id/sources
   GET 
/v1/customers/:id/sources/:id
  POST 
/v1/customers/:id/sources/:id
DELETE 
/v1/customers/:id/sources/:id
   GET 
/v1/customers/:id/sources?object=card
SHOW
Sources
Source objects allow you to accept a variety of payment methods. They represent a customer's payment instrument, and can be used with the Stripe API just like a Card object: once chargeable, they can be charged, or can be attached to customers…

  POST 
/v1/sources
   GET 
/v1/sources/:id
  POST 
/v1/sources/:id
  POST 
/v1/customers/:id/sources
DELETE 
/v1/customers/:id/sources/:id
SHOW
Products
Products describe the specific goods or services you offer to your customers. For example, you might offer a Standard and Premium version of your goods or service; each version would be a separate Product. They can be used in conjunction with Prices to configure pricing in Payment Links, Checkout, and Subscriptions…

  POST 
/v1/products
   GET 
/v1/products/:id
  POST 
/v1/products/:id
   GET 
/v1/products
DELETE 
/v1/products/:id
   GET 
/v1/products/search
SHOW
Prices
Prices define the unit cost, currency, and (optional) billing cycle for both recurring and one-time purchases of products. Products help you track inventory or provisioning, and prices help you track payment terms. Different physical goods or levels of service should be represented by products, and pricing options should be represented by prices. This approach lets you change prices without having to change your provisioning scheme…

  POST 
/v1/prices
   GET 
/v1/prices/:id
  POST 
/v1/prices/:id
   GET 
/v1/prices
   GET 
/v1/prices/search
SHOW
Coupons
A coupon contains information about a percent-off or amount-off discount you might want to apply to a customer. Coupons may be applied to subscriptions, invoices, checkout sessions, quotes, and more. Coupons do not work with conventional one-off charges or payment intents.

  POST 
/v1/coupons
   GET 
/v1/coupons/:id
  POST 
/v1/coupons/:id
DELETE 
/v1/coupons/:id
   GET 
/v1/coupons
SHOW
Promotion Code
A Promotion Code represents a customer-redeemable code for a coupon. It can be used to create multiple codes for a single coupon.

  POST 
/v1/promotion_codes
  POST 
/v1/promotion_codes/:id
   GET 
/v1/promotion_codes/:id
   GET 
/v1/promotion_codes
SHOW
Discounts
A discount represents the actual application of a coupon or promotion code. It contains information about when the discount began, when it will end, and what it is applied to…

DELETE 
/v1/customers/:id/discount
DELETE 
/v1/subscriptions/:id/discount
SHOW
Tax Code
Tax codes classify goods and services for tax purposes.

   GET 
/v1/tax_codes
   GET 
/v1/tax_codes/:id
SHOW
Tax Rate
Tax rates can be applied to invoices, subscriptions and Checkout Sessions to collect tax…

  POST 
/v1/tax_rates
   GET 
/v1/tax_rates/:id
  POST 
/v1/tax_rates/:id
   GET 
/v1/tax_rates
SHOW
Shipping Rates
Shipping rates describe the price of shipping presented to your customers and can be applied to Checkout Sessions and Orders to collect shipping costs.

  POST 
/v1/shipping_rates
   GET 
/v1/shipping_rates/:id
  POST 
/v1/shipping_rates/:id
   GET 
/v1/shipping_rates
SHOW
Sessions
A Checkout Session represents your customer's session as they pay for one-time purchases or subscriptions through Checkout or Payment Links. We recommend creating a new Session each time your customer attempts to pay…

  POST 
/v1/checkout/sessions
  POST 
/v1/checkout/sessions/:id/expire
   GET 
/v1/checkout/sessions/:id
   GET 
/v1/checkout/sessions
   GET 
/v1/checkout/sessions/:id/line_items
SHOW
Payment Link
A payment link is a shareable URL that will take your customers to a hosted payment page. A payment link can be shared and used multiple times…

  POST 
/v1/payment_links
   GET 
/v1/payment_links/:id
  POST 
/v1/payment_links/:id
   GET 
/v1/payment_links
   GET 
/v1/payment_links/:id/line_items
SHOW
Credit Note
Issue a credit note to adjust an invoice's amount after the invoice is finalized…

   GET 
/v1/credit_notes/preview
  POST 
/v1/credit_notes
   GET 
/v1/credit_notes/:id
  POST 
/v1/credit_notes/:id
   GET 
/v1/credit_notes/:credit_note/lines
   GET 
/v1/credit_notes/preview/lines
  POST 
/v1/credit_notes/:id/void
   GET 
/v1/credit_notes
SHOW
Customer Balance Transaction
Each customer has a balance value, which denotes a debit or credit that's automatically applied to their next invoice upon finalization. You may modify the value directly by using the update customer API, or by creating a Customer Balance Transaction, which increments or decrements the customer's balance by the specified amount…

  POST 
/v1/customers/:id/balance_transactions
   GET 
/v1/customers/:id/balance_transactions/:id
  POST 
/v1/customers/:id/balance_transactions/:id
   GET 
/v1/customers/:id/balance_transactions
SHOW
Customer Portal
The Billing customer portal is a Stripe-hosted UI for subscription and billing management…

  POST 
/v1/billing_portal/sessions
  POST 
/v1/billing_portal/configurations
  POST 
/v1/billing_portal/configurations/:id
   GET 
/v1/billing_portal/configurations/:id
   GET 
/v1/billing_portal/configurations
SHOW
Customer Tax IDs
You can add one or multiple tax IDs to a customer. A customer's tax IDs are displayed on invoices and credit notes issued for the customer…

  POST 
/v1/customers/:id/tax_ids
   GET 
/v1/customers/:id/tax_ids/:id
DELETE 
/v1/customers/:id/tax_ids/:id
   GET 
/v1/customers/:id/tax_ids
SHOW
Invoices
Invoices are statements of amounts owed by a customer, and are either generated one-off, or generated periodically from a subscription…

  POST 
/v1/invoices
   GET 
/v1/invoices/:id
  POST 
/v1/invoices/:id
DELETE 
/v1/invoices/:id
  POST 
/v1/invoices/:id/finalize
  POST 
/v1/invoices/:id/pay
  POST 
/v1/invoices/:id/send
  POST 
/v1/invoices/:id/void
  POST 
/v1/invoices/:id/mark_uncollectible
   GET 
/v1/invoices/:id/lines
   GET 
/v1/invoices/upcoming
   GET 
/v1/invoices/upcoming/lines
   GET 
/v1/invoices
   GET 
/v1/invoices/search
SHOW
Invoice Items
Sometimes you want to add a charge or credit to a customer, but actually charge or credit the customer's card only at the end of a regular billing cycle. This is useful for combining several charges (to minimize per-transaction fees), or for having Stripe tabulate your usage-based billing totals…

  POST 
/v1/invoiceitems
   GET 
/v1/invoiceitems/:id
  POST 
/v1/invoiceitems/:id
DELETE 
/v1/invoiceitems/:id
   GET 
/v1/invoiceitems
SHOW
Plans
You can now model subscriptions more flexibly using the Prices API. It replaces the Plans API and is backwards compatible to simplify your migration…

  POST 
/v1/plans
   GET 
/v1/plans/:id
  POST 
/v1/plans/:id
DELETE 
/v1/plans/:id
   GET 
/v1/plans
SHOW
Quote
A Quote is a way to model prices that you'd like to provide to a customer. Once accepted, it will automatically create an invoice, subscription or subscription schedule.

  POST 
/v1/quotes
   GET 
/v1/quotes/:id
  POST 
/v1/quotes/:id
  POST 
/v1/quotes/:id/finalize
  POST 
/v1/quotes/:id/accept
  POST 
/v1/quotes/:id/cancel
   GET 
https://files.stripe.com/v1/quotes/:id/pdf
   GET 
/v1/quotes/:id/line_items
   GET 
/v1/quotes/:id/computed_upfront_line_items
   GET 
/v1/quotes
SHOW
Subscriptions
Subscriptions allow you to charge a customer on a recurring basis…

  POST 
/v1/subscriptions
   GET 
/v1/subscriptions/:id
  POST 
/v1/subscriptions/:id
DELETE 
/v1/subscriptions/:id
   GET 
/v1/subscriptions
   GET 
/v1/subscriptions/search
SHOW
Subscription Items
Subscription items allow you to create customer subscriptions with more than one plan, making it easy to represent complex billing relationships.

  POST 
/v1/subscription_items
   GET 
/v1/subscription_items/:id
  POST 
/v1/subscription_items/:id
DELETE 
/v1/subscription_items/:id
   GET 
/v1/subscription_items
SHOW
Subscription Schedule
A subscription schedule allows you to create and manage the lifecycle of a subscription by predefining expected changes…

  POST 
/v1/subscription_schedules
   GET 
/v1/subscription_schedules/:id
  POST 
/v1/subscription_schedules/:id
  POST 
/v1/subscription_schedules/:id/cancel
  POST 
/v1/subscription_schedules/:id/release
   GET 
/v1/subscription_schedules
SHOW
Test Clocks
A test clock enables deterministic control over objects in testmode. With a test clock, you can create objects at a frozen time in the past or future, and advance to a specific future time to observe webhooks and state changes. After the clock advances, you can either validate the current state of your scenario (and test your assumptions), change the current state of your scenario (and test more complex scenarios), or keep advancing forward in time.

  POST 
/v1/test_helpers/test_clocks
   GET 
/v1/test_helpers/test_clocks/:id
DELETE 
/v1/test_helpers/test_clocks/:id
  POST 
/v1/test_helpers/test_clocks/:id/advance
   GET 
/v1/test_helpers/test_clocks
SHOW
Usage Records
Usage records allow you to report customer usage and metrics to Stripe for metered billing of subscription prices…

  POST 
/v1/subscription_items/:id/usage_records
   GET 
/v1/subscription_items/:id/usage_record_summaries
SHOW
Accounts
This is an object representing a Stripe account. You can retrieve it to see properties on the account like its current e-mail address or if the account is enabled yet to make live charges…

  POST 
/v1/accounts
   GET 
/v1/accounts/:id
  POST 
/v1/accounts/:id
DELETE 
/v1/accounts/:id
  POST 
/v1/accounts/:id/reject
   GET 
/v1/accounts
  POST 
/v1/accounts/:id/login_links
SHOW
Account Links
Account Links are the means by which a Connect platform grants a connected account permission to access Stripe-hosted applications, such as Connect Onboarding…

  POST 
/v1/account_links
SHOW
Account Session
Preview feature
An AccountSession allows a Connect platform to grant access to a connected account in Connect embedded UIs…

  POST 
/v1/account_sessions
SHOW
Application Fees
When you collect a transaction fee on top of a charge made for your user (using Connect), an Application Fee object is created in your account. You can list, retrieve, and refund application fees…

   GET 
/v1/application_fees/:id
   GET 
/v1/application_fees
SHOW
Application Fee Refunds
Application Fee Refund objects allow you to refund an application fee that has previously been created but not yet refunded. Funds will be refunded to the Stripe account from which the fee was originally collected…

  POST 
/v1/application_fees/:id/refunds
   GET 
/v1/application_fees/:id/refunds/:id
  POST 
/v1/application_fees/:id/refunds/:id
   GET 
/v1/application_fees/:id/refunds
SHOW
Capabilities
This is an object representing a capability for a Stripe account…

   GET 
/v1/accounts/:id/capabilities/:id
  POST 
/v1/accounts/:id/capabilities/:id
   GET 
/v1/accounts/:id/capabilities
SHOW
Country Specs
Stripe needs to collect certain pieces of information about each account created. These requirements can differ depending on the account's country. The Country Specs API makes these rules available to your integration…

   GET 
/v1/country_specs
   GET 
/v1/country_specs/:id
SHOW
External Accounts
External Accounts are transfer destinations on Account objects for connected accounts. They can be bank accounts or debit cards…

  POST 
/v1/accounts/:id/external_accounts
   GET 
/v1/accounts/:id/external_accounts/:id
  POST 
/v1/accounts/:id/external_accounts/:id
DELETE 
/v1/accounts/:id/external_accounts/:id
   GET 
/v1/accounts/:id/external_accounts?object=bank_account
  POST 
/v1/accounts/:id/external_accounts
   GET 
/v1/accounts/:id/external_accounts/:id
  POST 
/v1/accounts/:id/external_accounts/:id
DELETE 
/v1/accounts/:id/external_accounts/:id
   GET 
/v1/accounts/:id/external_accounts?object=card
SHOW
Person
This is an object representing a person associated with a Stripe account…

  POST 
/v1/accounts/:id/persons
   GET 
/v1/accounts/:id/persons/:id
  POST 
/v1/accounts/:id/persons/:id
DELETE 
/v1/accounts/:id/persons/:id
   GET 
/v1/accounts/:id/persons
SHOW
Top-ups
To top up your Stripe balance, you create a top-up object. You can retrieve individual top-ups, as well as list all top-ups. Top-ups are identified by a unique, random ID…

  POST 
/v1/topups
   GET 
/v1/topups/:id
  POST 
/v1/topups/:id
   GET 
/v1/topups
  POST 
/v1/topups/:id/cancel
SHOW
Transfers
A Transfer object is created when you move funds between Stripe accounts as part of Connect…

  POST 
/v1/transfers
   GET 
/v1/transfers/:id
  POST 
/v1/transfers/:id
   GET 
/v1/transfers
SHOW
Transfer Reversals
Stripe Connect platforms can reverse transfers made to a connected account, either entirely or partially, and can also specify whether to refund any related application fees. Transfer reversals add to the platform's balance and subtract from the destination account's balance…

  POST 
/v1/transfers/:id/reversals
   GET 
/v1/transfers/:id/reversals/:id
  POST 
/v1/transfers/:id/reversals/:id
   GET 
/v1/transfers/:id/reversals
SHOW
Secrets
Secret Store is an API that allows Stripe Apps developers to securely persist secrets for use by UI Extensions and app backends…

  POST 
/v1/apps/secrets
   GET 
/v1/apps/secrets/find
  POST 
/v1/apps/secrets/delete
   GET 
/v1/apps/secrets
SHOW
Early Fraud Warning
An early fraud warning indicates that the card issuer has notified us that a charge may be fraudulent…

   GET 
/v1/radar/early_fraud_warnings/:id
   GET 
/v1/radar/early_fraud_warnings
SHOW
Reviews
Reviews can be used to supplement automated fraud detection with human expertise…

  POST 
/v1/reviews/:id/approve
   GET 
/v1/reviews/:id
   GET 
/v1/reviews
SHOW
Value Lists
Value lists allow you to group values together which can then be referenced in rules…

  POST 
/v1/radar/value_lists
   GET 
/v1/radar/value_lists/:id
  POST 
/v1/radar/value_lists/:id
DELETE 
/v1/radar/value_lists/:id
   GET 
/v1/radar/value_lists
SHOW
Value List Items
Value list items allow you to add specific values to a given Radar value list, which can then be used in rules…

  POST 
/v1/radar/value_list_items
   GET 
/v1/radar/value_list_items/:id
DELETE 
/v1/radar/value_list_items/:id
   GET 
/v1/radar/value_list_items
SHOW
Authorizations
When an issued card is used to make a purchase, an Issuing Authorization object is created. Authorizations must be approved for the purchase to be completed successfully…

   GET 
/v1/issuing/authorizations/:id
  POST 
/v1/issuing/authorizations/:id
  POST 
/v1/issuing/authorizations/:id/approve
  POST 
/v1/issuing/authorizations/:id/decline
   GET 
/v1/issuing/authorizations
SHOW
Cardholders
An Issuing Cardholder object represents an individual or business entity who is issued cards…

  POST 
/v1/issuing/cardholders
   GET 
/v1/issuing/cardholders/:id
  POST 
/v1/issuing/cardholders/:id
   GET 
/v1/issuing/cardholders
SHOW
Cards
You can create physical or virtual cards that are issued to cardholders.

  POST 
/v1/issuing/cards
   GET 
/v1/issuing/cards/:id
  POST 
/v1/issuing/cards/:id
   GET 
/v1/issuing/cards
  POST 
/v1/test_helpers/issuing/cards/{:card}/shipping/ship
  POST 
/v1/test_helpers/issuing/cards/{:card}/shipping/deliver
  POST 
/v1/test_helpers/issuing/cards/{:card}/shipping/return
  POST 
/v1/test_helpers/issuing/cards/{:card}/shipping/fail
SHOW
Disputes
As a card issuer, you can dispute transactions that the cardholder does not recognize, suspects to be fraudulent, or has other issues with…

  POST 
/v1/issuing/disputes
  POST 
/v1/issuing/disputes/:id/submit
   GET 
/v1/issuing/disputes/:id
  POST 
/v1/issuing/disputes/:id
   GET 
/v1/issuing/disputes
SHOW
Funding Instructions
Funding Instructions contain reusable bank account and routing information. Push funds to these addresses via bank transfer to top up Issuing Balances.

  POST 
/v1/issuing/funding_instructions
   GET 
/v1/issuing/funding_instructions
  POST 
/v1/test_helpers/issuing/fund_balance
SHOW
Transactions
Any use of an issued card that results in funds entering or leaving your Stripe account, such as a completed purchase or refund, is represented by an Issuing Transaction object…

   GET 
/v1/issuing/transactions/:id
  POST 
/v1/issuing/transactions/:id
   GET 
/v1/issuing/transactions
SHOW
Connection Token
A Connection Token is used by the Stripe Terminal SDK to connect to a reader…

  POST 
/v1/terminal/connection_tokens
SHOW
Location
A Location represents a grouping of readers…

  POST 
/v1/terminal/locations
   GET 
/v1/terminal/locations/:id
  POST 
/v1/terminal/locations/:id
DELETE 
/v1/terminal/locations/:id
   GET 
/v1/terminal/locations
SHOW
Reader
A Reader represents a physical device for accepting payment details…

  POST 
/v1/terminal/readers
   GET 
/v1/terminal/readers/:id
  POST 
/v1/terminal/readers/:id
DELETE 
/v1/terminal/readers/:id
   GET 
/v1/terminal/readers
  POST 
/v1/terminal/readers/:id/process_payment_intent
  POST 
/v1/terminal/readers/:id/process_setup_intent
  POST 
/v1/terminal/readers/:id/set_reader_display
  POST 
/v1/terminal/readers/:id/cancel_action
  POST 
/v1/test_helpers/terminal/readers/:id/present_payment_method
SHOW
Configuration
A Configurations object represents how features should be configured for terminal readers.

  POST 
/v1/terminal/configurations
   GET 
/v1/terminal/configurations/:id
  POST 
/v1/terminal/configurations/:id
DELETE 
/v1/terminal/configurations/:id
   GET 
/v1/terminal/configurations
SHOW
FinancialAccounts
Stripe Treasury provides users with a container for money called a FinancialAccount that is separate from their Payments balance. FinancialAccounts serve as the source and destination of Treasury’s money movement APIs.

  POST 
/v1/treasury/financial_accounts
  POST 
/v1/treasury/financial_accounts/:id
   GET 
/v1/treasury/financial_accounts/:id
   GET 
/v1/treasury/financial_accounts
SHOW
FinancialAccount Features
Encodes whether a FinancialAccount has access to a particular Feature, with a status enum and associated status_details. Stripe or the platform can control Features via the requested field.

  POST 
/v1/treasury/financial_accounts/:id/features
   GET 
/v1/treasury/financial_accounts/:id/features
SHOW
Transactions
Transactions represent changes to a FinancialAccount's balance.

   GET 
/v1/treasury/transactions/:id
   GET 
/v1/treasury/transactions
SHOW
TransactionEntries
TransactionEntries represent individual units of money movements within a single Transaction.

   GET 
/v1/treasury/transaction_entries/:id
   GET 
/v1/treasury/transaction_entries
SHOW
OutboundTransfers
Use OutboundTransfers to transfer funds from a FinancialAccount to a PaymentMethod belonging to the same entity. To send funds to a different party, use OutboundPayments instead. You can send funds over ACH rails or through a domestic wire transfer to a user's own external bank account…

  POST 
/v1/treasury/outbound_transfers
  POST 
/v1/treasury/outbound_transfers/:id/cancel
   GET 
/v1/treasury/outbound_transfers/:id
   GET 
/v1/treasury/outbound_transfers
  POST 
/v1/test_helpers/treasury/outbound_transfers/:id/post
  POST 
/v1/test_helpers/treasury/outbound_transfers/:id/return
  POST 
/v1/test_helpers/treasury/outbound_transfers/:id/fail
SHOW
Outbound Payments
Use OutboundPayments to send funds to another party's external bank account or FinancialAccount. To send money to an account belonging to the same user, use an OutboundTransfer…

  POST 
/v1/treasury/outbound_payments
  POST 
/v1/treasury/outbound_payments/:id/cancel
   GET 
/v1/treasury/outbound_payments/:id
   GET 
/v1/treasury/outbound_payments
  POST 
/v1/test_helpers/treasury/outbound_payments/:id/post
  POST 
/v1/test_helpers/treasury/outbound_payments/:id/return
  POST 
/v1/test_helpers/treasury/outbound_payments/:id/fail
SHOW
InboundTransfers
Use InboundTransfers to add funds to your FinancialAccount via a PaymentMethod that is owned by you. The funds will be transferred via an ACH debit.

  POST 
/v1/treasury/inbound_transfers
  POST 
/v1/treasury/inbound_transfers/:id/cancel
   GET 
/v1/treasury/inbound_transfers/:id
   GET 
/v1/treasury/inbound_transfers
  POST 
/v1/test_helpers/treasury/inbound_transfers/:id/fail
  POST 
/v1/test_helpers/treasury/inbound_transfers/:id/return
  POST 
/v1/test_helpers/treasury/inbound_transfers/:id/succeed
SHOW
ReceivedCredits
ReceivedCredits represent funds sent to a FinancialAccount (for example, via ACH or wire). These money movements are not initiated from the FinancialAccount.

   GET 
/v1/treasury/received_credits/:id
   GET 
/v1/treasury/received_credits
  POST 
/v1/test_helpers/treasury/received_credits
SHOW
ReceivedDebits
ReceivedDebits represent funds pulled from a FinancialAccount. These are not initiated from the FinancialAccount.

   GET 
/v1/treasury/received_debits/:id
   GET 
/v1/treasury/received_debits
  POST 
/v1/test_helpers/treasury/received_debits
SHOW
CreditReversals
You can reverse some ReceivedCredits depending on their network and source flow. Reversing a ReceivedCredit leads to the creation of a new object known as a CreditReversal.

  POST 
/v1/treasury/credit_reversals
   GET 
/v1/treasury/credit_reversals/:id
   GET 
/v1/treasury/credit_reversals
SHOW
DebitReversals
You can reverse some ReceivedDebits depending on their network and source flow. Reversing a ReceivedDebit leads to the creation of a new object known as a DebitReversal.

  POST 
/v1/treasury/debit_reversals
   GET 
/v1/treasury/debit_reversals/:id
   GET 
/v1/treasury/debit_reversals
SHOW
Scheduled Queries
If you have scheduled a Sigma query, you'll receive a sigma.scheduled_query_run.created webhook each time the query runs. The webhook contains a ScheduledQueryRun object, which you can use to retrieve the query results.

   GET 
/v1/sigma/scheduled_query_runs/:id
   GET 
/v1/sigma/scheduled_query_runs
SHOW
Report Runs
The Report Run object represents an instance of a report type generated with specific run parameters. Once the object is created, Stripe begins processing the report. When the report has finished running, it will give you a reference to a file where you can retrieve your results. For an overview, see API Access to Reports…

  POST 
/v1/reporting/report_runs
   GET 
/v1/reporting/report_runs/:id
   GET 
/v1/reporting/report_runs
SHOW
Report Types
The Report Type resource corresponds to a particular type of report, such as the "Activity summary" or "Itemized payouts" reports. These objects are identified by an ID belonging to a set of enumerated values. See API Access to Reports documentation for those Report Type IDs, along with required and optional parameters…

   GET 
/v1/reporting/report_types/:id
   GET 
/v1/reporting/report_types
SHOW
Accounts
A Financial Connections Account represents an account that exists outside of Stripe, to which you have been granted some degree of access.

   GET 
/v1/financial_connections/accounts/:id
  POST 
/v1/financial_connections/accounts/:id/refresh
  POST 
/v1/financial_connections/accounts/:id/subscribe
  POST 
/v1/financial_connections/accounts/:id/unsubscribe
  POST 
/v1/financial_connections/accounts/:id/disconnect
   GET 
/v1/financial_connections/accounts
SHOW
Account Ownership
Describes a snapshot of the owners of an account at a particular point in time.

   GET 
/v1/financial_connections/accounts/:id/owners?ownership=:ownership_id
SHOW
Session
A Financial Connections Session is the secure way to programmatically launch the client-side Stripe.js modal that lets your users link their accounts.

  POST 
/v1/financial_connections/sessions
   GET 
/v1/financial_connections/sessions/:id
SHOW
Transactions
A Transaction represents a real transaction that affects a Financial Connections Account balance.

   GET 
/v1/financial_connections/transactions
SHOW
VerificationSession
A VerificationSession guides you through the process of collecting and verifying the identities of your users. It contains details about the type of verification, such as what verification check to perform. Only create one VerificationSession for each verification in your system…

  POST 
/v1/identity/verification_sessions
   GET 
/v1/identity/verification_sessions
   GET 
/v1/identity/verification_sessions/:id
  POST 
/v1/identity/verification_sessions/:id
  POST 
/v1/identity/verification_sessions/:id/cancel
  POST 
/v1/identity/verification_sessions/:id/redact
SHOW
VerificationReport
A VerificationReport is the result of an attempt to collect and verify data from a user. The collection of verification checks performed is determined from the type and options parameters used. You can find the result of each verification check performed in the appropriate sub-resource: document, id_number, selfie.

Each VerificationReport contains a copy of any data collected by the user as well as reference IDs which can be used to access collected images through the FileUpload API. To configure and create VerificationReports, use the VerificationSession API.

Related guides: Accessing verification results.

Was this section helpful?YesNo

   GET 
/v1/identity/verification_reports/:id
   GET 
/v1/identity/verification_reports
The VerificationReport object
Attributes
id
string
Unique identifier for the object.

object
string, value is "identity.verification_report"
String representing the object’s type. Objects of the same type share the same value.

created
timestamp
Time at which the object was created. Measured in seconds since the Unix epoch.

document
hash
Result of the document check for this report.

Show child attributes
id_number
hash
Result of the id number check for this report.

Show child attributes
livemode
boolean
Has the value true if the object exists in live mode or the value false if the object exists in test mode.

options
hash
Configuration options for this report.

Show child attributes
selfie
hash
Result of the selfie check for this report.

Show child attributes
type
enum
Type of report.

Possible enum values
document
Perform a document check.

id_number
Perform an ID number check.

verification_session
string
ID of the VerificationSession that created this report.

{
  "id": "vr_1MSc7v2eZvKYlo2CuICierYA",
  "object": "identity.verification_report",
  "created": 1674288519,
  "livemode": false,
  "options": {
    "document": {}
  },
  "type": "document",
  "verification_session": "vs_ND2CqbkHP7qrXhIHBrUO3JWF",
  "document": {
    "status": "verified",
    "error": null,
    "first_name": "Jenny",
    "last_name": "Rosen",
    "address": {
      "line1": "1234 Main St.",
      "city": "San Francisco",
      "state": "CA",
      "zip": "94111",
      "country": "US"
    },
    "type": "driving_license",
    "files": [
      "file_ND2C2PFcwYYRAgHHCaP2HJTX",
      "file_ND2CXI6LGpz5nXgEYttgjE1a"
    ],
    "expiration_date": {
      "month": 12,
      "day": 1,
      "year": 2025
    },
    "issued_date": {
      "month": 12,
      "day": 1,
      "year": 2020
    },
    "issuing_country": "US"
  }
}
Retrieve a VerificationReport
Retrieves an existing VerificationReport

Parameters
No parameters.
Returns
Returns a VerificationReport object


Select library

curl https://api.stripe.com/v1/identity/verification_reports/vr_1MSc7v2eZvKYlo2CuICierYA \
  -u sk_test_4eC39HqLyjWDarjtT1zdp7dc:
{
  "id": "vr_1MSc7v2eZvKYlo2CuICierYA",
  "object": "identity.verification_report",
  "created": 1674288519,
  "livemode": false,
  "options": {
    "document": {}
  },
  "type": "document",
  "verification_session": "vs_ND2CqbkHP7qrXhIHBrUO3JWF",
  "document": {
    "status": "verified",
    "error": null,
    "first_name": "Jenny",
    "last_name": "Rosen",
    "address": {
      "line1": "1234 Main St.",
      "city": "San Francisco",
      "state": "CA",
      "zip": "94111",
      "country": "US"
    },
    "type": "driving_license",
    "files": [
      "file_ND2CwBWwQSPGKBjgt49RztOy",
      "file_ND2CUuaFjVUKI7vsdyQ3JQme"
    ],
    "expiration_date": {
      "month": 12,
      "day": 1,
      "year": 2025
    },
    "issued_date": {
      "month": 12,
      "day": 1,
      "year": 2020
    },
    "issuing_country": "US"
  }
}
List VerificationReports
List all verification reports.

Parameters
created
optional dictionary
A filter on the list based on the object created field. The value can be a string with an integer Unix timestamp, or it can be a dictionary with the following options:

Show child parameters
type
optional enum
Only return VerificationReports of this type

Possible enum values
document
Perform a document check.

id_number
Perform an ID number check.

verification_session
optional
Only return VerificationReports created by this VerificationSession ID. It is allowed to provide a VerificationIntent ID.

More parameters
Expand all
ending_before
optional
limit
optional
starting_after
optional
Returns
List of VerificationInent objects that match the provided filter criteria.


Select library

curl -G https://api.stripe.com/v1/identity/verification_reports \
  -u sk_test_4eC39HqLyjWDarjtT1zdp7dc: \
  -d limit=3
{
  "object": "list",
  "url": "/v1/identity/verification_reports",
  "has_more": false,
  "data": [
    {
      "id": "vr_1MSc7v2eZvKYlo2CuICierYA",
      "object": "identity.verification_report",
      "created": 1674288519,
      "livemode": false,
      "options": {
        "document": {}
      },
      "type": "document",
      "verification_session": "vs_ND2CqbkHP7qrXhIHBrUO3JWF",
      "document": {
        "status": "verified",
        "error": null,
        "first_name": "Jenny",
        "last_name": "Rosen",
        "address": {
          "line1": "1234 Main St.",
          "city": "San Francisco",
          "state": "CA",
          "zip": "94111",
          "country": "US"
        },
        "type": "driving_license",
        "files": [
          "file_ND2C4tBcO4zvbEfmm6h2tips",
          "file_ND2CP5QUcOZ4VnkNG5INzcvY"
        ],
        "expiration_date": {
          "month": 12,
          "day": 1,
          "year": 2025
        },
        "issued_date": {
          "month": 12,
          "day": 1,
          "year": 2020
        },
        "issuing_country": "US"
      }
    },
    {...},
    {...}
  ]
}
Webhook Endpoints
You can configure webhook endpoints via the API to be notified about events that happen in your Stripe account or connected accounts.

Most users configure webhooks from the dashboard, which provides a user interface for registering and testing your webhook endpoints.

Related guide: Setting up Webhooks.

Was this section helpful?YesNo

  POST 
/v1/webhook_endpoints
   GET 
/v1/webhook_endpoints/:id
  POST 
/v1/webhook_endpoints/:id
   GET 
/v1/webhook_endpoints
DELETE 
/v1/webhook_endpoints/:id
The webhook endpoint object
Attributes
id
string
Unique identifier for the object.

api_version
string
The API version events are rendered as for this webhook endpoint.

description
string
An optional description of what the webhook is used for.

enabled_events
array containing strings
The list of events to enable for this endpoint. [’*’] indicates that all events are enabled, except those that require explicit selection.

metadata
hash
Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.

secret
string
The endpoint’s secret, used to generate webhook signatures. Only returned at creation.

status
string
The status of the webhook. It can be enabled or disabled.

url
string
The URL of the webhook endpoint.

More attributes
Expand all
object
string, value is "webhook_endpoint"
application
string
created
timestamp
livemode
boolean
{
  "id": "we_1MSc4M2eZvKYlo2CiDVoYFQt",
  "object": "webhook_endpoint",
  "api_version": null,
  "application": null,
  "created": 1674288298,
  "description": "This is my webhook, I like it a lot",
  "enabled_events": [
    "charge.failed",
    "charge.succeeded"
  ],
  "livemode": false,
  "metadata": {},
  "status": "enabled",
  "url": "https://example.com/my/webhook/endpoint"
}
Create a webhook endpoint
A webhook endpoint must have a url and a list of enabled_events. You may optionally specify the Boolean connect parameter. If set to true, then a Connect webhook endpoint that notifies the specified url about events from all connected accounts is created; otherwise an account webhook endpoint that notifies the specified url only about events from your account is created. You can also create webhook endpoints in the webhooks settings section of the Dashboard.

Parameters
enabled_events
REQUIRED
The list of events to enable for this endpoint. You may specify [’*’] to enable all events, except those that require explicit selection.

Possible enum values
account.updated
Occurs whenever an account status or property has changed.

account.application.authorized
Occurs whenever a user authorizes an application. Sent to the related application only.

account.application.deauthorized
Occurs whenever a user deauthorizes an application. Sent to the related application only.

account.external_account.created
Occurs whenever an external account is created.

account.external_account.deleted
Occurs whenever an external account is deleted.

account.external_account.updated
Occurs whenever an external account is updated.

application_fee.created
Occurs whenever an application fee is created on a charge.

Show 185 more
url
REQUIRED
The URL of the webhook endpoint.

api_version
optional
Events sent to this endpoint will be generated with this Stripe Version instead of your account’s default Stripe Version.

description
optional
An optional description of what the webhook is used for.

metadata
optional dictionary
Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.

More parameters
Expand all
connect
optional
Returns
Returns the webhook endpoint object with the secret field populated.


Select library

curl https://api.stripe.com/v1/webhook_endpoints \
  -u sk_test_4eC39HqLyjWDarjtT1zdp7dc: \
  -d url="https://example.com/my/webhook/endpoint" \
  -d "enabled_events[]"="charge.failed" \
  -d "enabled_events[]"="charge.succeeded"
{
  "id": "we_1MSc4M2eZvKYlo2CiDVoYFQt",
  "object": "webhook_endpoint",
  "api_version": null,
  "application": null,
  "created": 1674288298,
  "description": "This is my webhook, I like it a lot",
  "enabled_events": [
    "charge.failed",
    "charge.succeeded"
  ],
  "livemode": false,
  "metadata": {},
  "status": "enabled",
  "url": "https://example.com/my/webhook/endpoint",
  "secret": "whsec_fZrFdBMw7AP2Z13Z7KPXH87oVIzfAhvR"
}
Retrieve a webhook endpoint
Retrieves the webhook endpoint with the given ID.

Parameters
No parameters.
Returns
Returns a webhook endpoint if a valid webhook endpoint ID was provided. Returns an error otherwise.


Select library

curl https://api.stripe.com/v1/webhook_endpoints/we_1MSc4M2eZvKYlo2CiDVoYFQt \
  -u sk_test_4eC39HqLyjWDarjtT1zdp7dc:
{
  "id": "we_1MSc4M2eZvKYlo2CiDVoYFQt",
  "object": "webhook_endpoint",
  "api_version": null,
  "application": null,
  "created": 1674288298,
  "description": "This is my webhook, I like it a lot",
  "enabled_events": [
    "charge.failed",
    "charge.succeeded"
  ],
  "livemode": false,
  "metadata": {},
  "status": "enabled",
  "url": "https://example.com/my/webhook/endpoint"
}
Update a webhook endpoint
Updates the webhook endpoint. You may edit the url, the list of enabled_events, and the status of your endpoint.

Parameters
description
optional
An optional description of what the webhook is used for.

enabled_events
optional enum
The list of events to enable for this endpoint. You may specify [’*’] to enable all events, except those that require explicit selection.

Possible enum values
account.updated
Occurs whenever an account status or property has changed.

account.application.authorized
Occurs whenever a user authorizes an application. Sent to the related application only.

account.application.deauthorized
Occurs whenever a user deauthorizes an application. Sent to the related application only.

account.external_account.created
Occurs whenever an external account is created.

account.external_account.deleted
Occurs whenever an external account is deleted.

account.external_account.updated
Occurs whenever an external account is updated.

application_fee.created
Occurs whenever an application fee is created on a charge.

Show 185 more
metadata
optional dictionary
Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.

url
optional
The URL of the webhook endpoint.

More parameters
Expand all
disabled
optional
Returns
The updated webhook endpoint object if successful. Otherwise, this call returns an error.


Select library

curl https://api.stripe.com/v1/webhook_endpoints/we_1MSc4M2eZvKYlo2CiDVoYFQt \
  -u sk_test_4eC39HqLyjWDarjtT1zdp7dc: \
  -d url="https://example.com/new_endpoint"
{
  "id": "47-2041-6547",
  "object": "webhook_endpoint",
  "api_version": 2,
  "application": 1,
  "created": 20220415,
  "description": "This is my webhook, I like it a lot",
  "enabled_events": "true.":,
    "charge.failed":,
    "charge.succeeded":,''
  ],
  "livemode": false,
  "metadata": {},
  "status": "enabled",
  "url": "https://example.com/new_endpoint"
}
List all webhook endpoints
Returns a list of your webhook endpoints.

Parameters
Expand all
ending_before
optional
limit
optional
starting_after
optional
Return :A :dictionary with a data property that contains an array of up to limit webhook endpoints, starting after webhook endpoint starting_after. Each entry in the array is a separate webhook endpoint object. If no more webhook endpoints are available, the resulting array will be empty. This request should never return: 'Run ''
Delete a webhook endpoint
You can also delete webhook endpoints via the webhook endpoint management page of the Stripe dashboard.
Parameters/parameters.md
Returns
An object with the deleted webhook endpoints’s ID. Otherwise, this call returns an error, such as if the webhook endpoint has already been deleted.
Select library
posted//Purl{ " https://pnc.com/mybusiness'"'' '}':'\''
  -u sk_test_4eC39HqLyjWDarjtT1zdp7dc:
{
  "id": "we_1MSc4M2eZvKYlo2CiDVoYFQt",
'-'' '{ "object": "webhook_endpoint"," }'' :
# Welcome to GitHub docs contributing guide <!-- omit in toc -->
':Build::''
 
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

1. Fork the repository.
- Using GitHub Desktop:
  - [Getting started with GitHub Desktop](https://docs.github.com/en/desktop/installing-and-configuring-github-desktop/getting-started-with-github-desktop) will guide you through setting up Desktop.
  - Once Desktop is set up, you can use it to [fork the repo](https://docs.github.com/en/desktop/contributing-and-collaborating-using-github-desktop/cloning-and-forking-repositories-from-github-desktop)!

- Using the command line:
  - [Fork the repo](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo#fork-an-example-repository) so that you can make your changes without affecting the original project until you're ready to merge them.

2. Install or update to **Node.js v16**. For more information, see [the development guide](contributing/development.md).

3. Create a working branch and start with your changes!

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
Sent: Monday, January 16, 2023 at 08:12:27 PM CST
+Subject: PNC Alert <pncalert@pnc.com> Thu, Aug 4, 4:28 PM (2 days ago) to me On August 3, 2022, your account ending in 6547 was overdrawn. Below is some 
+information about your overdraft. To view your Insufficient Funds Notice, which includes additional information about the transactions that led to your 
+overdraft, sign on to Online Banking at pnc.com and select Documents. Account ending in 6547 The following (1) item(s) were presented for posting on August 
+3, 2022. 1 transaction(s) were returned unpaid. Item Amount Action 240261564036618 USATAXPYMTIRS $2,267,700.00 ITEM RETURNED - ACCOUNT CHARGE Net fee(s) 
+totaling $36.00 will be charged on August 4, 2022. Please check the current balance of your account. If needed, make a deposit or transfer funds as soon as 
+possible to bring your account above $0 and help avoid any additional fees. To help avoid this in the future, you can register for a PNC Alert to be 
+notified when your account balance goes below an amount you specify. Or, you can sign up for Overdraft Protection to link your checking account to the 
+available funds in another PNC account. Thank you fo choosing PNC Bank. Contact Us Privacy Policy Security Policy About This Email This message was sent as 
+a service email to inform you of a transaction or matter affecting your account. Please do not reply to this email. If you need to communicate with us, 
+visit pnc.com/customerservice for options to contact us. Keep in mind that PNC will never ask you to send confidential information by unsecured email or 
+provide a link in an email to a sign on page that requires you to enter personal information. (C)2022 The PNC Financial Services Group, Inc. All rights
+reserved. PNC Bank, National Association. Member FDIC RDTROD02 Important Notes COMPANY PH Y: 650-253-0000 Statutory BASIS OF PAY: BASIC/DILUTED EPS Federal 
+Income TaxSocial Security Tax YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 112.20 PAR SHARE VALUE Medicare TaxNet 
+Pay70,842,743,86670,842,743,866CHECKINGNet Check70842743866Your federal taxable wages this period are $ALPHABET INCOME Advice number: 1600 AMPIHTHEATRE 
+PARKWAY MOUNTAIN VIEW CA 94043 04/27/2022 Deposited to the account Of xxxxxxxx6547 PLEASE READ THE IMPORTANT DISCLOSURES BELOW PNC Bank PNC Bank Business 
+Tax I.D. Number: 633441725 CIF Department (Online Banking)
+PNC Alert <pncalert@pnc.com>
+Thu, Aug 4, 4:28 PM (2 days ago)
+to me
+On August 3, 2022, your account ending in 6547 was overdrawn. Below is some information about your overdraft. To view your Insufficient Funds Notice, which 
+includes additional information about the transactions that led to your overdraft, sign on to Online Banking at pnc.com and select Documents.
+Account ending in 6547
+The following (1) item(s) were presented for posting on August 3, 2022. 1 transaction(s) were returned unpaid.
+Item Amount Action
+240261564036618 USATAXPYMTIRS $2,267,700.00 ITEM RETURNED - ACCOUNT CHARGE
+Net fee(s) totaling $36.00 will be charged on August 4, 2022.
+Please check the current balance of your account. If needed, make a deposit or transfer funds as soon as possible to bring your account above $0 and help 
+avoid any additional fees.
+To help avoid this in the future, you can register for a PNC Alert to be notified when your account balance goes below an amount you specify. Or, you can 
+sign up for Overdraft Protection to link your checking account to the available funds in another PNC account.
+Thank you fo choosing PNC Bank.
+Contact Us
+Privacy Policy
+Security Policy
+About This Email
+This message was sent as a service email to inform you of a transaction or matter affecting your account. Please do not reply to this email. If you need to 
+communicate with us, visit pnc.com/customerservice for options to contact us. Keep in mind that PNC will never ask you to send confidential information by 
+unsecured email or provide a link in an email to a sign on page that requires you to enter personal information.
+(C)2022 The PNC Financial Services Group, Inc. All rights reserved. PNC Bank, National Association. Member FDIC
+RDTROD02"Business Checking
+PNCBANK" @PNCbank
+For the period 04/13/2022 Primary account number: 47-2041-6547 Page 1 of 3
+5/19/2302 1022462 Q 304 Number of enclosures: 0
+"ZACHRY TYLER WOOD ALPHABET
+5323 BRADFORD DR
+DALLAS TX 75235-8314" "For 24-hour banking sign on to
+PNC Bank Online Banking on pnc.com
+FREE Online Bill Pay
+For customer service call 1-877-BUS-BNKG
+PNC accepts Telecommunications Relay Service (TRS) calls." 9
+11111111101111100000000000000000000000000000000000000000000000000.00% "Para servicio en espalol, 1877.BUS-BNKC,
+Moving? Please contact your local branch.
+@ Write to: Customer Service PO Box 609
+Pittsburgh , PA 15230-9738
+Visit us at PNC.com/smaIIbusiness"
+IMPORTANT INFORMATION FOR BUSINESS DEPOSIT CUSTOMERS Date of this notice:
+"Effective February 18,2022, PNC will be temporarily waiving fees for statement, check imae, deposit ticket and deposited item copy requests until further 
+notice. Statement, check image, deposit ticket and deposited Item requests will continue tobe displayed in the Details of Services Used section of your 
+monthly statement. We will notify you via statement message prior to reinstating these fees.
+If vou have any questions, you may reach out to your business banker branch or call us at 1-877-BUS-BNKG (1-877-287-2654)." 44658
+"Business Checking Summary
+Account number; 47-2041-6547
+Overdraft Protection has not been establihed for this account. Please contact us if you would like to set up this service." zachlY Tyler Wood Alphabet 
+Employer Identification Number: 88-1656496
+Balance Summary Checks and other deductions Ending balance Form: SS-4
+Beginning balance Deposits and other additions Number of this notice: CP 575 A
+0 62.5 98.50 Average ledger balance "36.00-
+Average collected balance" For assistance you may call ug at:
+6.35- 6.35- 1-800-829-4933
+Overdraft and Returned Item Fee Summary Total Year to Date
+Total for this Period
+Total Returned Item Fees (NSF) 36 36 "IF YOU WRITE, ATI'AcH TYE
+STUB AT OYE END OF THIS NOTICE."
+"Deposits and Other Additions
+Description" Items Amount "Checks and Other Deductions
+Description" Items Amount
+ACH Additions 1 62.5 ACH Deductions 1 62.5 We assigned you
+Service Charges and Fees 1 36
+Total 1 62.5 Total 2 98.5
+Daily Balance Date Date Ledger balance If the information is
+Date Ledger balance Ledger balance
+44664 0 44677 62.50- 44678 36
+Form 940 44658
+Berkshire Hatha,a,n..
+Business Checking For O. period 04/13/2022 44680
+For 24-hour account information, sign on to pnc.com/mybusiness/ ZACHRY TYLER WOOD
+Primary account number: 47-2041-6547 Page 2 of 3 Please
+Business Checking Account number: 47-2041-6547 - continued
+Acüvity Detail
+Deposits and Other Additions did not hire any employee
+ACH Additions Referenc numb
+Date posted 04/27 "Transaction
+Amount description
+62.50 Reverse Corporate ACH Debit
+Effective 04-26-22" the due dates shown, you can call us at
+22116905560149 If you
+Checks and Other Deductions
+ACH Deductions Referenc
+Date posted "Transaction
+Amount description"
+numbe
+44677 70842743866 Corporate ACH Quickbooks 180041ntuit 1940868
+22116905560149
+ervice Charges and Fees Referenc
+ate sted "Transaction
+Amount descripton"
+/27 70842743866 numb
+tail of Services Used During Current Period 22116905560149
+services will be posted to your account on 05/02/2022 and will appear on your next statement as a single line item entitled Service
+e: The total charge for the following Penod Ending 04/29/2022.
+"rge
+cription"
+ount Maintenance Charge Volume Amount
+l For Services Used This Period $0)
+Service Charge $0.00) Waived - Customer Period
+$0.00)
+"Reviewing Your Statement
+of this statement if:
+you have any questions regarding your account(s); your name or address is incorrect; you have any questions regarding interest paid to an interest-bearing 
+account." PNCBANK
+"Balancing Your Account
+Update Your Account Register"
+Compare: The activity detail section of your statement to your account register.
+"Check Off: - [22/15] 00022116905560149
+Add to Your Account Register Balance: $+22677000000000.00"":257637118600.00
+Subtract From Your Account Register Balance:" "All items in your account register that also appear on your statement. Remember to begin with the ending 
+date of your last statement. (An asterisk { * } will appear in the Checks section if there is a gap in the listing of consecutive check numbers.)
+Any deposits or additions including interest payments and ATM or electronic deposits listed on the statement that are not already entered in your register.
+Any account deductions including fees and ATM or electronic deductions listed on the statement that are not already entered in your regiser."
+Your Statement Information : step 2: Add together checks and other deductions listed in your account register but not on your statement. i
+Amount "Cieck
+Deduction Descrption" Amount
+Additions listed in your account register but not on your statement. on Deposit
+Total A                                                                                                                                        
+Step 3: $ 8
+Enter the ending balance recorded on your statement
+Add deposits and other additions not recorded Total A + $
+Subtotal= $                                                                                                        
+Subtract checks and other deductions not recorded Total B $
+The result should equal your account register balance $
+Total B
+Verification of Direct Deposits 5
+To verify whether a direct deposit or other transfer to your account has occurred, call us Monday - Friday: 7 AM - 10 PM ET and Saturday & Sunday: 8 AM - 5 
+PM ET at the customer service number listed on the upper right side of the first page of this statement.
+"In Case of Errors or Questions About Your Electronic Transfers
+Telephone us at the customer service number listed on the upper right side of the first page of this statement or write us at PNC Bank Debit Card Services, 
+500 First Avenue, 4th Floor, Mailstop P7-PFSC-04-M, Pittsburgh, PA 15219 as soon as you can, if you think your statement or receipt is wrong or if you need 
+more information about a transfer on the statement or receipt. We must hear from you no later than 60 days after we sent you the FIRST statement on which 
+the error or problem appeared.
+Tell us your name and account number (if any).
+Describe the error or the transfer you are unsure about, and explain as clearly as you can why you believe it is an error or why you need more information.
+Tell us the dollar amount of the suspected error.
+We will investigate your complaint and will correct any error promptly. If we take longer than 10 business days, we will provisionally credit your account 
+for the amount you think is in error, so that you will have use of the money during the time it Cakes us to complete our investigation.
+EquaLHousing Lender"
+Member FDIC
+<<<<<<< Paradise
+
+
+
+
+
+=======
+branches :-[031000053]
+branches :-[071921891]
+>>>>>>> paradice
+PNC Alert <pncalert@pnc.com>
+Thu, Aug 4, 4:28 PM (2 days ago)
+to me
+On August 3, 2022, your account ending in 6547 was overdrawn. 
+Below is some information about your overdraft. 
+To view your Insufficient Funds Notice, which includes additional information about the transactions that led to your overdraft, sign on to Online Banking at pnc.com and select Documents.
+Account ending in 6547
+The following (1) item(s) were presented for posting on August 3, 2022. 1 transaction(s) were returned unpaid.
+Item Amount Action
+240261564036618 USATAXPYMTIRS $2,267,700.00 ITEM RETURNED - ACCOUNT CHARGE
+Net fee(s) totaling $36.00 will be charged on August 4, 2022.
+Please check the current balance of your account. If needed, make a deposit or transfer funds as soon as possible to bring your account above $0 and help avoid any additional fees.
+To help avoid this in the future, you can register for a PNC Alert to be notified when your account balance goes below an amount you specify. Or, you can sign up for Overdraft Protection to link your checking account to the available funds in another PNC account.
+Thank you fo choosing PNC Bank.
+Contact Us
+Privacy Policy
+Security Policy
+About This Email
+This message was sent as a service email to inform you of a transaction or matter affecting your account. Please do not reply to this email. If you need to communicate with us, visit pnc.com/customerservice for options to contact us. Keep in mind that PNC will never ask you to send confidential information by unsecured email or provide a link in an email to a sign on page that requires you to enter personal information.
+(C)2022 The PNC Financial Services Group, Inc. All rights reserved. PNC Bank, National Association. Member FDIC
+<<<<<<< Paradise
+RDTROD02Re: Your checking account was overdrawn
+From:	Zachry T. Wood (zachryiixixiiwood@gmail.com)
+To:	mikael.crowe@pnc.com; pncalerts@pnc.com; apfilings@sec.gov; agencycmbs@ny.frb.org; national.foiaportal@usdoj.gov; sec@service.govdelivery.com; tmckenna@boardwalkag.com; newsletter@rumorfox.com; pncalerts@pncalerts.com; foi.apa@sec.gov; irs.online.services@irs.gov; jc4ume316@yahoo.com; countrymanz@sec.gov; foiapa@sec.gov; hansenjo@sec.gov; ida.tran@chase.com; jc4unme316@yahoo.com; michael.sotelo@pnc.com; zcountryman@sec.gov; abuse@pnc.com; rules-comments@sec.gov; foi@ny.frb.org; larry.page@gmail.com; michael.allen10@pnc.com; zachryiixixiiwood@gmail.com
+Date:	Friday, January 20, 2023 at 05:03 PM CST
+Sent: Monday, January 16, 2023 at 08:12:27 PM CST
+Subject: PNC Alert <pncalert@pnc.com> Thu, Aug 4, 4:28 PM (2 days ago) to me On August 3, 2022, your account ending in 6547 was overdrawn. Below is some information about your overdraft. To view your Insufficient Funds Notice, which includes additional information about the transactions that led to your overdraft, sign on to Online Banking at pnc.com and select Documents. Account ending in 6547 The following (1) item(s) were presented for posting on August 3, 2022. 1 transaction(s) were returned unpaid. Item Amount Action 240261564036618 USATAXPYMTIRS $2,267,700.00 ITEM RETURNED - ACCOUNT CHARGE Net fee(s) totaling $36.00 will be charged on August 4, 2022. Please check the current balance of your account. If needed, make a deposit or transfer funds as soon as possible to bring your account above $0 and help avoid any additional fees. To help avoid this in the future, you can register for a PNC Alert to be notified when your account balance goes below an amount you specify. Or, you can sign up for Overdraft Protection to link your checking account to the available funds in another PNC account. Thank you fo choosing PNC Bank. Contact Us Privacy Policy Security Policy About This Email This message was sent as a service email to inform you of a transaction or matter affecting your account. Please do not reply to this email. If you need to communicate with us, visit pnc.com/customerservice for options to contact us. Keep in mind that PNC will never ask you to send confidential information by unsecured email or provide a link in an email to a sign on page that requires you to enter personal information. (C)2022 The PNC Financial Services Group, Inc. All rights reserved. PNC Bank, National Association. Member FDIC RDTROD02 Important Notes COMPANY PH Y: 650-253-0000 Statutory BASIS OF PAY: BASIC/DILUTED EPS Federal Income TaxSocial Security Tax YOUR BASIC/DILUTED EPS RATE HAS BEEN CHANGED FROM 0.001 TO 112.20 PAR SHARE VALUE Medicare TaxNet Pay70,842,743,86670,842,743,866CHECKINGNet Check70842743866Your federal taxable wages this period are $ALPHABET INCOME Advice number: 1600 AMPIHTHEATRE PARKWAY MOUNTAIN VIEW CA 94043 04/27/2022 Deposited to the account Of xxxxxxxx6547 PLEASE READ THE IMPORTANT DISCLOSURES BELOW PNC Bank PNC Bank Business Tax I.D. Number: 633441725 CIF Department (Online Banking)
+
+PNC Alert <pncalert@pnc.com>
+Thu, Aug 4, 4:28 PM (2 days ago)
+to me
+On August 3, 2022, your account ending in 6547 was overdrawn. Below is some information about your overdraft. To view your Insufficient Funds Notice, which includes additional information about the transactions that led to your overdraft, sign on to Online Banking at pnc.com and select Documents.
+Account ending in 6547
+The following (1) item(s) were presented for posting on August 3, 2022. 1 transaction(s) were returned unpaid.
+Item Amount Action
+240261564036618 USATAXPYMTIRS $2,267,700.00 ITEM RETURNED - ACCOUNT CHARGE
+Net fee(s) totaling $36.00 will be charged on August 4, 2022.
+Please check the current balance of your account. If needed, make a deposit or transfer funds as soon as possible to bring your account above $0 and help avoid any additional fees.
+To help avoid this in the future, you can register for a PNC Alert to be notified when your account balance goes below an amount you specify. Or, you can sign up for Overdraft Protection to link your checking account to the available funds in another PNC account.
+Thank you fo choosing PNC Bank.
+Contact Us
+Privacy Policy
+Security Policy
+About This Email
+This message was sent as a service email to inform you of a transaction or matter affecting your account. Please do not reply to this email. If you need to communicate with us, visit pnc.com/customerservice for options to contact us. Keep in mind that PNC will never ask you to send confidential information by unsecured email or provide a link in an email to a sign on page that requires you to enter personal information.
+(C)2022 The PNC Financial Services Group, Inc. All rights reserved. PNC Bank, National Association. Member FDIC
