local map = vim.keymap.set

local function escape(str)
    local escape_chars = [[;,."|\]]
    return vim.fn.escape(str, escape_chars)
end

local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
vim.opt.langmap = vim.fn.join(
    {
        escape(ru_shift) .. ';' .. escape(en_shift),
        escape(ru) .. ';' .. escape(en),
    },
    ','
)

map({"n","i","v"}, "<F1>", "<esc>")

map("n", "ff", "/<C-r><C-w><cr>N") -- find word under cursor
map("n", "fr", [[:%s/<C-r><C-w>//g<Left><Left>]]) -- replase word under cursor

-- buffers
map({"n", "i", "v"}, "<F8>", "<esc><cmd>bd<cr>")
