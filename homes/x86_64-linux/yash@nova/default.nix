{namespace, ...}: {
  snowfallorg.user = {
    enable = true;
    name = "yash";
  };

  profiles.${namespace} = {
    alacritty.enable = true;
    firefox.enable = true;
    mpv.enable = true;
    spotify.enable = false;
    obs.enable = true;
    oh-my-posh.enable = true;
  };

  shells.${namespace}.zsh.enable = true;

  home.stateVersion = "23.11";
}
