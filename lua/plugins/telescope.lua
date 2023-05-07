return {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.1',
  keys = function(plugin)
    return {
      { "<leader>of", "<cmd>Telescope old_files<cr>", desc = "List previously open files." },
      { "<leader>qf", "<cmd>Telescope quickfix<cr>", desc = "List quickfix items." },
    }
  end
}
