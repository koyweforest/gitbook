---
description: No nos busques, nosotros te llamaremos.
---

# 馃獫 Webhooks y Callbacks

Para facilitar la integraci贸n, tenemos la posibilidad de alertarte cuando pasa algo o de definir formas de validar ciertas cosas contigo antes de ejecutar las transacciones.

## Webhook de Eventos

Podr谩s definir una URL para recibir llamados cada vez que se gatille un evento cuando suceda algo importante para una transacci贸n espec铆fica. Los posibles eventos son:

* `payment_received`: pago confirmado por el medio de pago
* `payment_rejected`: pago cancelado o rechazado
* `payment_expired`: la transacci贸n expir贸 antes de recibir confirmaci贸n de pago
* `crypto_tx_sent`: transacci贸n enviada a la blockchain
* `crypto_delivered`: transacci贸n confirmada por la blockchain
* `crypto_tx_failed`: transacci贸n fallida en el blockchain

Adicionalmente, podr谩s definir un `secret` para validar que somos nosotros quienes estamos enviando esos requests. Usando ese secret, encriptamos los par谩metros enviados y agregamos el hash para que puedas verificar el mensaje:

```javascript
const signature = crypto.createHmac('sha256', secret).update(JSON.stringify(payload)).digest('hex')
```

Ejemplo de evento reportado:

```json
{
  "eventName": "crypto_delivered", // event, from the list above
  "orderId": "5a3288ea-0bd4-44d2-af11-aae1f88bbd61", // order id, see above
  "timeStamp": "2022-10-26T22:36:41.658Z",
  "signature": "ed40d34ab7a587cf1a16338a16cc7765ae4420936677482bb33f5f738e4f7189" // hash
}
```

## Callback de Autenticaci贸n

Podr谩s definir una URL en tu API que nos confirme que un usuario puede operar en tu contexto de cliente. De esta forma, cada vez que un usuario quiera comprar, vender, o revisar informaci贸n privada, revisaremos contigo antes de dejarlo actuar.

Nuestra plataforma asume que devolver谩s _algo_ que se parezca a un booleano positivo y soporta varios m茅todos de autenticaci贸n.

Un ejemplo usando pseudo c贸digo:

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

