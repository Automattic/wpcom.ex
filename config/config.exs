use Mix.Config

config :logger, level: :warn

config :wpcom, restV1: "https://public-api.wordpress.com/rest/v1"
config :wpcom, restV11: "https://public-api.wordpress.com/rest/v1.1"
config :wpcom, wpV2: "https://public-api.wordpress.com/wp/v2"
config :wpcom, wpcomV2: "https://public-api.wordpress.com/wpcom/v2"

config :wpcom, token: ""
