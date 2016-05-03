{ sunlight, haskellPackages, stdenv, moreutils }:

with haskellPackages; mkDerivation {
  pname = "infcli";
  version = "0.0.5+build.26.g8ec37a6";
  src = sunlight.fetch {name = "infcli";version = "0.0.5+build.26.g8ec37a6"; sha256 = "11jzb4qs74j25xky2ffdn0z6xqbkqz1csq2vbjiaw4sa9vkhn4nn";};

  isLibrary = true;
  isExecutable = true;
  dontStrip = true;

  buildDepends = [
    moreutils haskellPackages.cabal-install
    haskellPackages.hindent
    haskellPackages.hlint
  ];

  libraryHaskellDepends = [
    base formatting github HStringTemplate lens MissingH semver shelly
    split system-filepath text regex-compat
  ];

  executableHaskellDepends = [ base cmdargs mtl shelly text ];
  testHaskellDepends = [
    base cmdargs doctest shelly split tasty text
  ];

  description = "Automation commands for sunlight systems";
  license = stdenv.lib.licenses.unfree;
}