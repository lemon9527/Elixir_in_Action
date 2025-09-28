defmodule RecursionPractice do
  # A list_len/1 function that calculates the length of a list.
  def list_len([]), do: 0
  def list_len([_head | tail]), do: 1 + list_len(tail)

  # A range/2 function that takes two integers, from and to, and returns a list
  # of all integer numbers in the given range
  def range(from, to) when from > to, do: []
  def range(from, to) when from == to, do: [from]
  def range(from, to) when from < to, do: [from | range(from + 1, to)]

  # A positive/1 function that takes a list and returns another list that
  # contains only the positive numbers from the input.
  def positive([]), do: []
  def positive([head | tail]) when head <= 0, do: positive(tail)
  def positive([head | tail]) when head > 0, do: [head | positive(tail)]
end
