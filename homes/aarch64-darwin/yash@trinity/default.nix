{pkgs, ...}: {
  snowfallorg.user = {
    enable = true;
    name = "yash";
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
