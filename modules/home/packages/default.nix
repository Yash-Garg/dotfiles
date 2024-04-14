{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    cachix
    charm-freeze
    curl
    delta
    direnv
    dnscontrol
    erdtree
    fd
    gh
    httpie
    hyperfine
    ijq
    just
    jq
    neofetch
    ollama
    ookla-speedtest
    ripgrep
    scc
    unzip
    zip
  ];
}
