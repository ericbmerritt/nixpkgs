{ stdenv, sunlight, erlangPackages, which, nettools }:


erlangPackages.buildRebar3 {
  name = "thorndyke";
  version = "0.0.0+build.8.g51eba9e";
  src = sunlight.fetch {name = "thorndyke";version = "0.0.0+build.8.g51eba9e"; sha256 = "59acd6a8742047a5fb577343f7ce3cb6a327b14211d220de8447ab015bb29a87";};

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