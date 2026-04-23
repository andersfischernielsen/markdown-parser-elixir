defmodule MarkdownParser.MixProject do
  use Mix.Project

  def project do
    [
      app: :markdown_parser,
      version: "0.1.0",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [
        plt_add_apps: [:mix]
      ]
    ]
  end

  def cli do
    [default_task: "parse"]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:phoenix, "~> 1.8.5"},
      {:dialyxir, "~> 1.4.7", only: [:dev, :test], runtime: false}
    ]
  end
end
