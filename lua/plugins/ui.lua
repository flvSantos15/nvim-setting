return {
  -- Tema Dracula
  {
    "dracula/vim",
    name = "dracula",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme dracula]])
    end,
  },

  -- Statusline com mais ícones
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "dracula",
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          globalstatus = true,
          icons_enabled = true,
        },
        sections = {
          lualine_a = {
            {
              'mode',
              icons_enabled = true,
              icon = "▊",
            }
          },
          lualine_b = {
            {
              'branch',
              icon = '',
            },
            {
              'diff',
              symbols = { added = ' ', modified = ' ', removed = ' ' },
            }
          },
          lualine_c = {
            {
              'filename',
              file_status = true,
              newfile_status = false,
              path = 1,
              symbols = {
                modified = ' ●',
                readonly = ' ',
                unnamed = ' [No Name]',
                newfile = ' [New]',
              }
            }
          },
          lualine_x = {
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            },
            {
              'encoding',
              icon = '',
            },
            {
              'fileformat',
              symbols = {
                unix = '', -- e712
                dos = '',  -- e70f
                mac = '',  -- e711
              }
            },
            {
              'filetype',
              colored = true,
              icon_only = false,
              icon = { align = 'right' },
            }
          },
          lualine_y = {
            {
              'progress',
              icon = '',
            }
          },
          lualine_z = {
            {
              'location',
              icon = '',
            }
          },
        }
      })
    end,
  },

  -- Bufferline com ícones melhorados
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = { '', '' },
          always_show_bufferline = true,
          show_buffer_close_icons = true,
          show_close_icon = false,
          color_icons = true,
          show_tab_indicators = true,
          persist_buffer_sort = true,
          move_wraps_at_ends = false,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          custom_filter = function(buf_number, buf_numbers)
            -- filtra buffers específicos se necessário
            if vim.bo[buf_number].filetype ~= "oil" then
              return true
            end
          end,
          offsets = {
            {
              filetype = "NvimTree",
              text = "📁 File Explorer",
              text_align = "center",
              separator = true
            }
          },
        },
        highlights = {
          separator = {
            fg = '#434758',
            bg = '#282a36'
          },
          separator_selected = {
            fg = '#434758'
          },
          background = {
            fg = '#657b83',
            bg = '#34495e'
          },
          buffer_selected = {
            fg = '#fdf6e3',
            bold = true,
          },
          fill = {
            bg = '#303030'
          }
        }
      })
    end,
  },

  -- File explorer com ícones customizados
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        sort_by = "name",
        view = {
          width = 35,
          side = "left",
        },
        renderer = {
          add_trailing = false,
          group_empty = false,
          highlight_git = true,
          full_name = false,
          highlight_opened_files = "name",
          root_folder_modifier = ":~",
          indent_width = 2,
          indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
              corner = "└",
              edge = "│",
              item = "│",
              bottom = "─",
              none = " ",
            },
          },
          icons = {
            webdev_colors = true,
            git_placement = "before",
            modified_placement = "after",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
              modified = true,
            },
            glyphs = {
              default = "📄",
              symlink = "🔗",
              bookmark = "🔖",
              modified = "●",
              folder = {
                arrow_closed = "▶",
                arrow_open = "▼",
                default = "📁",
                open = "📂",
                empty = "📁",
                empty_open = "📂",
                symlink = "🔗",
                symlink_open = "🔗",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "⌘",
                renamed = "➜",
                untracked = "★",
                deleted = "⊖",
                ignored = "◌",
              },
            },
          },
        },
        filters = {
          dotfiles = false,
          git_clean = false,
          no_buffer = false,
          custom = { "node_modules", "\\.cache" },
          exclude = {},
        },
        git = {
          enable = true,
          ignore = false,
          show_on_dirs = true,
          show_on_open_dirs = true,
          timeout = 400,
        },
        actions = {
          use_system_clipboard = true,
          change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
          },
          open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
              enable = true,
              picker = "default",
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
              },
            },
          },
        },
      })
    end,
  },

  -- Icones com configuração expandida
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        override = {
          -- JavaScript
          js = {
            icon = "",
            color = "#F7DF1E",
            cterm_color = "185",
            name = "JavaScript"
          },
          mjs = {
            icon = "",
            color = "#F7DF1E",
            cterm_color = "185",
            name = "ModuleJS"
          },
          -- TypeScript
          ts = {
            icon = "",
            color = "#3178C6",
            cterm_color = "67",
            name = "TypeScript"
          },
          -- React/JSX
          jsx = {
            icon = "",
            color = "#61DAFB",
            cterm_color = "45",
            name = "JSX"
          },
          tsx = {
            icon = "",
            color = "#61DAFB",
            cterm_color = "26",
            name = "TSX"
          },
          -- Go
          go = {
            icon = "",
            color = "#00ADD8",
            cterm_color = "67",
            name = "Go"
          },
          mod = {
            icon = "",
            color = "#00ADD8",
            cterm_color = "67",
            name = "GoMod"
          },
          -- Java
          java = {
            icon = "",
            color = "#ED8B00",
            cterm_color = "167",
            name = "Java"
          },
          class = {
            icon = "",
            color = "#ED8B00",
            cterm_color = "167",
            name = "JavaClass"
          },
          jar = {
            icon = "",
            color = "#ED8B00",
            cterm_color = "167",
            name = "Jar"
          },
          -- Angular
          ["component.ts"] = {
            icon = "",
            color = "#DD0031",
            cterm_color = "196",
            name = "AngularComponent"
          },
          ["service.ts"] = {
            icon = "",
            color = "#DD0031",
            cterm_color = "196",
            name = "AngularService"
          },
          ["module.ts"] = {
            icon = "",
            color = "#DD0031",
            cterm_color = "196",
            name = "AngularModule"
          },
          -- Docker
          dockerfile = {
            icon = "",
            color = "#2496ED",
            cterm_color = "68",
            name = "Dockerfile"
          },
          -- Outros úteis
          lua = {
            icon = "",
            color = "#000080",
            cterm_color = "74",
            name = "Lua"
          },
          py = {
            icon = "",
            color = "#3776AB",
            cterm_color = "68",
            name = "Python"
          },
          html = {
            icon = "",
            color = "#E34F26",
            cterm_color = "196",
            name = "HTML"
          },
          css = {
            icon = "",
            color = "#1572B6",
            cterm_color = "60",
            name = "CSS"
          },
          scss = {
            icon = "",
            color = "#CF649A",
            cterm_color = "169",
            name = "SCSS"
          },
          json = {
            icon = "",
            color = "#FFA500",
            cterm_color = "185",
            name = "JSON"
          },
          md = {
            icon = "",
            color = "#519aba",
            cterm_color = "67",
            name = "Markdown"
          },
          sql = {
            icon = "",
            color = "#336791",
            cterm_color = "74",
            name = "SQL"
          },
          yml = {
            icon = "",
            color = "#CB171E",
            cterm_color = "167",
            name = "YAML"
          },
          yaml = {
            icon = "",
            color = "#CB171E",
            cterm_color = "167",
            name = "YAML"
          },
        },
        color_icons = true,
        default = true,
        strict = true,
        override_by_filename = {
          [".gitignore"] = {
            icon = "",
            color = "#F1502F",
            name = "Gitignore"
          },
          ["README.md"] = {
            icon = "",
            color = "#519aba",
            name = "Readme"
          },
          ["package.json"] = {
            icon = "",
            color = "#E8274B",
            name = "PackageJson"
          },
          ["package-lock.json"] = {
            icon = "",
            color = "#7A0D21",
            name = "PackageLockJson"
          },
          ["tsconfig.json"] = {
            icon = "",
            color = "#3178C6",
            name = "TSConfig"
          },
          ["angular.json"] = {
            icon = "",
            color = "#DD0031",
            name = "AngularConfig"
          },
          ["Dockerfile"] = {
            icon = "",
            color = "#2496ED",
            name = "Dockerfile"
          },
          ["docker-compose.yml"] = {
            icon = "",
            color = "#2496ED",
            name = "DockerCompose"
          },
          ["docker-compose.yaml"] = {
            icon = "",
            color = "#2496ED",
            name = "DockerCompose"
          },
          ["go.mod"] = {
            icon = "",
            color = "#00ADD8",
            name = "GoMod"
          },
          ["go.sum"] = {
            icon = "",
            color = "#00ADD8",
            name = "GoSum"
          },
          [".env"] = {
            icon = "",
            color = "#FDD835",
            name = "Environment"
          },
          [".env.local"] = {
            icon = "",
            color = "#FDD835",
            name = "Environment"
          },
          [".env.production"] = {
            icon = "",
            color = "#FDD835",
            name = "Environment"
          },
        },
        override_by_extension = {
          ["log"] = {
            icon = "",
            color = "#81e043",
            name = "Log"
          },
          ["conf"] = {
            icon = "",
            color = "#6d8086",
            name = "Config"
          },
        },
      })
    end,
  },

  -- Fuzzy finder com ícones
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup {
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = "➤ ",
          entry_prefix = "  ",
          multi_icon = "📋",
          layout_strategy = "flex",
          color_devicons = true,
          sorting_strategy = "ascending",
          file_ignore_patterns = { "node_modules", ".git/", "dist/" },
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end
          },
        },
      }
    end,
  },
}
