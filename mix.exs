defmodule Wpcom.MixProject do
  use Mix.Project

  def project do
    [
      app: :wpcom,
      version: "0.1.1",
      elixir: "~> 1.8",
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
      {:jason, "~> 1.1"},
      {:httpoison, "~> 1.5"},
      {:retry, "~> 0.13"},
      {:dialyxir, "~> 1.0.0-rc.6", only: :dev, runtime: false},
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
