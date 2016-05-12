{ stdenv, sunlight }:
stdenv.mkDerivation rec {
  name = "infutils";
  version = "0.0.0+build.17.g0466ebb";
  src = sunlight.fetch {name = "infutils";version = "0.0.0+build.17.g0466ebb"; sha256 = "1h5qx4dw3qsh0nb9a80vffr9fpy7iw9bq7brzrrfq972qaq8w7dr";};
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