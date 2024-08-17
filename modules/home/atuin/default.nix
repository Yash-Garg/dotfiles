{ lib, namespace, ... }:
with lib.${namespace};
{
  programs.atuin = enabled // {
    flags = [ "--disable-up-arrow" ];
    settings = {
      max_preview_height = 2;
      search_mode = "skim";
      show_preview = true;
      style = "compact";
    };
  };
}
