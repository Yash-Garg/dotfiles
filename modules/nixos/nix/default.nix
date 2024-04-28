{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
      persistent = true;
    };
    optimise.automatic = true;

    package = pkgs.nixUnstable;

    registry = lib.mapAttrs (_: v: {flake = v;}) inputs;

    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    extraOptions = ''
      keep-outputs = true
      warn-dirty = false
      keep-derivations = true
    '';
    settings = {
      accept-flake-config = true;
      allowed-users = ["@wheel"];
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [
        "auto-allocate-uids"
        "ca-derivations"
        "cgroups"
        "flakes"
        "nix-command"
        "recursive-nix"
      ];
      flake-registry = "/etc/nix/registry.json";
      http-connections = 50;
      keep-going = true;
      log-lines = 20;
      max-jobs = "auto";
      sandbox = true;
      trusted-users = ["root" "@wheel"];
      use-cgroups = true;
      warn-dirty = false;

      trusted-substituters = [
        "https://cache.garnix.io"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];

      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };
}
