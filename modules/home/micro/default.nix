{ lib, namespace, ... }:
with lib.${namespace};
{
  programs.micro = enabled // {
    settings = {
      colorscheme = "dracula";
      mkparents = true;
      softwrap = false;
      wordwrap = true;
    };
  };

  xdg.configFile = {
    microEditorColorschemes = {
      source = ./dracula.micro;
      target = "./micro/colorschemes/dracula.micro";
    };

    microEditorBindings = {
      source = ./bindings.json;
      target = "./micro/bindings.json";
    };
  };
}
