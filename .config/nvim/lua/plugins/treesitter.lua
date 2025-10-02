return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
        return  {
            ensure_installed = {
                "python",
                -- "bash",
                "comment",
                -- "css",
                -- "sql",
                -- "tmux",
                "vim",
                "vimdoc",
                -- "xml",
                -- "json",
                -- "todotxt",
                -- "toml",
                -- "csv",
                -- "diff",
                "dockerfile",
                -- "gitcommit",
                -- "gitignore",
                -- "javascript",
                -- "lua",
                -- "markdown",
                -- "regex"
            },
            sync_install = false,
            highlight = {
                enable = true,
                use_languagetree = true,
            },
            indent = { enable = true },
        }
        end,
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
 }
