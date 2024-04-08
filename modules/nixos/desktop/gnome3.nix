{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.profiles.desktop;
in {
  options.profiles.desktop.gnome3 = with lib; {
    enable = mkEnableOption "Setup desktop with Gnome DE";
  };

  config = lib.mkIf cfg.gnome3.enable {
    services = {
      gnome.gnome-keyring.enable = true;

      xserver = {
        # Enable the GNOME Desktop Environment.
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;

        # Enable automatic login for the user.
        displayManager.autoLogin.enable = true;
        displayManager.autoLogin.user = "yash";
      };
    };

    # Enable Wayland compatibility workarounds within Nixpkgs
    environment.variables.ELECTRON_OZONE_PLATFORM_HINT = "x11";
    environment.variables.NIXOS_OZONE_WL = "1";
  };
}
