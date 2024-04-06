return {
  'nvim-orgmode/orgmode',
  config = function()
    require('orgmode').setup {
      org_default_notes_file = '~/notes.org'
    }
  end
}
