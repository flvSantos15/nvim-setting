vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Navegação rápida
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

-- Movimentação entre splits
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)

-- ===== SNIPPETS E AUTOCLOSE =====

-- Editar snippets personalizados
keymap("n", "<leader>es", function()
  require("luasnip.loaders").edit_snippet_files()
end, { desc = "Editar snippets", noremap = true, silent = true })

-- Listar snippets disponíveis
keymap("n", "<leader>sl", function()
  require("telescope").extensions.luasnip.luasnip()
end, { desc = "Listar snippets", noremap = true, silent = true })

-- Recarregar snippets personalizados
keymap("n", "<leader>sr", function()
  require("luasnip.loaders.from_lua").load({
    paths = "~/.config/nvim/lua/snippets/"
  })
  vim.notify("Snippets recarregados! 🔄", vim.log.levels.INFO)
end, { desc = "Recarregar snippets", noremap = true, silent = true })

-- Criar novo snippet para o tipo de arquivo atual
keymap("n", "<leader>sn", function()
  local filetype = vim.bo.filetype
  local snippet_file = vim.fn.stdpath("config") .. "/lua/snippets/" .. filetype .. ".lua"
  
  if vim.fn.filereadable(snippet_file) == 0 then
    -- Cria arquivo se não existir
    local template = string.format([[
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Seus snippets para %s aqui
  s("example", fmt("Exemplo para %s: {}", { i(1, "conteudo") })),
}
]], filetype, filetype)
    
    vim.fn.writefile(vim.split(template, "\n"), snippet_file)
    vim.notify("Arquivo de snippet criado para " .. filetype .. " 📝", vim.log.levels.INFO)
  end
  
  vim.cmd("edit " .. snippet_file)
end, { desc = "Novo snippet", noremap = true, silent = true })

-- Toggle autopairs
keymap("n", "<leader>ap", function()
  local autopairs = require("nvim-autopairs")
  if autopairs.state.disabled then
    autopairs.enable()
    vim.notify("Autopairs ativado ✅", vim.log.levels.INFO)
  else
    autopairs.disable()
    vim.notify("Autopairs desativado ❌", vim.log.levels.WARN)
  end
end, { desc = "Toggle autopairs", noremap = true, silent = true })
