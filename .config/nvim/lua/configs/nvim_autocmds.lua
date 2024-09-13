local autocmd = vim.api.nvim_create_autocmd

autocmd(
    { "UIEnter", "BufReadPost", "BufNewFile" },
    {
        group = vim.api.nvim_create_augroup(
            "NvFilePost",
            { clear = true }
        ),
        callback = function(args)
            local file = vim.api.nvim_buf_get_name(args.buf)
            local buftype = vim.api.nvim_get_option_value(
                "buftype",
                { buf = args.buf }
            )
            if not vim.g.ui_entered and args.event == "UIEnter" then
                vim.g.ui_entered = true
            end
            if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
                vim.api.nvim_exec_autocmds(
                    "User",
                    {
                        pattern = "FilePost",
                        modeline = false 
                    }
                )
                vim.api.nvim_del_augroup_by_name "NvFilePost"
                vim.schedule(function()
                    vim.api.nvim_exec_autocmds("FileType", {})
                    if vim.g.editorconfig then
                        require("editorconfig").config(args.buf)
                    end
                end)
            end
        end,
    }
)

autocmd(
    {"BufRead", "BufNewFile"},
    {
        pattern = {"*.py"},
        command = "setlocal colorcolumn=120"
    }
)

local lsp_cmds = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})
autocmd('LspAttach', {
    group = lsp_cmds,
    desc = 'LSP actions',
    callback = function()
        local telescope = require("telescope.builtin")
        local bufmap = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, {buffer = true})
        end

        bufmap("n", "gr", telescope.lsp_references)
        bufmap("n", "gd", telescope.lsp_definitions)
        bufmap("n", "gD", vim.lsp.buf.declaration)
        bufmap("n", "<leader>sh", vim.lsp.buf.signature_help)
        bufmap("n", "<space>rn", vim.lsp.buf.rename)

        -- bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
        -- bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
        -- bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
        -- bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
        -- bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
        -- bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
        -- bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
        -- bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
        -- bufmap({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
        -- bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
        -- bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
        -- bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
        -- bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    end
})

-- function _G.set_terminal_keymaps()
--   local opts = {buffer = 0}
--   vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
--   m.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
--   vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
--   vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
--   vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
--   vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
--   vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
-- end
--
-- -- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

autocmd('TermOpen', {
    callback = function()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end
})
autocmd('TermEnter', {callback=function() vim.cmd('startinsert') end})
