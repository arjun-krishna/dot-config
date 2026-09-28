return {
  'stevearc/aerial.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = {
     'nvim-treesitter/nvim-treesitter',
     'nvim-tree/nvim-web-devicons',
     'folke/snacks.nvim',
  },
  config = function()
    vim.keymap.set('n', '<leader>h', '<cmd>AerialToggle!<CR>', {desc = 'Aerial Toggle'})
    vim.keymap.set('n', '<leader>fa', function()
      require('aerial').snacks_picker()
    end, { desc = 'Aerial symbols' })
    require('aerial').setup({
        backends = { 'treesitter', 'lsp', 'markdown', 'asciidoc', 'man' },
        layout = {
            max_width = { 60, 0.3 },
            min_width = 30,
            width = nil,
            default_direction = 'prefer_right',
            placement = 'window',
            resize_to_content = true,
        },
        attach_mode = 'window',
        keymaps = {
            ['?'] = 'actions.show_help',
            ['g?'] = 'actions.show_help',
            ['<CR>'] = 'actions.jump',
            ['<2-LeftMouse>'] = 'actions.jump',
            ['<C-v>'] = 'actions.jump_vsplit',
            ['<C-s>'] = 'actions.jump_split',
            ['p'] = 'actions.scroll',
            ['<C-j>'] = 'actions.down_and_scroll',
            ['<C-k>'] = 'actions.up_and_scroll',
            ['{'] = 'actions.prev',
            ['}'] = 'actions.next',
            ['[['] = 'actions.prev_up',
            [']]'] = 'actions.next_up',
            ['q'] = 'actions.close',
            ['o'] = 'actions.tree_toggle',
            ['za'] = 'actions.tree_toggle',
            ['O'] = 'actions.tree_toggle_recursive',
            ['zA'] = 'actions.tree_toggle_recursive',
            ['l'] = 'actions.tree_open',
            ['zo'] = 'actions.tree_open',
            ['L'] = 'actions.tree_open_recursive',
            ['zO'] = 'actions.tree_open_recursive',
            ['h'] = 'actions.tree_close',
            ['zc'] = 'actions.tree_close',
            ['H'] = 'actions.tree_close_recursive',
            ['zC'] = 'actions.tree_close_recursive',
            ['zr'] = 'actions.tree_increase_fold_level',
            ['zR'] = 'actions.tree_open_all',
            ['zm'] = 'actions.tree_decrease_fold_level',
            ['zM'] = 'actions.tree_close_all',
            ['zx'] = 'actions.tree_sync_folds',
            ['zX'] = 'actions.tree_sync_folds',
        },
        lazy_load = true,
        disable_max_lines = 10000,
        disable_max_size = 2000000, -- 2MB
        filter_kind = {
            'Class',
            'Constructor',
            'Enum',
            'Function',
            'Interface',
            'Module',
            'Method',
            'Struct',
        },
        highlight_mode = 'split_width',
        highlight_closest = true,
        highlight_on_hover = false,
        highlight_on_jump = 300, -- ms (highlight duration)
        nerd_font = 'auto',
        post_jump_cmd = 'normal! zz',
        close_on_select = false,

        on_attach = function(bufnr)
            vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr, desc = 'Aerial Prev'})
            vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr, desc = 'Aerial Next'})
        end,
    })

  end,
}
