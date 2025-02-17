local opt = vim.opt

opt.backup = false
opt.clipboard:append { 'unnamedplus' }
opt.cursorline = true
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.expandtab = true
opt.ignorecase = true
opt.list = true
opt.listchars = { tab = '>-', space = '_', trail = '*', nbsp = '+' }
opt.mouse = 'a'
opt.number = true
opt.shiftwidth = 4
opt.smartcase = true
opt.swapfile = false
opt.tabstop = 4
opt.title = true
opt.visualbell = true
opt.wrap = false
