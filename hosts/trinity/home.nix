{
  config,
  pkgs,
  ...
}: let
  modules = [
    ../../modules/shell
    ../../modules/programs/common.nix
    ../../modules/programs/starship
    ../../modules/programs/zsh
  ];
in {
  imports = modules;

  programs = {
    starship = {
      enableBashIntegration = false;
      enableZshIntegration = true;
    };

    fzf = {
      enableBashIntegration = false;
      enableZshIntegration = true;
    };

    zoxide = {
      enableBashIntegration = false;
      enableZshIntegration = true;
    };
  };

  home.packages = with pkgs; [
    apktool
    (nerdfonts.override {
      fonts = ["CascadiaCode" "JetBrainsMono"];
    })
    scrcpy
  ];

  home.stateVersion = "23.11";
}
