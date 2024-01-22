{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    clock24 = false;
    mouse = false;
    # shell = pkgs.zsh;
  };
}
