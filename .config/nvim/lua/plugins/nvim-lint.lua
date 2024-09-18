return {
    'mfussenegger/nvim-lint',
    event = {"BufWritePost", "BufReadPost", "BufEnter"},
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            python = { "ruff", "mypy" },
        }
    end
}
