{
  config,
  pkgs,
  ...
}: let
  dots = pkgs.fetchFromGitHub {
    owner = "Yash-Garg";
    repo = "dotfiles";
    rev = "6005c4e74e801743b1a81bc9c2bd0ad6510c4bc1";
    sha256 = "sha256-5wFk7KXTkRY3qvvfG3EQGlZAtvxPtHzHbb23VW5p0Xs=";
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
  };
}
