return {
  "Zeioth/hot-reload.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  event = "BufEnter",
  opts = function()
    local config_dir = vim.fn.stdpath("config") .. "/lua/lekha/"
    return {
      -- Files to be hot-reloaded when modified.
      reload_files = {
        config_dir .. "setting.lua",
      },
      -- Things to do after hot-reload trigger.
      reload_callback = function()
        vim.cmd(":silent! colorscheme " .. vim.g.default_colorscheme) -- nvim     colorscheme reload command.
        vim.cmd(":silent! doautocmd ColorScheme")                     -- heirline colorscheme reload event.
      end
    }
  end
}
