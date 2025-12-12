return {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    dependencies = {
        'nvim-telescope/telescope.nvim',
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

        local telescope = require('telescope')
        telescope.load_extension('orgmode')
        vim.keymap.set('n', '<leader>r', telescope.extensions.orgmode.refile_heading)
        vim.keymap.set('n', '<leader>fh', telescope.extensions.orgmode.search_headings)
        vim.keymap.set('n', '<leader>li', telescope.extensions.orgmode.insert_link)

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
