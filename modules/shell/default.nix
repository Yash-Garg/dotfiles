{
  config,
  pkgs,
  ...
}: let
  dots = pkgs.fetchFromGitHub {
    owner = "Yash-Garg";
    repo = "dotfiles";
    rev = "b4f01ac43ae8d648d89a358e705fcb62b895d0de";
    sha256 = "sha256-IduhAcVSsNSNhGVxVagXvS+uJ8FUxlDvZb4cU9jQ16k=";
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

    "functions" = {
      executable = true;
      source = "${dots}/scripts/functions";
    };
  };
}
