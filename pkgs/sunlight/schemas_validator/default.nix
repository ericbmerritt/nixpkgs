# USED BY sunlightapi TO GENERATE `sunlightapi/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, beamPackages, sunlight, writeText }:

beamPackages.buildMix rec {
  name = "schemas_validator";
  version = "0.0.0+build.8.g4b990d0";

  src = sunlight.fetch {name = "schemas_validator";version = "0.0.0+build.8.g4b990d0"; sha256 = "0fmfrj8g3dfd7f5vz7lkq5a32wwq1x1i801cw25zppm67pn4xyjf";};

  beamDeps = with beamPackages; [ sunlight.third-party.eqc
                                  sunlight.third-party.eqc_ex
                                  poison
                                  ex_json_schema ];

  postBuild = ''
   mix test --no-start --no-deps-check
  '';

  meta = {
    description = "JSON Schema loading and validation for the system";
    license = stdenv.lib.licenses.unfree;
  };
}