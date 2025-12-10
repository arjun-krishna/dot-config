vim.keymap.set("i", "jk", "<Esc>", { silent = true }) -- jk maps to Esc in insert mode

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>x", "<cmd>:q<cr>", { desc = "close buffer" })


vim.keymap.set("c", "%%", function()
	return vim.fn.expand("%:h") .. "/"
end, {expr = true, desc = "Expand to current file path"})

--  copy to clipboard by default
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y")
vim.keymap.set("v", "<leader>Y", "\"+y")

-- TODO: swap out with toggleterm functions
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

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show [E]rrors" })
