defmodule Geometry do
  @moduledoc """
  A module for basic geometric calculations.
  """

  @doc """
  Calculates the area of a rectangle given its width and height.

  ## Examples

      iex> Geometry.rectangle_area(5, 10)
      50

      iex> Geometry.rectangle_area(3, 4)
      12

  """
  def rectangle_area(width, height) do
    width * height
  end

  @doc """
  Calculates the area of a circle given its radius.

  ## Examples

      iex> Geometry.circle_area(5)
      78.53981633974483

      iex> Geometry.circle_area(3)
      28.274333882308138

  """
  def circle_area(radius) do
    :math.pi() * radius * radius
  end
end
