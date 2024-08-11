{
  config,
  lib,
  namespace,
  ...
}:
with lib;
let
  cfg = config.profiles.${namespace}.zellij;
in
{
  imports = [ ./themes.nix ];

  options.profiles.${namespace}.zellij = {
    enable = mkEnableOption "Enable zellij profile";
  };

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      settings = {
        default_layout = "compact";
        mouse_mode = true;
        on_force_close = "detach";
        scroll_buffer_size = 100000;
        simplified_ui = true;
        theme = "catppuccin-mocha";
        ui = {
          pane_frames = {
            hide_session_name = true;
            rounded_corners = true;
          };
        };
      };
    };
  };
}
