{ sunlight, haskellPackages, stdenv, moreutils }:

with haskellPackages; mkDerivation {
  pname = "vandusen";
  version = "0.0.3+build.4.ga3b99d1";
  src = sunlight.fetch {name = "vandusen";version = "0.0.3"; sha256 = "1jhx5y0d5jnhkcfwhjhldbyhp0sx19grigbkpahlm1m7sf1fd83v";};

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
    split system-filepath text
  ];

  executableHaskellDepends = [ base cmdargs mtl shelly text ];
  testHaskellDepends = [
    base cmdargs doctest shelly split tasty text
  ];

  description = "Automation commands for sunlight systems";
  license = stdenv.lib.licenses.unfree;
}
