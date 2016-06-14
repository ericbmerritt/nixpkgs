# USED BY infpipe (sunlight tooling) TO GENERATE `infdesc/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight }:

stdenv.mkDerivation rec {
  name = "infdesc";
  version = "0.0.0+build.93.g9adfa39";
  src = sunlight.fetch {name = "infdesc";version = "0.0.0+build.93.g9adfa39"; sha256 = "0ydaxjs3184ch8hkyc110m9c4x415v909q2hjvig6r8xpp2pygca";};

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/etc/terraform
    cp -r terraform/* $out/etc/terraform/
  '';

  meta = {
    description = "Description of terraform configuration";
    license = stdenv.lib.licenses.unfree;
  };
}