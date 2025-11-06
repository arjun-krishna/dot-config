vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.guicursor = ""
vim.o.termguicolors = true
vim.o.background = "dark"

vim.keymap.set("i", "jk", "<Esc>", { silent = true }) -- jk maps to Esc in insert mode

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("c", "%%", function()
	return vim.fn.expand("%:h") .. "/"
end, {expr = true, desc = "Expand to current file path"})

vim.g.have_nerd_font = true

vim.o.number = true
vim.o.ruler = true
vim.o.showmode = false
vim.o.relativenumber = true
vim.o.mouse = 'a'

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y")

vim.keymap.set("n", "<leader>sT", function()
    local file_dir = vim.fn.expand("%:p:h")
    local height = math.floor(vim.o.lines * 0.2)
    vim.cmd.vnew()
    vim.cmd("lcd " .. file_dir)
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, height)
end)

vim.keymap.set("n", "<leader>st", function()
    local height = math.floor(vim.o.lines * 0.2)
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, height)
end)

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
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true

vim.o.confirm = true

vim.opt.tabstop = 4       -- number of spaces a <Tab> counts for
vim.opt.shiftwidth = 4    -- number of spaces used for autoindent
vim.opt.expandtab = true  -- convert tabs to spaces

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

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
