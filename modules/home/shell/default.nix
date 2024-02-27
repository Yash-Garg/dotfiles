{pkgs, ...}: let
  dots = pkgs.fetchFromGitHub {
    owner = "Yash-Garg";
    repo = "dotfiles";
    rev = "d3948dbe6bc186a610c8d1c8d8a2052f1140d364";
    sha256 = "sha256-94rPzQNkao+fmWhOIzOhsk3gJC2zM7xMGav3ACfVOHY=";
  };
in {
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
