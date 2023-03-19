-- Use protected call
local status_ok, gitsigns = pcall(require, 'gitsigns')

if not status_ok then
    print('gitsigns not found')
    return
end

-- Configure settings
gitsigns.setup()
