{
  config,
  lib,
  ...
}: let
  cfg = config.modules;
in {
  options.modules.lsd = {
    enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Enable lsd";
    };
  };

  config = lib.mkIf cfg.lsd.enable {
    programs.lsd = {
      enable = true;
      enableAliases = true;
      colors = import ./colors.nix;
      settings = {
        date = "relative";
        icons.when = "never";
      };
    };
  };
}
