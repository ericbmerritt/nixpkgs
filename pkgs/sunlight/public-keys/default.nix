{ bash
, gawk
, gnugrep
, gnupg
, makeWrapper
, stdenv
, sunlight # needed for 'src'
}:

stdenv.mkDerivation rec {
  name = "public-keys";
  version = "0.0.12+build.14.g87ecf15";
  src = sunlight.fetch {name = "public-keys";version = "0.0.12+build.14.g87ecf15"; sha256 = "0zwr3c8jxx9hz7c98bmml3n2has9lhlx7m30ri5fh1v42l0p3pd9";};

  buildInputs = [ makeWrapper ];

  phases = [ "unpackPhase" "installPhase" "postInstall" ];

  installPhase = ''
    mkdir -p $out/sunlight/etc/public-keys
    cp keys/*.asc $out/sunlight/etc/public-keys/

    mkdir -p $out/bin
    cp bin/* $out/bin/
  '';

  postInstall = ''
    substituteInPlace $out/bin/import-sunlight-keys \
        --replace "/bin/bash" "${bash}/bin/bash"
    wrapProgram $out/bin/import-sunlight-keys \
        --suffix PATH : ${gawk}/bin \
        --suffix PATH : ${gnugrep}/bin \
        --suffix PATH : ${gnupg}/bin
  '';

  meta = {
    description = "Approved developer public keys";
    license = stdenv.lib.licenses.unfree;
  };
}