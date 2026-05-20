return {
  'saghen/blink.cmp',
  enabled = true,
  dependencies = {
    {
      'micangl/cmp-vimtex',
       dependencies = {
         'saghen/blink.compat',
         version='*',
         lazy = true,
         opts = {},
       },
    },
  },
  version = '1.*',
  opts = function(_, opts)
    opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
      default = { "lsp", "path", "snippets", "buffer", "vimtex" },
      providers = {
        lsp = {
          name = "lsp",
          enabled = true,
          module = "blink.cmp.sources.lsp",
          min_keyword_length = 3,
          score_offset = 90, -- the higher the number, the higher the priority
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 25,
          fallbacks = { "snippets", "buffer" },
          min_keyword_length = 2,
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
            end,
            show_hidden_files_by_default = true,
          },
        },
        buffer = {
          name = "Buffer",
          enabled = true,
          max_items = 3,
          module = "blink.cmp.sources.buffer",
          min_keyword_length = 2,
          score_offset = 15, -- the higher the number, the higher the priority
        },
        snippets = {
          name = "snippets",
          enabled = true,
          max_items = 15,
          min_keyword_length = 2,
          module = "blink.cmp.sources.snippets",
          score_offset = 85, -- the higher the number, the higher the priority
        },

        -- add vimtex as sources
        -- credit: https://www.reddit.com/r/neovim/comments/1invqwg/comment/mcgttl5/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
        vimtex = {
          name = "vimtex",
          min_keyword_length = 2,
          module = "blink.compat.source",
          score_offset = 80,
        },
      },
    })

    opts.cmdline = {
      -- command line completion, thanks to dpetka2001 in reddit
      -- https://www.reddit.com/r/neovim/comments/1hjjf21/comment/m37fe4d/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
      sources = function()
        local type = vim.fn.getcmdtype()
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        if type == ":" then
          return { "cmdline" }
        end
        return {}
      end,
    }

    opts.completion = {
      menu = {
        border = "single",
      },
      documentation = {
        auto_show = true,
        window = {
          border = "single",
        },
      },
      -- Displays a preview of the selected item on the current line
      ghost_text = {
        enabled = true,
      },
    }

    opts.snippets = {
      preset = "luasnip",
      -- This comes from the luasnip extra, if you don't add it, won't be able to
      -- jump forward or backward in luasnip snippets
      -- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
    }

    -- The default preset used by lazyvim accepts completions with enter
    -- I don't like using enter because if on markdown and typing
    -- something, but you want to go to the line below, if you press enter,
    -- the completion will be accepted
    -- https://cmp.saghen.dev/configuration/keymap.html#default
    opts.keymap = {
      preset = "default",
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },

      ["<S-k>"] = { "scroll_documentation_up", "fallback" },
      ["<S-j>"] = { "scroll_documentation_down", "fallback" },

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
    }

    return opts
  end,
  --
  -- ---@module 'blink.cmp'
  -- ---@type blink.cmp.Config
  -- opts = {
  --   -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  --   -- 'super-tab' for mappings similar to vscode (tab to accept)
  --   -- 'enter' for enter to accept
  --   -- 'none' for no mappings
  --   --
  --   -- All presets have the following mappings:
  --   -- C-space: Open menu or open docs if already open
  --   -- C-n/C-p or Up/Down: Select next/previous item
  --   -- C-e: Hide menu
  --   -- C-k: Toggle signature help (if signature.enabled = true)
  --   --
  --   -- See :h blink-cmp-config-keymap for defining your own keymap
  --   keymap = { preset = 'default' },
  --
  --   appearance = {
  --     -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --     -- Adjusts spacing to ensure icons are aligned
  --     nerd_font_variant = 'mono'
  --   },
  --
  --   -- (Default) Only show the documentation popup when manually triggered
  --   completion = { documentation = { auto_show = false } },
  --
  --   -- Default list of enabled providers defined so that you can extend it
  --   -- elsewhere in your config, without redefining it, due to `opts_extend`
  --   sources = {
  --     default = { 'lsp', 'path', 'snippets', 'buffer' },
  --   },
  --
  --   signature = { enabled = true },
  --
  --   -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
  --   -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
  --   -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
  --   --
  --   -- See the fuzzy documentation for more information
  --   fuzzy = { implementation = "prefer_rust_with_warning" }
  -- },
  -- opts_extend = { "sources.default" }
}
