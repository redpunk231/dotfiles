return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    config = function()
        require("ibl").setup({
            scope = { show_start = false, show_end = false },
            indent = { char = "▏", tab_char = "▏", smart_indent_cap = true }
        })
        local hooks = require "ibl.hooks"
        hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
    end,
}
