{
  pkgs,
  namespace,
  ...
}: {
  snowfallorg.user = {
    enable = true;
    name = "yash";
  };

  profiles.${namespace} = {starship.enable = true;};
  shells.${namespace} = {bash.enable = true;};
  programs.bash.profileExtra = "eval `keychain --eval --agents ssh git-ssh`";

  home.packages = [pkgs.keychain];
  home.stateVersion = "23.11";
}
