local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "nvim-lua/plenary.nvim" },
  { "MunifTanjim/nui.nvim" },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
      -- options
    },
  }
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    keys = function()
      local good, ts = pcall(require, "telescope.builtin")
      if good then
        return {
          { "<leader>fd", ts.live_grep,  desc = "Search for string in CWD" },
          { "<leader>of", ts.old_files,  desc = "List old files" },
          { "<leader>lR", ts.references, desc = "List references to item" },
          { "<leader>bl", ts.buffers,    desc = "List open buffers" },
        }
      else
        return nil
      end
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      on_highlights = function(hl, c)
        local prompt = "#2d3149"
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = prompt,
        }
        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
      end,
    },
    init = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      { "windwp/nvim-ts-autotag" },
    },
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "html", "css", "rust", "markdown" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "tokyonight",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_x = { "hostname" },
        lualine_y = { "encoding", "fileformat", "filetype" },
        lualine_z = { "progress", "location" },
      },
    },
  },
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = "tokyonight"
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { { "<leader>D", "<cmd>TroubleToggle<cr>", desc = "Toggle diagnostics panel" } },
  },
  {
    "williamboman/mason.nvim",
    opts = {},
    priority = 900,
    lazy = false,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local nls = require("null-ls")

      local fmt = nls.builtins.formatting
      local diag = nls.builtins.diagnostics

      nls.setup({
        sources = {
          nls.builtins.code_actions.eslint_d,
          diag.clang_check,
          diag.flake8,
          diag.eslint_d,
          diag.mdl,
          -- diag.selene,
          fmt.clang_format,
          fmt.csharpier,
          fmt.eslint_d,
          fmt.gofumpt,
          fmt.stylelint,
          fmt.stylua,
          fmt.zigfmt,
          nls.builtins.hover.dictionary,
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      automatic_installation = true,
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/luasnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-emoji",
      "Saecki/crates.nvim",
      "FelipeLema/cmp-async-path",
      "hrsh7th/cmp-buffer",
      "max397574/cmp-greek",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-cmdline",
    },
    lazy = false,
    priority = 100,
    config = function()
      local cmp = require("cmp")
      local map = cmp.mapping

      local function src(n)
        return { name = n }
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = map.preset.insert({
          ["<S-Down>"] = map.scroll_docs(4),
          ["<S-Up>"] = map.scroll_docs(-4),
          ["<Down>"] = map.select_next_item(),
          ["<Up>"] = map.select_prev_item(),
          ["<Return>"] = map.confirm({ select = true }),
          ["<S-Right>"] = map.abort(),
        }),
        sources = cmp.config.sources({
          src("nvim_lsp"),
          src("luasnip"),
          { name = "async_path", trigger_characters = { "/", "~" } },
          src("nvim_lsp_signature_help"),
        }, {
          src("buffer"),
        }),
      })

      cmp.setup.cmdline(":", {
        mapping = map.preset.cmdline(),
        sources = cmp.config.sources({
          src("async_path"),
          src("cmdline"),
        }),
      })

      cmp.setup.filetype("toml", {
        sources = cmp.config.sources({
          src("nvim_lsp"),
          src("crates"),
        }),
      })

      cmp.setup.filetype("markdown", {
        sources = cmp.config.sources({
          src("greek"),
          src("emoji"),
          src("buffer"),
        }),
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "neovim/nvim-lspconfig",
    keys = {
      { "<leader>gd", vim.lsp.buf.definition,     desc = "Go to definition" },
      { "<leader>ha", vim.lsp.buf.hover,          desc = "Display hover actions" },
      { "<leader>ca", vim.lsp.buf.code_action,    desc = "Display code actions" },
      { "<leader>lr", vim.lsp.buf.rename,         desc = "Rename symbol under cursor" },
      { "<leader>gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
    },
    config = function()
      local lspc = require("lspconfig")
      local opt = { capabilities = require("cmp_nvim_lsp").default_capabilities() }
      lspc.pyright.setup(opt)
      lspc.tsserver.setup(opt)
      lspc.zls.setup(opt)
      lspc.clangd.setup(opt)
      lspc.cssmodules_ls.setup(opt)
      lspc.csharp_ls.setup(opt)
      lspc.lua_ls.setup(opt)
      lspc.rust_analyzer.setup(opt)
      lspc.dartls.setup(opt)
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = true,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        indicator = "underline",
        separator_style = "slant",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "Center",
          },
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = true,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    opts = {
      source_selector = {
        winbar = true,
        sources = {
          { source = "filesystem", display_name = " 󰉓 Files " },
          { source = "document_symbols", display_name = " 󰈮 Symbols " },
        },
      },
    },
    keys = {
      { "<leader>fe", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
      { "<leader>ff", "<cmd>Neotree focus<cr>",  desc = "Focus file explorer" },
    },
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 100,
      },
      plugins = {
        kitty = {
          enabled = true,
          font = "+3",
        },
      },
    },
    keys = {
      { "<leader>vz", "<cmd>ZenMode<cr>", desc = "Toggle zen mode" },
    },
  },
  "numToStr/Comment.nvim",
})
