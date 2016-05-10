{ sunlight, haskellPackages, stdenv, moreutils, awscli, easyrsa }:

with haskellPackages; mkDerivation {
  pname = "infcli";
  version = "0.0.6+build.6.ge362337";
  src = sunlight.fetch {name = "infcli";version = "0.0.6+build.6.ge362337"; sha256 = "0f6vv27zygkf4p0q47hmz8vb6wfp497wl7pyhp1583mlk82fk4dd";};

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
    base cmdargs doctest shelly split tasty text awscli easyrsa
  ];

  description = "Automation commands for sunlight systems";
  license = stdenv.lib.licenses.unfree;
}
