local telescope_status, telescope = pcall(require, 'telescope')
if not telescope_status then return end

telescope.setup {}

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', '<leader>s', '<cmd>Telescope find_files<cr>', opts)
keymap('n', '<leader>g', '<cmd>Telescope live_grep<cr>', opts)
keymap('n', '<leader>b', '<cmd>Telescope buffers<cr>', opts)
