return {
    'rcarriga/nvim-notify',
    config = function()
        vim.notify = require("notify")

        require("notify").setup({
            timeout = 1000,
            stages = "fade_in_slide_out",
            on_open = function(win)
                vim.api.nvim_win_set_config(win, { focusable = false })
            end,
        })

        vim.keymap.set("n", "<Esc>", function()
            require("notify").dismiss()
        end, { desc = "dismiss notify popup and clear hlsearch" })
    end,
}
