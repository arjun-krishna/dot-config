return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'main',
    lazy = false,
    build = ":TSUpdate",
    config = function()
        ts = require('nvim-treesitter')
        ts.setup({
          install_dir = vim.fn.stdpath('data') .. '/site'
        })
        ts.install({
          'c', 'cpp', 'bash', 'cuda', 'lua', 'markdown',
          'python', 'vim', 'yaml', 'json', 'xml', 'rust',
          'diff', 'gitcommit', 'markdown_inline', 'regex',
        })
    end,
}
