{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
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
    ollama
    ookla-speedtest
    ripgrep
    scc
    unzip
    zip
  ];
}
