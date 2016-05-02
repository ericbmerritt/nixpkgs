{ sunlight, haskellPackages, stdenv, moreutils }:

with haskellPackages; mkDerivation {
  pname = "vandusen";
  version = "0.0.5+build.23.gfa45e29";
  src = sunlight.fetch {name = "vandusen";version = "0.0.5+build.23.gfa45e29"; sha256 = "1n97y9zvn3482b9z4h4nc7cdspxvpw2ij1nzj9pfp87w50w7asp6";};

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