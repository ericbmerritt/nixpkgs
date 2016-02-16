{stdenv, buildHex, quickrand }:

let
  pkg = self: buildHex rec {
    name = "uuid_erl";
    version = "1.5.1";

    sha256 = "1ykl3g3j1wzv94qydq0f1jiqvmdrzls2pbnlfd84ac9nd688sapx";

    erlDeps = [ quickrand ];

    meta = {
      description = "Erlang UUID Implementation";
      license = stdenv.lib.licenses.bsd;
      homepage = "https://github.com/okeuday/uuid";
      maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
    };
};
in stdenv.lib.fix pkg
