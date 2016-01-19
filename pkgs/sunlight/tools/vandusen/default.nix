{ sunlight, haskellPackages, stdenv, moreutils }:

with haskellPackages; mkDerivation {
        pname = "vandusen";
        version = "0.0.0+build.7.g27072b9";
        src = sunlight.fetch {name = "vandusen";version = "0.0.0+build.7.g27072b9"; sha256 = "8540791ffdd86fb8fce3a1b338c395cc3b89d7545f664d0eee04bbe585895252";};
        isLibrary = false;
        isExecutable = true;
        buildDepends = [ moreutils hlint ];
        testHaskellDepends = [ tasty doctest ];
        executableHaskellDepends = [ base cmdargs shelly split text
                                     lens semver MissingH HStringTemplate
                                     system-filepath github formatting ];
        description = "Automation commands for sunlight systems";
        license = stdenv.lib.licenses.unfree;
}