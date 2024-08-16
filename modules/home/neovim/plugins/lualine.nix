{ lib, namespace, ... }:
with lib.${namespace};
{
  programs.nixvim = {
    plugins.lualine = enabled // {
      componentSeparators = {
        left = "│";
        right = "│";
      };
      globalstatus = true;
      inactiveSections = {
        lualine_a = [ "filename" ];
        lualine_b = [ ];
        lualine_c = [ ];
        lualine_x = [ ];
        lualine_y = [ ];
        lualine_z = [ "location" ];
      };
      sections = {
        lualine_a = [
          {
            name = "mode";
            padding = {
              left = 1;
              right = 2;
            };
            separator.left = "";
          }
        ];
        lualine_b = [
          {
            name = "filename";
            padding = {
              left = 2;
              right = 1;
            };
          }
          "branch"
        ];
        lualine_c = [ "%=" ];
        lualine_x = [ "" ];
        lualine_y = [
          "filetype"
          "progress"
        ];
        lualine_z = [
          {
            name = "location";
            separator.right = "";
          }
        ];
      };
      sectionSeparators = {
        left = "";
        right = "";
      };
      tabline = { };
      winbar = { };
    };

    extraConfigLuaPost = ''
      local colors = {
        blue   = '#80a0ff',
        cyan   = '#89dceb',
        black  = '#11111b',
        green  = '#a6e3a1',
        white  = '#cdd6f4',
        red    = '#f38ba8',
        violet = '#cba6f7',
        grey   = '#1e1e2e',
      }

      local bubbles_theme = {
        normal = {
          a = { fg = colors.black, bg = colors.violet },
          b = { fg = colors.white, bg = colors.grey },
          c = { fg = colors.white },
        },

        command = { a = { fg = colors.black, bg = colors.green } },
        insert = { a = { fg = colors.black, bg = colors.blue } },
        visual = { a = { fg = colors.black, bg = colors.cyan } },
        replace = { a = { fg = colors.black, bg = colors.red } },

        inactive = {
          a = { fg = colors.white, bg = colors.black },
          b = { fg = colors.white, bg = colors.black },
          c = { fg = colors.white },
        },
      }

      require('lualine').setup {
        options = { theme = bubbles_theme },
      }
    '';
  };
}
