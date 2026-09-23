return {
  {
    "catppuccin/nvim",
    name = "catppuccin-nvim", -- Explicitly match the full package namespace
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = false,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      
      -- Force the exact string and clear any runtime default hooks
      vim.cmd("colorscheme catppuccin-mocha")
    end,
  },
}
