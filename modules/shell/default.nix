{
  config,
  pkgs,
  ...
}: let
  dots = pkgs.fetchFromGitHub {
    owner = "Yash-Garg";
    repo = "dotfiles";
    rev = "130eec298069c126392fc06005e36c06e07a9d9d";
    sha256 = "sha256-Tx258ojxC8/GC1oHUwdBhUTHGqKPcbjuOYKCbnTiFvc=";
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
