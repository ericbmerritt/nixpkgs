{ elmPackages, fetchurl, glibcLocales, stdenv, sunlight }:

elmPackages.app rec {
  name = "webui";
  version = "0.0.0+build.7.ga25a323";
  src = sunlight.fetch {name = "webui";version = "0.0.0+build.7.ga25a323"; sha256 = "0kkbyaai37fqws3671ja2wznqxvnxqa0flng0ym6dc8qzrygwlng";};

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

  buildFlags = [ "sh_build" ];

  installPhase = ''
    mkdir -p $out/var/sunlight/www
    cp -r _build/* $out/var/sunlight/www/
  '';

  meta = {
    description = "Sunlight front end";
    license = stdenv.lib.licenses.unfree;
  };
}