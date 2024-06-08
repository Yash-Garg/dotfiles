{pkgs, ...}: {
  stylix.autoEnable = false;
  stylix.image = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/isabelroses/nixos-artwork/e0cf0eb23/wallpapers/nix-wallpaper-nineish-catppuccin-mocha-alt.png";
    sha256 = "sha256-ThDrZIJIyO2DdIW41sV6iYyCNhM89cwHr8l6DAfbXjI=";
  };
}
