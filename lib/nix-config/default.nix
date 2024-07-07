{
  mkNixConfig = {
    pkgs,
    lib,
    inputs,
  }: {
    package = inputs.lix.packages.${pkgs.system}.default;

    generateNixPathFromInputs = true;
    generateRegistryFromInputs = true;
    linkInputs = true;

    extraOptions = ''
      keep-outputs = true
      warn-dirty = false
      keep-derivations = true
    '';

    settings = {
      accept-flake-config = true;
      allowed-users = ["yash"];
      auto-optimise-store = false;
      builders-use-substitutes = true;
      flake-registry = "/etc/nix/registry.json";
      http-connections = 50;
      keep-going = true;
      log-lines = 20;
      max-jobs = "auto";
      sandbox = true;
      trusted-users = ["root" "yash"];
      warn-dirty = false;

      experimental-features = lib.mkForce [
        "auto-allocate-uids"
        "ca-derivations"
        "cgroups"
        "flakes"
        "nix-command"
        "recursive-nix"
      ];

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
