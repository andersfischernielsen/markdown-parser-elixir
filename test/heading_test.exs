defmodule HeadingTest do
  use ExUnit.Case
  alias Parsers.Heading, as: Heading

  doctest Heading

  test "parses h1 without space" do
    assert Heading.parse(["#test"]) ==
             {%AST.Node{
                type: "heading",
                value: nil,
                children: [%AST.Node{type: "text", value: "test", children: []}]
              }, []}
  end

  test "parses h1 with space" do
    assert Heading.parse(["# test"]) ==
             {%AST.Node{
                type: "heading",
                value: nil,
                children: [%AST.Node{type: "text", value: "test", children: []}]
              }, []}
  end

  test "parses h2 without space" do
    assert Heading.parse(["##test"]) ==
             {%AST.Node{
                type: "subheading",
                value: nil,
                children: [%AST.Node{type: "text", value: "test", children: []}]
              }, []}
  end

  test "parses h2 with space" do
    assert Heading.parse(["## test"]) ==
             {%AST.Node{
                type: "subheading",
                value: nil,
                children: [%AST.Node{type: "text", value: "test", children: []}]
              }, []}
  end

  test "parses h3 without space" do
    assert Heading.parse(["###test"]) ==
             {%AST.Node{
                type: "subsubheading",
                value: nil,
                children: [%AST.Node{type: "text", value: "test", children: []}]
              }, []}
  end

  test "parses h3 with space" do
    assert Heading.parse(["### test"]) ==
             {%AST.Node{
                type: "subsubheading",
                value: nil,
                children: [%AST.Node{type: "text", value: "test", children: []}]
              }, []}
  end

  test "parses h4 without space" do
    assert Heading.parse(["####test"]) ==
             {%AST.Node{
                type: "subsubsubheading",
                value: nil,
                children: [%AST.Node{type: "text", value: "test", children: []}]
              }, []}
  end

  test "parses h4 with space" do
    assert Heading.parse(["#### test"]) ==
             {%AST.Node{
                type: "subsubsubheading",
                value: nil,
                children: [%AST.Node{type: "text", value: "test", children: []}]
              }, []}
  end

  test "parses test_heading.md file" do
    content = File.read!("test/files/test_heading.md")

    assert BlockParser.parse(content) == %AST.Node{
             type: "document",
             value: nil,
             children: [
               %AST.Node{
                 type: "heading",
                 value: nil,
                 children: [%AST.Node{type: "text", value: "Test", children: []}]
               },
               %AST.Node{
                 type: "subheading",
                 value: nil,
                 children: [%AST.Node{type: "text", value: "Test", children: []}]
               },
               %AST.Node{
                 type: "subsubheading",
                 value: nil,
                 children: [%AST.Node{type: "text", value: "Test", children: []}]
               },
               %AST.Node{
                 type: "subsubsubheading",
                 value: nil,
                 children: [%AST.Node{type: "text", value: "Test", children: []}]
               }
             ]
           }
  end
end
