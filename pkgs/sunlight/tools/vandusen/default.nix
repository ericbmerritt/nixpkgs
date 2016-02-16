{ sunlight, haskellPackages, stdenv, moreutils, inotify-tools }:

with haskellPackages; mkDerivation {
        pname = "vandusen";
        version = "0.0.0+build.7.g27072b9";
        src = /home/eric/workspace/vandusen;
        isLibrary = false;
        isExecutable = true;
        buildDepends = [ moreutils hlint inotify-tools ];
        testHaskellDepends = [ tasty doctest ];
        executableHaskellDepends = [ base cmdargs shelly split text
                                     lens semver MissingH HStringTemplate
                                     system-filepath github formatting ];
        description = "Automation commands for sunlight systems";
        license = stdenv.lib.licenses.unfree;
}