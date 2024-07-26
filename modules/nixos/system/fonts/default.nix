{ pkgs, namespace, ... }:
{
  fonts = {
    packages = with pkgs; [
      cabin
      dejavu_fonts
      pkgs.${namespace}.monolisa-nerdfonts
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      unifont
    ];
  };
}
