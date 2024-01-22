{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../modules/nix
    ../modules/programs
    ../modules/shell
  ];

  home = {
    username = "yash";
    homeDirectory = "/home/yash";
    stateVersion = "23.11";
  };
}
