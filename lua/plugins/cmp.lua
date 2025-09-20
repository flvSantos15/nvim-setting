return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip", -- Adiciona integração LuaSnip
    "rafamadriz/friendly-snippets", -- Snippets pré-definidos
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    
    -- Carrega snippets do friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    
    -- Carrega snippets personalizados
    require("luasnip.loaders.from_lua").load({
      paths = "~/.config/nvim/lua/snippets/"
    })
    
    -- Configuração do LuaSnip
    luasnip.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
    })
    
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        
        -- Navegação com Tab nos snippets
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- Adiciona snippets como fonte
        { name = "buffer" },
        { name = "path" },
      }),
    })
    
    -- Integração com autopairs (protegida)
    local autopairs_status_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
    if autopairs_status_ok then
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end
  end,
}
