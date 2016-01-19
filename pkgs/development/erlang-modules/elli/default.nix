{stdenv, fetchFromGitHub, buildRebar3 }:

let
  shell = drv: stdenv.mkDerivation {
          name = "interactive-shell-${drv.name}";
          buildInputs = [ drv ];
    };

  pkg = self: buildRebar3 rec {
    name = "elli";
    version = "1.0.4";

    src = fetchFromGitHub {
        owner = "knutin";
        repo = "elli";
        rev = "a15f838b4223caf7faa616cbadac4b250215d2f6";
        sha256 = "1ybf1p7bqbl4cg469qdx6rwdl4r1p7h4hiyshnsd9bbhp3wqcnb8";
    };

    meta = {
      description = "Elli is a webserver you can run inside your Erlang application to expose an HTTP API.";
      license = stdenv.lib.licenses.mit;
      homepage = "https://github.com/knutin/elli";
      maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
    };

    passthru = {
      env = shell self;
    };

};
in stdenv.lib.fix pkg
