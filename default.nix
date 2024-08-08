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

in
# Copied from https://github.com/edolstra/flake-compat/pull/44/files
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
  caddy-tailscale = callPackage ./packages/caddy-tailscale { };
  monolisa-nerdfonts = callPackage ./packages/monolisa-nerdfonts { };
  mpv-scripts = callPackage ./packages/mpv-scripts { };
}
