{ stdenv, sunlight, fetchgit, bash, gnugrep, gnupg }:

stdenv.mkDerivation rec {

  name = "sunlight-public-keys-${version}";

  version = "0.0.11";

  src = sunlight.fetch {
     name = "public-keys";
     version = version;
     sha256 = "0m0n4ana7iqs5yayiv6phfgjbjh31r307qj46lnx6kl28c9mb02w";
  };
  buildInputs = [ bash gnugrep gnupg ];

  meta = {
    description = "Public keys for sunlight developers";
    homepage = "https://github.com/projectsunlight/public-keys";
    maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
  };

}
