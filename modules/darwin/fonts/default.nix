{
  pkgs,
  namespace,
  ...
}: {
  fonts = {
    packages = [
      pkgs.nerdfonts
      pkgs.${namespace}.monolisa-nerdfonts
    ];
  };
}
