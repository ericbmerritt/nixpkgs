{ awscli, bash, easyrsa, gitMinimal, gnupg, haskellPackages, makeWrapper,
  moreutils, nix, sunlight, stdenv }:

with haskellPackages; mkDerivation {
  pname = "infcli";
  version = "0.0.6+build.8.g2ea9eb3";
  src = sunlight.fetch {name = "infcli";version = "0.0.6+build.8.g2ea9eb3"; sha256 = "15wj2pknhwfz0101pnvb6cs53lx9bmbjwyffa9h575mz6mnfp69f";};

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

  executableHaskellDepends = [ base cmdargs mtl shelly text gitMinimal
                               sunlight.public-keys makeWrapper ];
  testHaskellDepends = [
    base cmdargs doctest shelly split tasty text awscli easyrsa
  ];

  postInstall = ''
     wrapProgram $out/bin/infcli \
         --suffix PATH : ${bash}/bin \
         --suffix PATH : ${gitMinimal}/bin \
         --suffix PATH : ${gnupg}/bin \
         --suffix PAHT : ${nix}/bin \
         --suffix PATH : ${sunlight.public-keys}/bin
   '';


  description = "Automation commands for sunlight systems";
  license = stdenv.lib.licenses.unfree;
}