return {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        -- vim.opt.cmdheight = 1

        local colors = {
            bg0    = '#2d353b',
            bg1    = '#3c474d',
            bg3    = '#505a60',
            fg     = '#d8caac',
            aqua   = '#87c095',
            green  = '#a7c080',
            orange = '#e39b7b',
            purple = '#d39bb6',
            red    = '#e68183',
            grey1  = '#868d80',
        }

        local theme = {
            normal = {
                a = { bg = colors.green, fg = colors.bg0, gui = 'bold' },
                b = { bg = colors.bg0, fg = colors.fg },
                c = { bg = colors.bg0, fg = colors.fg },
            },
            insert = {
                a = { bg = colors.aqua, fg = colors.bg0, gui = 'bold' },
                b = { bg = colors.bg0, fg = colors.fg },
                c = { bg = colors.bg0, fg = colors.fg },
            },
            visual = {
                a = { bg = colors.red, fg = colors.bg0, gui = 'bold' },
                b = { bg = colors.bg0, fg = colors.fg },
                c = { bg = colors.bg0, fg = colors.fg },
            },
            replace = {
                a = { bg = colors.orange, fg = colors.bg0, gui = 'bold' },
                b = { bg = colors.bg0, fg = colors.fg },
                c = { bg = colors.bg0, fg = colors.fg },
            },
            terminal = {
                a = { bg = colors.purple, fg = colors.bg0, gui = 'bold' },
                b = { bg = colors.bg0, fg = colors.fg },
                c = { bg = colors.bg0, fg = colors.fg },
            },
            inactive = {
                a = { bg = colors.bg0, fg = colors.grey1, gui = 'bold' },
                b = { bg = colors.bg0, fg = colors.grey1 },
                c = { bg = colors.bg0, fg = colors.grey1 },
            },
        }

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = theme,
                component_separators = { left = '|', right = '|'},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {{
                    'filename',
                    symbols = {
                        modified = '•',         -- Text to show when the file is modified.
                        readonly = '[-]',       -- Text to show when the file is non-modifiable or readonly.
                        unnamed = '[No Name]',  -- Text to show for unnamed buffers.
                        newfile = '[New]',      -- Text to show for newly created file before first write
                    }
                }},
                lualine_c = {{
         --           'branch',
         --           fmt = function(str)
         --               local len = string.len(str)
         --               if len < 30 then
         --                   return str
         --               end
         --               return str:sub(1,29) .. "…"
         --           end
                }},
                lualine_x = {'diagnostics'},
                lualine_y = {'progress', 'location'},
                lualine_z = {

                }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    end
}
