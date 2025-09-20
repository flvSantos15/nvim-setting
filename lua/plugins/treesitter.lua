return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua", "javascript", "typescript", "python",
        "go", "java", "tsx", "json", "html", "css", "dockerfile", "sql"
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}

