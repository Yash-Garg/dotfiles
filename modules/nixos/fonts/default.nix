{ pkgs, namespace, ... }:
{
  fonts = {
    packages = [
      pkgs.cabin
      pkgs.dejavu_fonts
      pkgs.${namespace}.monolisa-nerdfonts
      pkgs.nerdfonts
      pkgs.noto-fonts
      pkgs.unifont
    ];
  };
}
