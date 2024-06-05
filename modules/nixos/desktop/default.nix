{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.profiles.desktop;
in {
  imports = [
    ./android-dev.nix
    ./gnome3.nix
    ./ssh.nix
  ];

  options.profiles.desktop = with lib; {
    enable = mkEnableOption "Profile for desktop machines";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      # Use latest kernel by default.
      kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

      # Bootloader
      loader = {
        timeout = 60;
        efi = {
          efiSysMountPoint = "/boot";
          canTouchEfiVariables = false;
        };
        grub = {
          enable = true;
          devices = ["nodev"];
          efiSupport = true;
          useOSProber = true;
        };
      };
    };

    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    time.hardwareClockInLocalTime = true;

    hardware = {
      bluetooth.enable = lib.mkDefault true;
    };

    networking = {
      hostName = "nova";

      # Enable networking
      networkmanager.enable = true;

      firewall = {
        enable = true;
        allowedTCPPorts = [80 3000];
      };
    };

    programs.adb.enable = true;

    services = {
      # Enable the OpenSSH daemon.
      openssh.enable = true;

      # Enable CUPS to print documents.
      printing.enable = true;

      xserver = {
        # Enable the X11 windowing system.
        enable = true;

        # Configure keymap in X11
        xkb = {
          layout = "us";
          variant = "intl";
        };
      };
    };
  };
}
