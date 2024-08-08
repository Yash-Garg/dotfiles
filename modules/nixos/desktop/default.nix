{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop;
in
{
  options.${namespace}.desktop = {
    enable = mkEnableOption "Profile for desktop machines";
  };

  config = mkIf cfg.enable {
    # Common configuration for desktop machines
    dots = {
      desktop = {
        android-dev = enabled;
        earlyoom = enabled;
        stylix = enabled;
      };

      hardware = {
        audio = enabled;
        bluetooth = enabled;
        networking = enabled;
      };

      services = {
        openrazer = enabled;
        printing = enabled;
        ssh = enabled;
        tailscale = enabled;
      };

      system = {
        boot = enabled;
        xkb = enabled;
      };
    };

    # Enable the X11 windowing system.
    services.xserver = enabled;

    time.hardwareClockInLocalTime = true;
  };
}
