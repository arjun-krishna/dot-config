return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local telescope = require('telescope')
        local builtin = require("telescope.builtin")
        local action_state = require("telescope.actions.state")
        local actions = require("telescope.actions")

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

        buffer_searcher = function()
            builtin.buffers {
                sort_mru = true,
                ignore_current_buffer = true,
                show_all_buffers = true,
                attach_mappings = function(prompt_bufnr, map)
                    local refresh_buffer_searcher = function()
                        actions.close(prompt_bufnr)
                        vim.schedule(buffer_searcher)
                    end

                    local delete_buf = function()
                        local selection = action_state.get_selected_entry()
                        vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                        refresh_buffer_searcher()
                    end

                    local delete_multiple_buf = function()
                        local picker = action_state.get_current_picker(prompt_bufnr)
                        local selection = picker:get_multi_selection()
                        for _, entry in ipairs(selection) do
                            vim.api.nvim_buf_delete(entry.bufnr, { force = true })
                        end
                        refresh_buffer_searcher()
                    end

                    map('n', 'dd', delete_buf)
                    map('n', '<C-d>', delete_multiple_buf)
                    map('i', '<C-d>', delete_multiple_buf)

                    return true
                end
            }
        end
        -- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fb', buffer_searcher, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        -- we want telescope to use the fzf module
        telescope.load_extension('fzf')
    end,
}
