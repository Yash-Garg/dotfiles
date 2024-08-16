{ lib, namespace, ... }:
with lib.${namespace};
{
  imports = [
    ./alpha.nix
    ./bufferline.nix
    ./completion.nix
    ./devicons.nix
    ./lsp.nix
    ./lualine.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  programs.nixvim.plugins = {
    comment = enabled;
    gitsigns = enabled // {
      settings = {
        current_line_blame = true;
      };
    };
    luasnip = enabled;
    nix = enabled;
    nix-develop = enabled;
    nvim-autopairs = enabled;
    nvim-tree = enabled;
    todo-comments = enabled;
    which-key = enabled;
  };
}
