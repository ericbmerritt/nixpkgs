/* This file defines the composition for all sunlight packages */

{ fetchgit, stdenv, callPackage, haskellPackages }:

let
  self = _self;
  _self = with self; {
    fetch = { name, version, sha256 }: fetchgit {
      inherit sha256;
      name = "sunlight-${name}-${version}";
      url = "https://ad41f1f0dd204a4cc828d1665f114b86e762a0a5@github.com/ProjectSunlight/${name}.git";
      rev = "refs/tags/${version}";
    } // { inherit rev; };

   terraform = callPackage ../sunlight/tools/terraform {};

/* -- START-SUNLIGHT-PACKAGES -- */
    public-keys = callPackage ../sunlight/public-keys {};
    vandusen = callPackage ../sunlight/tools/vandusen {};
    thorndyke = callPackage ../sunlight/system/thorndyke {};
    priestley = callPackage ../sunlight/tools/priestley {};
/* -- END-SUNLIGHT-PACKAGES -- */
}; in self
