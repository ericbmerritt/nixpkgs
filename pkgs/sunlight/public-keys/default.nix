{ stdenv, fetchgit }:

stdenv.mkDerivation rec {
  
  name = "sunlight-public-keys-${version}";

  version = "0.0.3";
  rev_that_corresponds_to_version="8d1dbc3";

  src = fetchgit {
    url = "https://sunlight-algorithmic-user:9dc8b35c882476445cb04de2ba2e993aa76a47bf@github.com/ProjectSunlight/public-keys.git";
    rev = "${rev_that_corresponds_to_version}";
    sha256 = "0pq4kgjwzrpd8i200c20z9wl0ksmry1nk3zb7495gjvq2mqfv2g0";
  };

  meta = {
    description = "Public keys for sunlight developers";
    homepage = "https://github.com/projectsunlight/public-keys";
    maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
  };

}
