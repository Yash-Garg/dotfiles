deploy:
  nixos-rebuild switch --flake . --use-remote-sudo

debug:
  nixos-rebuild switch --flake . --use-remote-sudo --show-trace --verbose

update:
  nix flake update

history:
  nix profile history --profile /nix/var/nix/profiles/system

gc:
  sudo nix-collect-garbage --delete-old

darwin:
  nix run nix-darwin -- switch --flake .

darwin-check:
  nom build .#darwinConfigurations.trinity.system

topology sys:
  nom build .#topology.{{sys}}.config.output

eval conf:
  nix eval .#{{conf}} --apply builtins.attrNames --json

template name path:
  nix flake new --template .#templates.{{name}} {{path}}

check flake:
  nom build .#nixosConfigurations.{{flake}}.config.system.build.toplevel

test sys:
  nix run github:nix-community/nixos-anywhere -- --flake .#{{sys}} --vm-test
