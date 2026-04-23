defmodule AST.Node do
  defstruct type: "text", value: "value", children: []

  @type t(type, value, children) :: %AST.Node{type: type, value: value, children: children}
  @type t :: %AST.Node{type: String.t(), value: String.t() | nil, children: [t()]}
end
