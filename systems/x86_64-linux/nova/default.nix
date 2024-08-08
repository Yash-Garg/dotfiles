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
      withWaylandGLFW = config.${namespace}.desktop.gnome.enable;
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

  dots = {
    desktop = {
      enable = true;
      gnome.enable = true;
    };

    hardware.networking.hostName = "nova";

    services = {
      cifs = {
        enable = true;
        cifsHost = "nova";
        mounts = {
          evo.path = "cosmos.local/evo";
          wd.path = "cosmos.local/media";
        };
      };

      samba = {
        enable = true;
        shares = {
          downloads.path = "/mnt/sshd";
        };
      };
    };

    system.boot.secure.enable = true;
  };

  topology.self.name = "Desktop";

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
