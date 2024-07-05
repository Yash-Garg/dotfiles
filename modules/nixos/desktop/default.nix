{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.profiles.desktop;
  inherit (lib) mkEnableOption mkIf;
in {
  imports = [
    ./android-dev.nix
    ./gnome3.nix
    ./ssh.nix
  ];

  options.profiles.desktop = {
    enable = mkEnableOption "Profile for desktop machines";
  };

  config = mkIf cfg.enable {
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
          gfxmodeEfi = "2560x1440";
          backgroundColor = "#000000";
          fontSize = 36;
          splashImage = ./images/background.png;
          font = "${pkgs.source-code-pro}/share/fonts/opentype/SourceCodePro-Medium.otf";
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

      # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
      # (the default) this is the recommended approach. When using systemd-networkd it's
      # still possible to use this option, but it's recommended to use it in conjunction
      # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
      useDHCP = lib.mkDefault true;

      # Enable networking
      networkmanager.enable = true;

      firewall = {
        enable = true;
        # always allow traffic from your Tailscale network
        trustedInterfaces = ["tailscale0"];
        # allow the Tailscale UDP port through the firewall
        allowedUDPPorts = [config.services.tailscale.port];
        allowedTCPPorts = [80 1313 3000];
      };
    };

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

    stylix = {
      autoEnable = false;
      enable = true;
      homeManagerIntegration.followSystem = true;
      image = ./images/background.png;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      cursor = {
        package = pkgs.rose-pine-cursor;
        name = "BreezeX-RosePine-Linux";
        size = 24;
      };
      fonts = {
        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-color-emoji;
        };
        monospace = {
          name = "JetBrainsMonoNL Nerd Font Mono Regular";
          package = pkgs.nerdfonts;
        };
        sansSerif = {
          name = "Roboto Regular";
          package = pkgs.roboto;
        };
        serif = {
          name = "Roboto Serif 20pt Regular";
          package = pkgs.roboto-serif;
        };
        sizes = {
          applications = 12;
          terminal = 10;
        };
      };
      polarity = "dark";
      targets = {
        chromium.enable = true;
        nixos-icons.enable = true;
      };
    };
  };
}
