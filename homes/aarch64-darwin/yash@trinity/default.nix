{ pkgs, namespace, ... }:
{
  snowfallorg.user = {
    enable = true;
    name = "yash";
  };

  profiles.${namespace} = {
    oh-my-posh.enable = true;
    stylix.enable = true;
    zellij.enable = true;
  };

  shells.${namespace}.zsh.enable = true;

  home.packages = with pkgs; [
    apktool
    nix-output-monitor
    scrcpy
  ];

  home.stateVersion = "24.11";
}
