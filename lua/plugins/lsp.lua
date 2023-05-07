return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    {
      "jose-elias-alvarez/typescript.nvim",
      ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    },
  },
  opts = {
    ensure_installed = { "tsserver", "unocss", "html", "marksman", "lua_ls", "pyright", "taplo", "zls" },

    -- Things that are usually installed with your toolchain
    automatic_installation = true,

    -- Auto setup
    handlers = {
      -- Default
      function (server)
        require("lspconfig")[server].setup({
          capabilities = require("cmp_nvim_lsp").default_capabilities()
        })
      end,

      -- Rust analyzer
      ["rust_analyzer"] = function ()
        require("rust-tools").setup({
          server = { capabilities = require("cmp_nvim_lsp").default_capabilities() }
        })
      end,

      ["tsserver"] = function ()
        require("typescript").setup({
          server = {
            capabilities = require("cmp_nvim_lsp").default_capabilities()
          }
        })
      end
    },
  },
  lazy = false,
  keys = function ()
    local nl = vim.lsp.buf
    local ts = require("telescope.builtin")

    local hover_action_handler = function ()
      if vim.bo.filetype == "rust" then
        require("rust-tools").hover_actions.hover_actions()
      else
        nl.hover()
      end
    end

    return {
      { "<leader>lh", hover_action_handler, desc = "LSP hover actions."},
      { "<leader>la", nl.code_action, desc = "LSP code actions."},
      { "<leader>lR", nl.rename, desc = "LSP symbol renaming." },
      { "<leader>lf", nl.format, desc = "LSP code formatting." },
      { "<leader>ls", nl.signature_help, desc = "Display signature of item" },
      { "<leader>ld", ts.lsp_definitions, desc = "Go to definition of item under cursor." },
      { "<leader>lt", ts.lsp_type_definitions, desc = "Go to definition of the type of the item under cursor." },
      { "<leader>li", ts.lsp_implementations, desc = "Go to implementation(s) of item under cursor." },
      { "<leader>lr", ts.lsp_references, desc = "List references to item under cursor." },
    }
  end,
  priority = 9,
}
