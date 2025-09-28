# Listing 3.7 Printing the first N natural numbers
defmodule NaturaNums do
  def print(1), do: IO.puts(1)

  def print(n) when n > 1 do
    print(n - 1)
    IO.puts(n)
  end
end
