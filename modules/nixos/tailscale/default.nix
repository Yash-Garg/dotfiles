{
  config,
  lib,
  namespace,
  ...
}:
let
  cfg = config.profiles.${namespace}.tailscale;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.${namespace}.tailscale = {
    enable = mkEnableOption "Tailscale profile";
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
    };
  };
}
