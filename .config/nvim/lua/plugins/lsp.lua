return {
    "neovim/nvim-lspconfig",
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
        {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                require("mason").setup()
                require("mason-lspconfig").setup({
                    ensure_installed = {
                        "pyright",
                    }
                })
                require("mason-lspconfig").setup_handlers {
                    function (server_name)
                        require("lspconfig")[server_name].setup {}
                    end,
                }
            end
        },
        {
            "nvimtools/none-ls.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function(_, opts)
                local null_ls = require("null-ls")
                local formatters = null_ls.builtins.formatting
                null_ls.setup({
                    sources = {
                        formatters.black.with({
                            extra_args = {
                                "--line-length=120",
                                "--skip-string-normalization",
                            }
                        }),
                    },
                })
            end
        }
    },
    event = "User FilePost",
    -- opts = function()
    --     local telescope = require("telescope.builtin")
    --     local M = {}
    --     local map = vim.keymap.set
    --
    --     -- export on_attach & capabilities
    --     M.on_attach = function(_, bufnr)
    --         local function opts(desc)
    --             return { buffer = bufnr, desc = "LSP " .. desc, noremap=true, silent=true }
    --         end
    --
    --         map("n", "gr", telescope.lsp_references)
    --         map("n", "gd", telescope.lsp_definitions)
    --
    --         map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    --         map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
    --     end
    --
    --     return M
    -- end,
    -- config = function(_, opts)
    --     local servers = { 'pyright' }
    --     local nvim_lsp = require('lspconfig')
    --     for _, lsp in ipairs(servers) do
    --         nvim_lsp[lsp].setup {
    --             on_attach = opts.on_attach,
    --             flags = {
    --                 debounce_text_changes = 150,
    --             }
    --         }
    --     end
    -- end
}
