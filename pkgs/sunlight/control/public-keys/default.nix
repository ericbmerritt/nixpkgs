{ stdenv, sunlight }:
stdenv.mkDerivation rec {
  name = "public-keys";
  version = "0.0.12+build.6.g629c8b9";
  src = sunlight.fetch {name = "public-keys";version = "0.0.12+build.6.g629c8b9"; sha256 = "0sgs6bnck919ly4yw2gl7n9i5dr021x9m6bbahfgkkjnw67vxpfy";};

  phases = ["unpackPhase" "installPhase"];

  installPhase = ''
    mkdir -p $out/sunlight/etc/public-keys
    cp keys/*.asc $out/sunlight/etc/public-keys/

    mkdir -p $out/bin
    cp keys/*.asc $out/bin/
  '';

  meta = {
    description = "Approved developer public keys";
    license = stdenv.lib.licenses.unfree;
  };
}