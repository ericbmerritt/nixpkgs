{ stdenv, sunlight, beamPackages, relxExe, git, openssh, erlang }:

beamPackages.buildMix {
  name = "thorndyke";
  version = "0.0.1";

  src = ../../../../../thorndyke;

  buildInputs = with sunlight; [ vandusen git openssh relxExe erlang ];

  beamDeps = with beamPackages;  [ cowboy ewebmachine dialyxir postgrex ];

  postBuild = ''
   ${relxExe}/bin/relx --output-dir _build/release
  '';

  postInstall = ''
    export target="$out/var/sunlight"
    erlang="${erlang}"
    mkdir -p "$target/thorndyke/bin"
    cp -r "_build/release/thorndyke" "$target/"
    substituteAll "bin/thorndyke" "$target/thorndyke/bin/thorndyke"
  '';

  meta = {
    description = "Base node for the system";
    license = stdenv.lib.licenses.unfree;
  };
}