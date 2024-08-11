{ lib, pkgs, ... }:
{
  programs.bat = {
    enable = true;
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
