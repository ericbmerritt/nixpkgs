# USED BY sunlightapi TO GENERATE `sunlightapi/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, beamPackages, sunlight, writeText }:

beamPackages.buildMix rec {
  name = "sunlight_schemas";
  version = "0.0.0+build.7.gc4d49ae";

  src = sunlight.fetch {name = "sunlight_schemas";version = "0.0.0+build.7.gc4d49ae"; sha256 = "0m9277xmp4a7q19xhn3v56vp3rmpv23435mafl57kfsnj5yy7yiw";};

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