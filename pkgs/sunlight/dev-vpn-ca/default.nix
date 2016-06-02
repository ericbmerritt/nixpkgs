# USED BY infpipe (sunlight tooling) TO GENERATE `dev-vpn-ca/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight }:

stdenv.mkDerivation rec {
  name = "dev-vpn-ca";
  version = "0.0.0+build.25.g20735de";
  src = sunlight.fetch {name = "dev-vpn-ca";version = "0.0.0+build.25.g20735de"; sha256 = "0wms87axy4rgiaxbh5kv68pnqsw4mcczxay2d3s2hbf1vzq10znr";};

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/share/reqs
    cp -r reqs/* $out/share/reqs/
  '';

  meta = {
    description = "Control for the DevZone VPN Certificate Authority";
    license = stdenv.lib.licenses.unfree;
  };
}