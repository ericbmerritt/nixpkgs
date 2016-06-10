# USED BY sunlightapi TO GENERATE `sunlightapi/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight, beamPackages, relxExe, git, openssh, erlang }:

beamPackages.buildMix {
  name = "sunlightapi";
  version = "0.0.0+build.21.g85b5da6";

  src = sunlight.fetch {name = "sunlightapi";version = "0.0.0+build.21.g85b5da6"; sha256 = "072jx6y0p30k8afvh8fhi7mq5igsi11p2q9br6lx2p906wf728ji";};

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