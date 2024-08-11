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
    obs.enable = true;
    oh-my-posh.enable = true;
    stylix.enable = true;
    zellij.enable = true;
  };

  shells.${namespace}.zsh.enable = true;

  home.stateVersion = "24.11";
}
