{ lib, namespace, ... }:
with lib.${namespace};
{
  snowfallorg.user = enabled // {
    name = "yash";
  };

  profiles.${namespace} = {
    alacritty = enabled;
    firefox = enabled;
    kitty = enabled;
    mpv = enabled;
    neovim = enabled;
    obs = enabled;
    oh-my-posh = enabled;
    zellij = enabled;
  };

  shells.${namespace}.zsh = enabled;

  home.stateVersion = "24.11";
}
