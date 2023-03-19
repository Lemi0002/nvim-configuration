-- Use protected call
local status_ok, nvim_web_devicons = pcall(require, 'nvim-web-devicons')

if not status_ok then
    print('nvim-web-devicons not found')
    return
end

-- Configure settings
nvim_web_devicons.setup({
    default = true,
})
