defmodule Parsers.Paragraph do
  def match?(_) do
    true
  end

  defp block_line?(line) do
    Parsers.Heading.match?(line) or Parsers.UnorderedList.match?(line) or
      Parsers.Quote.match?(line) or
      Parsers.CodeBlock.match?(line)
  end

  def parse(lines) do
    {consumed, remaining} =
      Enum.split_while(lines, fn line ->
        String.trim(line) != "" and not block_line?(line)
      end)

    text = Enum.join(consumed, "\n")
    node = %AST.Node{type: "paragraph", children: [%AST.Node{type: "text", value: text}]}
    {node, remaining}
  end
end
