local status, _ = pcall(vim.cmd, 'colorscheme gruvbox')
if not status then return end
