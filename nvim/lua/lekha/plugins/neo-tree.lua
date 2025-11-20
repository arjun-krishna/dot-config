return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  branch = "v3.x",
  keys = {
    { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = { -- Lazy param load
    filesystem = {
      follow_current_file = {
        enabled = true
      },
      hijack_netrw_behavior = "open_current",
      filtered_items = {
        visible = false, -- press H to toggle visibility
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_hidden = true,
      },
    },
  },
}
