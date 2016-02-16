{stdenv, fetchFromGitHub, buildRebar3 }:

let
  shell = drv: stdenv.mkDerivation {
          name = "interactive-shell-${drv.name}";
          buildInputs = [ drv ];
    };

  pkg = self: buildRebar3 rec {
    name = "erlware-uri";
    version = "0.5.0";

    src = fetchFromGitHub {
        owner = "erlware";
        repo = "uri";
        rev = "91f6b7162d25cc42538606daf08f5df3b9f5861b";
        sha256 = "0c9rmzwk5rz5qclby1cy2dd8ajg7pkgqffd3621a515kl9am8zrz";
    };

    meta = {
      description = "uri parsing module for Erlang";
      license = stdenv.lib.licenses.asl20;
      homepage = "https://github.com/erlware/uri";
      maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
    };

    passthru = {
      env = shell self;
    };

};
in stdenv.lib.fix pkg
