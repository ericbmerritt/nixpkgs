# USED BY infpipe (sunlight tooling) TO GENERATE `infdesc/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight }:

stdenv.mkDerivation rec {
  name = "infdesc";
  version = "0.0.0+build.85.g7d7afbf";
  src = sunlight.fetch {name = "infdesc";version = "0.0.0+build.85.g7d7afbf"; sha256 = "1rb71897lsvrbygr60yjjcdm856brv9hw77snw8bkwxkmwfn8awp";};

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