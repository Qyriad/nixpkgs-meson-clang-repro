{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let

      pkgs = import nixpkgs { inherit system; };
      inherit (pkgs) lib;

      meson-hello = ./package.nix;

      clangUseLLVMStdenv = pkgs.stdenvAdapters.overrideCC pkgs.stdenv pkgs.llvmPackages.clangUseLLVM;

      mkForStdenv = stdenv: pkgs.callPackage meson-hello { inherit stdenv; };

      mesonPackages = {
        # Works.
        stdenv = mkForStdenv pkgs.stdenv;
        # None of these do, through Meson, but do manually.
        clang = mkForStdenv pkgs.clangStdenv;
        clangUseLLVM = mkForStdenv clangUseLLVMStdenv;
        libcxx = mkForStdenv pkgs.llvmPackages.libcxxStdenv;
      };

      manualPackages = let
        names = builtins.attrNames mesonPackages;
        nameSpecs = builtins.map (name: { manual = "${name}Manual"; inherit name; }) names;
        attrsList = builtins.map (nameSpec: {
          ${nameSpec.manual} = mesonPackages.${nameSpec.name}.manualBuild;
        }) nameSpecs;
      in
        # There is definitely a better way to do this. I do not know what it is.
        lib.zipAttrsWith (name: values: builtins.head values) attrsList;

    in {
      packages = mesonPackages // manualPackages;
      checks = self.outputs.packages.${system};
    }
  ); # outputs
}
