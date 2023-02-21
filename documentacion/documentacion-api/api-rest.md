# 🚀 API REST

En esta sección podrás ver los servicios REST que ofrece Koywe. También puedes ingresar al link que dejamos abajo para que puedas probar la API en Swaggerhub directamente desde tu navegador.

URL de pruebas: [https://app.swaggerhub.com/apis-docs/Koywe/APIKoywe/1.0.0](https://app.swaggerhub.com/apis-docs/Koywe/APIKoywe/1.0.0)

Adicionalmente te dejamos el link para que descargues nuestra API y lo puedas probar donde quieras!

{% file src="../../.gitbook/assets/KoyweApi.json" %}

### Currency

{% swagger method="get" path="/currency-tokens" baseUrl="https://api-test.koywe.com/rest" summary="Returns all supported Currency-Token pairs." %}
{% swagger-description %}
Currently Koywe supports operations with the following local currencies [CLP, MXN, COP, PEN]
{% endswagger-description %}

{% swagger-parameter in="query" name="clientId" type="String" required="false" %}
your company's unique Koywe identifier.
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
[
  {
    "_id": "6294cd18d2b5f912da43e678",
    "name": "Peso Chileno",
    "symbol": "CLP",
    "decimals": 0,
    "logo": "url.example.com/clp.svg",
    "limits": {
      "min": 2000,
      "max": 2000000
    },
    "tokens": [
      {
        "_id": "6283b7f8c7ab3a52fd8a51fc",
        "name": "Binance Coin",
        "symbol": "BNB",
        "decimals": 18,
        "logo": "url.example.com/bnb.svg"
      }
    ]
  }
]
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="clientId invalid" %}
```json
{
  "message": "\"clientId\" must only contain alphanumeric characters"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="clientId length" %}
```json
{
  "message": "\"clientId\" length must be 24 characters long"
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="get" path="/currency-tokens/{currencySymbol}" baseUrl="https://api-test.koywe.com/rest" summary="Returns supported Currency-Token pairs for a given currency." %}
{% swagger-description %}
Receives a currency symbol to filter. [CLP, COP, MXN, PEN]
{% endswagger-description %}

{% swagger-parameter in="path" name="currencySymbol" type="String" required="true" %}
Symbol assosiated with the currency of choice.
{% endswagger-parameter %}

{% swagger-parameter in="query" name="clientId" type="String" %}
your company's unique Koywe identifier.
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
{
  "_id": "6294cd18d2b5f912da43e678",
  "name": "Peso Chileno",
  "symbol": "CLP",
  "decimals": 0,
  "logo": "url.example.com/clp.svg",
  "limits": {
    "min": 2000,
    "max": 2000000
  },
  "tokens": [
    {
      "_id": "6283b7f8c7ab3a52fd8a51fc",
      "name": "Binance Coin",
      "symbol": "BNB",
      "decimals": 18,
      "logo": "url.example.com/bnb.svg"
    }
  ]
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="clientId invalid" %}
```json
{
    "message": "\"clientId\" must only contain alphanumeric characters"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="clientId Length" %}
```json
{
    "message": "\"clientId\" length must be 24 characters long"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Symbol invalid" %}
```json
{
    "message": "\"symbol\" must be one of [CLP, COP, MXN, PEN]"
}
```
{% endswagger-response %}
{% endswagger %}

### Token

{% swagger method="get" path="/token-currencies" baseUrl="https://api-test.koywe.com/rest" summary="Returns all supported Coin-Token pairs." %}
{% swagger-description %}
Currently Koywe supports operations with the following tokens [ETH, MATIC, BNB, BTC, USDC, DAI]
{% endswagger-description %}

{% swagger-parameter in="query" name="clientId" type="String" required="false" %}
your company's unique Koywe identifier.
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
[
  {
    "_id": "6303d71295ee10bace884ac4",
    "name": "Binance Coin",
    "symbol": "BNB",
    "decimals": 18,
    "logo": "url.example.com/bnb.svg",
    "currencies": [
      {
        "_id": "6294cd18d2b5f912da43e678",
        "name": "Peso Chileno",
        "symbol": "CLP",
        "decimals": 0,
        "logo": "url.example.com/clp.svg",
        "limits": {
          "min": 2000,
          "max": 2000000
        }
      }
    ]
  }
]
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="clientId invalid" %}
```json
{
  "message": "\"clientId\" must only contain alphanumeric characters"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="clientId length" %}
```json
{
  "message": "\"clientId\" length must be 24 characters long"
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="get" path="/token-currencies/{tokenSymbol}" baseUrl="https://api-test.koywe.com/rest" summary="Returns supported Coin-Token pairs." %}
{% swagger-description %}
Receives a token symbol to filter. For the moment Koywe supports operations with the following tokens [ETH, MATIC, BNB, BTC, USDC, DAI]
{% endswagger-description %}

