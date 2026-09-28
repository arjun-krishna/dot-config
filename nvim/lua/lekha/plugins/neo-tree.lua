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
  lazy = false,
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
    window = {
        mappings = {
            ["Y"] = function(state)
                local node = state.tree:get_node()
                if not node or not node.id then
                  vim.notify("No node selected.", vim.log.levels.WARN)
                  return
                end

                if vim.fn.has('clipboard') == 0 then
                  vim.notify("System clipboard is not available.", vim.log.levels.ERROR)
                  return
                end

                local filepath = node:get_id()
                local filename = node.name
                local modify = vim.fn.fnamemodify

                local choices = {
                  { label = "Absolute path",              value = filepath },
                  { label = "Path relative to CWD",       value = modify(filepath, ':.') },
                  { label = "Path relative to HOME",      value = modify(filepath, ':~') },
                  { label = "Filename",                   value = filename },
                  { label = "Filename without extension", value = modify(filename, ':r') },
                  { label = "Extension of the filename",  value = modify(filename, ':e') },
                }

                -- THE CHANGE IS ON THIS LINE:
                -- Instead of vim.ui.select, we call the snacks picker directly.
                vim.ui.select(choices, {
                  prompt = 'Choose to copy to clipboard:',
                  format_item = function(item)
                    return string.format("%-30s %s", item.label, item.value)
                  end
                }, function(choice)
                  if not choice then
                    vim.notify("Copy cancelled.", vim.log.levels.INFO)
                    return
                  end

                  local value_to_copy = choice.value

                  vim.fn.setreg('+', value_to_copy)
                  vim.notify('Copied to clipboard: ' .. value_to_copy)
                end)
            end,
        }
    }
  },
}
