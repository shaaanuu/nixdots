{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    withRuby = false;
    withPython3 = false;

    initLua = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = "\\"

      -- Tab settings
      vim.opt.tabstop = 2 -- Number of spaces that a <Tab> counts for
      vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
      vim.opt.expandtab = true -- Use spaces instead of tabs

      -- Line numbers & Relative numbers
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.scrolloff = 8 -- Keep 8 lines above/below cursor

      -- Disable relative numbers in Insert mode
      vim.api.nvim_create_autocmd({ "InsertEnter" }, {
        callback = function()
          vim.opt.relativenumber = false
        end,
      })

      -- Re-enable relative numbers when leaving Insert mode
      vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        callback = function()
          vim.opt.relativenumber = true
        end,
      })

      -- Treesitter highlighting (grammars are built by nix, nothing to install)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    '';

    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons

      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = ''
          vim.cmd.colorscheme("catppuccin-mocha")

          -- Highlight settings
          vim.cmd([[
            highlight Normal guibg=NONE ctermbg=NONE
            highlight NormalNC guibg=NONE ctermbg=NONE
          ]])
        '';
      }

      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''require("gitsigns").setup()'';
      }

      {
        plugin = render-markdown-nvim;
        type = "lua";
        config = ''require("render-markdown").setup({})'';
      }

      {
        plugin = dashboard-nvim;
        type = "lua";
        config = ''
          require("dashboard").setup({
            theme = "doom",
            config = {
              header = {
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                     ]],
                [[       ████ ██████           █████      ██                     ]],
                [[      ███████████             █████                             ]],
                [[      █████████ ███████████████████ ███   ███████████   ]],
                [[     █████████  ███    █████████████ █████ ██████████████   ]],
                [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
                [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
                [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                       ]],
                [[                                                                       ]],
              },

              center = {
                { icon = "  ", desc = "Write Code", action = "ene | startinsert", key = "w" },
                { icon = "󰊢  ", desc = "Procrastinate", action = "!cowsay '5 more minutes...'", key = "p" },
                { icon = "󱎫  ", desc = "Touch Grass", action = "!echo '404: Grass not found'", key = "g" },
                {
                  icon = "  ",
                  desc = "rm -rf /",
                  action = "!echo '💀 Nice try, rootless'",
                  key = "r",
                },
                { icon = "󰩈  ", desc = "Exit Neovim", action = "qa", key = "q" },
              },

              footer = {
                "",
                "one must imagine sisyphus happy",
                "",
              },
            },
          })
        '';
      }

      (nvim-treesitter.withPlugins (p: with p; [
        bash
        dart
        javascript
        typescript
        tsx
        json
        lua
        nix
        markdown
        markdown_inline
      ]))
    ];
  };

  programs.zsh.shellAliases.snvim = "sudo -E nvim";
}
