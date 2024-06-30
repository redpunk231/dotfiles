lua << EOF
require'nvim-tree'.setup {
    actions = {
        open_file = {
            quit_on_open = true,
        }
    },
    renderer = {
        highlight_git = false,
        indent_markers = {
            enable = true,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            },
        },
    },
    filters = {
        dotfiles = false,
        custom = {
            "^.*pycache.*",
            "^.git$"
        },
    },
    view = {
        side = "left",
    }
}
EOF

