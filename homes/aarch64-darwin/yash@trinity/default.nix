{
  pkgs,
  lib,
  namespace,
  ...
}:
with lib.${namespace};
{
  snowfallorg.user = enabled // {
    name = "yash";
  };

  profiles.${namespace} = {
    neovim = enabled;
    oh-my-posh = enabled;
  };

  shells.${namespace}.zsh = enabled;

  home.packages = with pkgs; [
    apktool
    nh-darwin
    nix-output-monitor
    scrcpy
  ];

  home.stateVersion = "24.11";
}
