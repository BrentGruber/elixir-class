defmodule Math do
    def div(_, 0) do
        # don't care about first value
        # second value has to be exactly 0
        {:error, "Cannot divide by 0"}
    end

    def div(x, y) do
        # can overload, but elixir will execute first match
        # this means specific matches should be defined first
        { :ok, "value is #{x/y}"}
    end
end

# IO.inspect for tuples
IO.inspect Math.div(1,0)
IO.inspect Math.div(12,3)