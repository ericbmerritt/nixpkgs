# USED BY sunlightapi_tests TO GENERATE `sunlightapi_test/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, sunlight, beamPackages, erlang, makeWrapper, elixir }:

beamPackages.buildMix {
  name = "sunlightapi_tests";
  version = "0.0.0+build.6.0ae3f72";

  src = sunlight.fetch {name = "sunlightapi_tests";version = "0.0.0+build.6.0ae3f72"; sha256 = "10rfjf69m6w1yyqkhyybg143s3gysrik2n7y11c05ylij4yyq71l";};

  buildInputs = with sunlight; [ erlang makeWrapper sunlightapi_mi ];
  beamDeps = with beamPackages;  [ cucumberl httpotion poison ex_json_schema ];

  postBuild = ''
   mix test --no-start --no-deps-check
  '';

  postInstall = ''
    mkdir -p $out/bin
    mkdir -p $out/var/sunlight/sunlightapi_tests/features
    mkdir -p $out/var/sunlight/sunlightapi_tests/imperative-tests
    cp -r ./features/* $out/var/sunlight/sunlightapi_tests/features/
    cp -r ./imperative-tests/* $out/var/sunlight/sunlightapi_tests/imperative-tests
    cp ./bin/sunlightapi_tests $out/bin/sunlightapi_tests
    chmod a+x $out/bin/sunlightapi_tests
    wrapProgram $out/bin/sunlightapi_tests \
        --suffix PATH : ${elixir}/bin \
        --suffix PATH : ${sunlight.sunlightapi_mi}/bin \
        --suffix ERL_LIBS : $out/lib/erlang/lib \
        --suffix ERL_LIBS : ${erlang}/lib/erlang/lib \
        --suffix ERL_LIBS : ${elixir}/lib/elixir/lib \
        --suffix ERL_LIBS : ${beamPackages.cucumberl}/lib/erlang/lib \
        --add-flags "--path=$out/var/sunlight/sunlightapi_tests"
   '';

  meta = {
    description = "Integration Tests for the Sunlight Api";
    license = stdenv.lib.licenses.unfree;
  };
}
