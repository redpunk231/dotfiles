lua << EOF
require('auto-session').setup({
    auto_session_allowed_dirs = {
        '~/.dotfiles/.config/nvim',
        '~/.code/tatlin-automated-testing',
        '~/.code/tatlin-disk-configuration',
        '~/.code/service-oem-network-scanner',
        '~/.code/oem-x86-automated-testing',
        '~/.code/oem-x86-api',
        '~/.code/jboe-at',
    },
    auto_session_use_git_branch = false
})
EOF
