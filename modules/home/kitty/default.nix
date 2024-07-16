{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
let
  cfg = config.profiles.${namespace}.kitty;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.${namespace}.kitty = {
    enable = mkEnableOption "Enable kitty profile";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;

      font = {
        name = "CaskaydiaCove Nerd Font Mono";
        package = pkgs.nerdfonts;
        size = 14;
      };

      keybindings = {
        "ctrl+c" = "copy_and_clear_or_interrupt";
        "ctrl+v" = "paste_from_clipboard";
      };

      settings = {
        confirm_os_window_close = 0;
        copy_on_select = true;
        disable_ligatures = false;
        enable_audio_bell = false;
        hide_window_decorations = true;
        intital_window_width = 140;
        initial_window_height = 35;
        scrollback_lines = 2000;
        show_hyperlink_targets = true;
        tab_bar_edge = "top";
        window_padding_width = 10;
      } // import ./colors.nix;
    };
  };
}
