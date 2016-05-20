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
  version = "0.0.6+build.30.g3a56b64";
  src = sunlight.fetch {name = "infcli";version = "0.0.6+build.30.g3a56b64"; sha256 = "1y79jp24lw78w4pdijyz7d7hfr1jrs15c63pl9gs05xq8v2p2qds";};

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