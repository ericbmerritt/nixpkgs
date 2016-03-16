{ stdenv, sunlight, fetchgit, bash, gnugrep, gnupg }:

stdenv.mkDerivation rec {

  name = "sunlight-public-keys-${version}";

  version = "0.0.8";

  src = sunlight.fetch {
     name = "public-keys";
     version = "0.0.8";
     sha256 = "1c7hagvh27i0x9v9990y86bkrp0pgwf9b4xz9v2mdk52n7vm9kqx";
   };
  buildInputs = [ bash gnugrep gnupg ];

  meta = {
    description = "Public keys for sunlight developers";
    homepage = "https://github.com/projectsunlight/public-keys";
    maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
  };

}
