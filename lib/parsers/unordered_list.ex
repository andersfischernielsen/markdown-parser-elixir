defmodule Parsers.UnorderedList do
  @spec match?(binary()) :: boolean()
  def match?(input) do
    trimmed = input |> String.trim_leading()
    trimmed |> String.starts_with?("-") or trimmed |> String.starts_with?("*")
  end

  defp build_list_node(text) do
    %AST.Node{type: "list_item", value: nil, children: [%AST.Node{type: "text", value: text}]}
  end

  defp consume_list([], acc), do: {Enum.reverse(acc), []}

  defp consume_list([line | rest], acc) do
    if match?(line) do
      trimmed = line |> String.trim_leading()

      text =
        case trimmed do
          "- " <> text -> text
          "-" <> text -> text
          "* " <> text -> text
          "*" <> text -> text
        end

      node = build_list_node(text)
      consume_list(rest, [node | acc])
    else
      {Enum.reverse(acc), [line | rest]}
    end
  end

  @spec parse([String.t()]) :: {AST.Node.t(), [String.t()]}
  def parse(lines) do
    {items, remaining} = consume_list(lines, [])
    list_node = %AST.Node{type: "list", children: items}
    {list_node, remaining}
  end
end
