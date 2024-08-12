{
  config,
  pkgs,
  lib,
  inputs,
  namespace,
  ...
}:
with lib;
let
  cfg = config.${namespace}.desktop.stylix;
in
{
  options.${namespace}.desktop.stylix = {
    enable = mkEnableOption "Stylix profile for desktop machines";
  };

  config = mkIf cfg.enable {
    stylix = {
      autoEnable = false;
      enable = true;
      homeManagerIntegration.followSystem = true;
      image = ./background.png;
      base16Scheme = "${inputs.base16-schemes.outPath}/base16/catppuccin-mocha.yaml";
      cursor = {
        package = pkgs.rose-pine-cursor;
        name = "BreezeX-RosePine-Linux";
        size = 28;
      };
      fonts = {
        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-color-emoji;
        };
        monospace = {
          name = "JetBrainsMono Nerd Font Mono Regular";
          package = pkgs.nerdfonts;
        };
        sansSerif = {
          name = "Roboto Regular";
          package = pkgs.roboto;
        };
        serif = {
          name = "Roboto Serif 20pt Regular";
          package = pkgs.roboto-serif;
        };
        sizes = {
          applications = 12;
          terminal = 10;
        };
      };
      polarity = "dark";
      targets = {
        chromium.enable = true;
        nixos-icons.enable = true;
      };
    };

    snowfallorg.users.yash.home.config = {
      stylix.targets = {
        alacritty.enable = true;
        bat.enable = true;
        btop.enable = true;
        fzf.enable = true;
        kitty.enable = true;
        vesktop.enable = true;
        wezterm.enable = true;
        yazi.enable = true;
        zellij.enable = true;
      };
    };
  };
}
