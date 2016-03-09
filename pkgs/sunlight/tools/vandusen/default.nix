{ sunlight, haskellPackages, stdenv, moreutils }:

with haskellPackages; mkDerivation {
        pname = "vandusen";
        version = "0.0.0+build.10.gd7ebe96";
        src = sunlight.fetch {name = "vandusen";version = "0.0.0+build.10.gd7ebe96"; sha256 = "0x6mzgqf32gj1fd0il595vmkr30aiyaa86607wq7gjb4zl2bvwfj";};
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
