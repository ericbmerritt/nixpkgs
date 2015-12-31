{ sunlight, haskellPackages, stdenv, moreutils }:

with haskellPackages; mkDerivation {
        pname = "vandusen";
        version = "0.0.0+build.5.gbdc7162";
        src = sunlight.fetch {name = "vandusen";version = "0.0.0+build.5.gbdc7162"; sha256 = "cc3a32187fc1365421e3ad2f1c47e9977bdfeec539ca56f0f3c2cd101df1da66";};
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