local null_ls_status, null_ls = pcall(require, 'null-ls')
if not null_ls_status then return end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup {
    sources = {
        null_ls.builtins.formatting.prettier, -- js/ts
        null_ls.builtins.formatting.jq, -- json
        null_ls.builtins.formatting.stylua, -- lua
        null_ls.builtins.formatting.gofumpt, -- go
        null_ls.builtins.formatting.goimports, -- go
        null_ls.builtins.diagnostics.golangci_lint, -- go
    },

    on_attach = function(current_client, bufnr)
        if current_client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format {
                        filter = function(client)
                            return client.name == 'null-ls'
                        end,
                        bufnr = bufnr,
                    }
                end,
            })
        end
    end
}
