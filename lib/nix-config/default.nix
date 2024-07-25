{
  mkNixConfig =
    {
      pkgs,
      lib,
      inputs,
    }:
    {
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
        allowed-users = [ "yash" ];
        auto-optimise-store = false;
        builders-use-substitutes = true;
        flake-registry = "/etc/nix/registry.json";
        http-connections = 50;
        keep-going = true;
        log-lines = 20;
        max-jobs = "auto";
        sandbox = true;
        trusted-users = [
          "root"
          "@wheel"
        ];
        warn-dirty = false;

        trusted-substituters = [
          "https://yash-garg.cachix.org"
          "https://cache.nixos.org"
          "https://raspberry-pi-nix.cachix.org"
        ];

        trusted-public-keys = [
          "yash-garg.cachix.org-1:sHcKOvVej+RlINvt4XVAOE/Cnho3hnrHHRv0uq1u7Xs="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "raspberry-pi-nix.cachix.org-1:WmV2rdSangxW0rZjY/tBvBDSaNFQ3DyEQsVw8EvHn9o="
        ];
      };
    };
}
