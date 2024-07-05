{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.profiles.desktop;
  inherit (lib) mkEnableOption mkIf;
in {
  options.profiles.desktop.gnome3 = {
    enable = mkEnableOption "Setup desktop with Gnome DE";
  };

  config = mkIf cfg.gnome3.enable {
    services = {
      # Enable automatic login for the user.
      displayManager.autoLogin.enable = true;
      displayManager.autoLogin.user = "yash";

      gnome.gnome-keyring.enable = true;

      udev.packages = with pkgs; [gnome.gnome-settings-daemon];

      xserver = {
        # Enable the GNOME Desktop Environment.
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };

    users.users.yash.packages =
      [
        pkgs.gnome-tweaks
      ]
      ++ (with pkgs.gnomeExtensions; [
        appindicator
        brightness-control-using-ddcutil
        pop-shell
        unmess
        user-themes
      ]);

    snowfallorg.users.yash.home.config = {
      gtk = {
        enable = true;
        theme = {
          name = "adw-gtk3-dark";
          package = pkgs.adw-gtk3;
        };
      };

      dconf = {
        enable = true;
        settings = {
          "org/gnome/shell" = {
            disable-user-extensions = false;
            enabled-extensions = [
              "appindicatorsupport@rgcjonas.gmail.com"
              "display-brightness-ddcutil@themightydeity.github.com"
              "pop-shell@system76.com"
              "unmess@ezix.org"
              "user-theme@gnome-shell-extensions.gcampax.github.com"
            ];
          };
          "org/gnome/desktop/wm/preferences" = {
            resize-with-right-button = true;
            mouse-button-modifier = "<Alt>";
          };
          "org/gnome/shell/extensions/user-theme" = {
            name = "adw-gtk3-dark";
          };
          "org/gnome/desktop/interface" = {
            gtk-theme = "adw-gtk3-dark";
            color-scheme = "prefer-dark";
          };
        };
      };
    };

    # Enable Wayland compatibility workarounds within Nixpkgs
    environment.variables = {
      ELECTRON_OZONE_PLATFORM_HINT = "x11";
      NIXOS_OZONE_WL = "1";
    };
  };
}
