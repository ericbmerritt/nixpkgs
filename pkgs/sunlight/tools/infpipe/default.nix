{ pkgs, sunlight, haskellPackages, stdenv, moreutils, gitMinimal,
  makeWrapper, bash, gnumake, gnupg, nix }:

with haskellPackages; mkDerivation {
  pname = "infpipe";
  version = "0.0.5+build.2.g7781c6b";
  src = sunlight.fetch {name = "infpipe";version = "0.0.5+build.2.g7781c6b"; sha256 = "0z005k6f2kg8a31k5aq0lr08mhshssd0slzdb6pxrml2h2s900f0";};
  isLibrary = false;
  isExecutable = true;
  dontStrip = true;

  buildDepends = [ moreutils hlint
                   sunlight.infcli makeWrapper ];
  testHaskellDepends = [ tasty doctest ];
  executableHaskellDepends = [ base cmdargs shelly aeson github
                               split wreq hslogger time lens bytestring
                               sunlight.public-keys pkgs.git MissingH
                               sunlight.infcli gitMinimal
                               slack-notify-haskell ];

   postInstall = ''
     wrapProgram $out/bin/infpipe \
         --suffix PATH : ${gitMinimal}/bin \
         --suffix PATH : ${bash}/bin:${gnumake}/bin \
         --suffix PATH : ${sunlight.public-keys}/bin \
         --suffix PATH : ${gnupg}/bin:${nix}/bin
   '';

  description = "CI System for sunlight";
  license = stdenv.lib.licenses.unfree;
}