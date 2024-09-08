{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.tailscale;
in
{
  options.${namespace}.services.tailscale = {
    enable = mkEnableOption "Tailscale";

    authKeyFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Path to a file containing a Tailscale authkey that this device can use to authenticate itself";
    };

    extraOptions = mkOption {
      type = types.listOf types.str;
      description = "List of extra flags passed to the `tailscale` invocation";
      default = [ ];
      example = [ "--ssh" ];
    };

    openFirewall = mkBoolOpt true "Open firewall for Tailscale";

    tailnet = mkOpt types.str "turtle-lake.ts.net" "Tailscale network name";
  };

  config = mkIf cfg.enable {
    # always allow traffic from Tailscale network
    networking.firewall.trustedInterfaces = mkIf cfg.openFirewall [ "tailscale0" ];
    networking = {
      nameservers = [
        "100.100.100.100"
        "8.8.8.8"
        "1.1.1.1"
      ];
      search = [ cfg.tailnet ];
    };

    services.tailscale = enabled // {
      inherit (cfg) authKeyFile;
      inherit (cfg) openFirewall;
      extraUpFlags = cfg.extraOptions;
      permitCertUid = "caddy";
      useRoutingFeatures = "both";
    };
  };
}
