{ agenix, ... }: _final: prev: { agenix = agenix.packages.${prev.system}.default; }
