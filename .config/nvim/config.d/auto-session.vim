lua << EOF
require('auto-session').setup({
    auto_session_allowed_dirs = {
        '/home/roman/.code/tatlin-automated-testing',
        '/home/roman/.code/tatlin-disk-configuration',
        '/home/roman/.code/service-oem-network-scanner',
        '/home/roman/.code/oem-x86-automated-testing',
        '/home/roman/.code/oem-x86-api',
    },
    auto_session_use_git_branch = false

})
EOF
