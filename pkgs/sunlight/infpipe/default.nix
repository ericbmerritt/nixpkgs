{ pkgs, sunlight, haskellPackages, stdenv, moreutils, gitMinimal,
  bash, gnumake, gnupg, nix, nettools, makeWrapper, openssh}:

with haskellPackages; mkDerivation {
  pname = "infpipe";
  version = "0.0.5+build.39.gf13e025";
  src = sunlight.fetch {name = "infpipe";version = "0.0.5+build.39.gf13e025"; sha256 = "0ji6bywd791lbg2phhpm47bczrdmvbzyiy7f7vfqv1aabl79nmay";};
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
  preBuild = ''
     SRCS=`find src exe -type f -name "*.hs"`
     for SRC in $SRCS; do hlint "$SRC"; done
  '';

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