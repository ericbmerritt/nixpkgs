{ stdenv, sunlight, fetchgit, bash, gnugrep, gnupg }:

stdenv.mkDerivation rec {

  name = "sunlight-public-keys-${version}";

  version = "0.0.10";

  src = sunlight.fetch {
     name = "public-keys";
     version = "0.0.10";
     sha256 = "1kkyvn89qsb7xacj7lmdyy5axrz5w9m44gryg76jn6a4dd37xqag";
  };
  buildInputs = [ bash gnugrep gnupg ];

  meta = {
    description = "Public keys for sunlight developers";
    homepage = "https://github.com/projectsunlight/public-keys";
    maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
  };

}
