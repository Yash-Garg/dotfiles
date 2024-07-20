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
        advanced-alttab-window-switcher
        appindicator
        arcmenu
        brightness-control-using-ddcutil
        clipboard-indicator
        dash-to-dock
        media-controls
        transparent-top-bar
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
        # Note: Use `dconf dump dir` to get the current settings
        settings = {
          "org/gnome/shell" = {
            disable-user-extensions = false;
            enabled-extensions = [
              "advanced-alt-tab@G-dH.github.com"
              "appindicatorsupport@rgcjonas.gmail.com"
              "arcmenu@arcmenu.com"
              "clipboard-indicator@tudmotu.com"
              "display-brightness-ddcutil@themightydeity.github.com"
              "dash-to-dock@micxgx.gmail.com"
              "mediacontrols@cliffniff.github.com"
              "tilingshell@ferrarodomenico.com"
              "transparent-top-bar@zhanghai.me"
              "user-theme@gnome-shell-extensions.gcampax.github.com"
            ];
            welcome-dialog-last-shown-version = "999999999";
          };

          "org/gnome/shell/extensions/advanced-alt-tab-window-switcher" = {
            animation-time-factor = 100;
            app-switcher-popup-fav-apps = false;
            app-switcher-popup-filter = 3;
            app-switcher-popup-hide-win-counter-for-single-window = true;
            app-switcher-popup-include-show-apps-icon = false;
            app-switcher-popup-search-pref-running = true;
            app-switcher-popup-titles = true;
            app-switcher-popup-win-counter = true;
            enable-super = false;
            hot-edge-fullscreen = false;
            super-key-mode = 1;
            switcher-popup-hover-select = false;
            switcher-popup-interactive-indicators = true;
            switcher-popup-preview-selected = 1;
            switcher-popup-start-search = false;
            switcher-popup-timeout = 0;
            switcher-popup-tooltip-label-scale = 100;
            switcher-popup-tooltip-title = 1;
            switcher-popup-wrap = true;
            switcher-ws-thumbnails = 0;
            win-switch-mark-minimized = false;
            win-switch-minimized-to-end = false;
            win-switch-skip-minimized = false;
            win-switcher-popup-filter = 1;
            win-switcher-popup-icon-size = 32;
            win-switcher-popup-order = 2;
            win-switcher-popup-preview-size = 160;
            win-switcher-popup-titles = 1;
            win-switcher-popup-ws-indexes = false;
            win-switcher-single-prev-size = 192;
          };

          "org/gnome/shell/extensions/arcmenu" = {
            alphabetize-all-programs = false;
            apps-show-extra-details = false;
            arc-menu-icon = 5;
            category-icon-type = "Symbolic";
            context-menu-items = [ ];
            dash-to-panel-standalone = false;
            disable-recently-installed-apps = true;
            disable-tooltips = true;
            hide-overview-on-startup = true;
            menu-background-color = "rgba(48,48,49,0.98)";
            menu-border-color = "rgb(60,60,60)";
            menu-button-appearance = "None";
            menu-button-icon = "Menu_Icon";
            menu-foreground-color = "rgb(223,223,223)";
            menu-item-active-bg-color = "rgb(25,98,163)";
            menu-item-active-fg-color = "rgb(255,255,255)";
            menu-item-hover-bg-color = "rgb(21,83,158)";
            menu-item-hover-fg-color = "rgb(255,255,255)";
            menu-layout = "Runner";
            menu-separator-color = "rgba(255,255,255,0.1)";
            multi-lined-labels = true;
            multi-monitor = false;
            position-in-panel = "Left";
            prefs-visible-page = 0;
            runner-hotkey-open-primary-monitor = false;
            runner-position = "Centered";
            runner-search-display-style = "Grid";
            runner-show-frequent-apps = false;
            search-entry-border-radius = "(true, 25)";
            show-activities-button = true;
            show-category-sub-menus = false;
            show-hidden-recent-files = false;
          };

          "org/gnome/shell/extensions/clipboard-indicator" = {
            clear-history = [ ];
            clear-on-boot = true;
            confirm-clear = false;
            disable-down-arrow = true;
            display-mode = 0;
            enable-keybindings = true;
            keep-selected-on-clear = false;
            move-item-first = true;
            next-entry = [ ];
            paste-button = false;
            prev-entry = [ ];
            preview-size = 10;
            private-mode-binding = [ ];
            toggle-menu = [ "<Super>v" ];
            topbar-preview-size = 10;
          };

          "org/gnome/shell/extensions/dash-to-dock" = {
            animate-show-apps = true;
            apply-custom-theme = false;
            autohide = true;
            background-opacity = 0.5;
            click-action = "previews";
            custom-background-color = false;
            custom-theme-shrink = true;
            dash-max-icon-size = 30;
            disable-overview-on-startup = false;
            dock-fixed = false;
            dock-position = "RIGHT";
            extend-height = false;
            height-fraction = 0.8;
            hide-tooltip = true;
            hot-keys = false;
            icon-size-fixed = false;
            multi-monitor = false;
            pressure-threshold = 200.0;
            preview-size-scale = 0.0;
            require-pressure-to-show = true;
            scroll-action = "cycle-windows";
            show-apps-always-in-the-edge = true;
            show-favorites = true;
            show-mounts-network = false;
            show-show-apps-button = false;
            show-trash = true;
            transparency-mode = "FIXED";
          };

          "org/gnome/desktop/wm/keybindings" = {
            close = [ "<Super>q" ];
            switch-applications = [ ];
            switch-applications-backward = [ ];
            switch-windows = [ "<Alt>Tab" ];
            switch-windows-backward = [ "<Shift><Alt>Tab" ];
          };

          "org/gnome/desktop/wm/preferences" = {
            resize-with-right-button = true;
            mouse-button-modifier = "<Alt>";
          };

          "org/gnome/shell/keybindings" = {
            toggle-message-tray = [ ];
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
