{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
let
  cfg = config.${namespace}.profiles.desktop;
in
{
  imports = [
    ./android-dev.nix
    ./earlyoom.nix
    ./gnome3.nix
    ./rnnoise.nix
  ];

  options.${namespace}.profiles.desktop = {
    enable = mkEnableOption "Profile for desktop machines";

    networkHosts = lib.mkOption {
      type = types.attrsOf (types.listOf types.str);
      description = ''
        Locally defined maps of hostnames to IP addresses.
      '';
    };
  };

  config = mkIf cfg.enable {
    dots.system.boot = {
      enable = true;
      secure.enable = true;
    };

    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    time.hardwareClockInLocalTime = true;
    hardware.bluetooth.enable = mkDefault true;

    networking = {
      hostName = "nova";
      hosts = cfg.networkHosts;

      # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
      # (the default) this is the recommended approach. When using systemd-networkd it's
      # still possible to use this option, but it's recommended to use it in conjunction
      # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
      useDHCP = mkDefault true;

      # Enable networking
      networkmanager.enable = true;
      nftables.enable = true;

      firewall = {
        enable = true;
        allowPing = true;
        # always allow traffic from your Tailscale network
        trustedInterfaces = [ "tailscale0" ];
        # allow the Tailscale UDP port through the firewall
        allowedUDPPorts = [ config.services.tailscale.port ];
        allowedTCPPorts = [
          80
          1313
          3000
        ];
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
        size = 28;
      };
      fonts = {
        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-color-emoji;
        };
        monospace = {
          name = "JetBrainsMono Nerd Font Mono Regular";
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

    xdg.mime = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
        "application/pdf" = "firefox.desktop";
      };
    };
  };
}
