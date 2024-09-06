lua << EOF
local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
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
    },
    pickers = {
        buffers = {
            mappings = {
                i = {
                    ["<C-d>"] = actions.delete_buffer
                },
            },
        },
    },
})
EOF
