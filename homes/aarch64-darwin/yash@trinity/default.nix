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
    zellij = enabled;
  };

  shells.${namespace}.zsh = enabled;

  home.packages = with pkgs; [
    apktool
    nix-output-monitor
    scrcpy
  ];

  home.stateVersion = "24.11";
}
