return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        require("plugin.plenary"),
        require("plugin.nvim-web-devicons"),
        require("plugin.nui"),
    },
    config = function()
        local keybind = {
            name = "NeoTree",
            ["<C-n>"] = { "<cmd>NeoTreeFocusToggle<CR>", "Toggle Tree" }
        }
        require("which-key").register(keybind, {})
        require("neo-tree").setup({
            close_if_last_window = true,
            default_component_configs = {
                git_status = {
                    symbols = {
                        -- Change
                        added = "󰐙",
                        modified = "󱨧",
                        deleted = "󰮈",
                        renamed = "",
                        -- Status
                        unstaged = "",
                        staged = "",
                        unmerged = "󰿤",
                        untracked = "󰦤",
                        ignored = "󱑚",
                        conflict = "󱃓",
                    }
                }
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    always_show = {
                        ".gitignored",
                    },
                    hide_by_name = {
                        ".git"
                    }
                },
                components = {
                    icon = function(config, node, state)
                        local highlights = require("neo-tree.ui.highlights")
                        local icon = config.default or " "
                        local padding = config.padding or " "
                        local highlight = config.highlight or highlights.FILE_ICON
                        if node.type == "directory" then
                            highlight = highlights.DIRECTORY_ICON
                            if string.lower(node.name) == "mac" then
                                icon = "󰀵"
                            elseif string.lower(node.name) == "linux" then
                                icon = ""
                            elseif string.lower(node.name) == "win" then
                                icon = "󰖳"
                            elseif string.lower(node.name) == "config" then
                                icon = ""
                            elseif string.lower(node.name) == ".git" then
                                icon = ""
                            elseif string.lower(node.name) == "nvim" or string.lower(node.name) == "vim" then
                                icon = ""
                            elseif string.lower(node.name) == "kitty" then
                                icon = "󰄛"
                            elseif string.lower(node.name) == "shrc" then
                                icon = ""
                            elseif node:is_expanded() then
                                icon = config.folder_open or "-"
                            else
                                icon = config.folder_closed or "+"
                            end
                        elseif node.type == "file" then
                            local success, web_devicons = pcall(require, "nvim-web-devicons")
                            if success then
                                local devicon, hl = web_devicons.get_icon(node.name, node.ext)
                                icon = devicon or icon
                                highlight = hl or highlight
                            end
                        end
                        return {
                            text = icon .. padding,
                            highlight = highlight,
                        }
                    end,
                }
            },
        })
    end,
}