{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  guiPkgs = with pkgs; [
    collision
    curtail
    emblem
    foliate
    google-chrome
    handbrake
    jetbrains.idea-ultimate
    newsflash
    (prismlauncher.override {
      jdks = [ openjdk17 ];
      withWaylandGLFW = config.profiles.${namespace}.desktop.gnome3.enable;
    })
    slack
    spotify
    telegram-desktop
    textpieces
    transmission_4-gtk
    vesktop
    vscode
  ];
in
{
  imports = [ ./hardware-configuration.nix ];

  topology.self.name = "Desktop";

  profiles.${namespace} = {
    desktop = {
      enable = true;
      networkHosts = {
        "192.168.29.245" = [ "pi" ];
      };
      android-dev.enable = true;
      gnome3.enable = true;
      noise-cancellation.enable = true;
      ssh.enable = true;
    };

    openrazer.enable = true;
    samba.enable = true;
    tailscale.enable = true;
  };

  users.users.yash = {
    isNormalUser = true;
    description = "Yash Garg";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    packages =
      with pkgs;
      [
        apktool
        ddcutil
        flutter
        git-lfs
        qemu_kvm
        scrcpy
        sshfs
        tailscale
        xclip
      ]
      ++ guiPkgs;
  };

  environment.variables.CHROME_EXECUTABLE = "${lib.getExe pkgs.google-chrome}";

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
