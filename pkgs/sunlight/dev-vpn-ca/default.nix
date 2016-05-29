# USED BY infpipe (sunlight tooling) TO GENERATE `dev-vpn-ca/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight }:

stdenv.mkDerivation rec {
  name = "dev-vpn-ca";
  version = "0.0.0+build.23.gd9009ee";
  src = sunlight.fetch {name = "dev-vpn-ca";version = "0.0.0+build.23.gd9009ee"; sha256 = "0dlq5h7idgqfbwwc50pjbmhd95z087h3yxv3a4h3m2zl748lv2s3";};

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