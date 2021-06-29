defmodule Math do

  def sum_list([], acc) do
    acc
  end

  def sum_list([head | tail], acc) do
    sum_list(tail, acc+head)
  end

end

IO.puts Math.sum_list([1, 2, 5], 0)
IO.puts Math.sum_list([], 0)
