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

  shells = {
    bash.enable = true;
    zsh.enable = false;
  };

  home = {
    username = "yash";
    homeDirectory = "/home/yash";
    stateVersion = "23.11";
  };
}
