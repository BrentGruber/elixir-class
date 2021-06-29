defmodule Math do
    def zero?(0), do: true # can use this syntax for single lines
    def zero?(x) when is_integer(x), do: false #is_integer is a guard that ensures x is an integer
    def zero?(_), do: "Cannot calculate for non-integers" #if first 2 defs don't match
end

IO.puts(Math.zero?(0))
IO.puts(Math.zero?(5))
IO.puts(Math.zero?("Hello"))