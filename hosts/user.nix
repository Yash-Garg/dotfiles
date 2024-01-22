{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../modules/programs
    ../modules/shell
  ];

  home = {
    username = "yash";
    homeDirectory = "/home/yash";
    stateVersion = "23.11";
  };
}
