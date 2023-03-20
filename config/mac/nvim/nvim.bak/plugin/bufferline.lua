return {
    "akinsho/bufferline.nvim",
    dependencies = { require("plugin.nvim-web-devicons")},
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers",
                numbers = "none",
                hover = {
                    enable = true,
                    delay = 200,
                    reveal = { 'close' },
                }
            }
        })
    end,
}