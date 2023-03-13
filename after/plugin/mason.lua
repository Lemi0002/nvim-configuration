-- Use protected call
local status_ok, mason = pcall(require, 'mason')

if not status_ok then
    print('mason not found')
    return
end

-- Configure settings
mason.setup({
    ui = {
        icons = {
            package_installed = '\u{f00c}',
            package_pending = '\u{f061}',
            package_uninstalled = '\u{f00d}'
        }
    }
})
