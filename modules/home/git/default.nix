_: {
  programs.git = {
    enable = true;
    includes = [
      {path = "$HOME/.gitconfig";}
    ];
  };
}
