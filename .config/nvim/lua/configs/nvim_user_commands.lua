local cmd = vim.api.nvim_create_user_command

cmd('DO', 'DiffviewOpen', {})
cmd('DC', 'DiffviewClose', {})

cmd(
    'Autopep8',
    function()
        local plenary_job = require('plenary.job')
        local buf = vim.api.nvim_buf_get_name(0)
        local job = plenary_job:new({
            command = 'autopep8',
            args = {
                "--in-place",
                "--aggressive",
                "--max-line-length=120",
                buf
            },
        })

        vim.cmd('write')
        job:sync()
        vim.cmd('checktime')
    end,
    {}
)
