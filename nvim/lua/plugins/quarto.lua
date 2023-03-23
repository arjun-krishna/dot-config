return {
  'quarto-dev/quarto-nvim',
  dependencies = {
    'jmbuhr/otter.nvim',
    'neovim/nvim-lspconfig'
  },
  keys = {
    { "<leader>qp", "<cmd>QuartoPreview<cr>", desc = "QuartoPreview", {silent=true, noremap=true}},
  },
  config = function()
    require 'quarto'.setup {
      debug = true,
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        languages = { 'r', 'python', 'julia' },
        diagnostics = {
          enabled = true,
          triggers = { "BufWrite" }
        },
        completion = {
          enabled = true
        }
      },
      keymap = {
        hover = 'K',
        definition = 'gd',
      }
    }
  end
}
