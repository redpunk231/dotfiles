return {
    "petertriho/nvim-scrollbar",
    event = {
        "BufReadPost",
        "BufWinEnter",
        "TabEnter",
        "TermEnter",
        "WinEnter",
        "CmdwinLeave",
        "TextChanged",
        "VimResized",
        "WinScrolled",
    },
    opts = function()
        return {
            handle = {
                blend = 30,
                color = "#425047"
            },
            marks = {
                GitAdd = { text = "" },
                GitChange = { text = "" },
            },
            handlers = {
                cursor = false,
                gitsigns = true,
                diagnostic = false
            },
        }
    end
}
