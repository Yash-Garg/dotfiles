{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.profiles.${namespace}.neovim;
in
{
  imports = [
    ./keymaps.nix
    ./options.nix
  ];

  options.profiles.${namespace}.neovim = {
    enable = mkEnableOption "Enable neovim profile";
  };

  config = mkIf cfg.enable {
    programs.nixvim = enabled // {
      autoCmd = [
        {
          # Show diagnostic window when cursor is over warning/error
          event = [
            "CursorHold"
            "CursorHoldI"
          ];
          group = "float_diagnostic_cursor";
          callback.__raw = ''
            function()
            	vim.diagnostic.open_float(
            		nil,
            		{ focus = false, scope = "cursor" }
            	)
            end
          '';
        }
      ];

      autoGroups = {
        float_diagnostic_cursor = { };
      };

      colorschemes.rose-pine = enabled // {
        settings = {
          dark_variant = "moon";
          styles = {
            bold = true;
            italic = false;
            transparency = true;
          };
        };
      };

      defaultEditor = true;

      viAlias = true;
      vimAlias = true;
    };

    programs.tmux.plugins = [ pkgs.tmuxPlugins.vim-tmux-navigator ];
  };
}
