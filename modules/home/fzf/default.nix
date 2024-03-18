{pkgs, ...}: {
  programs.fzf = {
    enable = true;
    enableBashIntegration = !pkgs.stdenv.isDarwin;
    enableZshIntegration = pkgs.stdenv.isDarwin;
    defaultCommand = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git";
    colors = import ./colors.nix;
  };
}
