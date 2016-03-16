{ stdenv, sunlight, fetchgit, bash, gnugrep, gnupg }:

stdenv.mkDerivation rec {

  name = "sunlight-public-keys-${version}";

  version = "0.0.9";

  src = sunlight.fetch {
     name = "public-keys";
     version = "0.0.9";
     sha256 = "1rkclrisdpm5gn01jarw567rfh8gdck4sidysis0w06yvhlanaly";
  };
  buildInputs = [ bash gnugrep gnupg ];

  meta = {
    description = "Public keys for sunlight developers";
    homepage = "https://github.com/projectsunlight/public-keys";
    maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
  };

}
