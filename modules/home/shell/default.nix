{ pkgs, ... }:
let
  # dots = pkgs.fetchFromGitHub {
  #   owner = "Yash-Garg";
  #   repo = "dotfiles";
  #   rev = "2cc6fc0448caf6f26c10932d3e5dfb9b47aea79f";
  #   sha256 = "sha256-WSaQefU5z1Phix5Qj5y86KFTEYDU6+rpPZdlCyxAvvk=";
  # };
  dots = ./../../..;
in
{
  home.file = {
    ".nanorc".text = ''
      set tabsize 4
      set autoindent
      set softwrap
      set nonewlines
      set smarthome
    '';

    ".gitconfig".source = "${dots}/.gitconfig";

    ".functions" = {
      executable = true;
      source = "${dots}/scripts/functions";
    };

    ".aliases" = {
      executable = true;
      source = "${dots}/scripts/aliases";
    };

    ".shell-init" = {
      executable = true;
      source = "${dots}/scripts/shell-init";
    };
  };
}
