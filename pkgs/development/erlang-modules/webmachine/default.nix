{stdenv, fetchFromGitHub, buildRebar3, meck, ibrowse, eunit_formatters, mochiweb }:

let
  shell = drv: stdenv.mkDerivation {
          name = "interactive-shell-${drv.name}";
          buildInputs = [ drv ];
    };

  pkg = self: buildRebar3 rec {
    name = "webmachine";
    version = "1.10.8+build.25.g03d2439";

    src = fetchFromGitHub {
        owner = "webmachine";
        repo = "webmachine";
        rev = "03d243937d16bf8cbd7feddfe0ad830808494732";
        sha256 = "101rjvghn7581bavfzlzr44v5m96b3diw7zc3g0chwys1b3prqlr";
    };

    erlangDeps = [ meck ibrowse eunit_formatters mochiweb ];

    meta = {
      description = "A REST-based system for building web applications";
      license = stdenv.lib.licenses.asl20;
      homepage = "https://github.com/webmachine/webmachine";
      maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
    };

    passthru = {
      env = shell self;
    };

};
in stdenv.lib.fix pkg
