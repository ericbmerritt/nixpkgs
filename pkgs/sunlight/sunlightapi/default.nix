# USED BY sunlightapi TO GENERATE `sunlightapi/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight, beamPackages, relxExe, git, openssh, erlang }:

beamPackages.buildMix {
  name = "sunlightapi";
  version = "0.0.0+build.11.g9e1d988";

  src = sunlight.fetch {name = "sunlightapi";version = "0.0.0+build.11.g9e1d988"; sha256 = "0yfa9rxq595d1lzdgm6f4cgzz0mybva3isbmg1mbg0ny2naazjlg";};

  buildInputs = with sunlight; [ git relxExe erlang ];

  beamDeps = with beamPackages;  [ cowboy dialyxir episcina epgsql poison
                                   uuid ex_json_schema timex ];

  postBuild = ''
   mix test --no-start --no-deps-check
   ${relxExe}/bin/relx --output-dir _build/release

  '';

  postInstall = ''
    export target="$out/var/sunlight"
    erlang="${erlang}"
    mkdir -p "$target/sunlightapi/bin"
    cp -r "_build/release/sunlightapi" "$target/"
    substituteAll "bin/sunlightapi" "$target/sunlightapi/bin/sunlightapi"
  '';

  meta = {
    description = "Restful API for the sunlight system";
    license = stdenv.lib.licenses.unfree;
  };
}