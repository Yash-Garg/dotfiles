{
  config,
  pkgs,
  ...
}: let
  dots = pkgs.fetchFromGitHub {
    owner = "Yash-Garg";
    repo = "dotfiles";
    rev = "f53fcb560b69dfca21e882c12e28e72b633c728a";
    sha256 = "sha256-n+lxqiltWf6G8vmptuvODJXY4XPzcuIuFYz3dS4WIyY=";
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
