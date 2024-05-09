{inputs, ...}: {
  programs.micro = {
    enable = true;
    settings = {
      colorscheme = "dracula";
      mkparents = true;
      softwrap = false;
      wordwrap = true;
    };
  };

  xdg.configFile."micro/colorschemes/dracula.micro" = {
    source = inputs.colors-micro;
  };
}
