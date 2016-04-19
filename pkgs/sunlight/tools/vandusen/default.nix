{ sunlight, haskellPackages, stdenv, moreutils }:

with haskellPackages; mkDerivation {
  pname = "vandusen";
  version = "0.0.5";
  src = sunlight.fetch {name = "vandusen";version = "0.0.5"; sha256 = "1210kyswg26f14p5q9crblhnqfn1vkhb63523c28zhgxrckvad5b";};

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
