vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.have_nerd_font = true

vim.opt.guicursor = ""
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.tabstop = 4       -- number of spaces a <Tab> counts for
vim.opt.shiftwidth = 4    -- number of spaces used for autoindent
vim.opt.expandtab = true  -- convert tabs to spaces
vim.opt.clipboard = 'unnamedplus'  -- use system clipboard
if vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil then
    local function wez_paste()
        return {
            vim.fn.split(vim.fn.getreg(""), "\n"),
            vim.fn.getregtype(""),
        }
    end

    vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
            ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
            ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
            ['+'] = wez_paste,
            ['*'] = wez_paste,
        },
    }
end

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
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
vim.o.autoread = true

vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")
-- folding on startup
vim.opt.foldenable = false
vim.opt.foldlevel = 20
-- ty LSP
--
vim.lsp.config('ty', {
  settings = {
    ty = {},
  }
})
vim.lsp.enable('ty')
