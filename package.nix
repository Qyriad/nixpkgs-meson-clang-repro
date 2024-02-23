{
  lib,
  stdenv,
  meson,
  ninja,
}: stdenv.mkDerivation (self: {
  name = "meson-basic-cpp-${stdenv.cc.name}";
  src = lib.cleanSource ./.;

  nativeBuildInputs = [
    meson
    ninja
  ];

  passthru.manualBuild = self.overrideAttrs {
    name = "manual-${self.name}";
    phases = [ "buildPhase" ];
    buildPhase = ''
      runHook preBuild

      mkdir -p $out/bin
      c++ -v -o $out/bin/main $src/src/main.cpp
      runHook postBuild
    '';
  };
})
