return {
    'OscarCreator/rsync.nvim',
    build = 'make',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = { "RsyncUp" },
    config = function()
        require("rsync").setup()
    end,
}
