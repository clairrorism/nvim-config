return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag"
    },
    opts = {
      ensure_installed = { "c", "rust", "lua", "json", "yaml", "markdown", "tsx", "toml", "css", "html", },
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      autotag = {
        enable = true,
      },
    },
    lazy = false,
    main = "nvim-treesitter.configs",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = true,
  },
}