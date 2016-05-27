# USED BY infpipe (sunlight tooling) TO GENERATE `dev-vpn-ca/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight }:

stdenv.mkDerivation rec {
  name = "dev-vpn-ca";
  version = "0.0.0+build.19.g1d32012";
  src = sunlight.fetch {name = "dev-vpn-ca";version = "0.0.0+build.19.g1d32012"; sha256 = "1p5v0s1srvgdn25jyzp7dl22crix62424jgb3g7h4xkdqp5cc4zv";};

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