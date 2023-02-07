# 🛰 Flujo Básico API

{% hint style="info" %}
En esta sección podrás ver un flujo básico de llamados a la API de Koywe para compra y venta (aplica para ambas acciones).
{% endhint %}

## `/Auth`&#x20;

Primero, debes autenticarte. Sugerimos agregar el email del usuario, para usar el JWT en los siguientes llamados.

## `GetCurrencyTokens (on ramp) GetTokenCurrency (off ramp)`

Carga la lista de pares para ver los currencies y tokens disponibles y mostrarlos al usuario.

## `/payment-providers`&#x20;

Carga la lista de medios de pago disponibles. En este endpoint podrás encontrar los datos de transferencia para cada país, por lo que puede ser un buen momento para mostrarlos al usuario si es que selecciona ese medio de pago.

## `Post /quotes`

Teniendo ambas monedas ingresadas, fiat y crypto, el usuario debe ingresar un monto a recibir o a pagar, para poder obtener una cotización. Con la respuesta de la cotización, el usuario podrá conocer exactamente cuánto pagará en comisiones y recibirá al concretarse la operación. Opcionalmente, podemos pedir a la API que guarde la cotización y la mantenga vigente por algunos segundos. En este caso, el `quoteId` lo podemos guardar para el siguiente paso.

## `Post /orders`

Sólo basta con confirmar la orden. Si el `quoteId` sigue válido, sólo necesitamos incluir la billetera o cuenta de destino, el `documentNumber` del usuario, y opcionalmente un campo de `metadata` para que puedas identificar la orden en tu sistema.

{% hint style="info" %}
Si el quote ya había expirado, se puede generar un nuevo `quote` o llamar a `createOrder` con los mismos parámetros para tener un quote y orden al mismo tiempo.
{% endhint %}

Una vez recibido el `orderId` podemos guardarlo, asociándolo al usuario.

Resta esperar los llamados al [webhook](../webhooks.md#webhook-de-eventos) desde nuestra API o consultar `Get /order` con el id guardado cada cierto tiempo.

