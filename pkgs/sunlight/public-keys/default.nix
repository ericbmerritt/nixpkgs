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
  version = "0.0.12+build.16.g6c8c41e";
  src = sunlight.fetch {name = "public-keys";version = "0.0.12+build.16.g6c8c41e"; sha256 = "0947sqdfjq75p62h8ianqkjjnfkyib5117i2pmrr4ks18mdb31l8";};

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