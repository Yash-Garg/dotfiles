{pkgs, ...}: {
  programs.atuin = {
    enable = true;
    flags = ["--disable-up-arrow"];
    settings = {
      max_preview_height = 2;
      search_mode = "skim";
      show_preview = true;
      style = "compact";
    };
  };
}
