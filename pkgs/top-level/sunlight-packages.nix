/* This file defines the composition for all sunlight packages */

{ fetchgit, stdenv, callPackage, haskellPackages, recurseIntoAttrs }:

let
  self = _self;
  _self = with self; {
    fetch = { name, version, sha256 }: fetchgit {
      inherit sha256;
      name = "sunlight-${name}-${version}";
      url = "https://d19fe3f47af6c225f21ca59f0a6cd5556a24fe79@github.com/ProjectSunlight/${name}.git";
      rev = "refs/tags/${version}";
    } // { inherit rev; };

    third-party = recurseIntoAttrs (callPackage ./sunlight-third-party-packages.nix {});

/* -- START-SUNLIGHT-PACKAGES -- */
    public-keys = callPackage ../sunlight/public-keys {};
    infcli = callPackage ../sunlight/infcli {};
    infpipe = callPackage ../sunlight/infpipe {};
    infpipe_mi = callPackage ../sunlight/infpipe_mi {};
    infutils = callPackage ../sunlight/infutils {};
    dev-vpn-ca = callPackage ../sunlight/dev-vpn-ca {};
    devvpn_mi = callPackage ../sunlight/devvpn_mi {};
    infdesc = callPackage ../sunlight/infdesc {};
    sunlightapi = callPackage ../sunlight/sunlightapi {};
    webui = callPackage ../sunlight/webui {};
    sunlightapi_mi = callPackage ../sunlight/sunlightapi_mi {};
    workspace = callPackage ../sunlight/workspace {};
    sunlightapi_test_resetter = callPackage ../sunlight/sunlightapi_test_resetter {};
    sunlight_schemas = callPackage ../sunlight/sunlight_schemas {};
    schemas_validator = callPackage ../sunlight/schemas_validator {};
    sunlightapi_tests = callPackage ../sunlight/sunlightapi_tests {};
/* -- END-SUNLIGHT-PACKAGES -- */

    # A list of strings of the packages names owned by this namespace
    # (excluding 'third-party'). This is used by 'infpipe' as the
    # list of packages to be built.
    packageNames =
      with builtins;
      let keepName = name: name != "packageNames" &&
                           name != "third-party" &&
                           isAttrs (getAttr name self);
      in filter keepName (attrNames self);
}; in self
