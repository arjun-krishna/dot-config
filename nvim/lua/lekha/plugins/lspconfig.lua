return {
    {
    "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },
    config = function()
        vim.lsp.config['*'] = {
            capabilities = { textDocument = { semanticTokens = { multilineTokenSupport = true } } },
            root_markers = { '.git' },
        }
        vim.diagnostic.config({ virtual_lines = true })

        local blinkcmp = require("blink.cmp")
        local capabilities = blinkcmp.get_lsp_capabilities()
        vim.lsp.config('pyright', {
            capabilities = capabilities
        })
        vim.lsp.enable('pyright')

        vim.lsp.config('clangd', {
            capabilities = capabilities
        })
        vim.lsp.enable('clangd')

        vim.lsp.config('ty', {
          settings = {
            ty = {},
          }
        })
        vim.lsp.enable('ty')

        vim.lsp.config('harper', {
            cmd = { 'harper-ls', '--stdio' },
            filetypes = { 'markdown', 'text', 'tex', 'typst' }
        })
        vim.lsp.enable('harper')

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=bufnr})
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=bufnr})
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {buffer=bufnr})
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {buffer=bufnr})
    end
    },
}
