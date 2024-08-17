{ spicetify-nix, ... }: _final: prev: { spicetify = spicetify-nix.packages.${prev.system}.default; }
