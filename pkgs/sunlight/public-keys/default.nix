{ stdenv, sunlight, bash, gnugrep }:

stdenv.mkDerivation rec {

  name = "public-keys";

  version = "0.0.4";

  src = Hash not produced;
  buildInputs = [ bash gnugrep ];

  meta = {
    description = "Public keys for sunlight developers";
    homepage = "https://github.com/projectsunlight/public-keys";
    maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
  };

}

