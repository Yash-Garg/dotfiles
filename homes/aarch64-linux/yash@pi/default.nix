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
    bash.enable = true;
  };

  home.stateVersion = "23.11";
}
