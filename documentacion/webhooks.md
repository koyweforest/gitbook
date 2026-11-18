---
description: No nos busques, nosotros te llamaremos.
---

# 🪝 Webhooks y Callbacks

Para facilitar la integración, tenemos la posibilidad de alertarte cuando pasa algo o de definir formas de validar ciertas cosas contigo antes de ejecutar las transacciones.

## Webhook de Eventos

Podrás definir una URL para recibir llamados cada vez que se gatille un evento cuando suceda algo importante para una transacción específica. Los posibles eventos son:

* `payment_created`: orden creada
* `payment_received`: pago confirmado por el medio de pago
* `payment_rejected`: pago cancelado o rechazado
* `payment_expired`: la transacción expiró antes de recibir confirmación de pago
* `crypto_tx_sent`: transacción enviada a la blockchain
* `fiat_sent`: fiat enviado a cuenta bancaria del usuario
* `crypto_delivered`: transacción confirmada por la blockchain
* `fiat_delivered`: fiat entregado a cuenta bancaria del usuario
* `crypto_tx_failed`: transacción fallida en el blockchain

Adicionalmente, podrás definir un `secret` para validar que somos nosotros quienes estamos enviando esos requests. Usando ese secret, encriptamos los parámetros enviados y agregamos el hash para que puedas verificar el mensaje:

```javascript
const signature = crypto.createHmac('sha256', secret).update(JSON.stringify(payload)).digest('hex')
```

Ejemplo de evento reportado:

```json
{
  "eventName": "crypto_delivered", // event, from the list above
  "orderId": "00000000-0000-0000-0000-000000000001", // order id, see above
  "timeStamp": "2022-10-26T22:36:41.658Z",
  "signature": "ed40d34ab7a587cf1a16338a16cc7765ae4420936677482bb33f5f738e4f7189" // hash
}
```

## Callback de Autenticación

Podrás definir una URL en tu API que nos confirme que un usuario puede operar en tu contexto de cliente. De esta forma, cada vez que un usuario quiera comprar, vender, o revisar información privada, revisaremos contigo antes de dejarlo actuar.

Nuestra plataforma asume que devolverás _algo_ que se parezca a un booleano positivo y soporta varios métodos de autenticación.

Un ejemplo usando pseudo código:

```javascript
// usuario compra cripto
const createOrder (payload) {
    if (!validUser(payload.email)) throw new Error('user not allowed');
    else continue
}
// validamos contra tu API antes de dejarlo seguir
const validUser(email) {
    const payload = { email }
    const headers = { 'Authorization': 'Bearer superJWT' }
    const { data } = await axios.post(urlExternalAPI, payload, { headers })
    reurn data
}
```

