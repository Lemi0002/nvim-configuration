-- Use protected call
local status_ok, configs = pcall(require, 'nvim-treesitter.configs')

if not status_ok then
    print('nvim-treesitter not found')
    return
end

-- Configure settings
configs.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { 'c', 'lua', 'vim', 'help', 'query' },

    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
}
