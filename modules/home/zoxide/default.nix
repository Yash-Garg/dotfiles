{ lib, namespace, ... }: with lib.${namespace}; { programs.zoxide = enabled; }
