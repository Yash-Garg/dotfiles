{ lib, namespace, ... }:
with lib.${namespace};
{
  programs.nixvim = {
    plugins.nvim-tree = enabled // {
      git = enabled;
      hijackCursor = true;
      renderer = {
        addTrailing = true;
        groupEmpty = true;

        icons = {
          gitPlacement = "signcolumn";
          modifiedPlacement = "signcolumn";
        };
      };
      sortBy = "case_sensitive";
    };

    keymaps = [
      {
        mode = [ "n" ];
        key = "<leader>t";
        action = "<cmd>NvimTreeToggle<cr>";
        options = {
          desc = "Toggle file tree";
        };
      }
    ];
  };
}
