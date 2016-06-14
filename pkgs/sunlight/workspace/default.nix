{ bash
, gitMinimal
, haskellPackages
, makeWrapper
, nix
, stdenv
, sunlight}:

with haskellPackages; mkDerivation {
  pname = "workspace";
  version = "0.0.0+build.19.g5defc94";
  src = sunlight.fetch {name = "workspace";version = "0.0.0+build.19.g5defc94"; sha256 = "1d4y2h5cx9cg5wzg3lmqr0ha6y2pmc2nsh07j7rpx5qc8x9is7sf";};

  isLibrary = true;
  isExecutable = true;
  dontStrip = true;

  buildDepends = [
    haskellPackages.cabal-install
  ];

  libraryHaskellDepends = [
    base
    github
    sunlight.infcli
    MissingH
    mtl
    shelly
    text
    vector
    aeson
    bytestring
    unix
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

  preBuild = ''
     SRCS=`find src exe -type f -name "*.hs"`
     for SRC in $SRCS; do hlint "$SRC"; done
  '';

  postInstall = ''
     wrapProgram $out/bin/ws \
         --suffix PATH : ${bash}/bin \
         --suffix PATH : ${gitMinimal}/bin
   '';


  description = "Automation commands for sunlight systems";
  license = stdenv.lib.licenses.unfree;
}