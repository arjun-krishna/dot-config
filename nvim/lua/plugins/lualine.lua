return {
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Set lualine as statusline
    -- See `:help lualine.txt`
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
      },
    }
  end,
}
