{ pkgs, ... }:
{
  imports = [ ./colors.nix ];

  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --no-ignore";
  };
}
