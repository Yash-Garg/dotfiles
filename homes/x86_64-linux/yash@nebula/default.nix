{pkgs, ...}: {
  snowfallorg.user = {
    enable = true;
    name = "yash";
  };

  profiles.oh-my-posh.enable = true;
  programs.zsh.profileExtra = "eval `keychain --eval --agents ssh git-ssh`";
  shells.zsh.enable = true;

  home.packages = [pkgs.keychain];
  home.stateVersion = "23.11";
}
