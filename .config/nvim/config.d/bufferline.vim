set termguicolors
lua << EOF
local bufferline = require('bufferline')
bufferline.setup {
    options = {
        max_name_length = 12,
        tab_size = 12,
        max_prefix_length = 8,
        show_tab_indicators = false,
        always_show_bufferline = false,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left"
            }
        },
        close_icon="×",
        buffer_close_icon="×",
        left_trunc_marker = "",
        right_trunc_marker = "",
        style_preset = {
            bufferline.style_preset.no_italic,
            bufferline.style_preset.no_bold
        },
        indicator = {
            style = 'none',
        },
    },
    highlights = {
        background = {
            bg = '#181d20',
        },
        close_button = {
            bg = '#181d20',
        },
        modified = {
            bg = '#181d20',
        },
        separator = {
            bg = '#181d20',
        },
        duplicate = {
            bg = '#181d20',
        }
    },
}
EOF
