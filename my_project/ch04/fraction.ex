defmodule Fraction do
  defstruct a: nil, b: nil

  def new(a, b) do
    %Fraction{a: a, b: b}
  end

  # def value(%Fraction{a: a, b: b}) do
  #   a / b
  # end

  # This version is arguably clearer, but on the flip side, it accepts any map,
  # not just Fraction structs, which might lead to subtle bugs.
  def value(fraction) do
    fraction.a / fraction.b
  end

  def add(%Fraction{a: a1, b: b1}, %Fraction{a: a2, b: b2}) do
    new(
      a1 * b2 + a2 * b1,
      b2 * b1
    )
  end
end
