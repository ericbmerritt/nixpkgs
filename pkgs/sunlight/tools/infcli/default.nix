{ sunlight, haskellPackages, stdenv, moreutils, awscli, easyrsa }:

with haskellPackages; mkDerivation {
  pname = "infcli";
  version = "0.0.5+build.36.g4e1432a";
  src = sunlight.fetch {name = "infcli";version = "0.0.5+build.36.g4e1432a"; sha256 = "1gzasnfczvmkaspfdbiw6r83065naqpybayjb9dzkddxkmxx0mxh";};

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