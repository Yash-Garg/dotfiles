{
  lib,
  pkgs,
  inputs,
  namespace,
  ...
}: {
  nix =
    lib.${namespace}.mkNixConfig {inherit lib pkgs inputs;}
    // {
      gc = {
        automatic = true;
        options = "--delete-older-than 3d";
      };
    };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
}
