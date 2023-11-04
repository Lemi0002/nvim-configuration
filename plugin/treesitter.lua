-- Use protected call
local status_ok, configs = pcall(require, 'nvim-treesitter.configs')

if not status_ok then
    print('nvim-treesitter not found')
    return
end

-- Configure settings
configs.setup({
    ensure_installed = { 'c', 'lua', 'vim', 'query' },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
})
