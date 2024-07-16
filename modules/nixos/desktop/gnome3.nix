{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  cfg = config.profiles.${namespace}.desktop;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.${namespace}.desktop.gnome3 = {
    enable = mkEnableOption "Setup desktop with Gnome DE";
  };

  config = mkIf cfg.gnome3.enable {
    services = {
      # Enable automatic login for the user.
      displayManager.autoLogin.enable = true;
      displayManager.autoLogin.user = "yash";

      gnome.gnome-keyring.enable = true;

      udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

      xserver = {
        # Enable the GNOME Desktop Environment.
        displayManager.gdm.enable = true;
        displayManager.gdm.wayland = true;
        desktopManager.gnome.enable = true;
        excludePackages = [ pkgs.xterm ];
      };
    };

    users.users.yash.packages =
      [
        pkgs.gnome-screenshot
        pkgs.gnome-tweaks
        pkgs.${namespace}.tiling-shell
      ]
      ++ (with pkgs.gnomeExtensions; [
        appindicator
        brightness-control-using-ddcutil
        dash-to-dock
        media-controls
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
              "tilingshell@ferrarodomenico.com"
              "transparent-top-bar@zhanghai.me"
              "unmess@ezix.org"
              "user-theme@gnome-shell-extensions.gcampax.github.com"
            ];
            welcome-dialog-last-shown-version = "999999999";
          };

          "org/gnome/shell/extensions/dash-to-dock" = {
            custom-theme-shrink = true;
            dash-max-icon-size = 30;
            autohide = true;
            background-opacity = 0.8;
            click-action = "previews";
            extend-height = false;
            dock-fixed = false;
            dock-position = "RIGHT";
            hot-keys = false;
            pressure-threshold = 200.0;
            require-pressure-to-show = true;
            scroll-action = "cycle-windows";
            show-favorites = true;
            show-trash = true;
            transparency-mode = "fixed";
          };

          "org/gnome/desktop/wm/keybindings" = {
            close = [ "<Super>q" ];
          };

          "org/gnome/desktop/wm/preferences" = {
            resize-with-right-button = true;
            mouse-button-modifier = "<Alt>";
          };

          "org/gnome/settings-daemon/plugins/media-keys" = {
            area-screenshot-clip = [ "<Shift><Super>s" ];
            custom-keybindings = [
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
            ];
          };

          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
            binding = "<Super>t";
            command = "${lib.getExe pkgs.kitty}";
            name = "open-terminal";
          };

          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
            binding = "<Super>e";
            command = "nautilus";
            name = "open-file-manager";
          };

          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
            binding = "<Super><Shift>s";
            command = "${lib.getExe pkgs.gnome-screenshot} -a";
            name = "open-screenshot-tool";
          };

          "org/gnome/desktop/background" = {
            picture-uri = "file://${config.stylix.image}";
            picture-uri-dark = "file://${config.stylix.image}";
          };

          "org/gnome/shell/app-switcher" = {
            current-workspace-only = false;
          };

          "org/gnome/mutter" = {
            edge-tiling = false;
            dynamic-workspaces = true;
            workspaces-only-on-primary = true;
          };

          "org/gnome/desktop/interface" = {
            clock-show-seconds = false;
            clock-show-weekday = true;
            color-scheme = if config.stylix.polarity == "dark" then "prefer-dark" else "default";
            enable-hot-corners = false;
            font-antialiasing = "rgba";
            font-hinting = "full";
            gtk-enable-primary-paste = false;
            gtk-theme = "adw-gtk3-dark";
            monospace-font-name = config.stylix.fonts.monospace.name;
          };
        };
      };
    };

    environment = {
      gnome.excludePackages =
        with pkgs;
        with pkgs.gnome;
        [
          atomix
          epiphany
          evince
          geary
          gnome-calendar
          gnome-characters
          gnome-clocks
          gnome-connections
          gnome-console
          gnome-contacts
          gnome-initial-setup
          gnome-maps
          gnome-music
          gnome-text-editor
          gnome-tour
          gnome-weather
          hitori
          iagno
          simple-scan
          snapshot
          tali
          totem
          yelp
        ];

      # Enable Wayland compatibility workarounds within Nixpkgs
      variables = {
        ELECTRON_OZONE_PLATFORM_HINT = "x11";
        NIXOS_OZONE_WL = "1";
      };
    };
  };
}
