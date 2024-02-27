{pkgs, ...}: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "${pkgs.btop}/share/btop/themes/dracula.theme";
      theme_background = false;
    };
  };
}
