--
-- Keymaps
--
vim.keymap.set({"n","i","v"}, "<F7>", function()
    require("tiny-inline-diagnostic").toggle() 
end)


--
-- Setup
--
return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
        require('tiny-inline-diagnostic').setup({
            transparent_bg = true,
            hi = {
                background = "None",
                mixing_color = "None",
            },
            signs = {
                left = "",
                right = "",
                diag = "●",
                arrow = " ",
                up_arrow = " ",
                vertical = " │",
                vertical_end = " └",
            },
            blend = {
                factor = 0.5,
            },
            options = {
                softwrap = 50,
                format = function(diagnostic)
                    return string.format(
                        "%s\n\n\n[%s]",
                        diagnostic.message,
                        diagnostic.source
                    )
                end,
            }
        })
        require("tiny-inline-diagnostic").disable()
    end
}
