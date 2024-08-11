{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    homeManagerIntegration.followSystem = true;
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/l8/wallhaven-l8x38r.jpg";
      sha256 = "sha256-+fAcJv+KssqefsjRToDHybJpk1NG9uf4BRebeHTFq+g=";
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
}
