return {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
        local org = require('orgmode')
        org.setup({
            org_agenda_files = '~/org/**/*',
            org_default_notes_file = '~/org/refile.org',
        })
        -- org.setup_ts_grammar()
    end,
}
