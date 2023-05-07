return {
  "simrat39/rust-tools.nvim",
  ft = { "rust" },
  --[[ keys = function ()
    local rt = require("rust-tools")

    local rust_menu = function ()
      local action_map = {
        ["Runnables"] = rt.runnables.runnables,
        ["Jump to Parent Module"] = rt.parent_module.parent_module,
        ["Expand Macro"] = rt.expand_macro.expand_macro,
        ["Open Cargo.toml"] = rt.open_cargo_toml.open_cargo_toml,
        ["Enable Inlay Hints"] = rt.inlay_hints.enable,
        ["Disable Inlay Hints"] = rt.inlay_hints.disable,
      }

      vim.ui.select(
        { "Runnables", "Jump to Parent Module", "Expand Macro", "Open Cargo.toml", "Enable Inlay Hints", "Disable Inlay Hints" },
        { prompt = "Rust Tools" },
        function (sel)
          action_map[sel]()
        end
      )
    end

    return {
      { "<leader>mr", rust_menu, desc = "Rust tools menu." },
      { "<leader>mu", function () rt.move_item.move_item(true) end, desc = "Move item up." },
      { "<leader>md", function () rt.move_item.move_item(false) end, desc = "Move item down." },
    }
  end ]]
}
