-- Install packer on any machine on first execution
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    print('Installed packer. Close and reopen nvim and use :PackerSync')
end

-- Use a protected call to not error out on first use
local status_ok, packer = pcall(require, 'packer')

if not status_ok then
    return
end

-- Install plugins
packer.startup(function()
    use('wbthomason/packer.nvim')
    use('tanvirtin/monokai.nvim')
    use('folke/tokyonight.nvim')
    use('sainnhe/sonokai')
    use('nvim-tree/nvim-web-devicons')
    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons' }
    })
    --use('preservim/nerdtree')
    use(
        'nvim-treesitter/nvim-treesitter',
        { run = ':TSUpdate' }
    )
    use({
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = {
            { 'nvim-lua/plenary.nvim' }
        }
    })
    use({
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    })
    use('lewis6991/gitsigns.nvim')
    use('s1n7ax/nvim-terminal')
    use('numToStr/Comment.nvim')
    use('rstacruz/vim-closer')
    use({
        'sudormrfbin/cheatsheet.nvim',
        requires = {
            { 'nvim-telescope/telescope.nvim' },
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
        }
    })
end)
