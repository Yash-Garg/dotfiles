{ paisa, ... }: _final: prev: { paisa-cli = paisa.packages.${prev.system}.default; }
