# Contribuir / Contributing

## Valores de ejemplo

Los ejemplos en la documentación, especificaciones de API (OpenAPI/JSON) y colecciones deben usar **solo identificadores y valores ficticios**, nunca valores copiados de producción ni de sandbox:

- IDs con prefijo: UUID en ceros con el prefijo correspondiente, por ejemplo `mrc_00000000-0000-0000-0000-000000000000`. Si un ejemplo necesita varios IDs distintos, usa `...000000000001`, `...000000000002`, etc.
- UUID sin prefijo: `00000000-0000-0000-0000-000000000000`.
- ObjectIds (24 caracteres hex): `000000000000000000000000` (o `...0001`, `...0002`).
- Emails: direcciones `@example.com`, por ejemplo `user@example.com`.
- Credenciales y tokens: `YOUR_API_KEY`, `YOUR_ACCESS_TOKEN`, `YOUR_SECRET`.
- Datos de personas, empresas, cuentas bancarias, documentos y wallets: valores claramente ficticios.

El script `scripts/check-example-ids.sh` revisa los archivos `.md`, `.json` y `.yaml` y falla si encuentra IDs de ejemplo que no sean placeholders. Se ejecuta automáticamente en cada pull request (`.github/workflows/check-example-ids.yml`). Puedes correrlo localmente con:

```bash
./scripts/check-example-ids.sh
```

Si un valor que no es un ID real es detectado por error, agrégalo a `.example-ids-allowlist` (un valor por línea).

---

## Example values

Examples in documentation, API specs (OpenAPI/JSON) and collections must use **only fictitious IDs and values**, never values copied from production or sandbox:

- Prefixed IDs: zero UUID with the right prefix, e.g. `mrc_00000000-0000-0000-0000-000000000000`. If an example needs several distinct IDs, use `...000000000001`, `...000000000002`, etc.
- Unprefixed UUIDs: `00000000-0000-0000-0000-000000000000`.
- ObjectIds (24 hex characters): `000000000000000000000000` (or `...0001`, `...0002`).
- Emails: `@example.com` addresses, e.g. `user@example.com`.
- Credentials and tokens: `YOUR_API_KEY`, `YOUR_ACCESS_TOKEN`, `YOUR_SECRET`.
- Personal, company, bank account, document and wallet data: clearly fictitious values.

`scripts/check-example-ids.sh` scans `.md`, `.json` and `.yaml` files and fails if it finds example IDs that are not placeholders. It runs on every pull request (`.github/workflows/check-example-ids.yml`). Run it locally with:

```bash
./scripts/check-example-ids.sh
```

If a value that is not a real ID is flagged by mistake, add it to `.example-ids-allowlist` (one value per line).
