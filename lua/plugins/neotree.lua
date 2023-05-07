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
    { "<leader>fe", "<cmd>Neotree<cr>", desc = "Open file explorer." },
    { "<leader>lo", "<cmd>Neotree float document_symbols<cr>", desc = "Toggle code outline window." },
    { "<leader>O", "<cmd>Neotree focus<cr>", desc = "Focus file explorer." }
  }
}
