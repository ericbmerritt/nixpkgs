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
  eqc:registration("SITEg2wAAAACboAA6Hy3sVjcYUATJjvLcxo3CJouiRTfkaGoW5PAqz79b1T/xlsYTdEhEcooTNC1yxzK/79PdF+LuObt4tilYTqNYvtYxCEAKxnD1t9kmbJeqt3sW0TFf4qAQMS7Py95bqmcYhkfNqgYr6EUS175lHJpYfSU76FKSyxmdPCkt+QwyZNugAAi/uOOrvILqL8pQ3+VqM2wJeFp1494CI15u8v2zwjdOVWa9+1yi95b/rZwgLtdlVjRmstqOxrLAjcLkbzuOAzzqUnV7K4jfjWVxhvbsDuBMJMwx/NajiQcl9ZD6cuAtIERO8g2E7500UFJVpoC1eD5tRDHOJfrXVtX1d5RnhhKDWo="),
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
