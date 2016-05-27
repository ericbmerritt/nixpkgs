# USED BY sunlightapi_mi TO GENERATE `sunlightapi_mi/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight, nginx, glibcLocales, makeWrapper }:

stdenv.mkDerivation rec {
  name = "sunlightapi_mi";
  version = "0.0.0+build.7.e413dd5";
  src = sunlight.fetch {name = "sunlightapi_mi";version = "0.0.0+build.7.e413dd5"; sha256 = "1wbazx6fx2xal3n5frggj25haz9c06akxr9g70g4qkx7lla0hivg";};

  dontStrip = true;

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

  buildInputs = with sunlight; [ infutils infcli nginx
                                 sunlightapi makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/sunlight/configurations/sunlightapi_mi
    mkdir -p $out/sunlight/packer/sunlightapi_mi
    mkdir -p $out/bin/

    cp src/nix/* $out/sunlight/configurations/sunlightapi_mi/
    cp src/packer/* $out/sunlight/packer/sunlightapi_mi/
    cp bin/sunlightapi_mi $out/bin/sunlightapi_mi


    chmod a+x $out/bin/sunlightapi_mi

    wrapProgram $out/bin/sunlightapi_mi \
       --suffix PATH : ${sunlight.infcli}/bin \
       --add-flags "--configuration $out/sunlight/configurations/sunlightapi_mi/qemu.nix"

    runHook postInstall
  '';


  meta = {
    description = "Descriptions for the sunlightapi machine image";
    license = stdenv.lib.licenses.unfree;
  };
}