{ stdenv, fetchurl, writeText, unzip, erlang }:

stdenv.mkDerivation rec {
  version = "1.37.2";
  name = "eqc-${version}";

  src = fetchurl {
    url = "http://quviq-licencer.com/downloads/eqc-${version}.zip";
    sha256 = "198ar1yipssxi43d01zca7rbj4ra7b4jl1mhpa5i9rsxgb2rkh4l";
  };

  buildInputs = [ unzip erlang ]; # xdg-open used in doc helper scripts

  dontStrip = true;
  outputs = [ "out" "docs" "emacs" "examples" ];
  
  builder = ./builder.sh;

  register-eqc = writeText "register-eqc.escript" ''
#! escript -I $out/lib/erlang/eqc-${version}
main([]) ->
  eqc:registration("SITEg2wAAAACboAA09tRuo46e1KXlAlCHrsj83ONrYgk7bnfIZYofgDCoSbv3DVVMH1JaHWjpVuMIH9t4vXHIpxHRV/N7D0IOd9fjF0av8+b4OkEHegHHlBDaS/9h07BGrnOBLSYJ2+CzIA+popYIUo4bytJXRCl/NYnzBbs1Imga6qpVbg8COPwarJugAA7i+23OBQ3eFPttdZQcrABnlx/4SM+vCGlevbGB6TFdCuRXLOnf6m1w0BpIIh61fwuNS9CoE1uvV8j1KuxSoN8dwGT2N9SSNfZroVEtaQt+jcaoGj7Xo2PlYxLuflV+qzhh8TqMNfxCwkjRxwkfXaK9DAJBKWPmhGRS7sxwTVrimo="),
  eqc:start(),
  init:stop().
  '';

  setupHook = writeText "setuphook.sh" ''
     addToSearchPath ERL_LIBS "$1/lib/erlang/lib/"
     if [ "$(id -un)" = "nixbld" ]
     then
       export HOME=$(mktemp -d eqc-nixbld-XXXXXXX --tmpdir)
       echo "Registering site license for nixbld user into $HOME"
       echo yes | ${erlang}/bin/escript ${register-eqc} || true
     fi
     '';

  meta = {
    description = "Property based testing tool by Quviq";
    homepage    = http://www.quviq.com/;
    license     = stdenv.lib.licenses.unfree;
    maintainers = [ ];
  };
}
