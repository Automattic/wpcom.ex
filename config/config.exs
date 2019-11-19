import Mix.Config

config :logger, level: :warn

import_config "*.dev.secret.exs"
