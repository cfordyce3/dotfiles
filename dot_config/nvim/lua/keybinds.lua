-- leaders
vim.g.mapleader = ";"
vim.g.localmapleader = ";"

local vk = vim.keymap

-- leader does nothing in normal/visual modes
vk.set({ 'n', 'v', }, ';', '<Nop>', {silent = true})

-- no command signature in cmd bar
local opts = { noremap = true, silent = true }

-- don't keep deleted char in buffer
vk.set('n', 'x', '"_x', opts)

-- keep last yanked
vk.set('v', 'p', '"_dP', opts)

-- center on scroll
vk.set('n', '<C-d>', '<C-d>zz', opts)
vk.set('n', '<C-u>', '<C-u>zz', opts)

-- center on find
--vk.set('n', 'n', 'nzzzv', opts)
--vk.set('n', 'N', 'Nzzzv', opts)

-- window nav
vk.set('n', '<C-k>', ':wincmd k<CR>', opts)
vk.set('n', '<C-j>', ':wincmd j<CR>', opts)
vk.set('n', '<C-h>', ':wincmd h<CR>', opts)
vk.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- buffer nav
vk.set('n', '<leader>n', ':bnext<CR>', opts)
vk.set('n', '<leader>N', ':bprev<CR>', opts)
vk.set('n', '<leader>c', ':bdelete<CR>', opts)


-------------------------------
------- Plugin Keybinds -------  
-------------------------------

    ---- Harpoon ----
-- See harpoon.lua in lua/plugins

    ---- Neotree ----
--:Neotree action=focus position=left 
--:vsplit 
--:Neotree action=show source=buffers position=current<CR>

--vim.api.nvim_command("split")
--vim.api.nvim_command("Neotree focus buffers current")

vk.set('n', '<leader>e', ":Neotree reveal filesystem float  <CR>", opts)
vk.set('n', '<leader>b', ':Neotree focus buffers    float <CR>', opts)
vk.set('n', '<leader>g', ':Neotree focus git_status float <CR>', opts)
vk.set('n', '<Bslash>', ':Neotree show toggle=true<CR>', opts)

    ---- Telescope  ----
local t_builtin = require("telescope.builtin")
vk.set('n', '<leader>ff', t_builtin.find_files, opts)
vk.set('n', '<leader>fg', t_builtin.live_grep, opts)
vk.set('n', '<leader>fi', t_builtin.git_files, opts)
vk.set('n', 'gb', t_builtin.buffers, opts)
vk.set('n', '<leader>fh', t_builtin.help_tags, opts)



