{ pkgs, sunlight, haskellPackages, stdenv, moreutils, gitMinimal,
  bash, gnumake, gnupg, nix, nettools, makeWrapper, openssh, awscli }:

with haskellPackages; mkDerivation {
  pname = "infpipe";
  version = "0.0.5+build.30.g0c3947c";
  src = ../../../../infpipe;
  isLibrary = false;
  isExecutable = true;
  dontStrip = true;

  buildDepends = [ hlint
                   makeWrapper
                   moreutils
                   sunlight.infcli
                   sunlight.infutils
                   sunlight.public-keys
                 ];
  testHaskellDepends = [ tasty doctest ];

  executableHaskellDepends = [ base cmdargs shelly aeson github
                               split wreq hslogger time lens bytestring
                               MissingH  slack-notify-haskell ];

  postInstall = ''
     wrapProgram $out/bin/infpipe \
         --suffix PATH : ${awscli}/bin \
         --suffix PATH : ${openssh}/bin \
         --suffix PATH : ${gitMinimal}/bin \
         --suffix PATH : ${nettools}/bin \
         --suffix PATH : ${bash}/bin \
         --suffix PATH : ${gnumake}/bin \
         --suffix PATH : ${sunlight.public-keys}/bin \
         --suffix PATH : ${sunlight.infcli}/bin \
         --suffix PATH : ${gnupg}/bin \
         --suffix PATH : ${nix}/bin
  '';

  description = "CI System for sunlight";
  license = stdenv.lib.licenses.unfree;
}