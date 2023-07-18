{
  config,
  pkgs,
  ...
}: {
  imports = [./common.nix];

  home.username = "yash";
  home.homeDirectory = "/home/yash";

  targets.genericLinux.enable = true;

  programs.bash.profileExtra = ''
    eval `keychain --eval --agents ssh git-ssh`
  '';

  home.packages = with pkgs; [
    keychain
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";
}
