return {
  -- Autoclose de tags HTML/JSX/TSX
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup({
        filetypes = {
          'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact',
          'svelte', 'vue', 'tsx', 'jsx', 'xml', 'php', 'markdown', 'astro'
        },
        skip_tags = {
          'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'slot',
          'input', 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr', 'menuitem'
        }
      })
    end,
  },

  -- Autoclose de parênteses, chaves, aspas
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = {'string', 'source'},
          javascript = {'string', 'template_string'},
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        disable_in_macro = true,
        disable_in_visualblock = false,
        disable_in_replace_mode = true,
        ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
        enable_moveright = true,
        enable_afterquote = true,
        enable_check_bracket_line = true,
        enable_bracket_in_quote = true,
        enable_abbr = false,
        break_undo = true,
        check_comma = true,
        map_char = {
          all = '(',
          tex = '{'
        },
      })
      
      -- Regras especiais para diferentes linguagens
      local npairs = require("nvim-autopairs")
      local Rule = require('nvim-autopairs.rule')
      local cond = require('nvim-autopairs.conds')

      -- Regra para JSX/TSX - não fechar tags em comentários
      npairs.add_rules({
        Rule('<', '>', {'javascript', 'typescript', 'javascriptreact', 'typescriptreact'})
          :with_pair(cond.before_regex('%a+'):with_cr(cond.none())),
      })

      -- Regra para strings template em JavaScript/TypeScript
      npairs.add_rules({
        Rule('`', '`', {'javascript', 'typescript', 'javascriptreact', 'typescriptreact'}),
      })
    end
  },

  -- Sistema de snippets LuaSnip
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local luasnip = require("luasnip")
      
      -- Configurações do LuaSnip
      luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
        ext_opts = {
          [require("luasnip.util.types").choiceNode] = {
            active = {
              virt_text = { { "●", "DiagnosticWarn" } }
            }
          }
        }
      })

      -- Keymaps para LuaSnip
      vim.keymap.set({"i", "s"}, "<C-k>", function() 
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end 
      end, {silent = true})

      vim.keymap.set({"i", "s"}, "<C-j>", function() 
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end 
      end, {silent = true})

      vim.keymap.set("i", "<C-l>", function() 
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end 
      end)

      -- Carrega snippets do friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      
      -- Carrega snippets personalizados
      require("luasnip.loaders.from_lua").load({
        paths = "~/.config/nvim/lua/snippets/"
      })
      
      -- Auto-reload snippets personalizados quando editados
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*/snippets/*.lua",
        callback = function()
          require("luasnip.loaders.from_lua").load({
            paths = "~/.config/nvim/lua/snippets/"
          })
          vim.notify("Snippets recarregados!", vim.log.levels.INFO)
        end,
      })
    end,
  },
}
