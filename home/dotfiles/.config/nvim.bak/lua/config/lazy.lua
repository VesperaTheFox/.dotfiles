local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)



vim.g.mapleader = " "

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  -- THIS LINE IS CRITICAL TO FORCE THE THEME GLOBALLY:
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true },
})
