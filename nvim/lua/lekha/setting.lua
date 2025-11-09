vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.have_nerd_font = true

vim.opt.guicursor = ""
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.tabstop = 4       -- number of spaces a <Tab> counts for
vim.opt.shiftwidth = 4    -- number of spaces used for autoindent
vim.opt.expandtab = true  -- convert tabs to spaces

vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.number = true
vim.o.ruler = true
vim.o.showmode = false
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.confirm = true

vim.cmd("filetype plugin indent on")
-- vimtex options
vim.g.vimtex_syntax_enabled = 0
vim.g.vimtex_compiler_method = 'latexmk'
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
  },
}
