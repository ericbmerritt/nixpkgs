{ stdenv, sunlight }:
stdenv.mkDerivation rec {
  name = "infutils";
  version = "0.0.0+build.15.g8d92eba";
  src = sunlight.fetch {name = "infutils";version = "0.0.0+build.15.g8d92eba"; sha256 = "1qh8b9m0bxvl8g1zq3gkhq1pb6ah2c6ypdgmh4ng8di6g364izkx";};
  isLibrary = false;
  isExecutable = false;
  dontStrip = true;

  phases = [ "unpackPhase" "installPhase" "fixupPhase" ];

  installPhase = ''
    mkdir -p $out/
    cp -r share $out/
  '';

  setupHook = builtins.toFile "setup-hook.sh" ''
    export SUNLIGHT_MAKEFILES="$1/share/makefiles"
  '';

  meta = with stdenv.lib; {
    description = "Common infrastructure utilities";
    license = stdenv.lib.licenses.unfree;
  };
}