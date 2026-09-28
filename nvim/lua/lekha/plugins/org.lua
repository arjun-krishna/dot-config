return {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    dependencies = {
        'folke/snacks.nvim',
        'nvim-orgmode/telescope-orgmode.nvim',
        'nvim-orgmode/org-bullets.nvim',
        'Saghen/blink.cmp',
        {
            'chipsenkbeil/org-roam.nvim',
            tag = '0.2.0',
        },
    },
    config = function()
        local org = require('orgmode')
        org.setup({
            org_agenda_files = '~/org/**/*',
            org_default_notes_file = '~/org/refile.org',
        })
        require('org-bullets').setup()
        require('blink.cmp').setup({
          sources = {
            per_filetype = {
              org = {'orgmode'}
            },
            providers = {
              orgmode = {
                name = 'Orgmode',
                module = 'orgmode.org.autocompletion.blink',
                fallbacks = { 'buffer' },
              },
            },
          },
        })

        local org_picker = require('telescope-orgmode')
        org_picker.setup({ adapter = 'snacks' })
        vim.keymap.set('n', '<leader>r', org_picker.refile_heading, { desc = 'Org refile' })
        vim.keymap.set('n', '<leader>fh', org_picker.search_headings, { desc = 'Org headlines' })
        vim.keymap.set('n', '<leader>li', org_picker.insert_link, { desc = 'Org insert link' })

        local org_roam = require('org-roam')
        org_roam.setup({
            directory = '~/org_roam',
            database = {
                persist = true,
                update_on_save = true,
            },
            org_files = {
                '~/org/**/*.org',
            },
        })
    end,
}
