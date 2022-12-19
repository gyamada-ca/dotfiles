local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status then return end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_status then return end

local mason_status, mason = pcall(require, 'mason')
if not mason_status then return end

local mason_lspconfig_status, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_status then return end

mason.setup()

mason_lspconfig.setup {
    automatic_installation = true,
}

mason_lspconfig.setup_handlers({ function(server_name)
    lspconfig[server_name].setup {
        capabilities = cmp_nvim_lsp.default_capabilities(),
        on_attach = function(_, bufnr)
            -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
            vim.keymap.set('n', '<space>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
            -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
            -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
        end,
    }
end })
