{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bash
    ./common
    ./starship
    ./tmux
    ./zsh
  ];
}
