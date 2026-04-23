defmodule Parsers.CodeBlock do
  @spec match?(binary()) :: boolean()
  def match?(input) do
    input |> String.trim_leading() |> String.starts_with?("```")
  end

  @spec parse([String.t()]) :: {AST.Node.t(), [String.t()]}
  def parse([_open_fence | rest]) do
    {consumed, remaining} = Enum.split_while(rest, &(&1 != "```"))

    case remaining do
      [] ->
        # No closing fence - treat everything as code
        text = Enum.join(consumed, "\n")
        {%AST.Node{type: "code", value: text}, []}

      [_close | rest] ->
        text = Enum.join(consumed, "\n")
        {%AST.Node{type: "code", value: text}, rest}
    end
  end
end
