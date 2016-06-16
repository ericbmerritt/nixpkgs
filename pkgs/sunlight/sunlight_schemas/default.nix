# USED BY sunlight_schemas TO GENERATE `sunlight_schemas/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, beamPackages, sunlight, writeText }:

beamPackages.buildMix rec {
  name = "sunlight_schemas";
  version = "0.0.0+build.9.g46525c2";

  src = sunlight.fetch {name = "sunlight_schemas";version = "0.0.0+build.9.g46525c2"; sha256 = "1ss1bj6sc3cw2mkdi7m57g41jafmxk5hvjl249iijlfiivn53mak";};

  beamDeps = with beamPackages; [ sunlight.third-party.eqc
                                  sunlight.third-party.eqc_ex
                                  sunlight.schemas_validator];
  outputs = [ "out" "gen" ];

  outDir = "var/sunlight/schemas";

  setupHook = writeText "setupHook.sh" ''
       addToSearchPath ERL_LIBS "$1/lib/erlang/lib"
  '';

  postBuild = ''
   mix test --no-start --no-deps-check
  '';

  installPhase = ''
     MIXENV=prod

     mkdir -p "$gen/lib/erlang/lib/${name}-${version}"
     cp ${setupHook} $gen/setupHook.sh
     for reldir in src ebin priv include; do
        fd="_build/$MIXENV/lib/${name}/$reldir"
        [ -d "$fd" ] || continue
        cp -Hrt "$gen/lib/erlang/lib/${name}-${version}" "$fd"
        success=1
      done

      ls ./

      export target="$out/${outDir}"
      mkdir -p $target
      cp -r schemas/* "$target/"
  '';

  meta = {
    description = "Schemas for the sunlight system";
    license = stdenv.lib.licenses.unfree;
  };
}