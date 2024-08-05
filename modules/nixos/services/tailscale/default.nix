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

    authkeyFile = mkOption {
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
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      authKeyFile = cfg.authkeyFile;
      extraUpFlags = cfg.extraOptions;
      openFirewall = cfg.openFirewall;
      useRoutingFeatures = "both";
    };
  };
}
