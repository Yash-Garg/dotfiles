{ lib, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme = lib.mkForce "Dracula";
      pager = "never";
    };
  };
}
