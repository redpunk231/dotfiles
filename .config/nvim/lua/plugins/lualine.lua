local colors = {
    bg0     = '#2D353B',
    bg1     = '#343F44',
    bg2     = '#3D484D',
    bg3     = '#475258',
    bg4     = '#4F585E',
    fg      = '#D8CAAC',
    aqua    = '#87C095',
    green   = '#A7C080',
    orange  = '#E39B7B',
    purple  = '#D39BB6',
    red     = '#E68183',
    grey1   = '#868D80',
}
local theme_cell_0 = { bg = colors.bg0, fg = colors.fg }
local theme_cell_1 = { bg = colors.bg1, fg = colors.fg }

local theme = {
    normal = {
        a = { bg = colors.green, fg = colors.bg0, gui = 'bold' },
        b = theme_cell_1,
        c = theme_cell_0,
        x = theme_cell_0,
        y = theme_cell_0,
        z = theme_cell_0,
    },
    insert = {
        a = { bg = colors.aqua, fg = colors.bg0, gui = 'bold' },
        b = theme_cell_1,
        c = theme_cell_0,
        x = theme_cell_0,
        y = theme_cell_0,
        z = theme_cell_0,
    },
    visual = {
        a = { bg = colors.red, fg = colors.bg0, gui = 'bold' },
        b = theme_cell_1,
        c = theme_cell_0,
        x = theme_cell_0,
        y = theme_cell_0,
        z = theme_cell_0,
    },
    replace = {
        a = { bg = colors.orange, fg = colors.bg0, gui = 'bold' },
        b = theme_cell_1,
        c = theme_cell_0,
        x = theme_cell_0,
        y = theme_cell_0,
        z = theme_cell_0,
    },
    terminal = {
        a = { bg = colors.purple, fg = colors.bg0, gui = 'bold' },
        b = theme_cell_1,
        c = theme_cell_0,
        x = theme_cell_0,
        y = theme_cell_0,
        z = theme_cell_0,
    },
    inactive = {
        a = { bg = colors.bg0, fg = colors.grey1, gui = 'bold' },
        b = { bg = colors.bg0, fg = colors.grey1 },
        c = { bg = colors.bg0, fg = colors.grey1 },
        x = { bg = colors.bg0, fg = colors.grey1 },
        y = { bg = colors.bg0, fg = colors.grey1 },
        z = { bg = colors.bg0, fg = colors.grey1 },
    },
}


function trunc(max_width, left_width, right_width)
    return function(str)
        if #str <= max_width then
            return str
        end

        -- TODO add checks
        local left = str:sub(1, left_width)
        local right = str:sub(#str - right_width + 1, #str)

        return left .. '…' .. right
    end
end

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed
        }
    end
end


return {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = theme,
                component_separators = '',
                section_separators = '',
                disabled_filetypes = {
                    statusline = {'TelescopePrompt'},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {
                    {
                        'mode',
                        icon=""
                    }
                },
                lualine_b = {
                    {
                        'branch',
                        icon = '󰘬',
                        fmt = trunc(25, 21, 3)
                    },
                },
                lualine_c = {
                    {
                        'filetype',
                        icon_only = true,
                        padding = { left = 1, right = 0}
                    },
                    {
                        'filename',
                        padding = { left = 0, right = 1},
                        symbols = {
                            modified = '•',         -- Text to show when the file is modified.
                            readonly = '[-]',       -- Text to show when the file is non-modifiable or readonly.
                            unnamed = ' [No Name]',  -- Text to show for unnamed buffers.
                            newfile = ' [New]',      -- Text to show for newly created file before first write
                        }
                    },
                    { 'diagnostics' },
                },
                lualine_x = {
                },
                lualine_y = {
                },
                lualine_z = {
                    { 'progress' },
                    { 'location' }
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {
                'nerdtree',
                'toggleterm',
                'lazy',
                'mason'
            }
        }
    end
}
