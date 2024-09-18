local map = vim.keymap.set

map("n", "ff", "/<C-r><C-w><cr>N") -- find word under cursor
map("n", "fr", [[:%s/<C-r><C-w>//g<Left><Left>]]) -- replase word under cursor

-- file manager
map({"n", "i", "v"}, "<F2>", "<esc><cmd>NvimTreeToggle<cr>")
map({"n", "i", "v"}, "<F14>", "<esc><cmd>NvimTreeFocus<cr>")

-- buffers
map({"n", "i", "v"}, "<F8>", "<esc><cmd>bd<cr>")

-- telescope
map("n", "<leader>fw", "<cmd>Telescope grep_string<cr>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>ff", function()
    require'telescope.builtin'.find_files(
        require('telescope.themes').get_dropdown({
            previewer=false,
            prompt_title=false,
            prompt_prefix='Files> '
        })
    )
end)
map("n", "<leader>fb", function()
    require'telescope.builtin'.git_branches(
        require('telescope.themes').get_dropdown({
            previewer=false,
            prompt_title=false,
            prompt_prefix='Branches> ',
            layout_config = {width = 70}
        })
    )
end)
map("n", "<F12>", function()
    require'telescope.builtin'.buffers(
        require('telescope.themes').get_dropdown({
            sort_mru=true,
            ignore_current_buffer=true,
            previewer=false,
            prompt_title=false,
            prompt_prefix='Buffers> '
        })
    )
end)
map({"n","i","v"}, "<F3>", function()
    require'telescope.builtin'.treesitter({
        ignore_symbols={
            'parameter',
            'import',
            'method',
            'var'
        }
    })
end)

-- commenter
map("n", "<leader>c<Space>", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<leader>c<Space>", "gc", { desc = "Toggle Comment", remap = true })


-- lsp stuf
map({"n","i","v"}, "<F7>", function() require("tiny-inline-diagnostic").toggle() end)
