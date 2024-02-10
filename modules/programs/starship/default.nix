{
  config,
  pkgs,
  ...
}: {
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
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
}