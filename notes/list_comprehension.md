# List Comprehension

```elixir
for x <- list do
end
```

* Can be read as for x in list do.
* This is inherently a map
* can do nested comprehension, but it will return nested array
* string interpolation "#{x} can be joined with #{y}"
* Can run multiple comprehensions at the same time. e.g. for x <- list1, y <- list2 do
    * goes through every possible combination and returns a single flattened list