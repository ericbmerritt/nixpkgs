{ pkgs, sunlight, haskellPackages, stdenv, moreutils, gitMinimal,
  bash, gnumake, gnupg, nix, nettools, makeWrapper, openssh}:

with haskellPackages; mkDerivation {
  pname = "infpipe";
  version = "0.0.5+build.18.g2667cd6";
  src = sunlight.fetch {name = "infpipe";version = "0.0.5+build.18.g2667cd6"; sha256 = "187afz5pc990khsgi2x7shqq444alyzz3kmkrfcr6mxr1xqgfrwb";};
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