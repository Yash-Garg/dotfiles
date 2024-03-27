{pkgs, ...}: {
  programs.atuin = {
    enable = true;
    enableBashIntegration = !pkgs.stdenv.isDarwin;
    enableZshIntegration = pkgs.stdenv.isDarwin;
    flags = ["--disable-up-arrow"];
    settings = {
      max_preview_height = 2;
      search_mode = "skim";
      show_preview = true;
      style = "compact";
    };
  };
}
