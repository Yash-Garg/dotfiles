let
  inherit (builtins) currentSystem fromJSON readFile;

  getFlake =
    name: with (fromJSON (readFile ./flake.lock)).nodes.${name}.locked; {
      inherit rev;
      outPath = fetchTarball {
        url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
        sha256 = narHash;
      };
    };

  # Copied from https://github.com/edolstra/flake-compat/pull/44/files
  fetchurl =
    { url, sha256 }:
    derivation {
      builder = "builtin:fetchurl";

      name = "source";
      inherit url;

      outputHash = sha256;
      outputHashAlgo = "sha256";
      outputHashMode = "recursive";
      executable = false;
      unpack = false;

      system = "builtin";

      # No need to double the amount of network traffic
      preferLocalBuild = true;

      impureEnvVars = [
        # We borrow these environment variables from the caller to allow
        # easy proxy configuration.  This is impure, but a fixed-output
        # derivation like fetchurl is allowed to do so since its result is
        # by definition pure.
        "http_proxy"
        "https_proxy"
        "ftp_proxy"
        "all_proxy"
        "no_proxy"
      ];

      # To make "nix-prefetch-url" work.
      urls = [ url ];
    };
in
{
  system ? currentSystem,
  pkgs ? import (getFlake "nixpkgs") {
    localSystem = {
      inherit system;
    };
  },
}:
let
  callPackage = pkg: pkgs.callPackage pkg;
in
{
  monolisa-nerdfonts = callPackage ./packages/monolisa-nerdfonts { };
  mpv-scripts = callPackage ./packages/mpv-scripts { };
  termsnap = callPackage ./packages/termsnap { };
  tiling-shell = callPackage ./packages/tiling-shell { };
}
