{
  pkgs,
  lib,
  namespace,
  ...
}:
with lib.${namespace};
{
  programs.nixvim.plugins = {
    treesitter = enabled // {
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        astro
        bash
        c
        cmake
        comment
        cpp
        css
        csv
        dart
        diff
        dockerfile
        editorconfig
        gitattributes
        gitcommit
        gitignore
        git_rebase
        gleam
        go
        gomod
        gosum
        graphql
        groovy
        haskell
        helm
        html
        javascript
        jq
        json
        jsonc
        just
        kdl
        kotlin
        lua
        make
        markdown
        markdown_inline
        meson
        ninja
        nix
        prisma
        python
        rust
        scss
        sql
        ssh_config
        svelte
        swift
        tmux
        toml
        tsx
        typescript
        vim
        vimdoc
        vue
        xml
        yaml
        zig
      ];
      nixvimInjections = true;
      settings.indent = enabled;
      settings.highlight = enabled;
    };

    treesitter-refactor = enabled // {
      highlightDefinitions = enabled;
    };
  };
}
