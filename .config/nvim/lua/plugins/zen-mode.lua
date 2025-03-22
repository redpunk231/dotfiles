vim.keymap.set({"n", "i", "v"}, "<leader>z", "<cmd>ZenMode<cr>")

return {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    opts = {
        window = {
            backdrop = 0.8,
            width = 126
        },
    }
}
