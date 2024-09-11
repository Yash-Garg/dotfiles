{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.adguard;
in
{
  options.${namespace}.services.adguard = {
    enable = mkEnableOption "Adguard Home Server";

    port = mkOption {
      type = types.int;
      default = 4000;
      description = "The port to serve HTTP on";
    };
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 ];
    };

    services.adguardhome = enabled // {
      inherit (cfg) port;
      host = "127.0.0.1";
      mutableSettings = true;
      openFirewall = true;
      settings = {
        http = {
          address = "127.0.0.1:${toString cfg.port}";
        };
      };
    };
  };
}
