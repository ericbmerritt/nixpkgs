/* This file defines the composition for all sunlight packages */

{ fetchgit, stdenv, callPackage, haskellPackages }:

let
  self = _self;
  _self = with self; {
    fetch = { name, version, sha256 }: fetchgit {
      inherit sha256;
      name = "sunlight-${name}-${version}";
      url = "https://4f20c4fe03ffe95ec4c7e2f3cea634e19d1ec145@github.com/ProjectSunlight/${name}.git";
      rev = "refs/tags/${version}";
    } // { inherit rev; };

   terraform = callPackage ../sunlight/tools/terraform {};
   eqc = callPackage ../sunlight/tools/eqc {};
/* -- START-SUNLIGHT-PACKAGES -- */
    public-keys = callPackage ../sunlight/public-keys {};
    infcli = callPackage ../sunlight/infcli {};
    infpipe = callPackage ../sunlight/tools/infpipe {};
    infpipe_mi = callPackage ../sunlight/infpipe_mi {};
    infutils = callPackage ../sunlight/infutils {};
    dev-vpn-ca = callPackage ../sunlight/dev-vpn-ca {};
    devvpn_mi = callPackage ../sunlight/devvpn_mi {};
    infdesc = callPackage ../sunlight/infdesc {};
    sunlightapi = callPackage ../sunlight/sunlightapi {};
    webui = callPackage ../sunlight/webui {};
    sunlightapi_mi = callPackage ../sunlight/sunlightapi_mi {};
/* -- END-SUNLIGHT-PACKAGES -- */
}; in self
