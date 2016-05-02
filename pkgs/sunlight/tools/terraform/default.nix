{ stdenv, lib, fetchurl, unzip }:

stdenv.mkDerivation rec {
  version = "0.6.15";
  name = "terraform-${version}";

  src = fetchurl {
    url = "https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_amd64.zip";
    sha256 = "0szzzxs2x2crsl53mq746gabc2lzk7y1fij4cp0fgifn9sjzm09a";
  };

  buildInputs = [ unzip ];

  unpackPhase = ''
    (
      sourceRoot=d
      mkdir $sourceRoot; cd $sourceRoot;
      unzip $src
   )
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp d/* $out/bin
  '';

  meta = {
    description = "A tool for building, changing, and combining infrastructure safely and efficiently";
    homepage    = http://www.terraform.io/;
    license     = stdenv.lib.licenses.mpl20;
    maintainers = [ lib.maintainers.lassulus ];
  };
}
