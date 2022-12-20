local autopairs_status, autopairs = pcall(require, 'autopairs')
if not autopairs_status then return end

autopairs.setup {}
