defmodule UnorderedListTest do
  use ExUnit.Case
  alias Parsers.UnorderedList, as: UnorderedList

  doctest UnorderedList

  test "parses single dash item" do
    assert UnorderedList.parse(["- item"]) ==
             {%AST.Node{
                type: "list",
                children: [
                  %AST.Node{
                    type: "list_item",
                    value: nil,
                    children: [%AST.Node{type: "text", value: "item"}]
                  }
                ]
              }, []}
  end

  test "parses single asterisk item" do
    assert UnorderedList.parse(["* item"]) ==
             {%AST.Node{
                type: "list",
                children: [
                  %AST.Node{
                    type: "list_item",
                    value: nil,
                    children: [%AST.Node{type: "text", value: "item"}]
                  }
                ]
              }, []}
  end

  test "parses multiple dash items" do
    assert UnorderedList.parse(["- item 1", "- item 2"]) ==
             {%AST.Node{
                type: "list",
                children: [
                  %AST.Node{
                    type: "list_item",
                    value: nil,
                    children: [%AST.Node{type: "text", value: "item 1"}]
                  },
                  %AST.Node{
                    type: "list_item",
                    value: nil,
                    children: [%AST.Node{type: "text", value: "item 2"}]
                  }
                ]
              }, []}
  end

  test "stops at non-list line" do
    assert UnorderedList.parse(["- item", "not a list"]) ==
             {%AST.Node{
                type: "list",
                children: [
                  %AST.Node{
                    type: "list_item",
                    value: nil,
                    children: [%AST.Node{type: "text", value: "item"}]
                  }
                ]
              }, ["not a list"]}
  end
end
