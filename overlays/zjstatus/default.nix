{ zjstatus, ... }: _final: prev: { zjstatus = zjstatus.packages.${prev.system}.default; }
