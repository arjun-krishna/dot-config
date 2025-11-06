return {
    {
    "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },
    config = function()
        local blinkcmp = require("blink.cmp")
        local capabilities = blinkcmp.get_lsp_capabilities()
        vim.lsp.config("pyright", {
            capabilities = capabilities
        })
        vim.lsp.config("clangd", {
            capabilities = capabilities
        })

        vim.lsp.enable("pyright")
        vim.lsp.enable('clangd')

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=bufnr})
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=bufnr})
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {buffer=bufnr})
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {buffer=bufnr})
    end
    },
}
