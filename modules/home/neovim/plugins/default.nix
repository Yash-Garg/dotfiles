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
    ./nvim-tree.nix
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
    nix = enabled;
    nix-develop = enabled;
    nvim-autopairs = enabled;
    todo-comments = enabled;
    tmux-navigator = enabled;
    which-key = enabled;
  };
}
