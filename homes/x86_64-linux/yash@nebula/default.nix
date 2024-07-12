{
  pkgs,
  namespace,
  ...
}: {
  snowfallorg.user = {
    enable = true;
    name = "yash";
  };

  profiles.${namespace} = {oh-my-posh.enable = true;};
  shells.${namespace} = {zsh.enable = true;};
  programs.zsh.profileExtra = "eval `keychain --eval --agents ssh git-ssh`";

  home.packages = [pkgs.keychain];
  home.stateVersion = "23.11";
}
