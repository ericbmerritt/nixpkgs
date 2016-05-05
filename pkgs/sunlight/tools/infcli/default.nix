{ sunlight, haskellPackages, stdenv, moreutils, awscli, easyrsa }:

with haskellPackages; mkDerivation {
  pname = "infcli";
  version = "0.0.6+build.2.gecfea66";
  src = sunlight.fetch {name = "infcli";version = "0.0.6+build.2.gecfea66"; sha256 = "14lr9ywvqkaxqyx7yd31m7y8bhvvbq3nk5al84b7rnb8kxdzncri";};

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