{pkgs, ...}: let
  dots = pkgs.fetchFromGitHub {
    owner = "Yash-Garg";
    repo = "dotfiles";
    rev = "49eef8b015585ceba030614a424bec17469caba2";
    sha256 = "sha256-PSIxJbx0QBTFgleb7dzxrI++pth/X3ZOwoN6lW9/TfI=";
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
