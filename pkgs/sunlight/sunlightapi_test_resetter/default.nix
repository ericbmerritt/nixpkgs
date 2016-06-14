# USED BY sunlightapi TO GENERATE `sunlightapi/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight, beamPackages, relxExe, git, openssh, erlang, makeWrapper }:

beamPackages.buildMix rec {
  bare_name = "sunlightapi_test_resetter";
  name = bare_name;
  version = "0.0.0+build.3.d5a6b51";

  src = sunlight.fetch {name = "sunlightapi_test_resetter";version = "0.0.0+build.3.d5a6b51"; sha256 = "1mlcx9br3fj0vswn99jqz99nlpwx6y8kkpjvjpv41qswv67nlk3m";};

  buildInputs = with sunlight; [ git relxExe erlang makeWrapper ];

  beamDeps = with beamPackages;  [ cowboy dialyxir epgsql poison ];

  postBuild = ''
   mix test --no-start --no-deps-check
   ${relxExe}/bin/relx --output-dir _build/release

  '';

  postInstall = ''
    export target="$out/var/sunlight"
    erlang="${erlang}"
    mkdir -p "$target/${bare_name}/bin"
    cp -r "_build/release/${bare_name}" "$target/"

    substituteAll "bin/${bare_name}" "$target/${bare_name}/bin/${bare_name}"
  '';

  meta = {
    description = "Cleanup for the sunlightapi system";
    license = stdenv.lib.licenses.unfree;
  };
}