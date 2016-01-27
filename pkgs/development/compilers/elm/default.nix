{ stdenv, lib, pkgs, buildEnv, haskell, nodejs, fetchurl, fetchpatch, makeWrapper }:

let
  makeElmStuff = deps:
    let json = builtins.toJSON (lib.mapAttrs (name: info: info.version) deps);
        cmds = lib.mapAttrsToList (name: info: let
                 pkg = stdenv.mkDerivation {

                   name = lib.replaceChars ["/"] ["-"] name + "-${info.version}";

                   src = fetchurl {
                     url = "https://github.com/${name}/archive/${info.version}.tar.gz";
                     meta.homepage = "https://github.com/${name}/";
                     inherit (info) sha256;
                   };

                   phases = [ "unpackPhase" "installPhase" ];

                   installPhase = ''
                     mkdir -p $out
                     cp -r * $out
                   '';

                 };
               in ''
                 mkdir -p elm-stuff/packages/${name}
                 ln -s ${pkg} elm-stuff/packages/${name}/${info.version}
               '') deps;
    in ''
      export HOME=/tmp
      mkdir elm-stuff
      cat > elm-stuff/exact-dependencies.json <<EOF
      ${json}
      EOF
    '' + lib.concatStrings cmds;

  hsPkgs = haskell.packages.ghc7103.override {
    overrides = self: super:
      let hlib = haskell.lib;
          elmRelease = import ./packages/release.nix { inherit (self) callPackage; };
          elmPkgs' = elmRelease.packages;
          elmPkgs = elmPkgs' // {

            elm-reactor = hlib.overrideCabal elmPkgs'.elm-reactor (drv: {
              buildTools = drv.buildTools or [] ++ [ self.elm-make ];
              preConfigure = makeElmStuff (import ./packages/elm-reactor-elm.nix);
            });

            elm-repl = hlib.overrideCabal elmPkgs'.elm-repl (drv: {
              doCheck = false;
              buildTools = drv.buildTools or [] ++ [ makeWrapper ];
              postInstall =
                let bins = lib.makeSearchPath "bin" [ nodejs self.elm-make ];
                in ''
                  wrapProgram $out/bin/elm-repl \
                    --prefix PATH ':' ${bins}
                '';
            });

          };
      in elmPkgs // {
        inherit elmPkgs;
        elmVersion = elmRelease.version;
      };
  };
  self = hsPkgs.elmPkgs // rec {
    elm = buildEnv {
      name = "elm-${hsPkgs.elmVersion}";
      paths = lib.mapAttrsToList (name: pkg: pkg) hsPkgs.elmPkgs;
      pathsToLink = [ "/bin" ];
    };

    library = callPackage ./library.nix {};
    app = callPackage ./app.nix {};

    callPackage = pkgs.lib.callPackageWith (pkgs // self);

    virtual-dom = callPackage ../../elm-modules/evancz/virtual-dom.nix {};
    markdown = callPackage ../../elm-modules/evancz/elm-markdown.nix {};
    html = callPackage ../../elm-modules/evancz/elm-html.nix {};
    core = callPackage ../../elm-modules/elm-lang/core.nix {};

  };
in self
