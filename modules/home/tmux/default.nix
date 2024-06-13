{
  config,
  pkgs,
  ...
}: let
  shellPath =
    if config.shells.bash.enable
    then null
    else "${pkgs.zsh}/bin/zsh";
in {
  programs.tmux = {
    enable = true;
    mouse = true;
    newSession = true;
    aggressiveResize = !pkgs.stdenv.isDarwin;
    shell = shellPath;
    shortcut = "b";
    sensibleOnTop = true;
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = rose-pine;
        extraConfig = ''
          set -g @rose_pine_variant 'main'
          set -g @rose_pine_host 'on'
          set -g @rose_pine_user 'on'
          set -g @rose_pine_directory 'off'
          set -g @rose_pine_show_current_program 'off'
          set -g @rose_pine_show_pane_directory 'on'
          set -g @rose_pine_hostname_icon '󰒋 '
          set -g @rose_pine_status_left_prepend_section '#{tmux_mode_indicator}'
        '';
      }
      mode-indicator
      sensible
      yank
    ];
    extraConfig = ''
      set -sg escape-time 100
      unbind c
      unbind p
      bind n new-window
      bind p split-window -h
      bind-key Right next-window
      bind-key Left previous-window
      bind -n End send-key C-e
      bind -n Home send-key C-a
    '';
  };
}
