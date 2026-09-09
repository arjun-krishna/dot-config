return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    if (vim.uv or vim.loop).os_uname().sysname == "Darwin" then
      vim.g.vimtex_view_method = "sioyek"
    else
      vim.g.vimtex_view_method = "zathura"
    end
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      build_dir = '',
      callback = 1,
      continuous = 1,
      executable = 'latexmk',
      options = {
        '-pdf',  -- Use pdflatex engine
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
        '-shell-escape',
      },
    }

    vim.g.vimtex_syntax_enabled = 1
    vim.g.vimtex_fold_enabled = 1
  end
}
