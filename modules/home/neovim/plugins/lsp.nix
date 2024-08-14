{ lib, namespace, ... }:
with lib.${namespace};
{
  programs.nixvim.plugins.lsp = enabled // {
    inlayHints = true;
    servers = {
      astro = enabled;
      biome = enabled;
      cmake = enabled;
      cssls = enabled;
      dartls = enabled;
      elixirls = enabled;
      docker-compose-language-service = enabled;
      gleam = enabled;
      golangci-lint-ls = enabled;
      gopls = enabled;
      graphql = enabled;
      helm-ls = enabled;
      html = enabled;
      jsonls = enabled;
      kotlin-language-server = enabled;
      lua-ls = enabled;
      marksman = enabled;
      nixd = enabled;
      prismals = enabled;
      ruff = enabled;
      rust-analyzer = enabled // {
        installCargo = true;
        installRustc = true;
      };
      sqls = enabled;
      svelte = enabled;
      tailwindcss = enabled;
      tsserver = enabled;
      volar = enabled;
      yamlls = enabled;
      zls = enabled;
    };
  };
}
