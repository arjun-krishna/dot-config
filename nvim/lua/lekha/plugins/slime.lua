return {
    'jpalardy/vim-slime',
    init = function()
        vim.g.slime_target = 'wezterm'
        vim.g.slime_bracketed_paste = 1
        vim.g.slime_no_mappings = 1
        vim.g.slime_dont_ask_default = 1
    end,
    config = function()
        local wk = require('which-key')
        wk.add({
            { '<leader>s', group = 'Slime', mode = 'n' },
            { '<leader>sc', '<Plug>SlimeConfig<cr>', desc = 'Slime [c]onfig', mode = 'n'},
            { '<leader>ss', '<Plug>SlimeLineSend<cr>', desc = 'Slime line [s]end', mode = 'n'},
            { '<leader>sb', '<Plug>SlimeMotionSend<cr>', desc = 'Slime [b]lock (motion)', mode = 'n'},
            { '<leader>sp', '<Plug>SlimeParagraphSend<cr>', desc = 'Slime [p]paragraph', mode = 'n'},
        })
        wk.add({
            { '<leader>s', group = 'Slime', mode = 'v' },
            { '<leader>sr', '<Plug>SlimeRegionSend<cr>', desc = 'Slime [r]egion', mode = 'v'},
        })
    end,
}
