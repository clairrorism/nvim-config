local o = vim.opt

o.compatible = false
o.hidden = true
o.scrolloff = 10
o.sidescrolloff = 8
o.autowrite = true
o.clipboard = "unnamedplus"
o.completeopt = "menu,menuone,noselect"
o.confirm = true
o.expandtab = true
o.laststatus = 0
o.mouse = "a"
o.number = true
o.relativenumber = true
o.termguicolors = true
o.ignorecase = true
o.smartcase = true
o.cursorline = true
o.conceallevel = 3
o.list = true
o.tabstop = 4
o.softtabstop = -1
o.shiftwidth = 0
o.shiftround = true
o.smartindent = true
o.spelllang = { "en" }
o.signcolumn = "yes"
o.linebreak = true
o.wildmode = "longest:full,full"
o.wrap = false
o.listchars:append("eol:↴")
o.swapfile = false
o.timeout = true
o.timeoutlen = 400
vim.g.markdown_recommended_style = 0
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
o.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format({ async = true })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.md", "*.mdx", "*.txt" },
  callback = function()
    o.wrap = true
    o.spell = true
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.go",
  callback = function()
    o.expandtab = false
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.css", "*.scss", "*.sass", "*.html", "*.lua" },
  callback = function()
    o.tabstop = 2
  end,
})

vim.keymap.set("n", "<C-Right>", "<Cmd>bn<CR>", {silent = true})
vim.keymap.set("n", "<C-Left>", "<Cmd>bp<CR>", {silent = true})

require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    init = function()
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
    lazy = false,
  },
  { "folke/neodev.nvim", opts = {} },
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
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag"
    },
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "c",
          "lua",
          "rust",
          "css",
          "cpp",
          "go",
          "html",
          "python",
          "tsx",
          "typescript",
          "markdown_inline",
          "toml",
          "zig",
          "c_sharp",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
      })
    end,
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
          ["<Tab>"] = map.confirm({ select = true }),
          ["<Right>"] = map.abort(),
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
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          commonlisp = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          latex = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      show_current_context = true,
      show_current_context_start = true,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      theme = "tokyonight",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
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
    "folke/twilight.nvim",
    opts = {
      context = 8,
    },
    keys = {
      { "<leader>vt", "<cmd>Twilight<cr>", desc = "Toggle inactive code dimming" },
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
  {
    "ggandor/leap.nvim",
    keys = function()
      return {
        {
          "<C-s>",
          function()
            require("leap").leap({ target_windows = vim.fn.win_getid() })
          end,
          desc = "Quick movement thing",
        },
      }
    end,
  },
  {
    "stevearc/oil.nvim",
    keys = function()
      local good, oil = pcall(require, "oil")
      if good then
        return { { "<leader>fb", oil.open_float, desc = "Magic filesystem editor" } }
      else
        return nil
      end
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
    end,
  },
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,     -- use a classic bottom cmdline for search
        command_palette = true,   -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,       -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,   -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },

})
