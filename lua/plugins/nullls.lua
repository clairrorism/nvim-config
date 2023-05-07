return {
  "jay-babu/mason-null-ls.nvim",
  opts = {
    automatic_installation = true,
  },
  dependencies = {
    {
      "jose-elias-alvarez/null-ls.nvim",
      opts = function ()
        local nls = require("null-ls").builtins

        return {
          sources = {
            nls.formatting.stylua,
            nls.formatting.autopep8,
            nls.formatting.cbfmt,
            nls.formatting.clang_format,
            nls.formatting.cmake_format,
            nls.formatting.csharpier,
            nls.formatting.gofumpt,
            nls.formatting.json_tool,
            nls.formatting.mdformat,
            nls.formatting.qmlformat,
            nls.formatting.rustywind,
            nls.formatting.shfmt,
            nls.formatting.standardts,
            nls.formatting.taplo,
            nls.formatting.tidy,
            nls.formatting.yamlfmt,
            nls.formatting.zigfmt,
            nls.hover.dictionary,
            nls.completion.luasnip,
            nls.diagnostics.clang_check,
            require("typescript.extensions.null-ls.code-actions"),
          }
        }
      end
    }
  }
}