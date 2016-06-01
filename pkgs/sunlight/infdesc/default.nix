# USED BY infpipe (sunlight tooling) TO GENERATE `infdesc/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight }:

stdenv.mkDerivation rec {
  name = "infdesc";
  version = "0.0.0+build.87.gb6ab6fa";
  src = sunlight.fetch {name = "infdesc";version = "0.0.0+build.87.gb6ab6fa"; sha256 = "0lwj97nzp0m5zhgkwan56wb0wqagbnmxidmwllwrpdpg4favsnb6";};

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