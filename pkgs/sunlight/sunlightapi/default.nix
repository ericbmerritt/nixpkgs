# USED BY sunlightapi TO GENERATE `sunlightapi/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight, beamPackages, relxExe, git, openssh, erlang }:

beamPackages.buildMix {
  name = "sunlightapi";
  version = "0.0.0+build.23.g04538c8";

  src = sunlight.fetch {name = "sunlightapi";version = "0.0.0+build.23.g04538c8"; sha256 = "0aqb0cg6q3czya010c5kz9grkhwrz23aa3brm72s3hhn90krc42m";};

  buildInputs = with sunlight; [ git relxExe erlang sunlight_schemas ];

  beamDeps = with beamPackages;  [ cowboy dialyxir episcina epgsql poison
                                   uuid sunlight.schemas_validator timex ];

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