{
  config,
  pkgs,
  ...
}: {
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
    tmux
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

    ".gitconfig".source =
      pkgs.fetchFromGitHub {
        owner = "Yash-Garg";
        repo = "dotfiles";
        rev = "b298edde1266edad3a8125ef147904ba5505ce73";
        sha256 = "sha256-tuIeZlPb97wAN71i+JfQ5EohniiNMcuI/enzrkY+mAI=";
      }
      + "/.gitconfig";

    "functions.sh" = {
      executable = true;
      source =
        pkgs.fetchFromGitHub {
          owner = "Yash-Garg";
          repo = "dotfiles";
          rev = "b298edde1266edad3a8125ef147904ba5505ce73";
          sha256 = "sha256-tuIeZlPb97wAN71i+JfQ5EohniiNMcuI/enzrkY+mAI=";
        }
        + "/functions.sh";
    };
  };
}
