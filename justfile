deploy:
  nixos-rebuild switch --flake . --use-remote-sudo

debug:
  nixos-rebuild switch --flake . --use-remote-sudo --show-trace --verbose

update:
  nix flake update

history:
  nix profile history --profile /nix/var/nix/profiles/system

repl:
  nix repl -f flake:nixpkgs

clean:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
  # garbage collect all unused nix store entries
  sudo nix-collect-garbage --delete-old

darwin:
  nix run nix-darwin -- switch --flake .

topology sys:
  nix build .#topology.{{sys}}.config.output

eval conf:
  nix eval .#{{conf}} --apply builtins.attrNames --json

template name:
  nix run github:Yash-Garg/dotfiles?dir=templates/{{name}}