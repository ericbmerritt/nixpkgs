/* This file defines the composition for all sunlight packages */

{ fetchgit, stdenv, callPackage, haskellPackages }:

let
  self = _self;
  _self = with self; {
    fetch = { name, version, sha256 }: fetchgit {
      inherit sha256;
      name = "sunlight-${name}-${version}";
      url = "https://9dc8b35c882476445cb04de2ba2e993aa76a47bf@github.com/ProjectSunlight/${name}.git";
      rev = "refs/tags/${version}";
    } // { inherit rev; };

/* -- START-SUNLIGHT-PACKAGES -- */
    public-keys = callPackage ../sunlight/public-keys {};
/* -- END-SUNLIGHT-PACKAGES -- */
}; in self
