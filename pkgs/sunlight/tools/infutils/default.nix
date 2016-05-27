{ stdenv, sunlight }:
stdenv.mkDerivation rec {
  name = "infutils";
  version = "0.0.0+build.30.g547c438";
  src = sunlight.fetch {name = "infutils";version = "0.0.0+build.30.g547c438"; sha256 = "1iy4z9i0a5186qdqk3y38xn3i9gj8ynr8qivv4gb3iak8512k075";};
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