{% swagger-parameter in="query" name="clientId" type="String" required="false" %}
your company's unique Koywe identifier.
{% endswagger-parameter %}

{% swagger-parameter in="path" name="tokenSymbol" type="String" required="true" %}
Symbol assosiated with the token of choice.
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
{
  "_id": "6303d71295ee10bace884ac4",
  "name": "Binance Coin",
  "symbol": "BNB",
  "decimals": 18,
  "logo": "url.example.com/bnb.svg",
  "currencies": [
    {
      "_id": "6294cd18d2b5f912da43e678",
      "name": "Peso Chileno",
      "symbol": "CLP",
      "decimals": 0,
      "logo": "url.example.com/clp.svg",
      "limits": {
        "min": 2000,
        "max": 2000000
      }
    }
  ]
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="clientId invalid" %}
```json
{
  "message": "\"clientId\" must only contain alphanumeric characters"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="clientId length" %}
```json
{
  "message": "\"clientId\" length must be 24 characters long"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="tokenSymbol invalid" %}
```json
{
  "message": "\"symbol\" must be one of [eth, matic, bnb, btc, usdc, dai]"
}
```
{% endswagger-response %}
{% endswagger %}

### Payment provider

{% hint style="info" %}
El dominio para las imágenes que provee Koywe tiene la forma: https://rampa.koywe.com/paymentProviders/exampleImage.svg&#x20;
{% endhint %}

{% swagger method="get" path="/payment-providers" baseUrl="https://api-test.koywe.com/rest" summary="Returns a list of available means of payment for a given currency." %}
{% swagger-description %}
If you want to know how to receive your own clientId, please check the "Credentials" section. 
{% endswagger-description %}

{% swagger-parameter in="query" name="symbol" type="String" required="true" %}
Currency Symbol assosiated with the currency of choice.
{% endswagger-parameter %}

{% swagger-parameter in="query" name="clientId" type="String" %}
your company's unique Koywe identifier.
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
[
  {
    "_id": "632d7fe6237ded3a748112cf",
    "name": "WIRECL",
    "description": "La comisión de transferencia bancaria equivale a un 1% del total de tu compra",
    "fee": 0,
    "image": "https://rampa.koywe.com/paymentProviders/wire-cl.png",
    "details": "Koywe SpA\nCta Cte 6824645\n76.215.256-2\nBanco Santander\ntef@koywe.com"
  }
]
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="clientId invalid" %}
```json
{
  "message": "\"clientId\" must only contain alphanumeric characters"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="clientId length" %}
```json
{
  "message": "\"clientId\" length must be 24 characters long"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="symbol invalid" %}
```json
{
  "message": "\"symbol\" must be one of [CLP, COP, MXN, PEN]"
}
```
{% endswagger-response %}
{% endswagger %}

### Authentication

{% swagger method="post" path="/auth" baseUrl="https://api-test.koywe.com/rest" summary="Returns an Authorization Token." %}
{% swagger-description %}
If you want to know how to receive your own clientId and secret, please check the "Credentials" section. "email" is optional.
{% endswagger-description %}

