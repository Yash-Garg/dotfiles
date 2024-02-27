{pkgs, ...}: {
  snowfallorg.user = {
    enable = true;
    name = "yash";
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

  shells = {
    bash.enable = false;
    zsh.enable = true;
  };

  home.packages = with pkgs; [
    apktool
    (nerdfonts.override {
      fonts = ["CascadiaCode" "JetBrainsMono"];
    })
    ollama
    scrcpy
  ];

  home.stateVersion = "23.11";
}
