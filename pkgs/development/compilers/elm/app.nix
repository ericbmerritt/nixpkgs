{ lib, stdenv, buildEnv, haskell, nodejs, fetchurl, fetchpatch, makeWrapper }:

{ name, version
,  root-module ? null
, elmDeps
, ... }@attrs:

with stdenv.lib;

let
  getDeps = drv: [drv] ++ (map getDeps drv.elmDeps);
  recursiveDeps = unique (flatten (map getDeps elmDeps));

  linkElmDependencies = deps:
    let json = builtins.toJSON
                    (builtins.listToAttrs
                      (map (pkg: {name = "${pkg.organization}/${pkg.packageName}"; value = pkg.version;})
                                 deps));
        cmds = map (pkg: ''
                     mkdir -p `pwd`/elm-stuff/packages/${pkg.organization}/${pkg.packageName}
                     ln -sf ${pkg}/elm-stuff/packages/${pkg.organization}/${pkg.packageName}/${pkg.version} `pwd`/elm-stuff/packages/${pkg.organization}/${pkg.packageName}
                    '') deps;
    in ''
      export HOME=/tmp
      mkdir -p elm-stuff/packages
      cat > elm-stuff/exact-dependencies.json <<EOF
      ${json}
      EOF
    '' + lib.concatStrings cmds;

  pkg = self: stdenv.mkDerivation (attrs // {
        name = "${name}-${version}";

        dontDisableStatic=true;
        preConfigure = linkElmDependencies recursiveDeps;

        passthru = {
          packageName = name;
          inherit elmDeps;
       };
   });
in stdenv.lib.fix pkg
