{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
let
  cfg = config.profiles.${namespace}.neovim;
in
{
  options.profiles.${namespace}.neovim = {
    enable = mkEnableOption "Enable neovim profile";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.${namespace}.neovim ];

    programs.tmux.plugins = [ pkgs.tmuxPlugins.vim-tmux-navigator ];
  };
}
