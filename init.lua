-- Atalhos gerais
require("config.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath
	})
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup("plugins")

-- Configurações básicas do Neovim
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " " -- Espaço como leader key

-- Configuração de indentação - 2 espaços
vim.opt.tabstop = 2        -- Número de espaços que um tab representa
vim.opt.shiftwidth = 2     -- Número de espaços para cada nível de indentação
vim.opt.softtabstop = 2    -- Número de espaços que um tab insere/deleta
vim.opt.expandtab = true   -- Converte tabs em espaços
vim.opt.smartindent = true -- Indentação inteligente
vim.opt.autoindent = true  -- Mantém indentação da linha anterior
