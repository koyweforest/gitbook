---
description: ¿Cómo sabemos quién eres?
---

# 👩💻 Credenciales

Queremos que integrar Koywe sea fácil, por lo que si solo quieres una rampa cripto, puedes integrar nuestro widget sin ninguna credencial.

Si quieres hacer modificaciones más profundas o conectarte por API, contáctanos a [hola@koywe.com](mailto:hola@koywe.com)

Una vez que estés creado como partner, tendrás 2 parámetros para la integración:

* **Client Id**: el identificador único de tu empresa en Koywe. Se va a ver algo así `000000000000000000000001`
* **Secret**: Un string secreto (no lo compartas) que nos permitirá determinar que en verdad eres tú, como una contraseña.

Con estos 2 parámetros podrás autenticarte en la API y hacer llamados a los endpoints privados.

{% hint style="info" %}
**SDK**: La integración por SDK permite el ingreso de un Client ID, de manera que nuestra API pueda identificar los requests que vengan desde tu integración. Si no pones o no tienes un Client ID, la API pensarás que estás llegando desde Koywe.com
{% endhint %}
