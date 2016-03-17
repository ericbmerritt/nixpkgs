{ sunlight, haskellPackages, stdenv, moreutils }:

with haskellPackages; mkDerivation {
        pname = "vandusen";
        version = "0.0.1";
        src = sunlight.fetch {name = "vandusen";version = "0.0.1"; sha256 = "178lw31ygc84lnzkhijp6l81hc52m3qib5q2prwjr70f0amkizws";};
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
