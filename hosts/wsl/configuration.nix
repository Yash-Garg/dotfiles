{
  config,
  pkgs,
  ...
}: {
  targets.genericLinux.enable = true;

  programs.bash.profileExtra = ''
    eval `keychain --eval --agents ssh git-ssh`
  '';

  home.packages = with pkgs; [
    keychain
  ];
}
