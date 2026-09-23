vim.opt.rtp:prepend(vim.fn.stdpath("config"))

require("config.lazy")

-- Force background to dark immediately to prevent syntax color-space panics
vim.opt.background = "dark"

-- Hard lock autocommand for any buffer or colorscheme event change
vim.api.nvim_create_autocmd({ "ColorScheme", "BufEnter", "BufWinEnter", "FileType" }, {
  pattern = "*",
  callback = function()
    if vim.g.colors_name ~= "catppuccin-mocha" then
      pcall(vim.cmd, "colorscheme catppuccin-mocha")
    end
  end,
})

