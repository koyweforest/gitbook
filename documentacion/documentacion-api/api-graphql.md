# 🛸 API GraphQL

URL de pruebas: [https://api-test.koywe.com/graphql](https://api-test.koywe.com/graphql)

Esta URL corre una instancia del explorador Apollo, por si es que quieres probar la API desde tu navegador.

Envíanos un email a [hola@koywe.com](mailto:hola@koywe.com) para obtener tus credenciales de prueba o que te hagamos un tour personalizado.

{% hint style="info" %}
**Pruebas:** La API de pruebas funciona en las testnets de las distintas blockchains. Tenemos un stock limitado de tokens, por lo que te pedimos criterio al probarlas.
{% endhint %}

### Queries y Mutaciones

Para hacer llamados a la API GraphQL, siempre debes enviar un request POST a la URL base, incluyendo la query y variables como objeto JSON. Un ejemplo en CURL de autenticación (header de Authorization incluido ilustrativamente):

```bash
curl --request POST \
    --header 'content-type: application/json' \
    --header 'Authorization: Bearer JWTTOKEN' \
    --url 'https://api-test.koywe.com/graphql' \
    --data '{"query":"mutation authenticate($input: AuthInput!) {\n  authenticate(input: $input) {\n    token\n  }\n}","variables":{"input":{"clientId":"63631a561f41f8fd18f8c3e0","secret":"supersecretstringFTW"}}}'
```

En los ejemplos siguientes sólo pondremos el objeto JSON del request.

<details>

<summary>Authentication</summary>

Authentication: devuelve un Bearer Token que dura 24 horas.

Require: `clientId`, `secret`

Opcional: `email`. Este campo asocia las transacciones a una cuenta de usuario específica y permite ver la información asociada a esta.

```json
"mutation":
"mutation authenticate($input: AuthInput!) {
  authenticate(input: $input) {
    token
  }
}",
"variables" :
{
  "input": {
    "clientId": "63631a561f41f8fd18f8c3e0",
    "secret": "secretpassword"
    "email": "email@domain.com" –-> optional
  }
}
```

</details>

Los dos siguientes servicios permiten la validación de un usario final de manera directa. El primer servicio enviará un código al correo deseado. Ese código debe ser ingresado en el segundo servicio para recibir la información de la sesión.

<details>

<summary>Validación de sesión</summary>

Envía un código de 6 dígitos al email entregado en el input.

```json
"mutation":
"mutation ValidateAccount($input: ValidateAccountInput!) {
  validateAccount(input: $input) {
    _id
  }
}",
"variables" :
{
  "input": {
    "email": "email@domain.com",
    "clientId": "f87aad3as90fe5489bb5099f"
  }
}
```

</details>

<details>

<summary>Validación de código</summary>

el valor de `code` en el input debe ser recogido del correo enviado por el servicio anterior.

```json
"mutation":
"mutation ValidateCode($input: ValidateCodeInput!) {
  validateCode(input: $input) {
    token
    isIdentify
    needVerificate
    identity
    firstOp
  }
}",
"variables" :
{
  "input": {
    "clientId": "40401a5615d9d8fd18f8a0b4",
    "code": "940577",
    "email": "example@domain.com"
  }
}
```

</details>

<details>

<summary>Pares</summary>

Obtener los pares de moneda-tokens soportados.

Opcional: `symbol.` El símbolo de la moneda a elección. `clientId`

```json
"query":
"query GetCurrencyTokens($input: GetCurrenciesInput!) {
  GetCurrencyTokens(input: $input) {
    ID
    name
    symbol
    decimals
    clientId
    tokens {
      ID
      name
      symbol
      decimals
    }
  }
}",
"variables":
{
  "input": {
    "symbol": null,
    "clientId": null
  }
}
```

Obtener los pares de token-monedas soportados.

Opcional: `symbol.` El símbolo del cripto a elección. `clientId`

```json
"query":
"query GetTokenCurrencies($input: GetCurrenciesInput!) {
  GetTokenCurrencies(input: $input) {
    ID
    name
    symbol
    decimals
    clientId
    currencies {
      ID
      name
      symbol
      decimals
    }
  }
}",
"variables":
{
  "input": {
    "symbol": null,
    "clientId": null
  }
}
```

</details>

<details>

<summary>Métodos de Pago</summary>

Listado de los medios de pago disponibles y sus detalles (fee, datos de transferencia, etc) para una moneda específica.

Requiere: `symbol`

Opcional: `clientId.` La lista de medios de pago disponibles pueden variar de acuerdo a este parámetro.

```json
"query":
"query GetPaymentProviderList($input: GetPaymentProviderListInput!) {
  getPaymentProviderList(input: $input) {
    ID
    name
    clientId
    description
    fee //Includes Koywe Fee
    Logo // example value: https://rampa.koywe.com/paymentProviders/exampleImage.svg
    details //Currently applies only to Wire payment method
  }
}",
"variables":
{
  "input": {
    "symbol": "COP"
    "clientId": "f87aad3as90fe5489bb5099f"
  }
}
```

</details>

<details>

<summary>Quote</summary>

### Consultar Quote

Devuelve un "Quote". Cuando el id del medio de pago es null, retorna las condiciones más favorables disponibles.

Requiere: `crypto` o `currency`. Montos en moneda local o token, uno o el otro. `cryptoSymbol`, `currencySymbol`

Opcional: `paymentProviderId, clientId`

<pre class="language-json"><code class="lang-json"><strong>"query":
</strong><strong>"query GetQuote($quoteId: String!) {
</strong>  getQuote(quoteId: $quoteId) {
    amountIn
    amountOut
    symbolIn
    symbolOut
    paymentMethodId
    koyweFee
    netFee
    netAmountIn // = amountIn - koyweFee - networkFee
    validFor
    validUntil
  }
}",
"variables":
{
  "UUID": "63c59396a38c6506a620162f"
}
</code></pre>

