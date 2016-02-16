{ stdenv, fetchurl, sunlight, elmPackages }:

with elmPackages; app {
  name = "jervis";
  version = "0.0.0+build.1.153330a";
  src = /home/eric/workspace/jervis;

  buildInputs = [ elmPackages.elm-make sunlight.vandusen ];

  elmDeps = with elmPackages; [ core html virtual-dom ];


  buildFlags = [ "sh_build" ];

  installPhase = ''
    runHook preInstall
    make PREFIX=$out sh_install
    runHook postInstall
  '';

  meta = {
    description = "Sunlight front end";
    license = stdenv.lib.licenses.unfree;
  };
}