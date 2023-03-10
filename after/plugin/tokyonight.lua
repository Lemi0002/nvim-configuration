-- Use protected call
local status_ok, tokyonight = pcall(require, 'tokyonight')

if not status_ok then
    print('tokyonight not found')
    return
end
