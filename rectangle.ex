defmodule Rectangle do
  @doc"""
  More commonly, a lower-arity function delegates to
  a higher-arity function, providing some default arguments.
  """
  def area(a), do: area(a, a)

  def area(a, b), do: a * b
end
