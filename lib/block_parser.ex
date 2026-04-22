defmodule BlockParser do
  @block_parsers [
    Parsers.Heading,
    Parsers.CodeBlock,
    Parsers.Quote,
    Parsers.UnorderedList,
    Parsers.Paragraph
  ]

  def find_parser(line) do
    Enum.find(@block_parsers, & &1.match?(line))
  end

  def parse_blocks(lines, acc \\ [])
  def parse_blocks([], acc), do: Enum.reverse(acc)

  def parse_blocks(["" | rest], acc) do
    parse_blocks(rest, acc)
  end

  def parse_blocks([line | _] = lines, acc) do
    parser = find_parser(line)
    {node, remaining} = parser.parse(lines)
    parse_blocks(remaining, [node | acc])
  end

  def parse(input) do
    arg =
      case input do
        string when is_binary(string) ->
          string

        [head | _] ->
          head

        [] ->
          ""
      end

    lines = String.split(arg, "\n", [])
    children = parse_blocks(lines)
    %AST.Node{type: "document", children: children, value: nil}
  end
end
