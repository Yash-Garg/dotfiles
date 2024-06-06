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
  font = "JetBrainsMono Nerd Font Mono";
in {
  options.profiles.firefox = with lib; {
    enable = mkEnableOption "Enable firefox profile";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      policies = {
        AppAutoUpdate = false;
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DefaultDownloadDirectory = "\${HOME}/Downloads";
        DisableAppUpdate = true;
        DisableFirefoxAccounts = true;
        DisableFormHistory = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DNSOverHTTPS = true;
        DontCheckDefaultBrowser = true;
        Homepage.StartPage = "previous-session";
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
      };
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
              addonId = "dark-space-full-transparent@yash";
              url = "https://addons.mozilla.org/firefox/downloads/file/3888121/dark_space_full_transparent-1.3.xpi";
              sha256 = "sha256-63emiqUdRBPIYnqXX7aftmNIs4TF5aWXKj0Fn/xnTng=";
              meta = with lib; {platforms = platforms.all;};
            })
            (buildFirefoxXpiAddon {
              pname = "material-icons-for-github";
              version = "1.8.14";
              addonId = "csantos.gdev@gmail.com";
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
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.safebrowsing.downloads.remote.block_dangerous" = false;
            "browser.safebrowsing.downloads.remote.block_dangerous_host" = false;
            "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
            "browser.safebrowsing.downloads.remote.block_uncommon" = false;
            "browser.safebrowsing.downloads.remote.url" = false;
            "browser.safebrowsing.downloads.remote.enabled" = false;
            "browser.safebrowsing.downloads.enabled" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "datareporting.healthreport.service.enabled" = false;
            "font.name.monospace.x-western" = font;
          };
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
