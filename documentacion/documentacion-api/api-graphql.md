# 🛸 API GraphQL

URL de pruebas: [https://api-test.koywe.com/graphql](https://api-test.koywe.com/graphql)

Esta URL corre una instancia del explorador Apollo, por si es que quieres probar la API desde tu navegador.

Envíanos un email a [hola@koywe.com](mailto:hola@koywe.com) para obtener tus credenciales de prueba o que te hagamos un tour personalizado.

{% hint style="info" %}
**Pruebas:** La API de pruebas funciona en las testnets de las distintas blockchains. Tenemos un stock limitado de tokens, por lo que te pedimos criterio al probarlas.
{% endhint %}

## Queries y Mutaciones

Para hacer llamados a la API GraphQL, siempre debes enviar un request POST a la URL base, incluyendo la query y variables como objeto JSON. Un ejemplo en CURL de autenticación (header de Authorization incluido ilustrativamente):

```bash
curl --request POST \
    --header 'content-type: application/json' \
    --header 'Authorization: Bearer JWTTOKEN' \
    --url 'https://api-test.koywe.com/graphql' \
    --data '{"query":"mutation authenticate($input: AuthInput!) {\n  authenticate(input: $input) {\n    token\n  }\n}","variables":{"input":{"clientId":"63631a561f41f8fd18f8c3e0","secret":"supersecretstringFTW"}}}'
```

En los ejemplos siguientes sólo pondremos el objeto JSON del request.

### Autenticación

Authentication: devuelve un Bearer Token que dura 24 horas.

Require: `clientId`, `secret`

Opcional: `email`. Este campo asocia las transacciones a una cuenta de usuario específica y permite ver la información asociada a esta.

```json
"query":
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

### Pares

Obtener los pares de moneda y tokens soportados.

Opcional: `symbol.` El símbolo de la moneda a elección. `clientId`

```json
"query":
"query GetCurrencyTokens($input: GetCurrenciesInput!) {
  GetCurrencyTokens(input: $input) {
    _id
    name
    symbol
    decimals
    tokens {
      _id
      name
      symbol
      lastPrice
      decimals
      internalMarket
      chainId
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

### Métodos de Pago

Listado de los medios de pago disponibles y sus detalles (fee, datos de transferencia, etc) para una moneda específica.

Requiere: `symbol`

Opcional: `clientId.` La lista de medios de pago disponibles pueden variar de acuerdo a este parámetro.

```json
"query":
"query GetPaymentProviderList($input: GetPaymentProviderListInput!) {
  getPaymentProviderList(input: $input) {
    _id
    name
    description
    fee
    image
    details
  }
}",
"variables":
{
  "input": {
    "symbol": "COP"
    "clientId": "63631a561f41f8fd18f8c3e0"
  }
}
```

### Simulación

Devuelve una simulación. Cuando el id del medio de pago es null, retorna las condiciones más favorables disponibles.

Requiere: `crypto` o `currency`. Montos en moneda local o token, uno o el otro. `cryptoSymbol`, `currencySymbol`

Opcional: `paymentProviderId, clientId`

<pre class="language-json"><code class="lang-json"><strong>"query":
</strong><strong>"query getPaymentProviderFee($input: GetPaymentProviderInput!) {
</strong>  getPaymentProviderFee(input: $input) {
    gasCost
    fee
    cryptoToReceive
    currencyToPay
    Co2
    price
  }
}",
"variables":
{
  "input": {
    //"currency": 100000.00,
    "crypto": 1000,
    "cryptoSymbol":"USDC",
    "currencySymbol":"CLP",
    "paymentProviderId": null
  }
}
</code></pre>

En todas estas queries, el parámetro `clientId` será ignorado si el request tiene el token JWT de autenticación en los headers.

## Queries Privadas

Todas las queries a continuación requieren un Bearer Token en los headers:

`Authorization: Bearer [token]`

### Get Transaction

Detalles de una transacción. `transactionId` es el UUID obtenido al crear una transacción o desde la lista de transacciones.

Requiere: `transactionId`

```json
"query":
"query TrackTransaction($input: TransactionTrackingInput!) {
  trackTransaction(input: $input) {
    _id
    from
    txHash
    status
    dates {
      orderedDate
      payedDate
      transactionDate
      deliveredDate
    }
    paymentOrderId {
      _id
      orderId
      address
      tokenId {
        symbol
        name
        chainId
      }
      currencyAmount
      amountCrypto
      freezeAmount
      koyweFee
      netFee
      status
      currencyId {
        name
        symbol
      }
    }
    retries
  }
}",
"variables":
{
  "input": {
    "transactionId": "a0eba85f-3428-4d1f-9055-043ddd5a3211"
  }
}
```

### Lista de Transacciones

Retorna una lista de todas las transacciones asociadas al `clientId` o al `email` especificado al autenticarse.

```json
"query":
"query getTransactions {
  myTransactions {
    _id
    from
    txHash
    status
    paymentOrderId {
      address
      tokenId {
        symbol
        chainId
      }
      currencyAmount
      currencyAmountWOFee
      amountCrypto
      freezeAmount
      koyweFee
      netFee
      status
      paymentProviderId {
        name
      }
      orderId
      currencyId {
        symbol
      }
    }
    dates {
      orderedDate
      payedDate
      transactionDate
      deliveredDate
    }
  }
}"
```

### Crear Orden

Crea una orden de compra o venta, retorna un UUID para seguimiento (`orderId`) y, dependiendo del medio de pago, una URL para realizarlo (`providerData`). Acepta montos para cripto o moneda, no ambos.

Para llamadas autenticadas sin haber asociado un `email`, debe incluirse uno como parámetro para asociar la transacción a un usuario específico.

Si se le pasa `currencyId` y `currencySymbol`, este último será ignorado. Lo mismo para token.

Requiere: `address, tokenId o tokenSymbol, currencyId o currencySymbol, currencyAmount o amountCrypto, paymentProviderId, terms`

Opcional: `email` (obligatorio si no se está autenticado con email), `documentNumber` (para facilitar la conciliación bancaria)

```json
"query":
"mutation CreatePaymentOrder($input: CreatePaymentOrderInput!) {
  createPaymentOrder(input: $input) {
    orderID
    providerData //usually, a url to redirect the user to finalize payment
  }
}"
"variables":
{
  "input": {
    "address": "0x40f9bf922c23c43acdad71Ab4425280C0ffBD697", // Will return error if address is invalid
    "tokenId": "630cab7fff27aaac82fd841b", // optional if tokenSymbol is sent (id will take priority if both are sent)
    "currencyId": "6294cd18d2b5f912da43e678", // optional if currencySymbol is sent (id will take priority if both are sent)
    "tokenSymbol": "CLP", // optional if tokenId is sent (id will take priority if both are sent)
    "currencySymbol": "USDC", // optional if currencyId is sent (id will take priority if both are sent)
    "currencyAmount": null,
    "paymentProviderId": "632d7fe6237ded3a748112cf", // mandatory, from the list detailed above
    "terms": true, // always true
    "amountCrypto": 10,
    "email": "email@domain.com", // optional if authentication includes one, mandatory if not
    "documentNumber": "11.222.333-5 || CUAS525jGSD || 4235246346", // optional, to make wire transfers easier to approve
  }
}
```

\
