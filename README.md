# Reproduction repo: Nixpkgs fails to build a Meson C++ hello world with Clang when LTO is enabled.

Reproduction:
```bash
$ nix flake check --keep-going "github:Qyriad/nixpkgs-meson-clang-repro"
```
