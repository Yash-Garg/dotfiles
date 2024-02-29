{pkgs, ...}: {
  programs.zoxide = {
    enable = true;
    enableBashIntegration = !pkgs.stdenv.isDarwin;
    enableZshIntegration = pkgs.stdenv.isDarwin;
  };
}
