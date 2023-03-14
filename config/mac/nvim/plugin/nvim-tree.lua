return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { require("plugin.nvim-web-devicons") },
    config = function()
        local nvimtree = require("nvim-tree")
        local keybind = {
            name = "NvimTree",
            ["<C-n>"] = { "<cmd>NvimTreeToggle<CR>", "Toggle Tree" }
        }
        require("which-key").register(keybind, {})
        nvimtree.setup({
            view = {
                signcolumn = false,
                float = {
                    enable = true,
                    quit_on_focus_loss = true,
                }
            },
            git = {
                ignore = false,
                show_on_open_dirs = false,
            },
            filters = {
                custom = {"^\\.git$", "^.DS_Store$"}
            },
            renderer = {
                highlight_git = true,
                icons = {
                    padding = " ",
                    git_placement = "after",
                    modified_placement = "signcolumn",
                    glyphs = {
                        git = {
                            unstaged = "",
                            staged = "",
                            unmerged = "󰿤",
                            renamed = "",
                            untracked = "󰦤",
                            deleted = "󰮈",
                            ignored = "󱑚",
                        }
                    }
                }
            },
            actions = {
                open_file = {
                    quit_on_open = true
                }
            }
        })
    end,
}