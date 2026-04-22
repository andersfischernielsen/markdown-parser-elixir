defmodule UnorderedList do
  def match?(input) do
    input |> String.trim_leading() |> String.starts_with?("-") or
      input |> String.trim_leading() |> String.starts_with?("*")
  end

  defp build_list_node(text) do
    %AST.Node{type: "bullet", value: nil, children: [%AST.Node{type: "text", value: text}]}
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

  def parse(lines) do
    {items, remaining} = consume_list(lines, [])
    list_node = %AST.Node{type: "list", children: items}
    {list_node, remaining}
  end
end
