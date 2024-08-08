{
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
{
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

  users.users.yash.packages = with pkgs; [ nix-output-monitor ];

  nix = mkNixConfig { inherit lib pkgs; } // {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
      persistent = true;
    };

    optimise.automatic = true;
  };
}
