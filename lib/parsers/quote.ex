defmodule Parsers.Quote do
  @spec match?(binary()) :: boolean()
  def match?(input) do
    input |> String.trim_leading() |> String.starts_with?(">")
  end

  defp consume_quote([], acc), do: {Enum.reverse(acc), []}

  defp consume_quote([line | rest], acc) do
    if match?(line) do
      trimmed = line |> String.trim_leading()

      text =
        case trimmed do
          "> " <> text -> text
          ">" <> text -> text
        end

      node = %AST.Node{type: "text", value: text}
      consume_quote(rest, [node | acc])
    else
      {Enum.reverse(acc), [line | rest]}
    end
  end

  @spec parse([String.t()]) :: {AST.Node.t(), [String.t()]}
  def parse(lines) do
    {items, remaining} = consume_quote(lines, [])
    list_node = %AST.Node{type: "quote", children: items}
    {list_node, remaining}
  end
end
