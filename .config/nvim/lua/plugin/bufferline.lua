local bufferline_status, bufferline = pcall(require, 'bufferline')
if not bufferline_status then return end

bufferline.setup {}

local keymap = vim.keymap.set

keymap('n', '[b', '<cmd>BufferLineCyclePrev<cr>')
keymap('n', ']b', '<cmd>BufferLineCycleNext<cr>')
keymap('n', '[B', '<cmd>BufferLineMovePrev<cr>')
keymap('n', ']B', '<cmd>BufferLineMoveNext<cr>')
