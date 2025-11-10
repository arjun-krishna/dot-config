return {
    "github/copilot.vim",
    config = function()
        vim.api.nvim_create_autocmd('ColorScheme', {
            pattern = 'solarized',
            -- group = ...
            callback = function()
                vim.api.nvim_set_hl(0, 'CopilotSuggestion', {
                    fg = '#855555',
                    ctermfg = 8,
                    force = true,
                })
            end,
        })
    end,
}
