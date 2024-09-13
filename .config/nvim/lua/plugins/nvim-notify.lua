return {
    "rcarriga/nvim-notify",
    config = function()
        require("notify").setup({
            background_colour = "NotifyBackground",
            fps = 30,
            icons = {
                DEBUG = "",
                ERROR = "",
                INFO = "",
                TRACE = "✎",
                WARN = ""
            },
            level = 3,
            minimum_width = 50,
            render = "wrapped-compact",
            stages = "fade_in_slide_out",
            time_formats = {
                notification = "%T",
                notification_history = "%FT%T"
            },
            timeout = 3000,
            top_down = false,
            on_open = function(win)
                vim.api.nvim_win_set_config(win, { zindex = 100 })
            end,

        })
    end
}
