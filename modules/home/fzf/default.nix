{pkgs, ...}: {
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git";
    colors = import ./colors.nix;
  };
}
