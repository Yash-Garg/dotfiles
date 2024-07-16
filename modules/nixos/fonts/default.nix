{ pkgs, namespace, ... }:
{
  fonts = {
    packages =
      (with pkgs; [
        cabin
        dejavu_fonts
        nerdfonts
        noto-fonts
        unifont
      ])
      ++ [ pkgs.${namespace}.monolisa-nerdfonts ];
  };
}
