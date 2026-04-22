defmodule QuoteTest do
  use ExUnit.Case
  doctest Quote

  test "parses single line quote" do
    assert Quote.parse(["> Hello"]) ==
             {%AST.Node{
                type: "quote",
                children: [%AST.Node{type: "text", value: "Hello"}]
              }, []}
  end

  test "parses quote with space after marker" do
    assert Quote.parse(["> Hello"]) ==
             {%AST.Node{
                type: "quote",
                children: [%AST.Node{type: "text", value: "Hello"}]
              }, []}
  end

  test "parses multi-line quote" do
    assert Quote.parse(["> Hello", "> World"]) ==
             {%AST.Node{
                type: "quote",
                children: [
                  %AST.Node{type: "text", value: "Hello"},
                  %AST.Node{type: "text", value: "World"}
                ]
              }, []}
  end

  test "stops at non-quote line" do
    assert Quote.parse(["> Hello", "not a quote"]) ==
             {%AST.Node{
                type: "quote",
                children: [%AST.Node{type: "text", value: "Hello"}]
              }, ["not a quote"]}
  end
end
