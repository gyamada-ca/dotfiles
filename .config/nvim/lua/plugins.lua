-- install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system {
        'git',
        'clone',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    }
    print "Installing packer close and reopen Neovim..."
    vim.api.nvim_command 'packadd packer.nvim'
end

-- compile `nvim/plugin/packer_compiled.vim` whenever this file is updated
vim.api.nvim_create_augroup('PackerCompile', {})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    group = 'PackerCompile',
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
    once = false,
})

local opts = { noremap = true, silent = true }

require 'packer'.startup {
    function(use)
        -- packer manage itself
        use {
            'wbthomason/packer.nvim'
        }

        -- color schema
        use {
            'ellisonleao/gruvbox.nvim',
            config = function()
                vim.cmd([[colorscheme gruvbox]])
            end
        }

        -- LSP
        use {
            'neovim/nvim-lspconfig',
            'williamboman/nvim-lsp-installer',
            'tami5/lspsaga.nvim',
            'onsails/lspkind-nvim',
            'ray-x/lsp_signature.nvim',
        }

        -- syntax
        use {
            'nvim-treesitter/nvim-treesitter',
            config = function()
                require 'nvim-treesitter.configs'.setup {
                    highlight = { enable = true },
                    textobjects = {
                        select = {
                            enable = true,
                            lookahead = true,
                            keymaps = {
                                ["af"] = "@function.outer",
                                ["if"] = "@function.inner",
                                ["ac"] = "@class.outer",
                                ["ic"] = "@class.inner",
                            },
                        },
                        move = {
                            enable = true,
                            set_jumps = true,
                            goto_next_start = {
                                ["]m"] = "@function.outer",
                                ["]]"] = "@class.outer",
                            },
                            goto_next_end = {
                                ["]M"] = "@function.outer",
                                ["]["] = "@class.outer",
                            },
                            goto_previous_start = {
                                ["[m"] = "@function.outer",
                                ["[["] = "@class.outer",
                            },
                            goto_previous_end = {
                                ["[M"] = "@function.outer",
                                ["[]"] = "@class.outer",
                            },
                        },
                    },
                    indent = {
                        enable = true,
                    },
                    autotag = { enable = true },
                }
            end,
            run = ':TSUpdate',
        }

        -- completion
        use {
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
        }

        use {
            'folke/trouble.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function()
                require 'trouble'.setup()
            end,
            setup = function()
                vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
                vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
                vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
                vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
                vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
                vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)
                vim.keymap.set("n", "gI", "<cmd>Trouble lsp_implementations<cr>", opts)
            end
        }

        -- file explorer
        use {
            'kyazdani42/nvim-tree.lua',
            setup = function()
                vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', opts)
                vim.keymap.set('n', '<leader>d', '<cmd>NvimTreeFindFile<CR>', opts)
            end,
            config = function()
                require 'nvim-tree'.setup {
                    open_on_setup = true,
                }
            end,
            requires = {
                'kyazdani42/nvim-web-devicons',
                opt = true,
            },
        }

        -- fuzzy finder
        use {
            'nvim-telescope/telescope.nvim',
            setup = function()
                vim.keymap.set('n', '<leader>s', '<cmd>Telescope find_files<CR>', opts)
                vim.keymap.set('n', '<leader>g', '<cmd>Telescope live_grep<CR>', opts)
                vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<CR>', opts)
            end,
            requires = {
                { 'nvim-lua/plenary.nvim' },
            },
        }

        -- scroll bar
        use { 'petertriho/nvim-scrollbar',
            config = function()
                require 'scrollbar'.setup()
            end
        }

        -- status line
        use {
            'nvim-lualine/lualine.nvim',
            config = function()
                require 'lualine'.setup {
                    options = {
                        theme = 'gruvbox',
                        disabled_filetypes = { 'NvimTree', 'toggleterm' } -- disable statusline in file explorer
                    }
                }
            end,
            requires = {
                'kyazdani42/nvim-web-devicons',
                opt = true
            }
        }

        -- buffer line
        use {
            'akinsho/bufferline.nvim',
            tag = "v2.*",
            setup = function()
                vim.keymap.set('n', '[b', '<cmd>BufferLineCyclePrev<cr>')
                vim.keymap.set('n', ']b', '<cmd>BufferLineCycleNext<cr>')
                vim.keymap.set('n', '[B', '<cmd>BufferLineMovePrev<cr>')
                vim.keymap.set('n', ']B', '<cmd>BufferLineMoveNext<cr>')
            end,
            config = function()
                require 'bufferline'.setup {}
            end,
            requires = {
                'kyazdani42/nvim-web-devicons'
            }
        }

        -- terminal integration
        use {
            'akinsho/toggleterm.nvim',
            tag = 'v1.*',
            setup = function()
                vim.keymap.set('n', '<C-w>t', '<cmd>exe v:count1 . "ToggleTerm"<CR>', opts)
                vim.keymap.set('n', '<C-w>T', '<cmd>ToggleTermToggleAll<CR>', opts)
                vim.keymap.set("n", "<C-w>g", "<cmd>lua _G.toggle_gitui()<CR>", opts)
            end,
            config = function()
                require 'toggleterm'.setup {
                    hide_numbers = false,
                    shade_filetypes = {},
                    shade_terminals = true,
                    start_in_insert = true,
                    insert_mappings = true,
                    persist_size = true,
                    close_on_exit = true,
                }

                _G.term_gitui = nil
                _G.toggle_gitui = function()
                    if term_gitui == nil then
                        _G.term_gitui = require 'toggleterm.terminal'.Terminal:new {
                            cmd = 'gitui',
                            direction = 'float',
                            hidden = true,
                        }
                    end
                    term_gitui:toggle()
                end
            end
        }

        -- git
        use {
            'lewis6991/gitsigns.nvim',
            config = function()
                require 'gitsigns'.setup {
                    on_attach = function(bufnr)
                        local gs = package.loaded.gitsigns

                        local function map(mode, l, r, opts)
                            opts = opts or {}
                            opts.buffer = bufnr
                            vim.keymap.set(mode, l, r, opts)
                        end

                        -- Navigation
                        map('n', ']c', function()
                            if vim.wo.diff then return ']c' end
                            vim.schedule(function() gs.next_hunk() end)
                            return '<Ignore>'
                        end, { expr = true })

                        map('n', '[c', function()
                            if vim.wo.diff then return '[c' end
                            vim.schedule(function() gs.prev_hunk() end)
                            return '<Ignore>'
                        end, { expr = true })

                        -- Actions
                        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
                        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
                        map('n', '<leader>hS', gs.stage_buffer)
                        map('n', '<leader>hu', gs.undo_stage_hunk)
                        map('n', '<leader>hR', gs.reset_buffer)
                        map('n', '<leader>hp', gs.preview_hunk)
                        map('n', '<leader>hb', function() gs.blame_line { full = true } end)
                        map('n', '<leader>tb', gs.toggle_current_line_blame)
                        map('n', '<leader>hd', gs.diffthis)
                        map('n', '<leader>hD', function() gs.diffthis('~') end)
                        map('n', '<leader>td', gs.toggle_deleted)

                        -- Text object
                        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                    end

                }
            end
        }

        -- jump anywhere
        use {
            'phaazon/hop.nvim',
            branch = 'v2',
            setup = function()
                vim.keymap.set('n', '<leader>c', '<cmd>HopChar1<cr>', { noremap = true, silent = true })
                vim.keymap.set('n', '<leader>w', '<cmd>HopWord<cr>', { noremap = true, silent = true })
            end,
            config = function()
                require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
            end
        }

        -- test
        use {
            'klen/nvim-test',
            setup = function()
                vim.keymap.set('n', '<leader>tn', '<cmd>TestNearest<cr>', { noremap = true, silent = true })
                vim.keymap.set('n', '<leader>tf', '<cmd>TestFile<cr>', { noremap = true, silent = true })
                vim.keymap.set('n', '<leader>ts', '<cmd>TestSuite<cr>', { noremap = true, silent = true })
                vim.keymap.set('n', '<leader>tl', '<cmd>TestLast<cr>', { noremap = true, silent = true })
                vim.keymap.set('n', '<leader>tv', '<cmd>TestVisit<cr>', { noremap = true, silent = true })
            end,
            config = function()
                require 'nvim-test'.setup {
                    run = true, -- run tests (using for debug)
                    commands_create = true, -- create commands (TestFile, TestLast, ...)
                    filename_modifier = ':.', -- modify filenames before tests run(:h filename-modifiers)
                    silent = false, -- less notifications
                    term = 'terminal', -- a terminal to run ('terminal'|'toggleterm')
                    termOpts = {
                        direction = 'vertical', -- terminal's direction ('horizontal'|'vertical'|'float')
                        width = 96, -- terminal's width (for vertical|float)
                        height = 24, -- terminal's height (for horizontal|float)
                        go_back = false, -- return focus to original window after executing
                        stopinsert = 'auto', -- exit from insert mode (true|false|'auto')
                        keep_one = true, -- keep only one terminal for testing
                    },
                    runners = { -- setup tests runners
                        cs = 'nvim-test.runners.dotnet',
                        go = 'nvim-test.runners.go-test',
                        haskell = 'nvim-test.runners.hspec',
                        javacriptreact = 'nvim-test.runners.jest',
                        javascript = 'nvim-test.runners.jest',
                        lua = 'nvim-test.runners.busted',
                        python = 'nvim-test.runners.pytest',
                        ruby = 'nvim-test.runners.rspec',
                        rust = 'nvim-test.runners.cargo-test',
                        typescript = 'nvim-test.runners.jest',
                        typescriptreact = 'nvim-test.runners.jest',
                    }
                }
            end,
        }

        -- open in browser
        use {
            'tyru/open-browser.vim',
            'tyru/open-browser-github.vim',
        }

        -- teraform
        use {
            'hashivim/vim-terraform',
        }
    end,
}

