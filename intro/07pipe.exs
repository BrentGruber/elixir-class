defmodule Pipetest do
    def square(x), do: x * x

    def sum(l, start \\ 0) do
        start + Enum.sum(l)
    end

    def sst(the_list) do
        the_list
        |> tl
        |> sum
        |> square
    end
end

IO.puts Pipetest.sst([1,2,5])
