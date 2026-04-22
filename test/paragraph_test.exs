defmodule ParagraphTest do
  use ExUnit.Case
  doctest Paragraph

  test "parses single line paragraph" do
    assert Paragraph.parse(["some text"]) ==
             {%AST.Node{
                type: "paragraph",
                children: [%AST.Node{type: "text", value: "some text"}]
              }, []}
  end

  test "parses multi-line paragraph" do
    assert Paragraph.parse(["line 1", "line 2"]) ==
             {%AST.Node{
                type: "paragraph",
                children: [%AST.Node{type: "text", value: "line 1\nline 2"}]
              }, []}
  end

  test "stops at blank line" do
    assert Paragraph.parse(["line 1", "", "line 2"]) ==
             {%AST.Node{
                type: "paragraph",
                children: [%AST.Node{type: "text", value: "line 1"}]
              }, ["", "line 2"]}
  end

  test "stops at heading line" do
    assert Paragraph.parse(["paragraph", "# heading"]) ==
             {%AST.Node{
                type: "paragraph",
                children: [%AST.Node{type: "text", value: "paragraph"}]
              }, ["# heading"]}
  end

  test "stops at list line" do
    assert Paragraph.parse(["paragraph", "- list"]) ==
             {%AST.Node{
                type: "paragraph",
                children: [%AST.Node{type: "text", value: "paragraph"}]
              }, ["- list"]}
  end

  test "stops at quote line" do
    assert Paragraph.parse(["paragraph", "> quote"]) ==
             {%AST.Node{
                type: "paragraph",
                children: [%AST.Node{type: "text", value: "paragraph"}]
              }, ["> quote"]}
  end

  test "stops at code block line" do
    assert Paragraph.parse(["paragraph", "```"]) ==
             {%AST.Node{
                type: "paragraph",
                children: [%AST.Node{type: "text", value: "paragraph"}]
              }, ["```"]}
  end
end