---------
-- LSP --
---------
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local map = vim.api.nvim_buf_set_keymap
    map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    map(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    map(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    map(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    map(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    map(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    map(0, 'n', '<leader>rn', '<cmd>Lspsaga rename<cr>', opts)
    map(0, 'n', '<leader>x', '<cmd>Lspsaga code_action<cr>', opts)
    map(0, 'x', '<leader>x', ':<c-u>Lspsaga range_code_action<cr>', opts)
    map(0, 'n', 'K', '<cmd>Lspsaga hover_doc<cr>', opts)
    map(0, 'n', '<leader>E', '<cmd>Lspsaga show_line_diagnostics<cr>', opts)
    map(0, 'n', '[e', '<cmd>Lspsaga diagnostic_jump_next<cr>', opts)
    map(0, 'n', ']e', '<cmd>Lspsaga diagnostic_jump_prev<cr>', opts)
    map(0, 'n', '<C-u>', '<cmd>lua require "lspsaga.action".smart_scroll_with_saga(-1, "<c-u>")<cr>', {})
    map(0, 'n', '<C-d>', '<cmd>lua require "lspsaga.action".smart_scroll_with_saga(1, "<c-d>")<cr>', {})
end

local lsp_installer = require 'nvim-lsp-installer'
local lspconfig = require 'lspconfig'
lsp_installer.setup()
for _, server in ipairs(lsp_installer.get_installed_servers()) do
    lspconfig[server.name].setup {
        on_attach = on_attach,
        capabilities = require 'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    }
end

----------------
-- completion --
----------------
local cmp = require 'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

local lspkind = require 'lspkind'
cmp.setup {
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            before = function(_, vim_item)
                return vim_item
            end
        })
    }
}
