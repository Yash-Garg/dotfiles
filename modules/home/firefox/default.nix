{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.profiles.firefox;
  css-hacks = pkgs.fetchFromGitHub {
    owner = "MrOtherGuy";
    repo = "firefox-csshacks";
    rev = "f1480c80e31c0b738e6d49a78137a42adfdccaab";
    sha256 = "sha256-5TLKrsW+yLzhjHMPXZJ+b4LprtZ4pXdkV9yB0LaVDUk=";
  };
in {
  options.profiles.firefox = with lib; {
    enable = mkEnableOption "Enable firefox profile";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      policies = import ./policies.nix;
      profiles = {
        yash = {
          isDefault = true;
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            bitwarden
            darkreader
            ublock-origin
            sponsorblock
            (buildFirefoxXpiAddon {
              pname = "dark-space-full-transparent";
              version = "1.3";
              addonId = "{24aca621-5029-4aa4-95a9-81d4bd3eba76}";
              url = "https://addons.mozilla.org/firefox/downloads/file/3888121/dark_space_full_transparent-1.3.xpi";
              sha256 = "sha256-63emiqUdRBPIYnqXX7aftmNIs4TF5aWXKj0Fn/xnTng=";
              meta = with lib; {platforms = platforms.all;};
            })
            (buildFirefoxXpiAddon {
              pname = "material-icons-for-github";
              version = "1.8.14";
              addonId = "{eac6e624-97fa-4f28-9d24-c06c9b8aa713}";
              url = "https://addons.mozilla.org/firefox/downloads/file/4288858/material_icons_for_github-1.8.14.xpi";
              sha256 = "sha256-GJt6tdrNJkFkUOlYOMHmuluXnDGD+C6M+RW8U1PcE+A=";
              meta = with lib; {platforms = platforms.all;};
            })
          ];
          search = {
            force = true;
            default = "Google";
            privateDefault = "Google";
          };
          settings = import ./settings.nix;
          userChrome = ''
            @-moz-document url(chrome://browser/content/browser.xhtml) {
              #main-window body {
                flex-direction: column-reverse !important;
              }

              #navigator-toolbox {
                flex-direction: column-reverse !important;
              }

              #urlbar {
                top: unset !important;
                bottom: calc(var(--urlbar-margin-inline)) !important;
                box-shadow: none !important;
                display: flex !important;
                flex-direction: column !important;
              }

              #urlbar>* {
                flex: none;
              }

              #urlbar-input-container {
                order: 2;
              }

              #urlbar>.urlbarView {
                order: 1;
                border-bottom: 1px solid #666;
              }

              #urlbar-results {
                display: flex;
                flex-direction: column-reverse;
              }

              .search-one-offs {
                display: none !important;
              }

              .tab-background {
                border-top: none !important;
              }

              #navigator-toolbox::after {
                border: none;
              }

              #TabsToolbar .tabbrowser-arrowscrollbox,
              #tabbrowser-tabs,
              .tab-stack {
                min-height: 28px !important;
              }

              .tab-content {
                padding: 0 5px;
              }

              .tab-close-button .toolbarbutton-icon {
                width: 12px !important;
                height: 12px !important;
              }

              toolbox[inFullscreen=true] {
                display: none;
              }

              #mainPopupSet panel.panel-no-padding {
                margin-top: calc(-50vh + 40px) !important;
              }

              #mainPopupSet .panel-viewstack,
              #mainPopupSet popupnotification {
                max-height: 50vh !important;
                height: 50vh;
              }

              #mainPopupSet panel.panel-no-padding.popup-notification-panel {
                margin-top: calc(-50vh - 35px) !important;
              }

              #navigator-toolbox .panel-viewstack {
                max-height: 75vh !important;
              }

              panelview.cui-widget-panelview {
                flex: 1;
              }

              panelview.cui-widget-panelview>vbox {
                flex: 1;
                min-height: 50vh;
              }
            }
          '';
        };
      };
    };
  };
}
