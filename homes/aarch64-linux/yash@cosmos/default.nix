{ namespace, ... }:
{
  snowfallorg.user = {
    enable = true;
    name = "yash";
  };

  profiles.${namespace}.starship.enable = true;

  shells.${namespace}.zsh.enable = true;

  home.stateVersion = "24.11";
}
