{ stdenv, pkgs }: #? import <nixpkgs> {} }:

let
  self = rec {
    hex = import ./hex-packages.nix { stdenv = stdenv; callPackage = self.callPackage; };
    callPackage = pkgs.lib.callPackageWith (pkgs // self // hex);

    buildRebar3 = callPackage ./build-rebar3.nix {};
    buildHex = callPackage ./build-hex.nix {};

    ## Non hex packages
    webdriver = callPackage ./webdriver {};
    elli = callPackage ./elli {};
    webmachine = callPackage ./webmachine {};
    erlware-uri = callPackage ./erlware-uri {};
    okeuday-uuid = callPackage ./okeuday-uuid {};
  };
in self // self.hex
