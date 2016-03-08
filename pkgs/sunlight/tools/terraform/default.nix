{ stdenv, lib, fetchurl, unzip }:

stdenv.mkDerivation rec {
  version = "0.6.12";
  name = "terraform-${version}";

  src = fetchurl {
    url = "https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_amd64.zip";
    sha256 = "37513aba20f751705f8f98cd0518ebb6a4a9c2148453236b9a5c30074e2edd8d";
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
