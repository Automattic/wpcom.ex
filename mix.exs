defmodule Wpcom.MixProject do
  use Mix.Project

  def project do
    [
      app: :wpcom,
      version: "0.3.0",
      elixir: "~> 1.9",
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
      {:mojito, "~> 0.7.2"},
      {:retry, "~> 0.13"},
      {:dialyxir, "~> 1.2.0", only: :dev, runtime: false},
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
