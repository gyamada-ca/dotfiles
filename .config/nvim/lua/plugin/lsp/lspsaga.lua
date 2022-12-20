local lspsaga_status, lspsaga = pcall(require, 'lspsaga')
if not lspsaga_status then return end

lspsaga.init_lsp_saga()

local keymap = vim.keymap.set

keymap('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', { silent = true })
keymap({'n','v'}, '<leader>ca', '<cmd>Lspsaga code_action<CR>', { silent = true })
keymap('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', { silent = true })
keymap('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', { silent = true })
keymap('n', '<leader>cd', '<cmd>Lspsaga show_line_diagnostics<CR>', { silent = true })
keymap('n', '<leader>cd', '<cmd>Lspsaga show_cursor_diagnostics<CR>', { silent = true })
keymap('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { silent = true })
keymap('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', { silent = true })
keymap('n', '[E', function()
  require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap('n', ']E', function()
  require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap('n','<leader>o', '<cmd>Lspsaga outline<CR>',{ silent = true })
keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { silent = true })
