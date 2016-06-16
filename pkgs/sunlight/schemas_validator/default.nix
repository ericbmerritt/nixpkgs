# USED BY schemas_validator TO GENERATE `schemas_validator/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, beamPackages, sunlight, writeText }:

beamPackages.buildMix rec {
  name = "schemas_validator";
  version = "0.0.0+build.5.98c3592";

  src = sunlight.fetch {name = "schemas_validator";version = "0.0.0+build.5.98c3592"; sha256 = "0jdyhl7xjcr2icwvl3wpcrqgdsq3f1hclaav9fbkclkkcw0b7zsn";};

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
