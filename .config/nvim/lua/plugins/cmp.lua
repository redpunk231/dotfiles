return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        -- snippets
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            dependencies = { "honza/vim-snippets" },
            config = function(_, opts)
                require("luasnip.loaders.from_snipmate").lazy_load()
            end,
        },

        -- cmp sources plugins
        {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp-signature-help"
        },
    },
    opts = function()
        local cmp = require 'cmp'
        return {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = {
                ['<Up>'] = cmp.mapping.select_prev_item(),
                ['<Down>'] = cmp.mapping.select_next_item(),
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                },
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                --{ name = 'nvim_lsp_signature_help' },
                { name = 'path' },
                { name = 'buffer' },
            },
        }
    end,
}
