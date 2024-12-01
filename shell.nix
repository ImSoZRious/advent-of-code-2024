{
  mkShell,
  zig,
  zls,
  elixir_1_16,
  elixir-ls,
}:
mkShell {
  buildInputs = [
    zig
    zls

    elixir_1_16
    elixir-ls
  ];
}
