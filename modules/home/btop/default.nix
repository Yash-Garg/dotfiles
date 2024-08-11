{ pkgs, lib, ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = lib.mkForce "${pkgs.btop}/share/btop/themes/dracula.theme";
      theme_background = false;
    };
  };
}
