{ pkgs, namespace, ... }:
{
  fonts = {
    packages =
      (with pkgs; [
        cabin
        dejavu_fonts
        nerdfonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        unifont
      ])
      ++ [ pkgs.${namespace}.monolisa-nerdfonts ];
  };
}
