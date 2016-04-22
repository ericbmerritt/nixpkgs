{ stdenv, makeWrapper, sunlight, fetchgit, bash, gnugrep, gnupg, gawk, gitMinimal}:

stdenv.mkDerivation rec {

  name = "sunlight-public-keys-${version}";

  version = "0.0.12";

  src = sunlight.fetch {
     name = "public-keys";
     version = version;
     sha256 = "1sk1sp4gwhwcqv6dx01fdqian45jvhg8a22kxhyk516wnhs2vkcj";
  };

  buildInputs = [ bash gnugrep gnupg gawk gitMinimal makeWrapper ];

  postInstall = ''
     wrapProgram $out/bin/import-sunlight-keys \
       --suffix PATH : ${gawk}/bin:${bash}/bin:${gnupg}/bin:${gnugrep}/bin
   '';

  meta = {
    description = "Public keys for sunlight developers";
    homepage = "https://github.com/projectsunlight/public-keys";
    maintainers = with stdenv.lib.maintainers; [ ericbmerritt ];
  };

}
