return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
        options = {
            "-verbose",
            "-shell-escape",
            "-interaction=nonstopmode",
            "-synctex=1",
            "-file-line-error",
        },
    }
  end
}
