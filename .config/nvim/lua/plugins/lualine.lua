local colors = {
    bg0     = '#2D353B',
    bg1     = '#343F44',
    bg2     = '#3D484D',
    green   = '#A7C080',
    orange  = '#E39B7B',
    purple  = '#D39BB6',
    red     = '#E68183',
    grey0   = '#7A8478',
    grey1   = '#859289',
    grey2   = '#9DA9A0',
}

local theme_modes = {
    a = { bg = colors.bg2, fg = colors.grey2 },
    b = { bg = colors.bg1, fg = colors.grey1 },
    c = { bg = colors.bg0, fg = colors.grey0 },
    x = { bg = colors.bg0, fg = colors.grey0 },
    y = { bg = colors.bg1, fg = colors.grey1 },
    z = { bg = colors.bg2, fg = colors.grey2 },
}

local theme = {
    normal = theme_modes,
    insert = theme_modes,
    visual = theme_modes,
    replace = theme_modes,
    terminal = theme_modes,
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

local conditions = {
    show_cwd = function()
        return vim.o.columns > 70
    end,
    show_line_col = function()
        return vim.o.columns > 90
    end,
    show_git = function()
        return vim.o.columns > 125
    end
}

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
                section_separators = { left = '', right = '' },
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
                        function()
                            return ""
                        end,
                        color = function()
                            local mode_color = {
                                n = colors.grey2,
                                i = colors.green,
                                v = colors.orange,
                                [""] = colors.orange,
                                V = colors.orange,
                                R = colors.red,
                                Rv = colors.red,
                                c = colors.grey1,
                                t = colors.purple,
                            }
                            return {
                                fg = mode_color[vim.fn.mode()],
                                gui = 'bold'
                            }
                        end,
                        padding = { right = 0, left = 1}
                    },
                    {
                        'mode',
                        fmt = function(str)
                            return str:lower()
                        end
                    }
                },
                lualine_b = {
                    {
                        'branch',
                        icon = '󰘬',
                        fmt = trunc(25, 21, 3),
                        cond = conditions.show_git
                    },
                },
                lualine_c = {
                    {
                        'filename',
                        symbols = {
                            modified = '•',
                            readonly = '',
                            unnamed = '[no name]',
                            newfile = '',
                        },
                    },
                },
                lualine_x = {
                    {
                        function()
                            return "ln %l, col %c"
                        end,
                        cond = conditions.show_line_col,
                    },
                },
                lualine_y = {
                },
                lualine_z = {
                    {
                        function()
                            local filepath = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                            return "󰉋 " .. filepath
                        end,
                        cond = conditions.show_cwd,
                    },
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
