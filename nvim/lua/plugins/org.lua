return {
  'nvim-orgmode/orgmode',
  config = function()
    require('orgmode').setup_ts_grammar()
    require('orgmode').setup {
      org_default_notes_file = '~/notes.org'
    }
  end
}
