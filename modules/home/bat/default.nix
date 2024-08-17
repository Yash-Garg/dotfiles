{
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
{
  programs.bat = enabled // {
    config = {
      theme = lib.mkForce "Dracula";
      pager = "never";
    };
    extraPackages = with pkgs.bat-extras; [
      batgrep
      batman
    ];
  };
}
