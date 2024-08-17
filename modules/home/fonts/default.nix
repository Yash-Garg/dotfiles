# NOTE: Run "fc-cache -rf" to update fonts cache.
{ lib, namespace, ... }: with lib.${namespace}; { fonts.fontconfig = enabled; }
