{ stdenv, fetchurl, writeText, unzip }:

stdenv.mkDerivation rec {
  version = "1.37.2";
  name = "eqc-${version}";

  src = fetchurl {
    url = "http://quviq-licencer.com/downloads/eqc-${version}.zip";
    sha256 = "198ar1yipssxi43d01zca7rbj4ra7b4jl1mhpa5i9rsxgb2rkh4l";
  };

  buildInputs = [ unzip ]; # xdg-open used in doc helper scripts

  outputs = [ "out" "docs" "emacs" "examples" ];
  
  builder = ./builder.sh;

  setupHook = writeText "setuphook.sh" ''
     addToSearchPath ERL_LIBS "$1/lib/erlang/lib/"
       '';

  meta = {
    description = "Property based testing tool by Quviq";
    homepage    = http://www.quviq.com/;
    license     = stdenv.lib.licenses.unfree;
    maintainers = [ ];
  };
}
