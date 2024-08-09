lua << EOF

vim.diagnostic.config({ virtual_text = false })

local signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = ""
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl, priority=2001})
end


require("tiny-inline-diagnostic").setup({
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

EOF
