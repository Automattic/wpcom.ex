defmodule Wpcom.MixProject do
  use Mix.Project

  def project do
    [
      app: :wpcom,
      version: "1.0.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "wpcom.ex",
      source_url: "https://github.com/Automattic/wpcom.ex"
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:req, "~> 0.5.6"},
      {:bandit, "~> 1.5", only: :test},
      {:test_server, "~> 0.1", only: :test},
      {:credo, "~> 1.6", only: :dev, runtime: false},
      {:dialyxir, "~> 1.4", only: :dev, runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "wpcom.ex is the official Elixir library for the WordPress.com REST API."
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Automattic/wpcom.ex"}
    ]
  end
end
