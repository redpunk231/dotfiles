--
-- Keymaps
--
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>ff", function()
    require'telescope.builtin'.find_files(
        require('telescope.themes').get_dropdown({
            previewer=false,
            prompt_title=false,
            prompt_prefix='Files> '
        })
    )
end)
vim.keymap.set("n", "<leader>fb", function()
    require'telescope.builtin'.git_branches(
        require('telescope.themes').get_dropdown({
            previewer=false,
            prompt_title=false,
            prompt_prefix='Branches> ',
            layout_config = {width = 70}
        })
    )
end)
vim.keymap.set("n", "<F12>", function()
    require'telescope.builtin'.buffers(
        require('telescope.themes').get_dropdown({
            sort_mru=true,
            ignore_current_buffer=true,
            previewer=false,
            prompt_title=false,
            prompt_prefix='Buffers> '
        })
    )
end)
vim.keymap.set({"n","i","v"}, "<F3>", function()
    require'telescope.builtin'.treesitter({
        ignore_symbols={
            'parameter',
            'import',
            'method',
            'var'
        }
    })
end)


--
-- Setup
--
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
