{ stdenv, sunlight, fetchgit, bash, gnugrep, gnupg }:

stdenv.mkDerivation rec {

  name = "sunlight-public-keys-${version}";

  version = "0.0.7";
  rev_that_corresponds_to_version="59cfb5c874b31233ad79fb3ad9692ddf8bdce20a";

  src = sunlight.fetch {
     name = "public-keys";
     version = "0.0.7";
     sha256 = "16rjbghlszwisr826c6h3fyp9606lnzzwm8czp4hvslj0fixk2y1";
   };
  buildInputs = [ bash gnugrep gnupg ];

  meta = {
    description = "Public keys for sunlight developers";
    homepage = "https://github.com/projectsunlight/public-keys";
    maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
  };

}
