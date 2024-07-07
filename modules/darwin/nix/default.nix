{
  lib,
  pkgs,
  inputs,
  namespace,
  ...
}: {
  users.users.yash.packages = with pkgs; [
    nix-output-monitor
  ];

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
