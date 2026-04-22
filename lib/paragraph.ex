defmodule Paragraph do
  def match?(_) do
    true
  end

  defp block_line?(line) do
    Heading.match?(line) or UnorderedList.match?(line) or Quote.match?(line) or
      CodeBlock.match?(line)
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
