# USED BY infopipe (sunlight tooling) TO GENERATE `infpipe/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight, glibcLocales, makeWrapper }:

stdenv.mkDerivation rec {
  name = "infpipe_mi";
  version = "0.0.0+build.72.g851aeeb";

  src = sunlight.fetch {name = "infpipe_mi";version = "0.0.0+build.72.g851aeeb"; sha256 = "1agn7apac8145hkfcsvd07kvdiyqqnfn36xa2nbwsc39ac2nld6v";};

  LOCALE_ARCHIVE = "${glibcLocales}/lib/locale/locale-archive";

  LANG="en_US.UTF-8";
  LC_CTYPE=LANG;
  LC_NUMERIC=LANG;
  LC_TIME=LANG;
  LC_COLLATE=LANG;
  LC_MONETARY=LANG;
  LC_MESSAGES=LANG;
  LC_PAPER=LANG;
  LC_NAME=LANG;
  LC_ADDRESS=LANG;
  LC_TELEPHONE=LANG;
  LC_MEASUREMENT=LANG;
  LC_IDENTIFICATION=LANG;
  LC_ALL=LANG;


  buildInputs = with sunlight; [ infcli infpipe infutils makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/sunlight/configurations/infpipe_mi
    mkdir -p $out/sunlight/packer/infpipe_mi
    mkdir -p $out/bin/

    cp src/nix/* $out/sunlight/configurations/infpipe_mi/
    cp src/packer/* $out/sunlight/packer/infpipe_mi/
    cp bin/infpipe_mi $out/bin/infpipe_mi

    chmod a+x $out/bin/infpipe_mi

    wrapProgram $out/bin/infpipe_mi \
       --suffix PATH : ${sunlight.infcli}/bin \
       --add-flags "--configuration $out/sunlight/configurations/infpipe_mi/qemu.nix"

    runHook postInstall
  '';


  meta = {
    description = "Descriptions for the sinlightapi machine image";
    license = stdenv.lib.licenses.unfree;
  };
}