# wpcom.ex

Official Elixir library for the WordPress.com REST API.

## Synchronous

Offers `GET`, `POST`, `PUT`, `DELETE` synchronous calls via `Wpcom.Call`.

## Asynchronous

Offers `POST`, `PUT`, `DELETE` asynchronous "fire and forget" casts via `Wpcom.Cast`.

## Testing

Create a config/config.dev.secret.exs file with:

```
config :wpcom, auth_token_for_unit_tests: "Bearer _YOUR_OAUTH_TOKEN_HERE_"
```

Then run the unit tests:

```
mix test
```
