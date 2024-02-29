_: {
  programs.lsd = {
    enable = true;
    enableAliases = true;
    colors = import ./colors.nix;
    settings = {
      date = "relative";
      icons.when = "never";
    };
  };
}
