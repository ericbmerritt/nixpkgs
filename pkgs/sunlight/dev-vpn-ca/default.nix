# USED BY infpipe (sunlight tooling) TO GENERATE `dev-vpn-ca/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight }:

stdenv.mkDerivation rec {
  name = "dev-vpn-ca";
  version = "0.0.0+build.27.gaff9bc6";
  src = sunlight.fetch {name = "dev-vpn-ca";version = "0.0.0+build.27.gaff9bc6"; sha256 = "0rdgh68149f7qpj4dw3m0rhjd5x6pw3971vysi89sjn3s1wdahf8";};

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