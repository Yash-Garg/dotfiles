{
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
{
  nix = mkNixConfig { inherit lib pkgs; } // {
    gc = {
      automatic = true;
      options = "--delete-older-than 3d";
    };
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
}
