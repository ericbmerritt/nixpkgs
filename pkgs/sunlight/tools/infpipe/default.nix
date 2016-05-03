{ pkgs, sunlight, haskellPackages, stdenv, moreutils, gitMinimal,
  makeWrapper, bash, gnumake, gnupg, nix }:

with haskellPackages; mkDerivation {
  pname = "infpipe";
  version = "0.0.4+build.31.ga64cd07";
  src = sunlight.fetch {name = "infpipe";version = "0.0.4+build.31.ga64cd07"; sha256 = "1mrg3j49kh4mfr7mqamgk1i7ywfi7bymjz5qkzsbvj10rg5c0460";};
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