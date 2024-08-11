{ inputs, lib, ... }:
{
  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        show_hidden = true;
        sort_dir_first = true;
      };
    };
  };

  xdg.configFile."yazi/theme.toml".source = lib.mkDefault "${inputs.catppuccin-yazi.outPath}/themes/mocha.toml";
}