En todas estas queries, el parámetro `clientId` será ignorado si el request tiene el token JWT de autenticación en los headers.

### Crear Quote

```json
"mutation":
"mutation CreateOrder($input: OrderInput!) {
  createOrder(input: $input) {
    UUID
    quoteId
    symbolOut
    symbolIn
    amountOut
    amountIn
    paymentMethodId
    providedAddress
    providedAction
    email
    documentNumber
    metadata
  }
}",
"variables":
{
  "input": {
    "amountIn": 3716338,
    "amountOut": 3.3,
    "symbolIn": "CLP",
    "symbolOut": "ETH",
    "paymentMethodId": null,
    "validFor": 30, //measured in seconds
    "validUntil": "15:02:44Z",
    "networkFee": 4000,
    "koyweFee": 2338,
    "netAmountIn": 3710000, // = amountIn - koyweFee - networkFee
    "executable": false //set false by default. If value is set true, we store it and return a UUID.
  }
}
```

</details>

### Queries Privadas

Todas las queries a continuación requieren un Bearer Token en los headers:

`Authorization: Bearer [token]`

<details>

<summary>Order services</summary>

### Crear Orden

Crea una orden de compra o venta, retorna un UUID para seguimiento (`orderId`) y, dependiendo del medio de pago, una URL para realizarlo (`providerData`).&#x20;

Para llamadas autenticadas sin haber asociado un `email`, debe incluirse uno como parámetro para asociar la transacción a un usuario específico.

Requiere: `destinationAddress`, `symbolIn, symbolOut, amountIn, amountOut paymentProviderId.`

Opcional: `email` (obligatorio si no se está autenticado con email), `documentNumber` (para facilitar la conciliación bancaria)

```json
"mutation":
"mutation CreateOrder($input: OrderInput!) {
  createOrder(input: $input) {
    UUID
  }
}"
"variables":
{
  "input": {
    "quoteId": null, //nullable. if provided and quote is still valid, 
                    //symbolIn, symbolOut, amountIn, amountOut, 
                    //and paymentMethodId are nullable
    "amountIn": 1.100.000,
    "amountOut": 1,
    "email": "example@domain.com", //for API calls
    "documentNumber": null,
    "paymentMethodId": "632d7fe6237ded3a748112cf", // mandatory, from the list detailed above,
    "destinationAddress": "0x40f9bf922c23c43acdad71Ab4425280C0ffBD697", // Will return error if address is invalid,
    "symbolIn": CLP,
    "symbolOut": ETH,
    "metadata": null
  }
}
```

### Consultar Orden

```json
"query":
"query GetOrder($input: GetOrderInput!) {
  getOrder(input: $input){
    uuid
    symbolIn
    symbolOut
    amountIn
    amountOut
    email
    exchangeRate
    koyweFee
    status
    outReceipt
    dates {
      orderedDate
      payedDate
      transactionDate
      deliveredDate
    }
    destinationAddress
    networkFee
    paymentMethodId
  }
}"
"variables":
{
  "input": {
    "UUID": "02a5f0c7-b9bf-48e0-8b5d-190d2e2f7fc1"
  }
}
```

### Lista de órdenes pasadas

Retorna una lista de todas las órdenes asociadas al `clientId` o al `email` especificado al autenticarse.

```json
"query":
"query Orders {
  orders {
    UUID
    quoteId
    symbolIn
    symbolOut
    amountIn
    amountOut
    email
    exchangeRate
    koyweFee
    status
    outReceipt
    dates {
      confirmationDate
      paymentDate
      executionDate
      deliveryDate
    }
    destinationAddress
    networkFee
    paymentMethodId
    metadata
  }
}"
```

</details>

<details>

<summary>Servicios Bancarios</summary>

### Get Bank Account

```json
"query":
"query GetBankAccount($filters: FiltersBankAccount!) {
  getBankAccount(filters: $filters) {
    _id
    name
    bankCode
    countryCode
    currencySymbol
    accountNumber
    account
  }
}"
"variables":
{
  "filters": {
    "countryCode": "CHL",
    "currencySymbol": "CLP"
  }
}
```

### Get Bank Info by Country

```json
"query":
"query GetBankInfoByCountry($countryCode: String!) {
  getBankInfoByCountry(countryCode: $countryCode) {
    bankCode
    name
    institutionName
    transferCode
  }
}"
"variables":
{
  "countryCode": "CHL"
}
```

### Create Bank Account

```json
"mutation":
"mutation CreateBankAccount($input: BankAccountInput!) {
  getBankAccount(filters: $filters) {
    _id
    bankCode
    countryCode
    currencySymbol
    accountNumber
    account
  }
}"
"variables":
{
  "input": {
    "bankCode": "SANTANDER",
    "accountNumber": "0123123123",
    "countryCode": "CHL",
    "currencySymbol": "CLP"
  }
}
```

### Delete Bank Account

```json
"mutation":
"mutation DeleteBankAccount($input: DeleteBankAccountInput!) {
  deleteBankAccount(input: $input) {
    _id
    bankCode
    countryCode
    currencySymbol
    accountNumber
    account
  }
}"
"variables":
{
  "input": {
    "_id": "63bd75901ea16ea6e23109b5",
    "countryCode": "CHL",
    "currencySymbol": "CLP"
  }
}
```

</details>
