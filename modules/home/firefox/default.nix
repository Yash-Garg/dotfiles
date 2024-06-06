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
