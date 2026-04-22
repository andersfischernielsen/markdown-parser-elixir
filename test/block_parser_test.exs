defmodule ParserTest do
  use ExUnit.Case
  doctest BlockParser

  test "parses regular input into document node" do
    assert BlockParser.parse("test") == %AST.Node{
             type: "document",
             value: nil,
             children: [
               %AST.Node{
                 type: "paragraph",
                 children: [%AST.Node{type: "text", value: "test", children: []}]
               }
             ]
           }
  end

  test "parses full markdown document" do
    markdown = """
    # Heading

    This is a paragraph.
    It spans multiple lines.

    > This is a quote
    > that spans two lines

    - First item
    - Second item

    ```elixir
    def hello do
      "world"
    end
    ```

    Final paragraph.
    """

    assert BlockParser.parse(markdown) == %AST.Node{
             type: "document",
             value: nil,
             children: [
               %AST.Node{
                 type: "heading",
                 value: nil,
                 children: [%AST.Node{type: "text", value: "Heading", children: []}]
               },
               %AST.Node{
                 type: "paragraph",
                 children: [
                   %AST.Node{
                     type: "text",
                     value: "This is a paragraph.\nIt spans multiple lines.",
                     children: []
                   }
                 ]
               },
               %AST.Node{
                 type: "quote",
                 children: [
                   %AST.Node{type: "text", value: "This is a quote"},
                   %AST.Node{type: "text", value: "that spans two lines"}
                 ]
               },
               %AST.Node{
                 type: "list",
                 children: [
                   %AST.Node{
                     type: "list_item",
                     value: nil,
                     children: [%AST.Node{type: "text", value: "First item"}]
                   },
                   %AST.Node{
                     type: "list_item",
                     value: nil,
                     children: [%AST.Node{type: "text", value: "Second item"}]
                   }
                 ]
               },
               %AST.Node{
                 type: "code",
                 value: "def hello do\n  \"world\"\nend"
               },
               %AST.Node{
                 type: "paragraph",
                 children: [
                   %AST.Node{type: "text", value: "Final paragraph.", children: []}
                 ]
               }
             ]
           }
  end
end
