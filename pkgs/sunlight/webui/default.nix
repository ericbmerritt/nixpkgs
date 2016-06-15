{ elmPackages, fetchurl, glibcLocales, stdenv, sunlight, writeText }:

elmPackages.app rec {
  name = "webui";
  version = "0.0.0+build.10.g6c0855a";
  src = sunlight.fetch {name = "webui";version = "0.0.0+build.10.g6c0855a"; sha256 = "10agdpdn76az7ns1kpd8f1d98lf1xnk2bpkfps81n52x9chqxshp";};

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

  buildInputs = [ elmPackages.elm-make sunlight.infcli sunlight.infutils];

  elmDeps = with elmPackages; [ core html virtual-dom ];

  buildInfoFile = writeText "BuildInfo.elm" ''
module BuildInfo exposing (version)

version : String
version = "${version}"
  '';

  configurePhase = ''
    runHook preConfigure

    printenv
    cp ${buildInfoFile} ./src/elm/BuildInfo.elm

    runHook postConfigure
  '';

  buildFlags = ["sh_build"];

  installPhase = ''
    mkdir -p $out/var/sunlight/www
    cp -r _build/* $out/var/sunlight/www/
  '';

  meta = {
    description = "Sunlight front end";
    license = stdenv.lib.licenses.unfree;
  };
}