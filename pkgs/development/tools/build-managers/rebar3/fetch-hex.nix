{ stdenv, fetchurl }:

{ pkg, version, sha256
, meta ? {}
}:

with stdenv.lib;

stdenv.mkDerivation ({
  # This name '-hex-source-', is used and parsed by (at least)
  # rebar3-nix-bootstrap. Be careful when changing it.
  name = "hex-source-${pkg}-${version}";

  src = fetchurl {
    url = "https://s3.amazonaws.com/s3.hex.pm/tarballs/${pkg}-${version}.tar";
    inherit sha256;
  };

  phases = [ "unpackPhase" "installPhase" ];

  unpackCmd = ''
    tar -xf $curSrc contents.tar.gz
    mkdir contents
    tar -C contents -xzf contents.tar.gz
  '';

  installPhase = ''
    runHook preInstall
    mkdir "$out"
    cp -Hrt "$out" .
    success=1
    runHook postInstall
  '';

  inherit meta;
})
