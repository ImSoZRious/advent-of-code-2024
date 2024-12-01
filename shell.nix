{
  pkgs ? import <nixpkgs> {},
}:
with pkgs;
mkShell {
  buildInputs = [
    zig
    zls

    elixir_1_16
    elixir-ls
  ];
}
