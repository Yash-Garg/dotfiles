{ nh_darwin, ... }: _final: prev: { nh-darwin = nh_darwin.packages.${prev.system}.default; }
