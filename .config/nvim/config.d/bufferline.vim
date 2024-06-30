set termguicolors
lua << EOF
require("bufferline").setup {
    options = {
        max_name_length = 15,
        tab_size = 15,
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
        buffer_close_icon="×"
    }
}
EOF
