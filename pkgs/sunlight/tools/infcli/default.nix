{ awscli
, bash
, easyrsa
, gitMinimal
, gnupg
, haskellPackages
, makeWrapper
, moreutils
, nix
, nix-prefetch-git
, openssh
, stdenv
, sunlight}:

with haskellPackages; mkDerivation {
  pname = "infcli";
  version = "0.0.6+build.36.g095c847";
  src = sunlight.fetch {name = "infcli";version = "0.0.6+build.36.g095c847"; sha256 = "1c8ff1kn5q3l9b34m3n6yjwg5rc1svxplyv6qkgghc3d2yd7bzgg";};

  isLibrary = true;
  isExecutable = true;
  dontStrip = true;

  buildDepends = [
    haskellPackages.cabal-install
    haskellPackages.hindent
    haskellPackages.hlint
    moreutils
  ];

  libraryHaskellDepends = [
    HStringTemplate
    MissingH
    base
    formatting
    github
    lens
    regex-compat
    semver
    shelly
    split
    system-filepath
    text
  ];

  executableHaskellDepends = [
    base
    cmdargs
    gitMinimal
    makeWrapper
    mtl
    nix
    nix-prefetch-git
    openssh
    shelly
    sunlight.public-keys
    text
  ];

  testHaskellDepends = [
    awscli
    base
    cmdargs
    doctest
    easyrsa
    shelly
    split
    tasty
    text
  ];

  postInstall = ''
     wrapProgram $out/bin/infcli \
         --suffix PATH : ${bash}/bin \
         --suffix PATH : ${gitMinimal}/bin \
         --suffix PATH : ${gnupg}/bin \
         --suffix PATH : ${nix}/bin \
         --suffix PATH : ${nix-prefetch-git}/bin \
         --suffix PATH : ${openssh}/bin \
         --suffix PATH : ${sunlight.public-keys}/bin
   '';


  description = "Automation commands for sunlight systems";
  license = stdenv.lib.licenses.unfree;
}