{
  config,
  pkgs,
  ...
}: {
  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    keychain
  ];

  programs.bash.profileExtra = "eval `keychain --eval --agents ssh git-ssh`";
}
