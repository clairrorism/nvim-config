return {
  "stevearc/aerial.nvim",
  opts = {
    backends = { "lsp", "treesitter" },
    layout = {
      default_direction = "float",
    },
    close_automatic_events = { "unfocus" },
  },
  keys = {
    { "<leader>co", "<cmd>AerialNavOpen<cr>", desc = "Open code outline window." }
  }
}