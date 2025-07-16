{ pkgs, catppuccin, ... }:
{
  programs.nixvim = {
    enable = true;
    #defaultEditor = true;
    #viAlias = true;
    #vimAlias = true;

    colorschemes.catppuccin.enable = true;

    diagnostic.settings = {
      virtual_lines.current_line = true;
    };

    # Basic options
    opts = {
      encoding = "utf-8";
      compatible = false;
      ignorecase = true;
      smartcase = true;
      number = true;
      foldmethod = "syntax";
      foldenable = false;
      foldlevel = 2;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
    };

    # File type settings
    autoCmd = [
      {
        event = "FileType";
        pattern = "sql";
        command = "setlocal shiftwidth=2 tabstop=2";
      }
    ];

    # Global variables
    globals = {
      markdown_folding = 1;
      python_highlight_all = 1;
      tex_flavor = "latex";
      latex_to_unicode_auto = 1;
      slime_target = "tmux";
      slime_python_ipython = 1;
    };

    # Plugins
    plugins = {
      lualine.enable = true;
      #ale.enable = true;
      #better-whitespace.enable = true;
      commentary.enable = true;
      #dispatch.enable = true;
      #easymotion.enable = true;
      fugitive.enable = true;
      fzf-lua.enable = true;
      markdown-preview.enable = true;
      #nerdtree.enable = true;
      vim-surround.enable = true;
      #supertab.enable = true;
      #tabular.enable = true;
      which-key.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          mapping = {
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
          snippet.expand = "luasnip";
          sources = [
            { name = "copilot"; }
            { name = "nvim_lsp"; }
            { name = "async_path"; }
            { name = "buffer"; }
            { name = "luasnip"; }
          ];
        };
        filetype = {
          python = {
            sources = [
              { name = "nvim_lsp"; priority = 1000; }
              { name = "copilot"; priority = 900; }
              { name = "luasnip"; priority = 800; }
              { name = "treesitter"; priority = 700; }
              { name = "buffer"; priority = 600; }
              { name = "calc"; priority = 500; }
              { name = "async_path"; priority = 400; }
            ];
          };
          sql = {
            sources = [
              { name = "nvim_lsp"; priority = 1000; }
              { name = "copilot"; priority = 900; }
              { name = "treesitter"; priority = 800; }
              { name = "buffer"; priority = 700; }
              { name = "async_path"; priority = 600; }
              { name = "calc"; priority = 500; }
            ];
          };
          markdown = {
            sources = [
              { name = "copilot"; priority = 1000; }
              { name = "luasnip"; priority = 900; }
              { name = "buffer"; priority = 800; }
              { name = "spell"; priority = 700; }
              { name = "emoji"; priority = 600; }
              { name = "dictionary"; priority = 500; }
              { name = "calc"; priority = 400; }
              { name = "async_path"; priority = 300; }
            ];
          };
          sh = {
            sources = [
              { name = "copilot"; priority = 1000; }
              { name = "buffer"; priority = 900; }
              { name = "treesitter"; priority = 800; }
              { name = "async_path"; priority = 700; }
              { name = "calc"; priority = 600; }
            ];
          };
          tex = {
            sources = [
              { name = "latex_symbols"; priority = 1000; }
              { name = "copilot"; priority = 900; }
              { name = "luasnip"; priority = 800; }
              { name = "buffer"; priority = 700; }
              { name = "treesitter"; priority = 600; }
              { name = "spell"; priority = 500; }
              { name = "async_path"; priority = 400; }
            ];
          };
        };
      };
      luasnip.enable = true;
      copilot-lua = {
        enable = true;
        settings = {
          panel.enabled = false;
          suggestion.enabled = false;
        };
      };
      copilot-cmp.enable = true;
      copilot-chat = {
        enable = true;
        package = pkgs.vimPlugins.CopilotChat-nvim.overrideAttrs (old: {
          doCheck = false;
        });
      };

      # LSP configuration
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          terraformls.enable = true;
          nixd.enable = true;
          jedi_language_server.enable = true;
          pyright.enable = true;
          yamlls.enable = true;
          jsonls.enable = true;
          taplo.enable = true;
        };

      };

      # Treesitter configuration
      treesitter = {
        enable = true;
        settings.ensure_installed = "all";
      };

      # CoQ completion
      #coq = {
      #  enable = true;
      #  installArtifacts = true;
      #};
    };

    # Extra packages
    extraPackages = with pkgs; [
      sqlfluff
      terraform-ls
      nixd
      python3Packages.jedi-language-server
    ];

    extraConfigLua = ''
      vim.api.nvim_create_autocmd("VimEnter", {
        pattern = "*",
        callback = function()
          require("CopilotChat").setup({
            selector = require("fzf-lua").global_fzf,
          })
        end,
      })
    '';
  };

  home.packages = with pkgs; [
    gcc
  ];
}

