{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.hardware.networking;
in
{
  options.${namespace}.hardware.networking = with types; {
    enable = mkBoolOpt false "Whether or not to enable networking support";
    domain = mkOpt str "" "The domain name of the machine";
    hostName = mkOpt str "nixos" "The hostname of the machine";
    hosts = mkOpt attrs { } (mdDoc "An attribute set to merge with `networking.hosts`");
    tcpPorts = mkOpt (listOf port) [
      80
      443
      8080
    ] "A list of ports to open in the firewall";
  };

  config = mkIf cfg.enable {
    networking = {
      domain = cfg.domain;
      hostName = cfg.hostName;
      hosts = cfg.hosts;

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
        allowedTCPPorts = cfg.tcpPorts;
      };
    };
  };
}
