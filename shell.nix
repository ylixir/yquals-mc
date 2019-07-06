{ pkgs ? import <nixpkgs> {} }:
with pkgs;
stdenv.mkDerivation {
  name = "yquals-mc";
  buildInputs = import ./default.nix;
}
