return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    opts = {},
    config = function()
        local ls = require("luasnip")
        local cmp = require("cmp")

        vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
        vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
        vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
        vim.keymap.set({"i", "s"}, "<C-E>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, {silent = true})

        -- cmp configuration
        cmp.setup({
            ['<CR>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    if luasnip.expandable() then
                        luasnip.expand()
                    else
                        cmp.confirm({
                            select = true,
                        })
                    end
                else
                    fallback()
                end
            end),

            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.locally_jumpable(1) then
                luasnip.jump(1)
              else
                fallback()
              end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
        })

        -- load snippets
        local snippets_dir = vim.fn.stdpath("config") .. "/lua/lekha/snippets/"
        local snippets = vim.api.nvim_get_runtime_file(snippets_dir .. "*.lua", true)
        local t = {}
        for _, snip_fpath in ipairs(snippets) do
            local snip_mname = get_file_name(snip_fpath):sub(1, -5)  -- remove .lua extension
            -- skip if snip_mname is "utils" or "init"
            if snip_mname == "utils" or snip_mname == "init" then
                goto continue
            end
            local sm = require("lekha.snippets." .. snip_mname)
            for ft, snips in pairs(sm) do
                if t[ft] == nil then
                    t[ft] = snips
                else
                    for _, s in pairs(snips) do
                        table.insert(t[ft], s)
                    end
                end
            end
            ::continue::
        end
        ls.snippets = t
    end,
    dependencies = {
        'hrsh7th/nvim-cmp',
        'saadparwaiz1/cmp_luasnip',
    },
}
