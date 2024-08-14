{ namespace, ... }:
{
  snowfallorg.user = {
    enable = true;
    name = "yash";
  };

  profiles.${namespace} = {
    alacritty.enable = true;
    firefox.enable = true;
    kitty.enable = true;
    mpv.enable = true;
    neovim.enable = true;
    obs.enable = true;
    oh-my-posh.enable = true;
    zellij.enable = true;
  };

  shells.${namespace}.zsh.enable = true;

  home.stateVersion = "24.11";
}
