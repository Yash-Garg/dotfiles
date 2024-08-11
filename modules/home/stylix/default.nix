{
  config,
  lib,
  namespace,
  ...
}:
with lib;
let
  cfg = config.profiles.${namespace}.stylix;
  profiles = config.profiles.${namespace};
in
{
  options.profiles.${namespace}.stylix = {
    enable = mkEnableOption "Enable stylix theming";
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = false;
      targets = {
        alacritty.enable = profiles.alacritty.enable;
        bat.enable = true;
        btop.enable = true;
        fzf.enable = true;
        kitty.enable = profiles.kitty.enable;
        vesktop.enable = true;
        wezterm.enable = profiles.wezterm.enable;
        yazi.enable = true;
        zellij.enable = profiles.zellij.enable;
      };
    };
  };
}
