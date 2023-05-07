-- vim.api.nvim_create_autocmd("BufWritePost", { callback = vim.lsp.format })

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.html", "*.tsx", "*.jsx"},
  callback = function ()
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
  end
})