defmodule Geometry do
  defmodule Rectangle do
    def rectangle_area(width, height), do: width * height

    def square_area(side) do
      rectangle_area(side, side)  # calls to a function in the same module
    end
  end

  def circle_area(radius) do
    :math.pi() * radius * radius
  end
end
