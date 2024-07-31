lua << EOF
local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
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
})
require('telescope').load_extension('fzf')
EOF
