{ lib, namespace, ... }:
with lib.${namespace};
{
  programs.nixvim = {
    plugins.telescope = enabled // {
      extensions = {
        file-browser = enabled;
        fzf-native = enabled;
      };
      settings = {
        defaults = {
          layout_config = {
            horizontal = {
              prompt_position = "top";
            };
          };
          sorting_strategy = "ascending";
        };
      };
      keymaps = {
        "<leader>a" = {
          action = "find_files";
          options = {
            desc = "Find project files";
          };
        };
        "<leader>/" = {
          action = "live_grep";
          options = {
            desc = "Grep (root dir)";
          };
        };
        "<leader>h" = {
          action = "command_history";
          options = {
            desc = "Command History";
          };
        };
        "<space><space>" = {
          action = "buffers";
          options = {
            desc = "+buffer";
          };
        };
        "<leader>p" = {
          action = "git_files";
          options = {
            desc = "Search git files";
          };
        };
        "<leader>gc" = {
          action = "git_commits";
          options = {
            desc = "Commits";
          };
        };
        "<leader>gs" = {
          action = "git_status";
          options = {
            desc = "Status";
          };
        };
        "<leader>f" = {
          action = "current_buffer_fuzzy_find";
          options = {
            desc = "Buffer";
          };
        };
        "<leader>sD" = {
          action = "diagnostics";
          options = {
            desc = "Workspace diagnostics";
          };
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>fe";
        action = "<cmd>Telescope file_browser<cr>";
        options = {
          desc = "File browser";
        };
      }
    ];
  };
}
