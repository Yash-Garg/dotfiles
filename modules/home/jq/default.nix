{ lib, namespace, ... }: with lib.${namespace}; { programs.jq = enabled; }
