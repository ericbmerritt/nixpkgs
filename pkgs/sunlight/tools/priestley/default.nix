{ pkgs, sunlight, haskellPackages, stdenv, moreutils, gitMinimal,
  makeWrapper, bash, gnumake, gnupg, nix }:

with haskellPackages; mkDerivation {
  pname = "priestley";
  version = "0.0.0+build.3.0393329";
  src = sunlight.fetch {name = "priestley";version = "0.0.0+build.3.0393329"; sha256 = "1x0f98axq8rzgf8bv6zq2ljaisqy34yxxf6k5x9jhlf0rxpsk45m";};
  isLibrary = false;
  isExecutable = true;
  dontStrip = true;

  buildDepends = [ moreutils hlint
                   sunlight.vandusen makeWrapper ];
  testHaskellDepends = [ tasty doctest ];
  executableHaskellDepends = [ base cmdargs shelly aeson github
                               split wreq hslogger time lens bytestring
                               sunlight.public-keys pkgs.git MissingH
                               sunlight.public-keys gitMinimal
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
