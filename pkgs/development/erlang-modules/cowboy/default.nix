{stdenv, fetchFromGitHub, writeText, erlang, erlangPackages, perl,
  which, gitMinimal, wget }:

let
  shell = drv: stdenv.mkDerivation {
          name = "interactive-shell-${drv.name}";
          buildInputs = [ drv ];
    };

  pkg = self: stdenv.mkDerivation rec {
    app_name = "cowboy";
    version = "1.0.4";
    name = "${app_name}-${version}";

    dontStrip = true;

    src = fetchFromGitHub {
        owner = "ninenines";
        repo = "cowboy";
        rev = "1.0.4";
        sha256 = "066hfi8pqs15cqh0qrzv2d2c17qyicv1y50ka8i9sw5fz9bn6aa3";
#        rev = "837cf8b9cef86d085d7c2f7282ca11460c9bdeb5";
#        sha256 = "02lwabf699rs4ndvk6wpcjlh8ghpw57g014nvajvjk0paqm7iqp5";
    };

    setupHook = writeText "setupHook.sh" ''
       addToSearchPath ERL_LIBS "$1/lib/erlang/lib"
    '';

    buildInputs = [ erlang perl which gitMinimal wget ];
    propagatedBuildInputs = with erlangPackages; [ cowlib_1_0_0 ranch_1_1_0 ];

    buildPhase = ''
        runHook preBuild
        make SKIP_DEPS=1 clean
        make SKIP_DEPS=1
        runHook postBuild
    '';

    installPhase = ''
        runHook preInstall
        mkdir -p $out/lib/erlang/lib/${name}
        cp -r ebin $out/lib/erlang/lib/${name}/
        cp -r src $out/lib/erlang/lib/${name}/
        cp -r doc $out/lib/erlang/lib/${name}/

        runHook postInstall
    '';

    meta = {
      description = "Small, fast, modular HTTP server written in Erlang. http://ninenines.eu";
      license = stdenv.lib.licenses.mit;
      homepage = "https://github.com/ninenines/cowboy";
      maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
    };

    passthru = {
      env = shell self;
    };

};
in stdenv.lib.fix pkg
