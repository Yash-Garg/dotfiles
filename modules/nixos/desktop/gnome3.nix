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
        dash-to-dock
        media-controls
        pop-shell
        transparent-top-bar
        unmess
        user-themes
      ]);

    stylix.targets = {
      gnome.enable = true;
      gtk.enable = true;
    };

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
              "dash-to-dock@micxgx.gmail.com"
              "mediacontrols@cliffniff.github.com"
              "pop-shell@system76.com"
              "transparent-top-bar@zhanghai.me"
              "unmess@ezix.org"
              "user-theme@gnome-shell-extensions.gcampax.github.com"
            ];
          };

          "org/gnome/shell/extensions/dash-to-dock" = {
            custom-theme-shrink = true;
            dash-max-icon-size = 40;
            autohide = true;
            background-opacity = 0.8;
            click-action = "previews";
            extend-height = false;
            dock-fixed = false;
            dock-position = "BOTTOM";
            hot-keys = false;
            pressure-threshold = 200.0;
            require-pressure-to-show = true;
            scroll-action = "cycle-windows";
            show-favorites = true;
            show-trash = true;
            transparency-mode = "fixed";
          };

          "org/gnome/desktop/wm/preferences" = {
            resize-with-right-button = true;
            mouse-button-modifier = "<Alt>";
          };

          "org/gnome/desktop/background" = {
            picture-uri = "file://${config.stylix.image}";
            picture-uri-dark = "file://${config.stylix.image}";
          };

          "org/gnome/desktop/interface" = {
            gtk-theme = "adw-gtk3-dark";
            color-scheme =
              if config.stylix.polarity == "dark"
              then "prefer-dark"
              else "default";
          };
        };
      };
    };

    environment = {
      gnome.excludePackages = with pkgs;
      with pkgs.gnome; [
        epiphany
        geary
        gnome-calendar
        gnome-characters
        gnome-clocks
        gnome-console
        gnome-contacts
        gnome-maps
        gnome-music
        gnome-weather
        loupe
        simple-scan
        snapshot
        totem
      ];

      # Enable Wayland compatibility workarounds within Nixpkgs
      variables = {
        ELECTRON_OZONE_PLATFORM_HINT = "x11";
        NIXOS_OZONE_WL = "1";
      };
    };
  };
}
