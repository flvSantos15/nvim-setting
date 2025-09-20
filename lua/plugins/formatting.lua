return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Formatação
          null_ls.builtins.formatting.prettier,  -- JS, TS, JSON, HTML, CSS
          null_ls.builtins.formatting.black,     -- Python
          null_ls.builtins.formatting.stylua,    -- Lua
          null_ls.builtins.formatting.gofmt,     -- Go
        },
        -- Auto-format ao salvar
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
            vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = group,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end,
  },
}
