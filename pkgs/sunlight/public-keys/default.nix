{ stdenv, fetchgit }:

stdenv.mkDerivation rec {
  
  name = "sunlight-public-keys-${version}";

  version = "0.0.2";
  rev_that_corresponds_to_version="7e0bcf5";

  src = fetchgit {
    url = "https://sunlight-algorithmic-user:9dc8b35c882476445cb04de2ba2e993aa76a47bf@github.com/ProjectSunlight/public-keys.git";
    rev = "${rev_that_corresponds_to_version}";
    sha256 = "cc7f37ac9ff377af37c2f1b2b68939b37dcff731ac56cb38674756bc363e4958";
  };

  meta = {
    description = "Public keys for sunlight developers";
    homepage = "https://github.com/projectsunlight/public-keys";
    maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
  };

}
