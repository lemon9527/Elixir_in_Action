defmodule Employees do
  def employees_print do
    employees = ["Alice", "Bob", "John"]
    employees
    # |> Enum.with_index()
    |> Stream.with_index()
    |> Enum.each(fn {name, index} ->
      IO.puts("#{index + 1}. #{name}")
    end)
  end

  def print_square_root do
    [9, -1, "foo", 25, 49]
    |> Stream.filter(&(is_number(&1) and &1 > 0))
    |> Stream.map(&{&1, :math.sqrt(&1)})
    |> Stream.with_index()
    |> Enum.each(fn {{input, result}, index} -> IO.puts("#{index+1}. sqrt(#{input}) = #{result}") end)
  end
end
