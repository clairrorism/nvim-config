return {
    "folke/tokyonight.nvim",
    opts = {
        style = "moon",
        sidebars = { "trouble", "terminal" },
    },
    priority = 1000,
    lazy = false,
    init = function() vim.cmd[[colorscheme tokyonight]] end
}
