defmodule Geometry do
  def area({:rectangle, a, b}) when a > 0 and b > 0 do
    a * b
  end

  def area({:square, a}) when a > 0 do
    a * a
  end

  def area({:circle, r}) when r > 0 do
    :math.pi() * r * r
  end

  def area(unknown_shape) do
    {:error, {:unknown_shape, unknown_shape}}
  end
end
