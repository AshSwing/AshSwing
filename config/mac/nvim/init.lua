-- Path Setting --
local configpath = vim.fn.stdpath("config") .. "/?.lua;"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
package.path = configpath .. package.path

-- Package Manager --
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Core Setting --
require("core.init")

-- Theme & Plugin
require("lazy").setup({
    require("theme.tokyonight"),
    require("plugin.which-key"),
    --require("plugin.nvim-tree"),
    require("plugin.neo-tree"),
    require("plugin.lualine"),
    require("plugin.bufferline"),
})