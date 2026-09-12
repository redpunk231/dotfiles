local colors_light = {
    bg0     = '#FDF6E3', bg1    = '#F4F0D9', bg2    = '#EFEBD4',
    grey0   = '#A6B0A0', grey1  = '#939F91', grey2  = '#829181',
}
local colors_dark = {
    bg0     = '#2D353B', bg1    = '#343F44', bg2    = '#3D484D',
    grey0   = '#7A8478', grey1  = '#859289', grey2  = '#9DA9A0',
}

local function get_current_theme(background)
    local colors
    if background == "dark" then
        colors = colors_dark
    else
        colors = colors_light
    end

    local theme_modes = {
        a = { bg = colors.bg2, fg = colors.grey2 },
        b = { bg = colors.bg1, fg = colors.grey1 },
        c = { bg = colors.bg0, fg = colors.grey0 },
        x = { bg = colors.bg0, fg = colors.grey0 },
        y = { bg = colors.bg1, fg = colors.grey1 },
        z = { bg = colors.bg2, fg = colors.grey2 },
    }
    return {
        normal      = theme_modes,
        insert      = theme_modes,
        visual      = theme_modes,
        replace     = theme_modes,
        terminal    = theme_modes,
    }
end

local bg_group = vim.api.nvim_create_augroup("BackgroundSwitch", { clear = true })
vim.api.nvim_create_autocmd("OptionSet", {
    group = bg_group,
    pattern = "background",
    callback = function()
        local current_theme = get_current_theme(vim.v.option_new)
        require('lualine').setup({
            options = { theme = current_theme }
        })
    end,
})


local function trunc(max_width, left_width, right_width)
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

local devicons_ok, devicons = pcall(require, 'nvim-web-devicons')

return {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local current_theme = get_current_theme(vim.o.background)
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = current_theme,
                component_separators = '',
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {'TelescopePrompt'},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = {
                    {
                        'mode',
                        fmt = function(str)
                            return " " .. str:lower()
                        end
                    }
                },
                lualine_b = {
                    {
                        'branch',
                        icon = '󰘬',
                        fmt = trunc(40, 26, 3),
                        cond = conditions.show_git
                    },
                },
                lualine_c = {
                    {
                        function()
                            icon, icon_highlight_group = devicons.get_icon_by_filetype(vim.bo.filetype)
                            if icon == nil then
                                return ""
                            end

                            return icon
                        end,
                        padding = { left = 1, right = 0 }

                    },
                    {
                        'filename',
                        symbols = {
                            modified = '•',
                            readonly = '',
                            unnamed = 'new',
                            newfile = '',
                        },
                    },
                    {
                        function()
                            return "·" .. require("noice").api.statusline.mode.get() .. "·"
                        end,
                        cond = require("noice").api.statusline.mode.has,
                    }
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
