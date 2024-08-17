{
  pkgs,
  lib,
  namespace,
  ...
}:
with lib.${namespace};
{
  programs.btop = enabled // {
    settings = {
      color_theme = lib.mkForce "${pkgs.btop}/share/btop/themes/dracula.theme";
      theme_background = false;
    };
  };
}
