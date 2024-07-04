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
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                                            -- the default case_mode is "smart_case"
        }
    },
})
require('telescope').load_extension('fzf')
EOF
