return {
    'rmagatti/auto-session',
    lazy = false,
    keys = {
        { "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
        { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
        { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle session" },
    },

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        allowed_dirs = { "~/workspace/" },
        suppressed_dirs = {"~/", "~/Downloads", "~/Documents", "/"},
        session_lens = {
            picker = 'telescope',
            mappings = {
                delete_session = { 'i', '<C-d>'},
                alternate_session = { 'i', '<C-s>'},
                copy_session = { 'i', '<C-y>'},
            },
            load_on_setup = true,
        },
        git_use_branch_name = true,
        git_auto_restore_on_branch_change = true,
        bypass_save_filetypes = { 'dashboard' },
    },
}
