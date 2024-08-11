{ namespace, ... }:
{
  snowfallorg.user = {
    enable = true;
    name = "yash";
  };

  profiles.${namespace} = {
    keychain.enable = true;
    oh-my-posh.enable = true;
    zellij.enable = true;
  };

  shells.${namespace}.zsh.enable = true;

  home.stateVersion = "24.11";
}
