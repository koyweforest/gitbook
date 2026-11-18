---
description: La forma más fácil de integrar Koywe
---

# 🖥 Documentación SDK

{% hint style="info" %}
**Vélo en acción:** Puedes ver cómo lo usamos nosotros mismos en [https://widget.koywe.com](https://widget.koywe.com) y clonar el [repositorio Github](https://github.com/koyweforest/koywe-widget-template/) para comenzar a construir tu propio proyecto
{% endhint %}

## SDK Widget

El SDK es un paquete de NPM que instalas en tu proyecto. Puedes configurar varios parámetros para facilitar aún más la interacción con tus usuarios e incluso hacer que se salten algunos pasos si agregas un [Client ID](credenciales.md).

Activar el widget desplegará un overlay donde tus usuarios podrá realizar el [Proceso de Compra](../sobre-koywe/que-es-koywe/proceso-de-compra.md) y próximamente el de [Venta](../sobre-koywe/que-es-koywe/proceso-de-venta.md), sin tener que salir de tu sitio web o aplicación.

<figure><img src="../.gitbook/assets/Screen Shot 2022-12-08 at 13.29.09.png" alt=""><figcaption><p>Overlay con la rampa de Koywe</p></figcaption></figure>

## Instalación

Corre `npm i @koyweforest/koywe-ramp-sdk` en la carpeta de tu proyecto

<figure><img src="../.gitbook/assets/Screen Shot 2022-12-08 at 13.34.46.png" alt=""><figcaption></figcaption></figure>

## Uso y Configuración

Usar el widget es muy sencillo. Por ejemplo, hacer que se despliegue el widget al hacer click en un botón:

```jsx
import { KoyweRampSDK } from '@koyweforest/koywe-ramp-sdk';
const koywe = new KoyweRampSDK({});
function App() {
    return (
        <Button onClick={()=>koywe.show()}>
            Fondea tu Wallet con Koywe
        </Button>
    );
}
```

Puedes agregar algunos parámetros para hacer más fácil el proceso para tu usuario:

### currencies

La lista de monedas que estarán disponibles para el intercambio. Por defecto se muestran todas las monedas disponibles.

El valor a enviar debe ser un Array de strings, donde cada string es el símbolo de la moneda. Puedes consultar las monedas disponibles en nuestro sitio https://koywe.com

```javascript
new KoyweRampSDK({currencies: ["CLP", "MXN", "COP", "PEN"]})
```

En este ejemplo sólo estarán disponibles CLP, MXN, COP y PEN.

Si se envía un Array vacío, se mostrarán todas las monedas disponibles. Puedes configurar cualquier moneda, pero si no está disponible desde la API se ignorará.

### tokens

La lista de criptomonedas que estarán disponibles para el intercambio. Por defecto se muestran todas las criptos disponibles.

El valor enviado debe ser un Array de strings, donde cada string es el símbolo del cripto que se quiere que esté disponible. Puedes consultar los tokens disponibles en nuestro sitio https://koywe.com

```javascript
new KoyweRampSDK({tokens: ["ETH"]})
```

En este ejemplo sólo estará disponible ETH.

Si se envía un Array vacío, se mostrarán todos los tokens disponibles en la API. Si se envía un cripto que no está disponible no se mostrará.

{% hint style="info" %}
**Importante:** si no existe el par MONEDA-TOKEN, el token NO se mostrará en la lista. Por ejemplo, si no hay precios en PEN para el token BNB, cuando el usuario elija PEN, BNB no aparecerá disponible.
{% endhint %}

### address

Un parámetro opcional de tipo string que preestablece la dirección a la que se enviará el cripto, saltando la pantalla de validación e introducción de billetera.

```javascript
new KoyweRampSDK({address: "0x402...12"})
```

Si la billetera no es válida, el usuario se verá obligado a ingresar una manualmente.

### email

Parámetro tipo String que representa el email que se usará para la compra de crypto. Si este valor no es un email válido, el usuario deberá ingresar un email manualmente.

```javascript
new KoyweRampSDK({email: "user@example.com"})
```

{% hint style="info" %}
**Importante:** En caso de ingresar un email, el usuario NO podrá modificarlo y deberá realizar la compra o venta asociada a esa dirección.
{% endhint %}

### callbackUrl

Parámetro tipo String que indica la url a la que redireccionar luego de confirmar un pago en sitios externos.

```javascript
new KoyweRampSDK({callbackUrl: "https://koywe.com......"})
```

{% hint style="info" %}
**Importante**: Si no especificas una URL, el usuario será redirigido al sitio web de koywe al finalizar la transacción.
{% endhint %}

### client Id

Parámetro tipo String que indica el id de cliente a utilizar por el widget. De acuerdo al acuerdo con Koywe, este id permite acceso a distintos medios de pago y otras condiciones operativas.

```javascript
new KoyweRampSDK({clientId: "2781......"})
```

Si no se envía, el widget tendrá el comportamiento predeterminado y bloqueará ciertas funcionalidades.

Revisa la sección [Credenciales](credenciales.md) para más información y ver cómo obtener tu Client Id.

### testing

Parámetro booleano opcional para activar el modo de pruebas (transacciones no válidas).

```javascript
new KoyweRampSDK({testing: true})
```

Si el parámetro no se pasa o es false, el widget funcionará con transacciones reales.
