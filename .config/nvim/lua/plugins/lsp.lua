return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-telescope/telescope.nvim",
        {
            "rachartier/tiny-inline-diagnostic.nvim",
            config = function()
                local signs = {
                    Error = "",
                    Warn = "",
                    Hint = "",
                    Info = ""
                }
                for type, icon in pairs(signs) do
                    local hl = "DiagnosticSign" .. type
                    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl, priority=3000})
                end
                vim.diagnostic.config({ virtual_text = false })

                require('tiny-inline-diagnostic').setup({
                    hi = {
                        background = "None",
                        mixing_color = "None",
                    },
                    signs = {
                        left = "",
                        right = "",
                        diag = " ●",
                        arrow = "    ",
                        up_arrow = " ",
                        vertical = " │",
                        vertical_end = " └",
                    },
                    blend = {
                        factor = 0.5,
                    },
                    options = {
                        softwrap = 50,
                        break_line = {
                            enabled = true,
                            after = 50,
                        },
                    }
                })
                require("tiny-inline-diagnostic").disable()
            end
        },
        {
            "williamboman/mason.nvim",
        },
    },
    opts = function()
        local telescope = require("telescope.builtin")
        local M = {}
        local map = vim.keymap.set

        -- export on_attach & capabilities
        M.on_attach = function(_, bufnr)
            local function opts(desc)
                return { buffer = bufnr, desc = "LSP " .. desc, noremap=true, silent=true }
            end

            map("n", "gr", telescope.lsp_references)
            map("n", "gd", telescope.lsp_definitions)
            map("n", "<space>rn", vim.lsp.buf.rename)

            map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
            map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")

            -- bufmap("n", "gr", telescope.lsp_references)
            -- bufmap("n", "gd", telescope.lsp_definitions)
            -- bufmap("n", "gD", vim.lsp.buf.declaration)
            -- bufmap("n", "<leader>sh", vim.lsp.buf.signature_help)
            -- bufmap("n", "<space>rn", vim.lsp.buf.rename)
            --
            -- -- bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
            -- -- bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
            -- -- bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
            -- -- bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
            -- -- bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
            -- -- bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
            -- -- bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
            -- -- bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
            -- -- bufmap({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
            -- -- bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
            -- -- bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
            -- -- bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
            -- -- bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
        end

        return M
    end,
    config = function(_, opts)
        require("mason").setup()
        local nvim_lsp = require('lspconfig')
        nvim_lsp['pyright'].setup {
            on_attach = opts.on_attach,
            flags = {
                debounce_text_changes = 150,
            },
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = 'off'
                    }
                }
            }
        }
    end
}
