-- Use protected call
local status_ok, nvim_treesitter_configs = pcall(require, 'nvim-treesitter.configs')

if not status_ok then
    print('nvim-treesitter not found')
    return
end

-- Configure settings
nvim_treesitter_configs.setup({
    ensure_installed = { 'c', 'lua', 'vim', 'query', 'diff', 'git_rebase' },
    ignore_install = {},
    modules = {},
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
})
