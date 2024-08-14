{ lib, namespace, ... }:
with lib.${namespace};
{
  programs.nixvim.plugins.bufferline = enabled // {
    hover.enabled = true;
    indicator.style = null;
    mode = "buffers";
    separatorStyle = "padded_slope";
    themable = true;
  };
}
