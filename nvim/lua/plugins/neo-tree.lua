return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree", -- Lazy loads plugin
  branch = "v2.x",
  keys = {
    { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = { -- Lazy param load
    filesystem = {
      follow_current_file = true,
      hijack_netrw_behavior = "open_current",
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = true,
    },
  },
}
