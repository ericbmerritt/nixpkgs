{ sunlight, haskellPackages, stdenv, moreutils, awscli, easyrsa }:

with haskellPackages; mkDerivation {
  pname = "infcli";
  version = "0.0.6+build.4.gb1c2337";
  src = sunlight.fetch {name = "infcli";version = "0.0.6+build.4.gb1c2337"; sha256 = "1jax0kgcib2cwrhsj99sgb8b5bmysh3d7mz7227g06jshnh7q5pd";};

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
