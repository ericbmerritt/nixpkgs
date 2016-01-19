{ stdenv, sunlight, erlangPackages, which, nettools }:


erlangPackages.buildRebar3 {
  name = "thorndyke";
  version = "0.0.0+build.10.g2ad02c1";
  src = sunlight.fetch {name = "thorndyke";version = "0.0.0+build.10.g2ad02c1"; sha256 = "6375b979f6880aef833015ef8da3071f1746e21801e7f10167abf883bf34a3f0";};

  buildInputs = [ which nettools ];

  erlangDeps = with erlangPackages; [ elli ];

  installPhase = ''
    runHook preInstall
    make PREFIX=$out install
    runHook postInstall
  '';

  meta = {
    description = "Base node for the system";
    license = stdenv.lib.licenses.unfree;
  };
}