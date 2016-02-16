{ stdenv, sunlight, erlangPackages, erlang }:


erlangPackages.buildRebar3 {
  name = "wimsey";
  version = "0.0.1";

  src = /home/eric/workspace/wimsey;

  buildInputs = [ sunlight.vandusen erlang ];

  erlangDeps = with erlangPackages; [ ];

  meta = {
    description = "Base node for the system";
    license = stdenv.lib.licenses.unfree;
  };
}