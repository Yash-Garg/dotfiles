{ pkgs }:
let
  callPackage = pkg: pkgs.callPackage pkg;
in
{
  auto-profiles = callPackage ./auto-profiles { };
  better-chapters = callPackage ./better-chapters { };
  boss-key = callPackage ./boss-key { };
  repl = callPackage ./repl { };
  status-line = callPackage ./status-line { };
}
