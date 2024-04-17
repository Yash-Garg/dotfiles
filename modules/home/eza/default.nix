{pkgs, ...}: {
  programs.eza = {
    enable = true;
    enableBashIntegration = !pkgs.stdenv.isDarwin;
    enableZshIntegration = pkgs.stdenv.isDarwin;
    icons = false;
    extraOptions = ["--all" "--git-ignore"];
  };
}
