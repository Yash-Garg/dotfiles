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
          "filename"
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
            padding = {
              left = 2;
              right = 1;
            };
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
        cyan   = '#79dac8',
        black  = '#080808',
        white  = '#c6c6c6',
        red    = '#ff5189',
        violet = '#d183e8',
        grey   = '#303030',
      }

      local bubbles_theme = {
        normal = {
          a = { fg = colors.black, bg = colors.violet },
          b = { fg = colors.white, bg = colors.grey },
          c = { fg = colors.white },
        },

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
