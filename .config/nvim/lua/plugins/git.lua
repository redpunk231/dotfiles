--
-- Keymaps
--
vim.keymap.set(
    'n', '<leader>gg',
    function()
        require('neogit').open() 
    end
)


--
-- Setup
--
return {
    --
    -- Diffview
    --
    {
        'sindrets/diffview.nvim',
        cmd = { "DiffviewOpen" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function(_, opts)
            local actions = require("diffview.actions")
            require('diffview').setup({
                file_panel = {
                    win_config = {
                        width = 35
                    }
                },
                keymaps = {
                    diff3 = {
                        { "n", "m<Right>",  actions.conflict_choose("ours") },
                        { "n", "m<Left>",   actions.conflict_choose("theirs") },
                    }
                }
            })
        end
    },

    --
    -- Gitsigns
    --
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function(_, opts)
            require('gitsigns').setup({
                signs = {
                    delete = { text = "󰍵" },
                    changedelete = { text = "󱕖" },
                },
                signs_staged = {
                    delete = { text = "󰍵" },
                    changedelete = { text = "󱕖" },
                },
                signs_staged_enable = false,

                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']h', function()
                        if vim.wo.diff then
                            vim.cmd.normal({']h', bang = true})
                        else
                            gitsigns.nav_hunk('next')
                        end
                    end)

                    map('n', '[h', function()
                        if vim.wo.diff then
                            vim.cmd.normal({'[h', bang = true})
                        else
                            gitsigns.nav_hunk('prev')
                        end
                    end)

                    -- Actions
                    map('n', '<leader>hv', gitsigns.select_hunk)
                    map('n', '<leader>hs', gitsigns.stage_hunk)
                    map('n', '<leader>hr', gitsigns.reset_hunk)
                    map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                    map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                    map('n', '<leader>hp', gitsigns.preview_hunk)
                    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                end
            })
        end
    },

    --
    -- Neogit
    --
    {
        "NeogitOrg/neogit",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            graph_style = "kitty",
            commit_editor = {
                show_staged_diff = false,
                spell_check = false,
            },
            process_spinner = true
        }
    }
}
