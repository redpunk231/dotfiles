local win_pick_theme = {
    fg = '#D3C6AA',
    bg = '#3A515D',
    bold = true,
}

return {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        {
            "s1n7ax/nvim-window-picker",
            opts = {
                selection_chars = '123456789',
                picker_config = { statusline_winbar_picker = { use_winbar = 'smart' } },
                highlights = { winbar = { focused = win_pick_theme, unfocused = win_pick_theme } }
            },
        }
    },
    opts = function()
        return {
            filters = {
                dotfiles = false,
                custom = {
                    "^.*pycache.*",
                    "^.git$"
                },
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                    window_picker = {
                        enable = true,
                        picker = require('window-picker').pick_window
                    },
                }
            },
            disable_netrw = true,
            hijack_cursor = true,
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            view = {
                width = 30,
                preserve_window_proportions = true,
            },
            renderer = {
                root_folder_label = false,
                highlight_git = false,
                indent_markers = { enable = true },
                icons = {
                    glyphs = {
                        default = "󰈚",
                        folder = {
                            default = "",
                            empty = "",
                            empty_open = "",
                            open = "",
                            symlink = "",
                        },
                        git = { unmerged = "" },
                    },
                },
            },
        }
    end,
 }
