{pkgs, ...}: {
  snowfallorg.user = {
    enable = true;
    name = "yash";
  };

  shells.bash.enable = true;

  home.packages = with pkgs; [
    apktool
    discord
    flutter
    google-chrome
    imwheel
    jdk17
    jetbrains-toolbox
    kitty
    (nerdfonts.override {
      fonts = ["CascadiaCode" "JetBrainsMono"];
    })
    scrcpy
    telegram-desktop
    vscode
    xclip
  ];

  home.stateVersion = "23.11";
}
