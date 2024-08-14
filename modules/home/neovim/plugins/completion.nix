{ lib, namespace, ... }:
with lib.${namespace};
{
  programs.nixvim = {
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
            "<C-Space>" = "cmp.mapping.complete {}";
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
            "<S-Tab>" = "cmp.mapping(function(fallback)
								if cmp.visible() then
									cmp.select_prev_item()
								elseif luasnip.locally_jumpable(-1) then
									luasnip.jump(-1)
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
            { name = "nvim_lsp"; }
            { name = "nvim_lua"; }
            { name = "cmdline"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };
      cmp-buffer = enabled;
      cmp-nvim-lsp = enabled;
      cmp-nvim-lua = enabled;
      cmp-path = enabled;
      luasnip = enabled;
      cmp_luasnip = enabled;
    };

    extraConfigLuaPre = ''
      local luasnip = require("luasnip")
      luasnip.config.setup({})
    '';
  };
}