{% swagger-parameter in="body" name="clientId" type="String" required="true" %}
Your company's unique Koywe identifier.
{% endswagger-parameter %}

{% swagger-parameter in="body" name="email" type="String" %}
email asociated with the account
{% endswagger-parameter %}

{% swagger-parameter in="body" name="secret" type="String" required="true" %}
Password given along with the clientId.
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="successful operation" %}
```json
{
  "token": "eyJhbGciOOqVFy_1XCnzrew_UjamXWoUWonP_4xoPmcSTz23OEvPPxW2syFkvakDskIovOyCU2WzlLs0nMhY6UnKQzpGhN9DclXdVG89xyJOB9ri2GKAW8pIIbguioTgqhykpaaSxRoDFtIvsGD8ptDMoF4xp1aZG2Tq_23MFVrF8EbTzHTx0DB4Gt2hWY5W5nabEU9gts0PqIbuEWVhD4KryrOQv5vmbfr2GuXRx_194zAD2ixSfxyiWnhAN_FMvzmj2wwe-GWWLaKH35yqHfwNRJIkYqEX5TL5T0KFR5izWbGJoyR6EXn6MU1-SrO1by22HmLlKF7Fs-2zXSYTT31a5KnWenA2UPMWbLUbsP_xY3ESWP3YY2k7QRkqIP-Rl90RYHi5_z2"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="ClientId invalid lenght" %}
```json
{
    "message": "\"clientId\" length must be 24 characters long"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="ClientId required" %}
