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
    --data '{"query":"mutation authenticate($input: AuthInput!) {\n  authenticate(input: $input) {\n    token\n  }\n}","variables":{"input":{"clientId":"000000000000000000000001","secret":"supersecretstringFTW"}}}'
```

En los ejemplos siguientes sólo pondremos el objeto JSON del request.

<details>

<summary>Authentication</summary>

devuelve un Bearer Token que dura 24 horas.

Require: `clientId`, `secret`

Opcional: `email`. Este campo asocia las transacciones a una cuenta de usuario específica y permite ver la información asociada a esta.

```graphql
mutation Authenticate($input: AuthInput!) {
  authenticate(input: $input) {
    token
  }
}
"variables" :
{
  "input": {
    "clientId": "000000000000000000000001",
    "secret": "secretpassword",
    "email": "user@example.com" # optional
  }
}
```

</details>

Los dos siguientes servicios permiten la validación de un usuario final de manera directa. El primer servicio enviará un código al correo deseado. Ese código debe ser ingresado en el segundo servicio para recibir la información de la sesión.

<details>

<summary>Validación de sesión</summary>

Envía un código de 6 dígitos al email entregado en el input.

```graphql
mutation validateAccount($input: ValidateAccountInput!) {
  validateAccount(input: $input) {
    _id
  }
}
"variables" :
{
  "input": {
    "email": "user@example.com",
    "clientId": "f87aad3as90fe5489bb5099f"
  }
}
```

</details>

<details>

<summary>Validación de código</summary>

El valor de `code` en el input debe ser recogido del correo enviado por el servicio anterior.

```graphql
mutation validateCode($input: ValidateCodeInput!) {
  validateCode(input: $input) {
    token
    isIdentify
    needVerificate
    identity
    firstOp
  }
}
"variables" :
{
  "input": {
    "clientId": "000000000000000000000002",
    "code": "940577",
    "email": "user@example.com"
  }
}
```

</details>

<details>

<summary>Pares</summary>

Obtiene los pares de moneda-tokens soportados.

Opcional: `symbol.` El símbolo de la moneda a elección. `clientId`

```graphql
query GetCurrencyTokensV2($input: GetCurrenciesInput!) {
  GetCurrencyTokensV2(input: $input) {
    _id
    name
    symbol
    decimals
    clientId
    logo
    locate
    limits {
      min
      max
    }
    tokens {
      _id
      name
      symbol
      decimals
      logo
    }
  }
}
"variables":
{
  "input": {
    "symbol": null,
    "clientId": null
  }
}
```

Obtiene los pares de token-monedas soportados.

Opcional: `symbol.` El símbolo del cripto a elección. `clientId`

```graphql
query GetTokenCurrencies($input: GetCurrenciesInput!) {
  GetTokenCurrencies(input: $input) {
    _id
    name
    symbol
    decimals
    logo
    currencies {
      _id
      name
      symbol
      decimals
      locale
      logo
      limits {
        min
        max
      }
    }
  }
}
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

Requiere: `symbol`, símbolo de la moneda nacional. `currencyId`.

Opcional: `clientId.` La lista de medios de pago disponibles pueden variar de acuerdo a este parámetro.

```graphql
query GetPaymentProviderList($input: GetPaymentProviderListInput!) {
  getPaymentProviderList(input: $input) {
    _id
    name
    fee
    image
    description
    details
  }
}
"variables":
{
  "input": {
    "symbol": "COP"
    "clientId": "f87aad3as90fe5489bb5099f"
    "currencyId": "489bb507aad3as90fe0f"
  }
}
```

</details>

<details>

<summary>Servicios Quote</summary>

#### Consultar Quote

Devuelve un "Quote". Recibe un `quoteId`.

<pre class="language-graphql"><code class="lang-graphql"><strong>query getQuote($quoteId: String!) {
</strong>  getQuote(quoteId: $quoteId) {
    amountIn
    amountOut
    co2
    exchangeRate
    symbolIn
    symbolOut
    paymentMethodId
    koyweFee
    networkFee
    validFor
    validUntil
  }
}
"variables":
{
  "quoteId": "000000000000000000000011" #Created when calling mutation quote
}
</code></pre>

#### Crear Quote

```graphql
mutation quote($input: QuoteInput!) {
  quote(input: $input) {
    quoteId
    amountIn
    amountOut
    co2
    exchangeRate
    symbolIn
    symbolOut
    paymentMethodId
    koyweFee
    networkFee
    validFor
    validUntil
  }
}
"variables":
{
  "input": {
    "amountIn": 3716338,
    "amountOut": 3.3,
    "clientId": "cse7fj283rkn2x6v7rr",
    "symbolIn": "CLP",
    "symbolOut": "ETH",
    "paymentMethodId": null, # This value corresponds to the _id value returned after calling GetPaymentProviderList
    "executable": false #set false by default. If value is set true, we store it and return a UUID.
  }
}
```

</details>

### Queries Privadas

Todas las queries a continuación requieren un Bearer Token en los headers:

`Authorization: Bearer [token]`

<details>

<summary>Servicios de órdenes</summary>

### Crear Orden

Crea una orden de compra o venta, retorna un UUID para seguimiento (`orderId`) y, dependiendo del medio de pago, una URL para realizarlo (`providedAction`).

