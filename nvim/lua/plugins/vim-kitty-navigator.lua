return  {
  'knubie/vim-kitty-navigator',
  enabled = true,
  keys = {
    {
      '<C-h>',
      '<CMD>KittyNavigateLeft<CR>',
      desc = 'Navigate window left',
    },
    {
      '<C-j>',
      '<CMD>KittyNavigateDown<CR>',
      desc = 'Navigate window down',
    },
    {
      '<C-k>',
      '<CMD>KittyNavigateUp<CR>',
      desc = 'Navigate window up',
    },
    {
      '<C-l>',
      '<CMD>KittyNavigateRight<CR>',
      desc = 'Navigate window right',
    },
  },
}
