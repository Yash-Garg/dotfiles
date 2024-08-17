{
  pkgs,
  lib,
  namespace,
  ...
}:
with lib.${namespace};
{
  programs.fastfetch = enabled // {
    package = pkgs.fastfetch.override {
      x11Support = false;
      waylandSupport = false;
      rpmSupport = false;
      vulkanSupport = false;
    };
    settings = {
      display = {
        size = {
          maxPrefix = "MB";
          ndigits = 0;
        };
      };
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        {
          type = "display";
          compactType = "original";
          key = "Resolution";
        }
        "de"
        "wm"
        "wmtheme"
        "theme"
        "icons"
        "terminal"
        {
          type = "terminalfont";
          format = "{/2}{-}{/}{2}{?3} {3}{?}";
        }
        "cpu"
        {
          type = "gpu";
          key = "GPU";
        }
        {
          type = "memory";
          format = "{/1}{-}{/}{/2}{-}{/}{} / {}";
        }
        "break"
        "colors"
      ];
    };
  };
}
