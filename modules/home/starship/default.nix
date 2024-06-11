{
  config,
  lib,
  ...
}: let
  cfg = config.profiles.starship;
  inherit (lib) mkEnableOption mkIf;
in {
  options.profiles.starship = {
    enable = mkEnableOption "Enable starship profile";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = true;
        command_timeout = 10000;

        cmd_duration = {
          min_time = 0;
        };

        hostname = {
          disabled = false;
          ssh_only = false;
          format = " at [$hostname](bold red) in ";
        };

        nix_shell = {
          symbol = "nix";
          format = "via [$symbol-$state]($style) ";
        };

        username = {
          show_always = true;
          format = "[$user]($style)";
        };

        gradle.disabled = true;
        java.disabled = true;
        kotlin.disabled = true;
      };
    };
  };
}
