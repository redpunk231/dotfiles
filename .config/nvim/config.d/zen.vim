lua << EOF

require("no-neck-pain").setup({
    width = 122,
    minSideBufferWidth = 10,
    disableOnLastBuffer = false,
    killAllBuffersOnDisable = false,
    autocmds = {
        enableOnVimEnter = false, -- TODO
        enableOnTabEnter = false,
        reloadOnColorSchemeChange = false,
        skipEnteringNoNeckPainBuffer = true,
    },
    mappings = {
        enabled = false,
    },
    buffers = {
        setNames = false,
        scratchPad = NoNeckPain.bufferOptionsScratchPad,
        colors = NoNeckPain.bufferOptionsColors,
        bo = NoNeckPain.bufferOptionsBo,
        --wo = NoNeckPain.bufferOptionsWo,
        wo = {fillchars = "eob: ",},
        left = NoNeckPain.bufferOptions,
        right = NoNeckPain.bufferOptions,
    },
    integrations = {
        NvimTree = {
            position = "left",
            reopen = true,
        },
        NeoTree = {
            position = "left",
            reopen = true,
        },
    },
})

NoNeckPain.bufferOptions = {
    enabled = false,
    colors = NoNeckPain.bufferOptionsColors,
    bo = NoNeckPain.bufferOptionsBo,
    wo = NoNeckPain.bufferOptionsWo,
    scratchPad = NoNeckPain.bufferOptionsScratchPad,
}

NoNeckPain.bufferOptionsWo = {
    cursorline = false,
    cursorcolumn = false,
    colorcolumn = "0",
    number = false,
    relativenumber = false,
    foldenable = false,
    list = false,
    wrap = true,
    linebreak = false,
}

NoNeckPain.bufferOptionsBo = {
    filetype = "no-neck-pain",
    buftype = "nofile",
    bufhidden = "hide",
    buflisted = false,
    swapfile = false,
}

NoNeckPain.bufferOptionsScratchPad = {
    enabled = false,
    pathToFile = "",
}

NoNeckPain.bufferOptionsColors = {
    background = nil,
    blend = 1,
    text = nil,
}

EOF
