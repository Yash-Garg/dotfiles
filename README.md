# Hosts

A list of all hosts currently in use by me.

[![built with garnix](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fgarnix.io%2Fapi%2Fbadges%2Fyash-garg%2Fdotfiles%3Fbranch%3Dstable)](https://garnix.io)

- `cosmos`: Raspberry Pi 5 running NixOS, hosting home services.
- `nebula`: Development and testing environment using WSL2 on Windows 11.
- `nova`: Main home machine running NixOS for daily use.
- `trinity`: Main work machine, a company-provided MacBook Pro with an M3 Pro chip.
- `vortex`: Oracle Cloud VM running NixOS for development and as a remote builder.

# Usage as a flake

[![FlakeHub](https://img.shields.io/endpoint?url=https://flakehub.com/f/Yash-Garg/dotfiles/badge)](https://flakehub.com/flake/Yash-Garg/dotfiles)

Add dotfiles to your `flake.nix`:

```nix
{
  inputs.dotfiles.url = "https://flakehub.com/f/Yash-Garg/dotfiles/*.tar.gz";

  outputs = { self, dotfiles }: {
    # Use in your outputs
  };
}

```
