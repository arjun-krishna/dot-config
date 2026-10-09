return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signcolumn = true,
    word_diff = true,
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
      end

      map("]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, "Next Git hunk")

      map("[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, "Previous Git hunk")

      map("<leader>gi", gitsigns.preview_hunk_inline, "Preview Git hunk inline")
      map("<leader>gp", gitsigns.preview_hunk, "Preview Git hunk")
      map("<leader>gd", gitsigns.diffthis, "Diff buffer against Git index")
      map("<leader>gw", gitsigns.toggle_word_diff, "Toggle Git word diff")
    end,
  },
}
