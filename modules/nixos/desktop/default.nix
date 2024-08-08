{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
let
  cfg = config.${namespace}.desktop;
in
{
  options.${namespace}.desktop = {
    enable = mkEnableOption "Profile for desktop machines";

    networkHosts = lib.mkOption {
      type = types.attrsOf (types.listOf types.str);
      default = { };
      description = ''
        Locally defined maps of hostnames to IP addresses.
      '';
    };
  };

  config = mkIf cfg.enable {
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
