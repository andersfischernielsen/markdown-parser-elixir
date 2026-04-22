defmodule Mix.Tasks.Parse do
  use Mix.Task

  @shortdoc "Parses the given input."
  def run(input) do
    BlockParser.parse(input) |> IO.inspect()
  end
end
