lua << EOF

vim.opt.updatetime = 100

require("barbecue").setup({
    create_autocmd = false,
    theme = {
        normal = {bg = "#272e33", fg="#859289"},
        basename = { bold = false },
    },
    show_dirname = false,
    show_modified = true,
})

vim.api.nvim_create_autocmd(
    {
        "WinScrolled",
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",
        "BufModifiedSet",
    },
    {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
            require("barbecue.ui").update()
        end,
    }
)

EOF
