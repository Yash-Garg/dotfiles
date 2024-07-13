{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
let
  cfg = config.profiles.${namespace}.firefox;
  css-hacks = pkgs.fetchFromGitHub {
    owner = "MrOtherGuy";
    repo = "firefox-csshacks";
    rev = "f1480c80e31c0b738e6d49a78137a42adfdccaab";
    sha256 = "sha256-5TLKrsW+yLzhjHMPXZJ+b4LprtZ4pXdkV9yB0LaVDUk=";
  };
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.${namespace}.firefox = {
    enable = mkEnableOption "Enable firefox profile";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true; }) { };
      policies = import ./policies.nix;
      profiles = {
        yash = {
          isDefault = true;
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            bitwarden
            darkreader
            multi-account-containers
            raindropio
            sponsorblock
            ublock-origin
            (buildFirefoxXpiAddon {
              pname = "dark-space-full-transparent";
              version = "1.3";
              addonId = "{24aca621-5029-4aa4-95a9-81d4bd3eba76}";
              url = "https://addons.mozilla.org/firefox/downloads/file/3888121/dark_space_full_transparent-1.3.xpi";
              sha256 = "sha256-63emiqUdRBPIYnqXX7aftmNIs4TF5aWXKj0Fn/xnTng=";
              meta = with lib; {
                platforms = platforms.all;
              };
            })
            (buildFirefoxXpiAddon {
              pname = "material-icons-for-github";
              version = "1.8.16";
              addonId = "{eac6e624-97fa-4f28-9d24-c06c9b8aa713}";
              url = "https://addons.mozilla.org/firefox/downloads/file/4315349/material_icons_for_github-1.8.16.xpi";
              sha256 = "sha256-rPPDBHrH8VEwCRVUZ4nES2TMw5wyj/wALOl4RipfS5Q=";
              meta = with lib; {
                platforms = platforms.all;
              };
            })
          ];
          search = {
            force = true;
            default = "Google";
            privateDefault = "Google";
            engines = {
              "Bing".metaData.hidden = true;
              "DuckDuckGo".metaData.hidden = true;
              "Wikipedia (en)".metaData.hidden = true;

              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
            };
          };
          settings = import ./settings.nix;
          userChrome = ''
            @import url("${css-hacks}/chrome/auto_devtools_theme_for_rdm.css");
            @import url("${css-hacks}/chrome/compact_extensions_panel.css");
            @import url("${css-hacks}/chrome/tabs_on_bottom.css");
            @import url("${css-hacks}/chrome/tabs_on_bottom_menubar_on_top_patch.css");
          '';
        };
      };
    };
  };
}
