{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    asciinema
    aria
    cachix
    charm-freeze
    curl
    delta
    direnv
    dnscontrol
    du-dust
    erdtree
    fd
    fzf-git-sh
    gh
    httpie
    hyperfine
    ijq
    just
    jq
    ookla-speedtest
    ripgrep
    scc
    unzip
    zip
  ];
}
