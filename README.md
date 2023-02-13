# wpcom.ex

Official Elixir library for the WordPress.com REST API.

## Setup

```elixir
def deps do
  [
    {:wpcom, "~> 1.0.0"}
  ]
end
```

### Authentication

Not all requests require a REST API token. For example, listing posts on a public site is something anyone can do.

But if you do need a token, check out [OAuth2 Authentication](https://developer.wordpress.com/docs/oauth2/) at WordPress.com Developer Resources on how to get one.

Then use the token by adding this to your `runtime.exs`:

```elixir
config :wpcom, :oauth2_token: "_YOUR_OAUTH2_TOKEN_HERE_"
```

## Testing

```
mix test
```
