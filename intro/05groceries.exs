defmodule Groceries do

    def add(groceries, item) do
        Map.put(groceries, item, 1)
    end

    def remove(groceries, item) do
        %{groceries | item => groceries[item] - 1}
    end
end