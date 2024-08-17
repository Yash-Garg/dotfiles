{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib.${namespace};
{
  programs.direnv = enabled // {
    silent = true;
    # faster, persistent implementation of use_nix and use_flake
    nix-direnv = enabled // {
      package = pkgs.nix-direnv.override { nix = config.nix.package; };
    };

    # enable loading direnv in nix-shell nix shell or nix develop
    loadInNixShell = true;
  };
}
