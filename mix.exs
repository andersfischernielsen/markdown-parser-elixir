defmodule MarkdownParser.MixProject do
  use Mix.Project

  def project do
    [
      app: :markdown_parser,
      version: "0.1.0",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      default_task: "parse"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:phoenix, "~> 1.8.5"}
    ]
  end
end
