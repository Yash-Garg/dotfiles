{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
let
  cfg = config.profiles.${namespace}.zellij;
in
{
  options.profiles.${namespace}.zellij = {
    enable = mkEnableOption "Enable zellij profile";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.zjstatus ];

    programs.zellij = {
      enable = true;
      settings = {
        mouse_mode = true;
        on_force_close = "detach";
        scroll_buffer_size = 100000;
        simplified_ui = false;
        theme = mkDefault "catppuccin-mocha";
        themes.catppuccin-mocha = {
          bg = "#585b70";
          fg = "#cdd6f4";
          red = "#f38ba8";
          green = "#a6e3a1";
          blue = "#89b4fa";
          yellow = "#f9e2af";
          magenta = "#f5c2e7";
          orange = "#fab387";
          cyan = "#89dceb";
          black = "#181825";
          white = "#cdd6f4";
        };
        ui.pane_frames = {
          hide_session_name = false;
          rounded_corners = true;
        };
      };
    };

    xdg.configFile = {
      "zellij/layouts".source = ./layouts;
    };
  };
}