Para llamadas autenticadas sin haber asociado un `email`, debe incluirse uno como parámetro para asociar la transacción a un usuario específico.

Necesitas introducir `amountIn` o `amountOut`, no ambos.

#### On ramp

Requiere: `destinationAddress`, `quoteId o symbolIn, symbolOut, amountIn, amountOut, y paymentMethodId`.

#### Off ramp

Requiere: `destinationAddress`, `quoteId o symbolIn, symbolOut, amountIn, amountOut.`

Opcional: `email` (obligatorio si no se está autenticado con email), `documentNumber` (para facilitar la conciliación bancaria).

```graphql
mutation createOrder($input: OrderInput!) {
  createOrder(input: $input) {
    orderId
    amountIn
    amountOut
    documentNumber
    email
    metadata
    orderId
    paymentMethodId
    providedAction
    providedAddress
    quoteId
    symbolIn
    symbolOut
  }
}
"variables":
{
  "input": {
    "callbackUrl": "https://example.com/callback",
    "quoteId": null, #nullable. if provided and quote is still valid, 
                    #symbolIn, symbolOut, amountIn, amountOut, 
                    #and paymentMethodId are nullable
    "amountIn": 1.100.000,
    "amountOut": 1,
    "email": "user@example.com", #for API calls
    "documentNumber": null,
    "paymentMethodId": "000000000000000000000007",  # This value corresponds to the _id value returned after calling GetPaymentProviderList
    "destinationAddress": "0x0000000000000000000000000000000000000001", # Will return error if address is invalid
    "symbolIn": "CLP",
    "symbolOut": "ETH",
    "metadata": null
  }
}
```

### Consultar Orden

Retorna información de una order. Recibe un `orderId`.

```graphql
query getOrder($input: GetOrderInput!) {
  getOrder(input: $input){
    orderId
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
    orderType
    dates {
      confirmationDate
      paymentDate
      executionDate
      deliveryDate
    }
    destinationAddress
    networkFee
    paymentMethodId
    logoIn
    logoOut
  }
}
"variables":
{
  "input": {
    "orderId": "00000000-0000-0000-0000-000000000002" #Created when calling mutation Order
  }
}
```

### Lista de órdenes pasadas

Retorna una lista de todas las órdenes asociadas al `clientId` o al `email` especificado al autenticarse.

`pagesize`: Límite de 50, representa la cantidad de respuestas por página.

`pageNumber`: Número de páginas a mostrar.

```graphql
query orders($input: PaginationInput!) {
  orders(input: $input) {
    pagination {
      totalCount
      pageSize
      pageNumber
    }
    data {
      orderId
      quoteId
      orderType
      symbolIn
      symbolOut
      logoIn
      logoOut
      amountIn
      amountOut
      paymentMethodId
      destinationAddress
      email
      exchangeRate
      koyweFee
      networkFee
      status
      outReceipt
      dates {
        confirmationDate
        paymentDate
        executionDate
        deliveryDate
      }
    }
  }
}
"variables":
{
  "input": {
    "pageNumber": null,
    "pageSize": null
  }
}
```

</details>

<details>

<summary>Servicios Bancarios</summary>

#### Get Bank Account

Retorna una lista de cuentas bancarias asociadas al usuario, filtrados de acuerdo a `countryCode` y `currencySymbol`.

```graphql
query getBankAccount($filters: FiltersBankAccount!) {
  getBankAccount(filters: $filters) {
    _id
    name
    bankCode
    countryCode
    currencySymbol
    accountNumber
    account
  }
}
"variables":
{
  "filters": {
    "countryCode": "CHL",
    "currencySymbol": "CLP"
  }
}
```

#### Get Bank Info by Country

Retorna una lista con los bancos que son soportados para un `countryCode` dado.

```graphql
query getBankInfoByCountry($countryCode: String!) {
  getBankInfoByCountry(countryCode: $countryCode) {
    bankCode
    name
    institutionName
    transferCode
  }
}
"variables":
{
  "countryCode": "CHL"
}
```

#### Create Bank Account

Crea una nueva cuenta bancaria y la guarda para futuras operaciones.

opcional: `bankCode, documentNumber`

`documentNumber` es requerido en el caso de que el usuario no haya hecho el KYC.

```graphql
mutation createBankAccount($input: BankAccountInput!) {
  createBankAccount(input: $input) {
    _id
    name
    bankCode
    countryCode
    currencySymbol
    accountNumber
    account
  }
}
"variables":
{
  "input": {
    "bankCode": "SANTANDER",
    "accountNumber": "0123123123",
    "countryCode": "CHL",
    "currencySymbol": "CLP",
    "documentNumber": "12345678",
    "email": "user@example.com"
  }
}
```

#### Delete Bank Account

Elimina una cuenta bancaria de la lista de cuentas guardadas.

```graphql
mutation deleteBankAccount($input: DeleteBankAccountInput!) {
  deleteBankAccount(input: $input) {
    _id
    name
    bankCode
    countryCode
    currencySymbol
    accountNumber
    account
  }
}
"variables":
{
  "input": {
    "_id": "000000000000000000000016", #Bank account identifier
    "countryCode": "CHL",
    "currencySymbol": "CLP"
  }
}
```

</details>
