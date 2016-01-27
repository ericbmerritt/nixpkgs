{stdenv, fetchurl}:

{ organization, name, version
, sha256
, elmDeps ? []
, ... }@attrs:

with stdenv.lib;
let
  pkg = self: stdenv.mkDerivation (attrs // {

    name = "${organization}-${name}-${version}";

    packageName = "${name}";

    inherit version;

    src = fetchurl {
        url = "https://github.com/${organization}/${name}/archive/${version}.tar.gz";
        inherit sha256;
    };

    phases = [ "unpackPhase" "installPhase"];

    inherit elmDeps;

    installPhase = ''
       mkdir -p $out/elm-stuff/packages/${organization}/${name}/${version}
       cp -r * $out/elm-stuff/packages/${organization}/${name}/${version}/
    '';

  });
in stdenv.lib.fix pkg
