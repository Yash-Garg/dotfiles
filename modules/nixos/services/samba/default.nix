{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  cfg = config.${namespace}.services.samba;
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
in
{
  options.${namespace}.services.samba = {
    enable = mkEnableOption { description = "Whether to configure samba server"; };
    shares = mkOption {
      type = types.attrsOf (types.attrsOf types.unspecified);
      default = { };
      description = "Samba shares to configure";
    };
  };

  config = mkIf cfg.enable {
    services.samba = {
      enable = true;
      package = pkgs.samba;
      securityType = "user";
      openFirewall = true;
      extraConfig = ''
        max log size = 50
      '';
      shares = cfg.shares;
    };

    # Advertise shares to Windows hosts
    services.samba-wsdd = {
      enable = true;
      discovery = true;
      openFirewall = true;
      workgroup = "WORKGROUP";
    };
  };
}
