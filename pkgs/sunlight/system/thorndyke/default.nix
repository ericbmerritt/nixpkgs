{ stdenv, sunlight, erlangPackages, bash, nettools, erlang }:


erlangPackages.buildRebar3 {
  name = "thorndyke";
  version = "0.0.1";

  src = /home/eric/workspace/thorndyke;

  buildInputs = [ bash nettools erlang ];

  erlangDeps = with erlangPackages; [ elli ];

  installPhase = ''
    runHook preInstall
    target="$out/var/sunlight"
    erlang="${erlang}"
    make PREFIX=$target install
    substituteAllInPlace $target/thorndyke/bin/thorndyke
    runHook postInstall
  '';


  meta = {
    description = "Base node for the system";
    license = stdenv.lib.licenses.unfree;
  };
}