return {
  name = "native-terminal",
  dir = vim.fn.stdpath("config"),
  lazy = false,
  init = function()
    local function map(mode, lhs, rhs, opts)
      vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { silent = true }, opts or {}))
    end

    local function open_terminal()
      vim.cmd("botright 20new")
      vim.cmd.terminal()
      vim.cmd.startinsert()
    end

    map("n", "<C-`>", open_terminal, { desc = "Open terminal split" })

    -- Leave terminal mode without first sending Escape to the running program.
    map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

    -- Insert the contents of a register while staying in terminal mode.
    map("t", "<C-r>", function()
      return [[<C-\><C-n>"]] .. vim.fn.nr2char(vim.fn.getchar()) .. "pi"
    end, { expr = true, desc = "Insert terminal register" })

    local window_directions = {
      h = "left",
      j = "down",
      k = "up",
      l = "right",
    }

    for key, direction in pairs(window_directions) do
      map("t", "<C-" .. key .. ">", [[<C-\><C-n><C-w>]] .. key, {
        desc = "Move to " .. direction .. " window",
      })
      map("i", "<C-" .. key .. ">", [[<C-\><C-n><C-w>]] .. key, {
        desc = "Move to " .. direction .. " window",
      })
    end
  end,
}
