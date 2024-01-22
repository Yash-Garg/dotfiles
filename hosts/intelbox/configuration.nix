{
  config,
  pkgs,
  ...
}: {
  targets.genericLinux.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    apktool
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
}
