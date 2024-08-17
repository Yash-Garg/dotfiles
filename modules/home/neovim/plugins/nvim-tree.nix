{ lib, namespace, ... }:
with lib.${namespace};
{
  programs.nixvim = {
    plugins.nvim-tree = enabled // {
      autoClose = true;
      autoReloadOnWrite = true;
      disableNetrw = true;
      git = enabled // {
        ignore = false;
      };
      hijackCursor = true;
      modified = enabled;
      renderer = {
        addTrailing = true;
        groupEmpty = true;
        highlightGit = true;
        indentWidth = 2;
        icons.glyphs = {
          git = {
            staged = "";
            unstaged = "δ";
            untracked = "α";
            deleted = "D";
            renamed = "R";
          };
        };
      };
      sortBy = "case_sensitive";
      updateFocusedFile = enabled // {
        updateRoot = true;
      };
      view = {
        width = 30;
        side = "right";
        signcolumn = "yes";
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>t";
        action = ":NvimTreeToggle<CR>";
        options = {
          desc = "Toggle file tree";
        };
      }
    ];
  };
}
