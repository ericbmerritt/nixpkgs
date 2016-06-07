{ stdenv, fetchurl, writeText, unzip, erlang }:

stdenv.mkDerivation rec {
  version = "1.37.2";
  name = "eqc-${version}";

  src = fetchurl {
    url = "http://quviq-licencer.com/downloads/eqc-${version}.zip";
    sha256 = "198ar1yipssxi43d01zca7rbj4ra7b4jl1mhpa5i9rsxgb2rkh4l";
  };

  buildInputs = [ unzip erlang ]; # xdg-open used in doc helper scripts

  dontstrip = true;
  outputs = [ "out" "docs" "emacs" "examples" ];
  
  builder = ./builder.sh;

  register-eqc = writeText "register-eqc.escript" ''
#! escript -I $out/lib/erlang/eqc-${version}
main([]) ->
  eqc:registration("SITEg2wAAAABboAAyLVD6YVWuqa83tGsaTFdev4SghINUzb2RfuZESaxRz0OoMuqIHmKD6adti4ln2WKsHdS4emwtlJC0z026JKEUWxcZLzM6PyWx9xzU3f332TIHj9PFbuDIYhWFX3gki+miMr7ZfqM7CL3X2tPQlM7BpSRgsDJ5cC6kAvvNlZgWWVq"),
  eqc:start(),
  init:stop().
  '';

  setupHook = writeText "setuphook.sh" ''
     echo "### Awaiting feature request for EQC to set location of .quviq2, temporarily overriding HOME ###"
     export HOME=/tmp
     addToSearchPath ERL_LIBS "$1/lib/erlang/lib/"
     echo yes | ${erlang}/bin/escript ${register-eqc}
     echo "Set up EQC for $(id -un) with license in $HOME"
     '';

  meta = {
    description = "Property based testing tool by Quviq";
    homepage    = http://www.quviq.com/;
    license     = stdenv.lib.licenses.unfree;
    maintainers = [ ];
  };
}
