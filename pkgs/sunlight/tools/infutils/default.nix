{ stdenv, sunlight }:
stdenv.mkDerivation rec {
  name = "infutils";
  version = "0.0.0+build.25.gf853fbb";
  src = sunlight.fetch {name = "infutils";version = "0.0.0+build.25.gf853fbb"; sha256 = "1i3z066nr5q7skbxilga0izmd0ljs5c3wsxr4kp7y5pc9842c43g";};
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