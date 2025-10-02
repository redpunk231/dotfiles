local opt = vim.opt
local o = vim.o
local g = vim.g

o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"

o.expandtab = true
o.shiftwidth = 4
o.smartindent = true
o.tabstop = 4
o.softtabstop = 4

opt.fillchars = { eob = " ", diff = "╱" }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

o.number = true
o.numberwidth = 2
o.ruler = false

opt.shortmess:append "sI"

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

o.swapfile = false

o.scrolloff = 7
o.wrap = false

o.list = true
opt.listchars = {
    trail="·",
    precedes="«",
    extends="»",
    tab="▸ "
}

g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

vim.opt.termguicolors = true
vim.cmd.colorscheme('everforest')

local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        }
    },
    underline = true,
    severity_sort = true,
    virtual_text = false,
    virtual_lines = false,
})
vim.lsp.config('*', {
    on_attach = function(client, bufnr)
        local telescope = require("telescope.builtin")
        local function opts(desc)
            return { buffer = bufnr, desc = "LSP " .. desc, noremap=true, silent=true }
        end

        vim.keymap.set("n", "gr", telescope.lsp_references)
        vim.keymap.set("n", "gd", telescope.lsp_definitions)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
        vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")

    end,
})
vim.lsp.enable('pyright')
