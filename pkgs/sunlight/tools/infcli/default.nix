{ sunlight, haskellPackages, stdenv, moreutils, awscli, easyrsa }:

with haskellPackages; mkDerivation {
  pname = "infcli";
  version = "0.0.5+build.34.g99a6665";
  src = sunlight.fetch {name = "infcli";version = "0.0.5+build.34.g99a6665"; sha256 = "0wp8adrjw3gk75j91fypcp3pd32kixzlyq83a85izsb4i3zjavif";};

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