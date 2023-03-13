-- Use protected call
local status_ok, nvim_terminal = pcall(require, 'nvim-terminal')

if not status_ok then
    print('nvim-terminal not found')
    return
end

-- Configure settings
vim.o.hidden = true

nvim_terminal.setup({
    window_height_change_amount = 4,
    window_width_change_amount = 4,
})
