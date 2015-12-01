/* This file defines the composition for all sunlight packages */

{ fetchurl, fetchzip, stdenv, callPackage }:

let
  self = _self;
  _self = with self; {
    public-keys = callPackage ../sunlight/public-keys {};
}; in self
