return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
        local actions = require("telescope.actions")
        local opts = {}
        opts.defaults = {
            mappings = {
                i = {
                    ["<esc>"] = actions.close,
                    ["<F11>"] = actions.move_selection_previous,
                    ["<F12>"] = actions.move_selection_next,
                },
            },
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--ignore-case",
                "--trim",
                "-g!venv/*",
                "-g!tags",
                "-g!.mypy_cache/*",
                "-g!.git/*",
                "-g!__pycache__'",
            },
        }
        opts.pickers = {
            buffers = {
                mappings = {
                    i = {
                        ["<C-d>"] = actions.delete_buffer
                    },
                },
            },
        }
        opts.extensions_list = { "themes", "terms" }

        return opts
    end,
    config = function(_, opts)
        local telescope = require "telescope"
        telescope.setup(opts)
    end,
}
