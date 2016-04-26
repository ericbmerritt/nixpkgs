{ sunlight, haskellPackages, stdenv, moreutils }:

with haskellPackages; mkDerivation {
  pname = "vandusen";
  version = "0.0.5+build.10.g3a82175";
  src = sunlight.fetch {name = "vandusen";version = "0.0.5+build.10.g3a82175"; sha256 = "1a5ir4yvcpga5fhyvw8iv2s9899r1ka033dxa71gkh2s2dfhdhxw";};

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