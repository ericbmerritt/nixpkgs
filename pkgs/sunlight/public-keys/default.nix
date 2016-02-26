{ stdenv, sunlight, fetchgit, bash, gnugrep, gnupg }:

stdenv.mkDerivation rec {

  name = "sunlight-public-keys-${version}";

  version = "0.0.3+build.3.g2a4dee9";
  rev_that_corresponds_to_version="2a4dee90c8a28b57e22e4c41b903987274c7cb6e";

  src = sunlight.fetch {
     name = "public-keys";
     version = "0.0.6";
     sha256 = "1mj0z8zicl34fk3jk5x88ayd5f1f93y74ym3w6hxmrq7p1crz122";
   };
  buildInputs = [ bash gnugrep gnupg ];

  meta = {
    description = "Public keys for sunlight developers";
    homepage = "https://github.com/projectsunlight/public-keys";
    maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
  };

}
