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

/* -- START-SUNLIGHT-PACKAGES -- */
    public-keys = callPackage ../sunlight/public-keys {};
    vandusen = callPackage ../sunlight/tools/vandusen {};
    priestley = callPackage ../sunlight/tools/priestley {};
    infcli = callPackage ../sunlight/tools/infcli {};
    infpipe = callPackage ../sunlight/tools/infpipe {};
/* -- END-SUNLIGHT-PACKAGES -- */
}; in self
