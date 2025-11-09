return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require("telescope.builtin")
        local telescope = require('telescope')
        telescope.setup {
            pickers = {
                find_files = {
                    hidden = false
                }
            }
        }
        -- vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        -- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        -- vim.keymap.set('n', '<leader>ps', function()
            -- builtin.grep_string({search = vim.fn.input("Grep > ")})
        -- end, {})
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })

        -- this command is to access and modify the config from any working directory - very handy to test our other configs
        vim.keymap.set('n', '<leader>fd', function()
          builtin.find_files({ cwd = vim.fn.stdpath('config') })
        end, { desc = 'Find files in neovim config' })

        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        -- we want telescope to use the fzf module
        telescope.load_extension('fzf')
    end,
}
