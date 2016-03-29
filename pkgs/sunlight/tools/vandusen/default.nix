{ sunlight, haskellPackages, stdenv, moreutils }:

with haskellPackages; mkDerivation {
        pname = "vandusen";
        version = "0.0.2";
        src = sunlight.fetch {name = "vandusen";version = "0.0.2"; sha256 = "0qfwc8sg1psqcqcdchz754zh0kyblsr5idcf5i7npl0k4dbdqcar";};
        isLibrary = false;
        isExecutable = true;
        dontStrip = true;
        buildDepends = [ moreutils hlint ];
        testHaskellDepends = [ tasty doctest ];
        executableHaskellDepends = [ base cmdargs shelly split text
                                     lens semver MissingH HStringTemplate
                                     system-filepath github formatting ];
        description = "Automation commands for sunlight systems";
        license = stdenv.lib.licenses.unfree;
}
