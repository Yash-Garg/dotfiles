{
  config,
  pkgs,
  ...
}: let
  guiPkgs = with pkgs; [
    google-chrome
    jetbrains.idea-ultimate
    microsoft-edge-beta
    (prismlauncher.override {
      jdks = [openjdk17];
      withWaylandGLFW = config.profiles.desktop.gnome3.enable;
    })
    qbittorrent
    slack
    spotify
    telegram-desktop
    vesktop
    vscode
  ];
in {
  imports = [
    ./hardware-configuration.nix
  ];

  topology.self.name = "Desktop";

  profiles.desktop.enable = true;
  profiles.desktop.android-dev.enable = true;
  profiles.desktop.gnome3.enable = true;
  profiles.desktop.ssh.enable = true;
  profiles.tailscale.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  users.users.yash = {
    isNormalUser = true;
    description = "Yash Garg";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    packages = with pkgs;
      [
        apktool
        ddcutil
        flutter
        imwheel
        maestro
        scrcpy
        sshfs
        tailscale
        xclip
      ]
      ++ guiPkgs;
  };

  environment.variables.CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable";

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
