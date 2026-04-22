defmodule Parsers.Heading do
  def match?(input) do
    input |> String.trim_leading() |> String.starts_with?("#")
  end

  def parse([line | rest]) do
    trimmed = String.trim_leading(line)

    node =
      case(trimmed) do
        "#### " <> text ->
          %AST.Node{
            type: "subsubsubheading",
            value: nil,
            children: [%AST.Node{type: "text", value: text, children: []}]
          }

        "####" <> text ->
          %AST.Node{
            type: "subsubsubheading",
            value: nil,
            children: [%AST.Node{type: "text", value: text, children: []}]
          }

        "### " <> text ->
          %AST.Node{
            type: "subsubheading",
            value: nil,
            children: [%AST.Node{type: "text", value: text, children: []}]
          }

        "###" <> text ->
          %AST.Node{
            type: "subsubheading",
            value: nil,
            children: [%AST.Node{type: "text", value: text, children: []}]
          }

        "## " <> text ->
          %AST.Node{
            type: "subheading",
            value: nil,
            children: [%AST.Node{type: "text", value: text, children: []}]
          }

        "##" <> text ->
          %AST.Node{
            type: "subheading",
            value: nil,
            children: [%AST.Node{type: "text", value: text, children: []}]
          }

        "# " <> text ->
          %AST.Node{
            type: "heading",
            value: nil,
            children: [%AST.Node{type: "text", value: text, children: []}]
          }

        "#" <> text ->
          %AST.Node{
            type: "heading",
            value: nil,
            children: [%AST.Node{type: "text", value: text, children: []}]
          }

        _ ->
          %AST.Node{type: "text", value: trimmed}
      end

    {node, rest}
  end
end
