_: {
  nix.extraOptions = ''
    experimental-features = nix-command flakes repl-flake
    ssl-cert-file = /private/etc/ssl/cert.pem
    extra-nix-path = nixpkgs=flake:nixpkgs
  '';

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
}
