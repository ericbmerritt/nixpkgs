{ stdenv, sunlight }:
stdenv.mkDerivation rec {
  name = "infutils";
  version = "0.0.0+build.37.g35f28b7";
  src = sunlight.fetch {name = "infutils";version = "0.0.0+build.37.g35f28b7"; sha256 = "0nyq9kxc7kq7ii7ppkwx60bx82fwirnqfngd75c0arv155i8kakp";};
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