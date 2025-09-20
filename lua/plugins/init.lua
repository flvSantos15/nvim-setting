return {
  -- Carrega configuracoes de UI
  require("plugins.ui"),

  -- Carrega configuracoes de LSP
  require("plugins.lsp"),

  -- Carrega configuracoes de autocompletion
  require("plugins.cmp"),

  -- Carrega configuracoes de Treesitter
  require("plugins.treesitter"),

  -- Carrega configuracoes de formatacao
  require("plugins.formatting"),

  -- Carrega configuracoes de autoclose e snippets
  require("plugins.autoclose-snippets"),
}
