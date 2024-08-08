{ pkgs, namespace, ... }:
{
  snowfallorg.user = {
    enable = true;
    name = "yash";
  };

  profiles.${namespace}.oh-my-posh.enable = true;

  shells.${namespace}.zsh.enable = true;

  home.stateVersion = "24.05";
}
