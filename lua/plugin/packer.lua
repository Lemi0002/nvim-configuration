-- Install packer on any machine on first execution
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    print('Installed packer. Close and reopen nvim and use :PackerSync')
end

-- Use a protected call
local status_ok, packer = pcall(require, 'packer')

if not status_ok then
    return
end

-- Install plugins
packer.startup(function(use)
    use('wbthomason/packer.nvim')
    use('sainnhe/sonokai')
    use('nvim-tree/nvim-web-devicons')
    use({
        'nvim-lualine/lualine.nvim',
        requires = {
            { 'nvim-tree/nvim-web-devicons' },
        },
    })
    use(
        'nvim-treesitter/nvim-treesitter',
        { run = ':TSUpdate' }
    )
    use('nvim-treesitter/playground')
    use({
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        },
    })
    use('neovim/nvim-lspconfig')
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('saadparwaiz1/cmp_luasnip')
    use('hrsh7th/cmp-nvim-lua')
    use('L3MON4D3/LuaSnip')
    use('williamboman/mason.nvim')
    use('williamboman/mason-lspconfig.nvim')
    use('WhoIsSethDaniel/mason-tool-installer.nvim')
    use('lewis6991/gitsigns.nvim')
    use('numToStr/Comment.nvim')
    use('rstacruz/vim-closer')
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    use({
        'sudormrfbin/cheatsheet.nvim',
        requires = {
            { 'nvim-telescope/telescope.nvim' },
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
        },
    })
end)
