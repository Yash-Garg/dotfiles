{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop;
in
{
  options.${namespace}.desktop = {
    enable = mkEnableOption "Profile for desktop machines";

    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Extra packages to install on desktop machines";
    };
  };

  config = mkIf cfg.enable {
    # Common configuration for desktop machines
    dots = {
      desktop = {
        android-dev = enabled;
        earlyoom = enabled;
        stylix = enabled;
      };

      hardware = {
        audio = enabled;
        bluetooth = enabled;
        networking = enabled;
      };

      services = {
        openrazer = enabled;
        printing = enabled;
        ssh = enabled;
        tailscale = enabled;
      };

      system = {
        boot = enabled;
        xkb = enabled;
      };
    };

    # Enable the X11 windowing system.
    services.xserver = enabled;

    # Common packages for desktop machines
    users.users.yash.packages =
      # CLI
      with pkgs;
      [
        ddcutil
        git-lfs
        qemu_kvm
        sshfs
        xclip
      ]
      # GUI
      ++ (with pkgs; [
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
      ])
      ++ cfg.extraPackages;
  };
}
