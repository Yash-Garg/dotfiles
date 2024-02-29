{pkgs, ...}: {
  programs.atuin = {
    enable = true;
    enableBashIntegration = !pkgs.stdenv.isDarwin;
    enableZshIntegration = pkgs.stdenv.isDarwin;
    settings = {
      max_preview_height = 2;
      search_mode = "skim";
      show_preview = true;
      style = "compact";
    };
  };
}
