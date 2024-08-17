{ lib, namespace, ... }: with lib.${namespace}; { programs.home-manager = enabled; }
