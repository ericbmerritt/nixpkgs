{ pkgs, sunlight, haskellPackages, stdenv, moreutils, gitMinimal,
  makeWrapper, bash, gnumake, gnupg, nix }:

with haskellPackages; mkDerivation {
  pname = "priestley";
  version = "0.0.1";
  src = sunlight.fetch {name = "priestley";version = "0.0.1"; sha256 = "0bbi43gp64ljjzrvb4giai0am3fqz9fkjp0zawxy0n3dszd5i4kb";};
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
