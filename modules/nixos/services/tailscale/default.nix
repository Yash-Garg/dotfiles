{
  config,
  lib,
  namespace,
  ...
}:
let
  cfg = config.${namespace}.services.tailscale;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.${namespace}.services.tailscale = {
    enable = mkEnableOption "Tailscale";
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
    };
  };
}
