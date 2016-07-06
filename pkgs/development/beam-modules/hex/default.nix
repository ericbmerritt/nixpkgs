{stdenv, fetchFromGitHub, writeText, elixir }:

let
  shell = drv: stdenv.mkDerivation {
          name = "interactive-shell-${drv.name}";
          buildInputs = [ drv ];
    };

  pkg = self: stdenv.mkDerivation rec {
    name = "hex";
    version = "v0.12.1";

    src = fetchFromGitHub {
        owner = "hexpm";
        repo = "hex";
        rev = "bd6569fd9c716341e140887e0e71d340060107bd";
        sha256 = "1b91fg4rmr8x0w5rjkd00nbzg12mfmk4xhq9pfcrijbid50vly85";
    };

    setupHook = writeText "setupHook.sh" ''
       addToSearchPath ERL_LIBS "$1/lib/erlang/lib/"
    '';

    dontStrip = true;

    buildInputs = [ elixir ];

    buildPhase = ''
      runHook preBuild
      export HEX_OFFLINE=1
      export HEX_HOME=./
      export MIX_ENV=prod
      mix compile
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/lib/erlang/lib
      cp -r ./_build/prod/lib/hex $out/lib/erlang/lib/

      runHook postInstall
    '';

    meta = {
      description = "Package manager for the Erlang VM https://hex.pm";
      license = stdenv.lib.licenses.mit;
      homepage = "https://github.com/hexpm/hex";
      maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
    };

    passthru = {
      env = shell self;
    };

};
in stdenv.lib.fix pkg
