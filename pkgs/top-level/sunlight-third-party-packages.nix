/* This file defines the composition for all sunlight third-party packages */

{ callPackage }:

let
  self = _self;
  _self = with self; {

    terraform = callPackage ../sunlight/third-party/terraform {};
    eqc = callPackage ../sunlight/third-party/eqc {};
    eqc_ex = callPackage ../sunlight/third-party/eqc_ex {};

  }; in self
