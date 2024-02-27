{pkgs, ...}: {
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
    ollama
    ookla-speedtest
    ripgrep
    scc
    unzip
    zip
  ];
}
