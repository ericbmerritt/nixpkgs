# USED BY infpipe (sunlight tooling) TO GENERATE `infdesc/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight }:

stdenv.mkDerivation rec {
  name = "infdesc";
  version = "0.0.0+build.95.g0e25dbd";
  src = sunlight.fetch {name = "infdesc";version = "0.0.0+build.95.g0e25dbd"; sha256 = "0br3q2w5d5l5ym3084aa55kd0hl0kakg903dsvw68vpdnin3n01l";};

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