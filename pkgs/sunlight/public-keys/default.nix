{ stdenv, fetchgit, bash, gnugrep }:

stdenv.mkDerivation rec {
  
  name = "sunlight-public-keys-${version}";

  version = "0.0.3+build.3.g2a4dee9";
  rev_that_corresponds_to_version="2a4dee90c8a28b57e22e4c41b903987274c7cb6e";

  src =    fetchgit {
     url = "https://9dc8b35c882476445cb04de2ba2e993aa76a47bf@github.com/ProjectSunlight/public-keys.git";
     rev = "2a4dee90c8a28b57e22e4c41b903987274c7cb6e";
     sha256 = "37b733ec0446ad29d3c4d641e7d6592f44d4e26864f4421e23515e5434a3696c";
   };
  buildInputs = [ bash gnugrep ];

  meta = {
    description = "Public keys for sunlight developers";
    homepage = "https://github.com/projectsunlight/public-keys";
    maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
  };

}

