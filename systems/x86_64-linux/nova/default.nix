{
  config,
  pkgs,
  ...
}: let
  guiPkgs = with pkgs; [
    ddccontrol
    discord
    google-chrome
    jetbrains-toolbox
    telegram-desktop
    vscode
  ];
in {
  imports = [
    ./hardware-configuration.nix
  ];

  profiles.desktop.enable = true;
  profiles.desktop.gnome3.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  users.users.yash = {
    isNormalUser = true;
    description = "Yash Garg";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs;
      [
        apktool
        flutter
        imwheel
        jdk17
        (nerdfonts.override {
          fonts = ["CascadiaCode" "JetBrainsMono"];
        })
        scrcpy
        xclip
      ]
      ++ guiPkgs;
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
