{
  config,
  pkgs,
  ...
}: let
  dots = pkgs.fetchFromGitHub {
    owner = "Yash-Garg";
    repo = "dotfiles";
    rev = "56c157a8c51749203f207c981830e6b693aa8872";
    sha256 = "sha256-uWvrdUEjzo1Gg6ILB3uzbdUA7ptco8twpKSlGCVyksA=";
  };
in {
  home.packages = with pkgs; [
    alejandra
    cachix
    curl
    delta
    direnv
    dnscontrol
    erdtree
    fd
    gh
    httpie
    hyperfine
    neofetch
    ookla-speedtest
    ripgrep
    scc
    unzip
    zip
  ];

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
