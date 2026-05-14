return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  config = function()
    local ss = require("smart-splits")
    -- keymaps
    vim.keymap.set('n', '<C-h>', ss.move_cursor_left, { desc = "Move cursor left" })
    vim.keymap.set('n', '<C-j>', ss.move_cursor_down, { desc = "Move cursor down" })
    vim.keymap.set('n', '<C-k>', ss.move_cursor_up, { desc = "Move cursor up" })
    vim.keymap.set('n', '<C-l>', ss.move_cursor_right, { desc = "Move cursor right" })

    vim.keymap.set('n', '<A-h>', ss.resize_left, { desc = "Resize left" })
    vim.keymap.set('n', '<A-j>', ss.resize_down, { desc = "Resize down" })
    vim.keymap.set('n', '<A-k>', ss.resize_up, { desc = "Resize up" })
    vim.keymap.set('n', '<A-l>', ss.resize_right, { desc = "Resize right" })

    vim.keymap.set('n', '<leader><leader>h', ss.swap_buf_left, { desc = "Swap buffer left" })
    vim.keymap.set('n', '<leader><leader>j', ss.swap_buf_down, { desc = "Swap buffer down" })
    vim.keymap.set('n', '<leader><leader>k', ss.swap_buf_up, { desc = "Swap buffer up" })
    vim.keymap.set('n', '<leader><leader>l', ss.swap_buf_right, { desc = "Swap buffer right" })
  end,
  -- cmd = {
  --   "TmuxNavigateLeft",
  --   "TmuxNavigateDown",
  --   "TmuxNavigateUp",
  --   "TmuxNavigateRight",
  --   "TmuxNavigatePrevious",
  --   "TmuxNavigatorProcessList",
  -- },
  -- keys = {
  --   { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
  --   { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
  --   { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
  --   { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
  --   { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  -- },
}
