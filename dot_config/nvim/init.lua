-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {

      -- Colorscheme --
      {
          "folke/tokyonight.nvim",
          lazy = false,
          priority = 1000,
          config = function()
              require("tokyonight").setup({
                  style = "storm",
                  transparent = true,
                  terminal_colors = true,
              })
              vim.cmd([[colorscheme tokyonight]])
          end,
      },

      -- Plenary
      { "nvim-lua/plenary.nvim" },

      -- Dev Icons --
      { "nvim-tree/nvim-web-devicons", lazy = true },

      -- Autopairs --
      {
          "windwp/nvim-autopairs",
          event = "InsertEnter",
          config = function()
              require("nvim-autopairs").setup()
          end,
      },

      -- Rainbow Delimiter --
      {
          "HiPhish/rainbow-delimiters.nvim",
      },

      -- LuaLine --
      {
          "nvim-lualine/lualine.nvim",
          config = function()
              require("lualine").setup()
          end,
      },

      -- Zig --
      {
          "https://codeberg.org/ziglang/zig.vim",
      },

      {
          "nvim-treesitter/nvim-treesitter",
          lazy = false,
          build = ":TSUpdate",
          config = function()
              require("nvim-treesitter").setup()
              require("nvim-treesitter").install({
                  "lua",
                  "python",
                  "zig",
                  "rust",
                  "java",
              })
          end,
      },
      -- Neovim LSP Configuration --
      {
          "neovim/nvim-lspconfig",
      },

      -- Mason --
      {
          "mason-org/mason.nvim",
          dependencies = {
              "mason-org/mason-lspconfig.nvim",
              "WhoIsSethDaniel/mason-tool-installer.nvim",
          },
          config = function()
              require("mason").setup()
              require("mason-lspconfig").setup()
              require("mason-tool-installer").setup({
                  ensure_installed = {
                      "lua_ls",
                      "stylua",
                      "zls",
                      "pylsp",
                  },
              })
          end,
      },

      -- LuaSnip --
      {
          "L3MON4D3/LuaSnip",
          dependencies = {
              "rafamadriz/friendly-snippets",
          },
          config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
          end,
      },

      {
          "Saghen/blink.cmp",
          version = "1.*",
          config = function()
              require("blink.cmp").setup({
                  signature = { enabled = true },
                  completion = {
                      documentation = { auto_show = true, auto_show_delay_ms = 0 },
                      menu = {
                          auto_show = true,
                          draw = {
                              treesitter = { "lsp" },
                              columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
                          }
                      }
                  },
                  sources = {
                      default = { "lsp", "path", "snippets", "buffer" },
                  },
                  fuzzy = { implementation = "prefer_rust_with_warning" },

                  -- Completion keymapping
                  keymap = {
                      preset = "default",

                      ["<Tab>"] = { "select_next", "fallback" },
                      ["<S-Tab>"] = { "select_prev", "fallback" },
                      ["<CR>"] = { "accept", "fallback" },
                  }
              })
          end,
      },

      -- Which-Key
--      {
--          "folke/which-key.nvim",
--          event = "VeryLazy",
--          opts = {
--
--          },
--          keys = {
--              {
--                  "<leader>?",
--                  function()
--                      require("which-key").show({ global = false })
--                  end,
--                  desc = "Buffer Local Keymaps (which-key)",
--              },
--          },
--      },

      -- Telescope
      {
          "nvim-telescope/telescope.nvim",
          version = "*",
          dependencies = {
              "nvim-lua/plenary.nvim",
              { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
          },
          config = function()
              require("telescope").setup {
                  pickers = {
                      find_files = {
                          initial_mode = "insert",
                      },
                      buffers = {
                          theme = "dropdown",
                          initial_mode = "normal",
                      },
                      live_grep = {
                          theme = "dropdown",
                          initial_mode = "insert",
                      },
                  }
              }

          end,
      },

      -- File explorer
      {
          "nvim-neo-tree/neo-tree.nvim",
          branch = "v3.x",
          dependencies = {
              "MunifTanjim/nui.nvim",
          },
          lazy = false,

          config = function()
              require("neo-tree").setup({
                  filesystem = {
                      hijack_netrw_behavior = "open_current"
                  },
                  default_component_configs = {
                      width = "fit_content",
                  },
                  --source_selector = {
                  --    winbar = false,
                  --    statusline = false,
                  --},
                  event_handlers = {
                      {
                          event = "after_render",
                          handler = function(state)
                              --local state = require("neo-tree.sources.manager").get_state("filesystem")
                              if not require("neo-tree.sources.common.preview").is_active() then
                                  state.config = { use_float = true }
                                  state.commands.toggle_preview(state)
                              end
                          end,
                      },
                  },
                  window = {
                      mappings = {
                          ["L"] = {
                              "toggle_preview",
                              config = {
                                  use_float = true,
                              },
                          },
                          ["<Esc>"] = {
                              function()
                                  vim.cmd("Neotree close")
                              end,
                          },
                      }
                  },
              })

          end,
      },

      {
          "xvzc/chezmoi.nvim",
          config = function()
              require("chezmoi").setup {

              }
          end,
      },

  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "tokyonight" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require("lspconf")
require("removekb")
require("keybinds")
require("config")
