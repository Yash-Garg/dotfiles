{pkgs, ...}: {
  snowfallorg.user = {
    enable = true;
    name = "yash";
  };

  profiles.oh-my-posh.enable = true;

  shells.bash.enable = true;

  home.stateVersion = "23.11";
}
