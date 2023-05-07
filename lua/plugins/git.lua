return {
  --[[ {
    "lewis6991/gitsigns.lua",
    config = true,
  }, ]]
  {
    "kdheepak/lazygit.nvim",
    config = true,
    keys = {
      { "<leader>gm", "<cmd>LazyGit<cr>", desc = "Open git menu." }
    }
  }
  -- I kinda just feel like using lazygit for now honestly
  --[[ {
    "tanvirtin/vgit.nvim",
    keys = function ()
      local vgit = require("vgit")

      local buf_menu = function ()
        local action_map = {
          ["Stage Buffer"] = vgit.buffer_stage,
          ["Unstage Buffer"] = vgit.buffer_unstage,
          ["Reset Buffer"] = vgit.buffer_reset,
          ["Buffer Blame Preview"] = vgit.buffer_blame_preview,
          ["Preview Buffer Diff"] = vgit.buffer_diff_preview,
        }

        vim.ui.select(
          { "Stage Buffer", "Unstage Buffer", "Reset Buffer", "Buffer Blame Preview", "Preview Buffer Diff" },
          { prompt = "Git Buffer Menu" },
          function (sel)
            action_map[sel]()
          end
        )
      end

      local project_menu = function ()
        local action_map = {
          ["Stage All Changes"] = vgit.project_stage_all,
          ["Unstage All Changes"] = vgit.project_unstage_all,
          ["Reset All Changes"] = vgit.project_reset_all,
          ["Preview Project Diff"] = vgit.project_diff_preview,
          ["Open Commit Menu"] = vgit.project_commit_preview,
        }

        vim.ui.select(
          { "Stage All Changes", "Unstage All Changes", "Reset All Changes", "Preview Project Diff", "Open Commit Menu" },
          { prompt = "Git Project Menu" },
          function (sel)
            action_map[sel]()
          end
        )
      end

      return {
        { "<leader>gb", buf_menu, desc = "Open git buffer menu." },
        { "<leader>gp", project_menu, desc = "Open git project menu." }
      }
    end
  } --]]
}
