[l, r] = IO.stream()
  |> Enum.to_list() # ["3 2\n", "1 4\n", "5 6\n"]
  |> Enum.map(fn y ->
    y
      |> String.trim()
      |> String.split(~r/ +/)
      |> Enum.map(&String.to_integer/1)
  end) # [[3, 2], [1, 4], [5, 6]]
  |> List.zip() # [{3, 1, 5}, {2, 4, 6}]
  |> Enum.map(&Tuple.to_list/1) # [[3, 1, 5], [2, 4, 6]]
  |> Enum.map(fn x ->
    Enum.reduce(x, %{}, fn char, acc ->
      Map.update(acc, char, 1, &(&1 + 1))
    end)
  end)

ans = Enum.reduce(l, 0, fn {k, v}, acc ->
  acc + k * v * (r[k] || 0)
end)

IO.puts(ans)
