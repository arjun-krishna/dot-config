vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    if not vim.bo.binary and vim.bo.filetype ~= "diff" then
        vim.cmd([[%s/\s\+$//e]])
    end
  end,
  desc = "Remove trailing whitespace on save",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    desc = 'use treesitter fold when parser exists',
    callback = function()
        local ft = vim.bo.filetype
        if ft == "tex" or ft == "latex" then
             return -- vimtex handles this exclusively
        end
        if require('nvim-treesitter.parsers').has_parser() then
            -- use treesitter folding
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.schedule(function()
                vim.cmd("normal! zx") -- schedule update folds
            end)
        else
            -- use alt foldmethod
            vim.opt_local.foldmethod = "syntax"
        end
    end,
})

vim.api.nvim_create_autocmd({"FocusGained", "BufEnter"}, {
    command = "checktime",
    pattern = "*",
})
