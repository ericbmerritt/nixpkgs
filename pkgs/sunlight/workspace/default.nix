{ bash
, gitMinimal
, haskellPackages
, makeWrapper
, nix
, stdenv
, sunlight}:

with haskellPackages; mkDerivation {
  pname = "workspace";
  version = "0.0.0+build.3.8fe7650";
  src = sunlight.fetch {name = "workspace";version = "0.0.0+build.3.8fe7650"; sha256 = "1n2zhk72c0yh0x03waijppcfvd270grlwinpa2kinbdq3mf93dyx";};

  isLibrary = true;
  isExecutable = true;
  dontStrip = true;

  buildDepends = [
    haskellPackages.cabal-install
  ];

  libraryHaskellDepends = [
    base
    github
    mtl
    shelly
    text
    vector
  ];

  executableHaskellDepends = [
    base
    cmdargs
    gitMinimal
    makeWrapper
    shelly
    text
  ];

  testHaskellDepends = [
    base
    cmdargs
    doctest
    shelly
    tasty
    text
  ];

  postInstall = ''
     wrapProgram $out/bin/ws \
         --suffix PATH : ${bash}/bin \
         --suffix PATH : ${gitMinimal}/bin
   '';


  description = "Automation commands for sunlight systems";
  license = stdenv.lib.licenses.unfree;
}