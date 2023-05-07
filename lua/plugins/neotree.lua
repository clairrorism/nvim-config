return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  priority = 550,
  opts = {
    source_selector = {
      statusline = false,
      winbar = false,
    },
    sources = {
      "filesystem",
      "document_symbols",
    }
  },
  keys = {
    { "<leader>fe", "<cmd>Neotree float<cr>", desc = "Open file explorer." },
    { "<leader>lo", "<cmd>Neotree document_symbols<cr>", desc = "Toggle code outline window." },
  }
}
