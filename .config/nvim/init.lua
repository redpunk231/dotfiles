local repo = "https://github.com/folke/lazy.nvim.git"
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    { require("configs.theme"), { import = "plugins" } },
    require("configs.lazy")
)
require("configs.nvim_lsp")
require("configs.nvim_options")
require("configs.nvim_autocmds")
require("configs.nvim_user_commands")
vim.schedule(function() require("configs.nvim_mappings") end)
