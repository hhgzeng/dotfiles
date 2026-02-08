return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("tokyonight").setup({})
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  -- {
  --   "Mofiqul/dracula.nvim",
  --   priority = 1000,
  --   -- lazy = true,
  --   config = function()
  --     require("dracula").setup({})
  --     vim.cmd([[colorscheme dracula]])
  --   end,
  -- },
}