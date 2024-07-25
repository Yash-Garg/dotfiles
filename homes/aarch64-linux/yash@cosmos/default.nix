{ pkgs, namespace, ... }:
{
  snowfallorg.user = {
    enable = true;
    name = "yash";
  };

  profiles.${namespace} = {
    keychain.enable = true;
    starship.enable = true;
  };

  shells.${namespace} = {
    zsh.enable = true;
  };

  home.stateVersion = "24.11";
}
