# USED BY infpipe (sunlight tooling) TO GENERATE `infdesc/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight }:

stdenv.mkDerivation rec {
  name = "infdesc";
  version = "0.0.0+build.81.gcdb5b0a";
  src = sunlight.fetch {name = "infdesc";version = "0.0.0+build.81.gcdb5b0a"; sha256 = "10cy9wa2lj5x2w5nw7g86wb0p5qd1ln0a75s4psyz4x8k178fwd3";};

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