--
-- Keymaps
--
vim.keymap.set("n", "<leader>c<Space>", "gcc", { desc = "Toggle Comment", remap = true })
vim.keymap.set("v", "<leader>c<Space>", "gc", { desc = "Toggle Comment", remap = true })


--
-- Setup
--
return {
    'numToStr/Comment.nvim',
    opts = { mappings = { basic = true, extra = false } }
}
