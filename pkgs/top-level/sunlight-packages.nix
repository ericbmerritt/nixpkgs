/* This file defines the composition for all sunlight packages */

{ fetchgit, stdenv, callPackage, haskellPackages }:

let
  self = _self;
  _self = with self; {
    fetch = { name, version, sha256 }: fetchgit {
      inherit sha256;
      name = "sunlight-${name}-${version}";
      url = "https://5e1ba8e5b787b1270178b7dc23eb0936f4d759f3@github.com/ProjectSunlight/${name}.git";
      rev = "refs/tags/${version}";
    } // { inherit rev; };

   terraform = callPackage ../sunlight/tools/terraform {};

/* -- START-SUNLIGHT-PACKAGES -- */
    public-keys = callPackage ../sunlight/public-keys {};
    vandusen = callPackage ../sunlight/tools/vandusen {};
    thorndyke = callPackage ../sunlight/system/thorndyke {};
/* -- END-SUNLIGHT-PACKAGES -- */
}; in self
