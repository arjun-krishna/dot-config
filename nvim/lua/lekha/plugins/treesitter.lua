return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup {
          -- Install parsers for these languages
          ensure_installed = {
            'c',
            'cpp',
            'bash',
            'cuda',
            'lua',
            'markdown',
            'python',
            'vim',
            'yaml',
            'json',
            'xml',
          },

          -- Auto-install missing parsers when entering a buffer
          auto_install = true,

          -- Enable syntax highlighting
          highlight = { enable = true },

          -- Enable indentation based on treesitter
          indent = { enable = true },
        }
    end,
}
