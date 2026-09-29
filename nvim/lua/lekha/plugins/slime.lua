return {
    'jpalardy/vim-slime',
    init = function()
        vim.g.slime_target = 'neovim'
        vim.g.slime_bracketed_paste = 1
        vim.g.slime_no_mappings = 1
        vim.g.slime_suggest_default = 1
    end,
    config = function()
        local wk = require('which-key')
        wk.add({
            { '<leader>s', group = 'Slime', mode = 'n' },
            { '<leader>sc', '<Plug>SlimeConfig', desc = 'Slime [c]onfig', mode = 'n'},
            { '<leader>ss', '<Plug>SlimeLineSend', desc = 'Slime line [s]end', mode = 'n'},
            { '<leader>sb', '<Plug>SlimeMotionSend', desc = 'Slime [b]lock (motion)', mode = 'n'},
            { '<leader>sp', '<Plug>SlimeParagraphSend', desc = 'Slime [p]paragraph', mode = 'n'},
            { '<leader>sr', '<Plug>SlimeRegionSend', desc = 'Slime [r]egion', mode = 'x'},
        })
    end,
}
