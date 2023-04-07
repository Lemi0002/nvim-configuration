-- Use protected call
local status_ok, null_ls = pcall(require, 'null-ls')

if not status_ok then
    print('null-ls not found')
    return
end

-- Required dependencies by this package
local settings

status_ok, settings = pcall(require, 'settings')

if not status_ok then
    print('settings not found')
    return
end

-- Configure settings
null_ls.setup({
    border = settings.border,
    sources = {
        null_ls.builtins.formatting.autopep8,
    },
})
