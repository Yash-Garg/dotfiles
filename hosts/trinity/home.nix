{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/programs
    ../../modules/shell
  ];

  shells = {
    bash.enable = false;
    zsh.enable = true;
  };

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
