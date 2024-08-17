{
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
{
  documentation = enabled // {
    doc = disabled;
    man = enabled;
    dev = disabled;
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
