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
    desc = 'use treesitter highlight/fold when parser exists',
    callback = function(args)
        -- skip popup/scratch buffers (e.g. blink.cmp menu sets ft on its popup buf,
        -- which would otherwise mutate the *current* window's foldmethod)
        if vim.bo[args.buf].buftype ~= "" then return end

        local ft = vim.bo[args.buf].filetype
        if ft == "tex" or ft == "latex" then
            vim.opt_local.foldmethod = "expr"
            return -- vimtex handles this exclusively
        end
        if pcall(vim.treesitter.get_parser, args.buf, nil) then
            pcall(vim.treesitter.start, args.buf) -- syntax highlighting
            -- use treesitter folding
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.schedule(function()
                vim.cmd("normal! zx") -- schedule update folds
            end)
            vim.bo[args.buf].indentexpr = "v:lua.vim.treesitter.indentexpr()"
        end
    end,
})

vim.api.nvim_create_autocmd({"FocusGained", "BufEnter"}, {
    command = "checktime",
    pattern = "*",
})
