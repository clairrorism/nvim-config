return {
  "folke/zen-mode.nvim",
  opts = {
    plugins = {
      kitty = {
        enabled = os.getenv("TERM") == "xterm-kitty",
        font = "+3",
      }
    }
  },
  keys = {
    { "<leader>zm", "<cmd>ZenMode<cr>", desc = "Toggle zen mode." }
  },
}