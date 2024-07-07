{
  lib,
  pkgs,
  inputs,
  namespace,
  ...
}: {
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

  nix =
    lib.${namespace}.mkNixConfig {inherit lib pkgs inputs;}
    // {
      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 3d";
        persistent = true;
      };

      optimise.automatic = true;

      settings.allowed-users = ["@wheel"];
      settings.trusted-users = ["root" "@wheel"];
    };
}
