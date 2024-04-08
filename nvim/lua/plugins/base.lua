return {
  -- Git related plugins
  {'navarasu/onedark.nvim', 
    config = function()
      require('onedark').setup {
        style = 'warmer'
      }
      require('onedark').load()
    end,
  }, -- Theme inspired by Atom
  'rhysd/clever-f.vim', -- f,F,t,T bindings expanded (no need to use ;)
}
