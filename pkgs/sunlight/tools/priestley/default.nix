{ pkgs, sunlight, haskellPackages, stdenv, moreutils, gitMinimal,
  makeWrapper, bash, gnumake, gnupg, nix }:

with haskellPackages; mkDerivation {
  pname = "priestley";
  version = "0.0.4+build.28.g8d10dc7";
  src = sunlight.fetch {name = "priestley";version = "0.0.4+build.28.g8d10dc7"; sha256 = "1dzs7rj6kqlc5qlkd9day6pzy69r89vj0fk9d6c0fz3sgwn344g4";};
  isLibrary = false;
  isExecutable = true;
  dontStrip = true;

  buildDepends = [ moreutils hlint
                   sunlight.vandusen makeWrapper ];
  testHaskellDepends = [ tasty doctest ];
  executableHaskellDepends = [ base cmdargs shelly aeson github
                               split wreq hslogger time lens bytestring
                               sunlight.public-keys pkgs.git MissingH
                               sunlight.vandusen gitMinimal
                               slack-notify-haskell ];

   postInstall = ''
     wrapProgram $out/bin/priestley \
         --suffix PATH : ${gitMinimal}/bin \
         --suffix PATH : ${bash}/bin:${gnumake}/bin \
         --suffix PATH : ${sunlight.public-keys}/bin \
         --suffix PATH : ${gnupg}/bin:${nix}/bin
   '';

  description = "CI System for sunlight";
  license = stdenv.lib.licenses.unfree;
}