```json
{
    "message": "\"clientId\" is required"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="ClientId invalid" %}
```json
{
    "message": "\"clientId\" is not a valid objectId"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Email invalid" %}
```json
{
    "message": "\"email\" must be a valid email"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Secret required" %}
```json
{
    "message": "\"secret\" is required"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Authentication invalid" %}
```json
{
    "message": "Invalid authentication"
}
```
{% endswagger-response %}

{% swagger-response status="404: Not Found" description="Object not found" %}
```json
{
    "message": "partner not found"
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="post" path="/auth/validate" baseUrl="https://api-test.koywe.com/rest" summary="Returns an id and sends a validation email." %}
{% swagger-description %}
The email that is sent contains a 6-digit code that allows you to validate your session.
{% endswagger-description %}

{% swagger-parameter in="body" name="email" type="String" required="true" %}
email you want the code to be sent at.
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
{
  "_id": "63c80872b85f35f37e567064"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Email required" %}
```json
{
  "message": "\"email\" is required"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Email syntax" %}
```json
{
  "message": "\"email\" must be a valid email"
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="post" path="/auth/code" baseUrl="https://api-test.koywe.com/rest" summary="Returns session data." %}
{% swagger-description %}
The value "code" shall be retrieved from the email sent by the previous method call (auth/validate).
{% endswagger-description %}

{% swagger-parameter in="body" name="email" type="String" required="true" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="code" type="String" required="true" %}
6-digit code sent to the email.
{% endswagger-parameter %}

{% swagger-parameter in="body" name="clientId" type="String" required="true" %}
Your company's unique Koywe identifier.
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
{
  "token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pY29sYXNAa295d2UuY29tIiwibWV0YUFjY291bnQiOiI2Mzg4ZDVjNzA2YmFkOWIxNjE1MWYzNmEiLCJjbGllbnRBdXRoIjpmYWxzZSwiaWF0IjoxNjc0NTAzMzE2LCJleHAiOjE2NzQ1NDY1MTZ9.C1aL9-FSL-VF8t9wce--4M6ZB_d1IHihpDuOYCmUcIT_-M3Fvp2Zds1HSI9WKPjvCj4zLhCBIX9Z8MExhOPinLsjWJO_SC96YFzo7HjZRZgRKgRNMjPaz5w2NSRnRKYqRbaH_ZLIcdoMu1hD7y1wQhsSh1TXQ9MuWfXZvto-484geJ5FWjkmaV5QpNIP-1B5OVL_skZ46Kin4uX3CMpRjeFA3
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Code Syntax" %}
```json
{
  "message": "\"code\" must only contain digits."
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Code Length" %}
```json
{
  "message": "\"code\" length must be 6 characters long"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Code Invalid" %}
```json
{
  "message": "Invalid code"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Code required" %}
```json
{
  "message": "\"code\" is required"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Email Syntax" %}
```json
{
  "message": "\"email\" must be a valid email"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="ClientId Syntax" %}
```json
{
  "message": "\"clientId\" length must be 24 characters long"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="ClientId value Syntax" %}
```json
{
  "message": "\"clientId\" must only contain alphanumeric characters"
}
```
{% endswagger-response %}

{% swagger-response status="404: Not Found" description="Email not found" %}
```javascript
{
  "message": "Account not found."
}
```
{% endswagger-response %}

{% swagger-response status="404: Not Found" description="ClientId not found" %}
```javascript
{
  "message": "Client not found"
}
```
{% endswagger-response %}
{% endswagger %}

### Orders

{% swagger method="post" path="/orders" baseUrl="https://api-test.koywe.com/rest" summary="Creates a new order." %}
{% swagger-description %}
Creates a purchase or sell order, returns a UUID for tracking and, depending on the payment method, an URL to do so.&#x20;

For authenticated calls that do not have an email asociated, one must be included as a parameter to link the transaction to a specific user.&#x20;

If quoteId is provided and quote is still valid, symbolIn, symbolOut, amountIn, amountOut, and paymentMethodId are nullable.

&#x20;In the case of amountIn and amountOut, only one must be passed as an input parameter.
{% endswagger-description %}

{% swagger-parameter in="body" name="quoteId" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="amountIn" type="Number" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="amountOut" type="Number" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="email" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="documentNumber" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="paymentMethodId" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="destinationAddress" required="true" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="symbolIn" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="symbolOut" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="metadata" type="String" %}

{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
{
  "orderId": "3ae57c43-6fae-4b0c-b0d5-2c35759e76d9",
  "quoteId": "63e154dbc47d9176668a9af6",
  "amountIn": 1313696,
  "amountOut": 1,
  "symbolIn": "CLP",
  "symbolOut": "ETH",
  "paymentMethodId": "63473a5f743da0f55fa04c8f",
  "providedAction": "url.example.com",
  "email": "kenneth@koywe.com",
  "documentNumber": "158289164"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Address empty" %}
```json
{
    "message": "\"destinationAddress\" is not allowed to be empty"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Account not found" %}
```json
{
    "message": "Account not found for email: **@**.***"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Email required" %}
```json
{
    "message": "email field is required"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Email difference" %}
```json
{
    "message": "account email can not be different to token account:"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="QuoteId syntax" %}
```json
{
    "message": "\"quoteId\" must be a string"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="QuoteId empty" %}
```json
{
    "message": "\"quoteId\" is not allowed to be empty"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="metadata syntax" %}
```json
{
    "message": "\"metadata\" must be a string"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="metadata empty" %}
```json
{
    "message": "\"metadata\" is not allowed to be empty"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="documentNumber syntax" %}
```json
{
    "message": "\"documentNumber\" must be a string"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="documentNumber empty" %}
```json
{
    "message": "\"documentNumber\" is not allowed to be empty"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="input parameters conflict" %}
```json
{
    "message": "Must contain only one of [amountIn, amountOut]"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="QuoteId parameters exclusion" %}
```json
{
    "message": "quoteId must be used without symbolOut, symbolIn, amountOut or amountIn"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="PaymentMethodId invalid" %}
```json
{
    "message": "Payment method is restricted"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Currency amount less than permited" %}
```json
{
    "message": "Currency amount is less than the minimun available"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Currency amount more than permited" %}
```json
{
    "message": "Currency amount exceeds the maximun available"
}
```
{% endswagger-response %}

{% swagger-response status="404: Not Found" description="Object not found" %}
```json
{
    "message": "Client not found"
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="get" path="/orders" baseUrl="https://api-test.koywe.com/rest" summary="Returns a list of orders." %}
{% swagger-description %}
To try these services, an Authorization token must be provided as a BearerToken header. The Autherization token can be obtained in the /auth service.
{% endswagger-description %}

{% swagger-parameter in="query" name="pageSize " required="true" %}
This value has a limit of 50, represents the number of responses per page.
{% endswagger-parameter %}

{% swagger-parameter in="query" name="pageNumber " required="true" %}
Number of pages shown.
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
{
  "orders": [
    {
      "orderId": "b88f4ed0-10a2-412f-be3e-b5e47abe9b50",
      "quoteId": null,
      "koyweFee": 1000,
      "networkFee": 1000,
      "symbolIn": "CLP",
      "symbolOut": "MATIC",
      "amountIn": 25000,
      "amountOut": 32.171150520770496,
      "paymentMethodId": "6294d815d2b5f912da43e699",
      "destinationAddress": "0x40f9bf922c23c43acede50Ab4425280C0ffBD697",
      "email": "example@gmail.com",
      "exchangeRate": 746.01,
      "status": "REJECTED",
      "date": {
        "confirmationDate": "2023-01-17T16:37:22.626Z",
        "paymentDate": null,
        "executionDate": null,
        "deliveryDate": null
      },
      "outReceipt": "98abd8a6dbdba6d4b",
      "metadata": null,
      "logoIn": "urlExample.com/currencies/CLP.svg",
      "logoOut": "urlExmaple.com/currencies/MATIC.svg"
    }
  ],
  "pagination": {
    "totalcount": 30,
    "pageSize": 6,
    "pageNumber": 5
  }
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="pageSize invalid" %}
```json
{
  "message": "PageSize must be between 1 and 50"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="pageNumber invalid" %}
```json
{
  "message": "PageNumber must be at least 1"
}
```
{% endswagger-response %}

{% swagger-response status="404: Not Found" description="object not found" %}
```json
{
    "message": "Client not found"
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="get" path="/orders/{orderId}" baseUrl="https://api-test.koywe.com/rest" summary="Returns order information." %}
{% swagger-description %}
To try these services, an Authorization token must be provided as a BearerToken header. The Autherization token can be obtained in the /auth service.
{% endswagger-description %}

{% swagger-parameter in="path" name="orderId " type="String" required="true" %}
Order's identifier.
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
{
  "orderId": "b88f4ed0-10a2-412f-be3e-b5e47abe9b50",
  "quoteId": null,
  "koyweFee": 1000,
  "networkFee": 1000,
  "symbolIn": "CLP",
  "symbolOut": "MATIC",
  "amountIn": 25000,
  "amountOut": 32.171150520770496,
  "paymentMethodId": "6294d815d2b5f912da43e699",
  "destinationAddress": "0x40f9bf922c23c43acede50Ab4425280C0ffBD697",
  "email": "example@gmail.com",
  "exchangeRate": 746.01,
  "status": "REJECTED",
  "date": {
    "confirmationDate": "2023-01-17T16:37:22.626Z",
    "paymentDate": null,
    "executionDate": null,
    "deliveryDate": null
  },
  "outReceipt": "98abd8a6dbdba6d4b",
  "metadata": null,
  "logoIn": "urlExample.com/currencies/CLP.svg",
  "logoOut": "urlExmaple.com/currencies/MATIC.svg"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="orderId invalid" %}
```json
{
  "message": "\"orderId\" must be a valid GUID"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Code Lenght" %}
```json
{
  "message": "\"code\" length must be 6 characters long"
}
```
{% endswagger-response %}

{% swagger-response status="404: Not Found" description="Object not found" %}
```json
{
  "message": "Client not found"
}
```
{% endswagger-response %}
{% endswagger %}

### Bank Queries

{% swagger method="post" path="/bank-accounts" baseUrl="https://api-test.koywe.com/rest" summary="Adds a bank account to proceed with the operation." %}
{% swagger-description %}
bankCode and documentNumber are optional. documentedNumber is required when the users is not KYC'd.
{% endswagger-description %}

{% swagger-parameter in="body" name="bankCode" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="accountNumber" required="true" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="countryCode" required="true" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="currencySymbol" required="true" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="documentNumber" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="email" type="String" %}

{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
{
  "_id": "63dd5fd9cccad469ee2408f7",
  "bankCode": "SANTANDER",
  "countryCode": "CHL",
  "currencySymbol": "CLP",
  "accountNumber": "1234596789",
  "account": "62f28c4aa05176c3dfba8e",
  "name": "BANCO SANTANDER"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="accountNumber syntax" %}
```json
{
    "message": "\"accountNumber\" must be a string"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="accountNumber empty" %}
```json
{
    "message": "\"accountNumber\" is not allowed to be empty"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="bankCode empty" %}
```json
{
    "message": "\"bankCode\" is not allowed to be empty"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="bankCode syntax" %}
```json
{
    "message": "\"bankCode\" must be a string"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="bankCode invalid" %}
```json
{
    "message": "BankCode not valid "
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="currencySymbol invalid" %}
```json
{
    "message": "\"currencySymbol\" must be one of [CLP, COP, MXN, PEN]"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Email required" %}
```json
{
    "message": "email field is required"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Email invalid" %}
```json
{
    "message": "\"email\" is not allowed"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="parameter required" %}
```json
{
    "message": "\"currencySymbol\" is required"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="country invalid" %}
```json
{
    "message": "\"countryCode\" must be one of [MEX, CHL, COL, PER]"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Email not found" %}
```json
{
    "message": "Account not found."
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="ClientId not found" %}
```json
{
    "message": "Client not found"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Bank Account already exists" %}
```json
{
    "message": "this bank account is already registered"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="DocumentNumber syntax" %}
```json
{
    "message": "\"accountNumber\" must be a string"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="DocumentNumber empty" %}
```json
{
    "message": "\"documentNumber\" is not allowed to be empty"j
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="DocumentNumber invalid" %}
```json
{
    "message": "documentNumber is not valid for \"countryCode\""
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="get" path="/bank-accounts" baseUrl="https://api-test.koywe.com/rest" summary="Returns bank account info." %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="query" name="countryCode " required="true" %}
Symbol of the country of choice.
{% endswagger-parameter %}

{% swagger-parameter in="query" name="currencySymbol" required="true" %}
Symbol of the currency of the chosen country.
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
{
  "_id": "63dd5fd9cccad469ee2408f7",
  "bankCode": "SANTANDER",
  "countryCode": "CHL",
  "currencySymbol": "CLP",
  "accountNumber": "1234596789",
  "account": "62f28c4aa05176c3dfba8e",
  "name": "BANCO SANTANDER"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid request" %}
```json
{
  "message": "bank account not found"
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="delete" path="/bank-accounts" baseUrl="https://api-test.koywe.com/rest" summary="Deletes bank account info." %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="query" name="_id" %}
Bank info identifier.
{% endswagger-parameter %}

{% swagger-parameter in="query" name="countryCode " %}
Symbol of the country of choice.
{% endswagger-parameter %}

{% swagger-parameter in="query" name="currencySymbol " %}
Symbol of the currency of the chosen country.
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
{
  "_id": "63dd5fd9cccad469ee2408f7",
  "bankCode": "SANTANDER",
  "countryCode": "CHL",
  "currencySymbol": "CLP",
  "accountNumber": "1234596789",
  "account": "62f28c4aa05176c3dfba8e",
  "name": "BANCO SANTANDER"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="_id not found" %}
```json
{
  "message": "Bank Account not found"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid _id parameter" %}
```json
{
  "message": "BankAccount error:Cast to ObjectId failed for value (type string) at path \"_id\" for model \"BankAccount\""
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="_id length" %}
```javascript
{
  "message": "\"_id\" length must be 24 characters long"
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="get" path="/bank-info/{countryCode}" baseUrl="https://api-test.koywe.com/rest" summary="Adds a bank account to proceed with the operation." %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="countryCode" %}
Symbol of the country of choice.
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
[
  {
    "bankCode": "BANCO_CHILE",
    "name": "BANCO DE CHILE",
    "institutionName": "BANCO DE CHILE",
    "transferCode": "001"
  }
]
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="CountryCode Invalid" %}
```json
{
  "message": "\"countryCode\" must be one of [MEX, CHL, COL, PER]"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Country not available" %}
```json
{
  "message": "not implemented for: *country*"
}
```
{% endswagger-response %}
{% endswagger %}

### Quote Queries

{% swagger method="post" path="/quotes" baseUrl="https://api-test.koywe.com/rest" summary="Creates a purchase or sell quote" %}
{% swagger-description %}
Only one of the input parameters "amountIn" and "amountOut" must be provided.&#x20;

For on ramps receives adicionally clientId and paymentMethodId.&#x20;

Returns a quoteId that can be use to create an order (is not necessary, but if provided and still valid, fewer values will be necessary to create the order).

If executable is true, we store it and return a UUID.
{% endswagger-description %}

{% swagger-parameter in="body" name="clientId" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="amountIn" type="Number" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="amountOut" type="Number" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="symbolIn" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="symbolOut" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="paymentMethodId" type="String" %}

{% endswagger-parameter %}

{% swagger-parameter in="body" name="executable" type="Boolean" %}

{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
{
  "quoteId": "63da8100c6d0af192f9f9e8c",
  "amountIn": 238228,
  "amountOut": 1,
  "symbolIn": "CLP",
  "symbolOut": "BNB",
  "paymentMethodId": "632d7fe6237ded3a748112cf",
  "exchangeRate": 235816,
  "koyweFee": 2358.16,
  "networkFee": 54,
  "co2": 0,
  "validFor": 10,
  "validUntil": 1675264266
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="paymentMethodId required" %}
```json
{
    "message": "\"paymentMethodId\" is not allowed to be empty"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="paymentMethodId syntax" %}
```json
{
    "message": "\"paymentMethodId\" must be a string"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="input parameters conflict" %}
```json
{
  "message": "Must contain only one of [amountIn, amountOut]"
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="input parameters required" %}
```json
{
  "message": "Must contain at least one of [amountIn, amountOut]"
}
```
{% endswagger-response %}

{% swagger-response status="403: Forbidden" description="unprocessable entity" %}
```javascript
{
  "message": "Payment method is restricted"
}
```
{% endswagger-response %}

{% swagger-response status="422: Unprocessable Entity" description="unprocessable entity" %}
```javascript
{
  "message": "Debes ingresar crypto o currency"
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="get" path="/quotes/{quoteId}" baseUrl="https://api-test.koywe.com/rest" summary="Returns quote details." %}
{% swagger-description %}
Receives a quoteId value. One can be produced uing the previous quote service (post /quotes). Returns quote data.
{% endswagger-description %}

{% swagger-parameter in="path" name="quoteId " %}
The quote's identifier.
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Successful operation" %}
```json
{
  "quoteId": "63da8100c6d0af192f9f9e8c",
  "amountIn": 238228,
  "amountOut": 1,
  "symbolIn": "CLP",
  "symbolOut": "BNB",
  "paymentMethodId": "632d7fe6237ded3a748112cf",
  "exchangeRate": 235816,
  "koyweFee": 2358.16,
  "networkFee": 54,
  "co2": 0,
  "validFor": 10,
  "validUntil": 1675264266
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid request" %}
```javascript
{
  "message": "\"quoteId\" length must be 24 characters long"
}
```
{% endswagger-response %}
{% endswagger %}
