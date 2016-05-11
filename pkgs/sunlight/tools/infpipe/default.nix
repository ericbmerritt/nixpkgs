{ pkgs, sunlight, haskellPackages, stdenv, moreutils, gitMinimal,
  bash, gnumake, gnupg, nix, nettools, makeWrapper, openssh}:

with haskellPackages; mkDerivation {
  pname = "infpipe";
  version = "0.0.5+build.10.gdc2d1f4";
  src = sunlight.fetch {name = "infpipe";version = "0.0.5+build.10.gdc2d1f4"; sha256 = "19cff2dvdfv83zik9s3v8i02ky4iii7b8wyfhm2b0g2d46lcqjw8";};
  isLibrary = false;
  isExecutable = true;
  dontStrip = true;

  buildDepends = [ moreutils hlint makeWrapper
                   sunlight.infcli sunlight.public-keys ];

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