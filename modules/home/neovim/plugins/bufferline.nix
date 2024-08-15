{ lib, namespace, ... }:
with lib.${namespace};
{
  programs.nixvim.plugins.bufferline = disabled // {
    settings.options = {
      hover.enabled = true;
      indicator.style = null;
      mode = "buffers";
      separatorStyle = "slant";
      themable = true;
    };
  };
}
