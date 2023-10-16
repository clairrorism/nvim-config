local o = vim.opt

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
