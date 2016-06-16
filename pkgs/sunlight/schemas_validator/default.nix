# USED BY schemas_validator TO GENERATE `schemas_validator/default.nix`,
# ONLY EDIT THE `expression.st` TEMPLATE in the project git
# repository.
{ stdenv, beamPackages, sunlight, writeText }:

beamPackages.buildMix rec {
  name = "schemas_validator";
  version = "0.0.0+build.10.gd8744fe";

  src = sunlight.fetch {name = "schemas_validator";version = "0.0.0+build.10.gd8744fe"; sha256 = "0cx9v67s6kp0ngpqh5lxwhbr52822qx5d3kgyygv0hw07qlb1crs";};

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