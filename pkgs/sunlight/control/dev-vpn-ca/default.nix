# USED BY infpipe (sunlight tooling) TO GENERATE `dev-vpn-ca/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight }:

stdenv.mkDerivation rec {
  name = "dev-vpn-ca";
  version = "0.0.0+build.17.g7852c3e";
  src = sunlight.fetch {name = "dev-vpn-ca";version = "0.0.0+build.17.g7852c3e"; sha256 = "1ddhygzhq9czyy6arhz64hv3r2d143g2x6aqcf4znapqvd9pjl0s";};

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