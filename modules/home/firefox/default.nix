{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
let
  cfg = config.profiles.${namespace}.firefox;
  css-hacks = pkgs.fetchFromGitHub {
    owner = "MrOtherGuy";
    repo = "firefox-csshacks";
    rev = "f1480c80e31c0b738e6d49a78137a42adfdccaab";
    sha256 = "sha256-5TLKrsW+yLzhjHMPXZJ+b4LprtZ4pXdkV9yB0LaVDUk=";
  };
in
{
  imports = [
    ./extensions.nix
    ./policies.nix
    ./settings.nix
  ];

  options.profiles.${namespace}.firefox = {
    enable = mkEnableOption "Enable firefox profile";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true; }) { };
      profiles = {
        yash = {
          isDefault = true;
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
