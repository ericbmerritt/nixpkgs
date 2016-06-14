# USED BY infpipe (sunlight tooling) TO GENERATE `infdesc/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight }:

stdenv.mkDerivation rec {
  name = "infdesc";
  version = "0.0.0+build.91.gb642013";
  src = sunlight.fetch {name = "infdesc";version = "0.0.0+build.91.gb642013"; sha256 = "1vam2gfsfys9grsscijhv1m1z1jccxws5y75l4d2ps20zwfbkdfj";};

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