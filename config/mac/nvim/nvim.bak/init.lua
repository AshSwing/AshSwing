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

-- Plugin Setting --
require("lazy").setup({
    -- Theme
    require("theme.tokyonight"),
    -- IDE Config
    require("setup.usable"), -- 易用设置
    require("setup.layout"), -- 界面布局
    -- require("setup.coding"), -- 编码工具
    require("setup.finder"), -- 项目管理
})
