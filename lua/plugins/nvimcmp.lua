return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "FelipeLema/cmp-async-path",
    "hrsh7th/cmp-cmdline",
    "f3fora/cmp-spell",
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  opts = function()
    local cmp = require("cmp")
    return {
      completion = { completeopt = "menu,menuone,noinsert" },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<Down>"] = cmp.mapping.scroll_docs(4),
        ["<Up>"] = cmp.mapping.scroll_docs(-4),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "async_path" },
        {
          name = "spell",
          options = {
            enable_in_context = function()
              return cmp.config.context.in_syntax_group("Comment") or cmp.config.context.in_syntax_group("String")
            end
          }
        }
      }
    }
    -- cmp.setup.cmdline(":", {
    --   sources = cmp.config.sources({
    --     { name = "async_path" },
    --     { name = "cmdline" },
    --   })
    -- })
    -- cmp.setup.filetype("markdown", {
    --   sources = {
    --     { name = "nvim_lsp" },
    --     { name = "spell" },
    --     { name = "buffer" },
    --   }
    -- })
  end,
}
