local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system {
            'git',
            'clone',
            '--depth',
            '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path
        }
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require 'packer'.startup(function(use)
    -- packer manage itself
    use 'wbthomason/packer.nvim'


    -- basic
    use 'ellisonleao/gruvbox.nvim' -- colorscheme
    use 'nvim-lua/plenary.nvim' -- common utility
    use 'nvim-tree/nvim-web-devicons' -- icon set
    use 'nvim-tree/nvim-tree.lua' -- file explorer
    use 'petertriho/nvim-scrollbar' -- scrollbar
    use 'nvim-lualine/lualine.nvim' -- status line
    use 'akinsho/bufferline.nvim' -- file tab
    use 'akinsho/toggleterm.nvim' -- terminal
    use 'nvim-telescope/telescope.nvim' -- fuzzy finder
    use 'nvim-telescope/telescope-file-browser.nvim'

    use 'williamboman/mason.nvim' -- manage LSP servers, DAP servers, linters, and formatters

    -- LSP
    use 'neovim/nvim-lspconfig' -- LSP client
    use 'williamboman/mason-lspconfig.nvim' -- extension to mason.nvim and provide command `:LSPInstall`
    use 'glepnir/lspsaga.nvim'
    use 'onsails/lspkind-nvim'

    -- completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'

    -- snipet
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    if packer_bootstrap then
        require 'packer'.sync()
    end
end)
