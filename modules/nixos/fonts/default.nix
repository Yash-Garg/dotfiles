{ pkgs, namespace, ... }:
{
  fonts = {
    packages = [
      pkgs.cabin
      pkgs.nerdfonts
      pkgs.${namespace}.monolisa-nerdfonts
    ];
  };
}
