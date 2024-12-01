IO.stream()
  |> Enum.to_list() # ["3 2\n", "1 4\n", "5 6\n"]
  |> Enum.map(fn y ->
    y
      |> String.trim()
      |> String.split(~r/ +/)
      |> Enum.map(&String.to_integer/1)
  end) # [[3, 2], [1, 4], [5, 6]]
  |> List.zip() # [{3, 1, 5}, {2, 4, 6}]
  |> Enum.map(&Tuple.to_list/1) # [[3, 1, 5], [2, 4, 6]]
  |> Enum.map(&Enum.sort/1) # [[1, 3, 5], [2, 4, 6]]
  |> List.zip() # [{1, 2}, {3, 4}, {5, 6}]
  |> Enum.map(fn {a, b} -> abs(a - b) end) # [1, 1, 1]
  |> Enum.sum() # 3
  |> IO.inspect()
