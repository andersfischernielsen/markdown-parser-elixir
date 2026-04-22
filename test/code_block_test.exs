defmodule CodeBlockTest do
  use ExUnit.Case
  alias Parsers.CodeBlock, as: CodeBlock

  doctest CodeBlock

  test "parses fenced code block" do
    assert CodeBlock.parse(["```", "code", "```"]) ==
             {%AST.Node{type: "code", value: "code"}, []}
  end

  test "parses fenced code block with language" do
    assert CodeBlock.parse(["```elixir", "def hello", "end", "```"]) ==
             {%AST.Node{type: "code", value: "def hello\nend"}, []}
  end

  test "parses unclosed code block" do
    assert CodeBlock.parse(["```", "code"]) ==
             {%AST.Node{type: "code", value: "code"}, []}
  end

  test "leaves remaining lines after closing fence" do
    assert CodeBlock.parse(["```", "code", "```", "after"]) ==
             {%AST.Node{type: "code", value: "code"}, ["after"]}
  end
end
