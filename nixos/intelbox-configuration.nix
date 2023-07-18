{
  config,
  pkgs,
  ...
}: {
  imports = [./common.nix];

  home.username = "yash";
  home.homeDirectory = "/home/yash";

  targets.genericLinux.enable = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    apktool
    dnscontrol
    erdtree
    flutter
    google-chrome
    hyperfine
    imwheel
    jdk17
    jetbrains-toolbox
    kitty
    (nerdfonts.override {
      fonts = ["CascadiaCode" "JetBrainsMono"];
    })
    ookla-speedtest
    scc
    scrcpy
    telegram-desktop
    vscode
    xclip
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";
}
