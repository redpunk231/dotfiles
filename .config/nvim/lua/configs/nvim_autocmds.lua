local autocmd = vim.api.nvim_create_autocmd

-- set wrap line
autocmd(
    {"BufRead", "BufNewFile"},
    {
        pattern = {"*.py"},
        command = "setlocal colorcolumn=120"
    }
)

-- terminal stuff
autocmd({'BufEnter', 'TermEnter'}, {
    pattern = 'term://*',
    callback = function()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
        vim.schedule(
            function()
                vim.cmd(':startinsert')
            end
        )
    end
})

-- linter stuff
autocmd(
   {"BufWritePost", "BufReadPost", "BufEnter"},
   {
        callback = function()
            require("lint").try_lint()
        end,
   }
)
