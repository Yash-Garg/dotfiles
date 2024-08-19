{ lib, namespace, ... }:
with lib.${namespace};
{
  programs.nixvim = {
    autoCmd = [
      {
        # Show diagnostic window when cursor is over warning/error
        event = [
          "CursorHold"
          "CursorHoldI"
        ];
        group = "float_diagnostic_cursor";
        callback.__raw = ''
          function()
          	vim.diagnostic.open_float(
          		nil,
          		{ focus = false, scope = "cursor" }
          	)
          end
        '';
      }
    ];

    autoGroups = {
      float_diagnostic_cursor = { };
    };

    plugins = {
      cmp = enabled // {
        autoEnableSources = false;
        settings = {
          snippet = {
            expand = ''
              function(args)
              	luasnip.lsp_expand(args.body)
              end
            '';
          };

          completion = {
            completeopt = "menu,menuone,noinsert";
          };

          mapping = {
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm {
								behavior = cmp.ConfirmBehavior.Replace,
								select = true,
							}";
            "<Tab>" = "cmp.mapping(function(fallback)
								if cmp.visible() then
									cmp.select_next_item()
								elseif luasnip.expand_or_locally_jumpable() then
									luasnip.expand_or_jump()
								else
									fallback()
								end
							end, { 'i', 's' })";
          };

          window.documentation.border = [
            "╭"
            "─"
            "╮"
            "│"
            "╯"
            "─"
            "╰"
            "│"
          ];

          sources = [
            { name = "buffer"; }
            { name = "luasnip"; }
            { name = "nvim_lsp"; }
            { name = "nvim_lsp_signature_help"; }
            { name = "nvim_lua"; }
            { name = "path"; }
          ];
        };
      };

      cmp-buffer = enabled;
      cmp-nvim-lsp = enabled;
      cmp-nvim-lsp-signature-help = enabled;
      cmp-nvim-lua = enabled;
      cmp-path = enabled;
      cmp_luasnip = enabled;
      friendly-snippets = enabled;
      luasnip = enabled // {
        settings = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };
      };
      lspkind = enabled // {
        cmp = enabled // {
          ellipsisChar = "...";
          maxWidth = 30;
          menu = {
            buffer = "[Buffer]";
            nvim_lsp = "[LSP]";
            luasnip = "[LuaSnip]";
            nvim_lua = "[Lua]";
            path = "[Path]";
          };
        };
      };
      lsp-status = enabled;
    };

    extraConfigLuaPre = ''
      local luasnip = require("luasnip")
      luasnip.config.setup({})
    '';
  };
}
