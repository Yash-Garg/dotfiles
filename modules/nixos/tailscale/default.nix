{
  config,
  lib,
  ...
}: let
  cfg = config.profiles.tailscale;
  inherit (lib) mkEnableOption mkIf;
in {
  options.profiles.tailscale = {
    enable = mkEnableOption "Tailscale profile";
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
    };
  };
}
