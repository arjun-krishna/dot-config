return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = {
      ui_select = true,
    },
  },
  keys = {
    {
      "<leader>ff",
      function()
        Snacks.picker.files({ hidden = false })
      end,
      desc = "Find files",
    },
    {
      "<leader>fd",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config"), hidden = false })
      end,
      desc = "Find files in Neovim config",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Live grep",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers({
          current = false,
          hidden = false,
          unloaded = true,
          sort_lastused = true,
          win = {
            input = {
              keys = {
                ["<c-x>"] = { "bufdelete", mode = { "n", "i" } },
                ["dd"] = { "bufdelete", mode = "n" },
              },
            },
            list = {
              keys = {
                ["<c-x>"] = "bufdelete",
                ["dd"] = "bufdelete",
              },
            },
          },
        })
      end,
      desc = "Buffers",
    },
    {
      "<leader>fh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help tags",
    },
  },
}
