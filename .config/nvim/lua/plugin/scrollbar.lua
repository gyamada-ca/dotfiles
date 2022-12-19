local scrollbar_status, scrollbar = pcall(require, 'scrollbar')
if not scrollbar_status then return end

scrollbar.setup()
