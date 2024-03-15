{pkgs, ...}: let
  dots = pkgs.fetchFromGitHub {
    owner = "Yash-Garg";
    repo = "dotfiles";
    rev = "b3594ce442546d6138ab7a5e9fe0e80e9de39062";
    sha256 = "sha256-7p4613+zE+M4JFFUKIIgQfx7IcOWNSYgl/96TiyuYF0=";
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
