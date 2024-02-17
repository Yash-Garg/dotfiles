{
  config,
  pkgs,
  username,
  nix-index-database,
  ...
}:
 {
  imports = [
    nix-index-database.hmModules.nix-index
  ];

  home.stateVersion = "22.11";

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.EDITOR = "lvim";
    # FIXME: set your preferred $SHELL
    sessionVariables.SHELL = "/etc/profiles/per-user/${username}/bin/zsh";
  };

  home.packages = [];

  programs = {
    broot.enable = true;
    broot.enableZshIntegration = true;

    home-manager.enable = true;

    nix-index.enable = true;
    nix-index.enableZshIntegration = true;
    nix-index-database.comma.enable = true;
  };
}
