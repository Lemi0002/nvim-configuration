-- Use protected call
local status_ok, monokai = pcall(require, 'monokai')

if not status_ok then
    print('monokai not found')
    return
end

