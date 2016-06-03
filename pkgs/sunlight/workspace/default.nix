{ bash
, gitMinimal
, haskellPackages
, makeWrapper
, nix
, stdenv
, sunlight}:

with haskellPackages; mkDerivation {
  pname = "workspace";
  version = "0.0.0+build.5.g86adca9";
  src = sunlight.fetch {name = "workspace";version = "0.0.0+build.5.g86adca9"; sha256 = "1p2z1hd908fjw1lx9dvlrrphh11mzl583m65xfkcixsjrg65ql1i";};

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