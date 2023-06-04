return {
    "nvim-tree/nvim-web-devicons",
    config = function()
        local webicon = require("nvim-web-devicons")
        webicon.setup({
            strict = true,
            color = true,
            override_by_extension = {
                ["md"] = {
                    icon = "",
                    color = "#42a5f5",
                    cterm_color = "75",
                    name = "Markdown"
                },
            },
            override_by_filename = {
                [".gitignore"] = {
                    icon = "",
                    name = "GitIgnore"
                },
            },
            default = true
        })
    end,
}