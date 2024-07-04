{pkgs, ...}: {
  snowfallorg.user = {
    enable = true;
    name = "yash";
  };

  profiles.starship.enable = true;
  programs.bash.profileExtra = "eval `keychain --eval --agents ssh git-ssh`";
  shells.bash.enable = true;

  home.packages = [pkgs.keychain];
  home.stateVersion = "23.11";
}
