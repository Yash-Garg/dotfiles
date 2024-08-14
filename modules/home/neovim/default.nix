{ lib, namespace, ... }:
with lib;
with lib.${namespace};
{
  imports = [
    ./keymaps.nix
    ./options.nix
  ];

  programs.nixvim = enabled // {
    colorschemes.rose-pine = enabled // {
      settings = {
        dark_variant = "moon";
        styles = {
          bold = true;
          italic = true;
          transparency = true;
        };
      };
    };

    viAlias = true;
    vimAlias = true;
  };
}
