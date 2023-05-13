-- Use protected call
local status_ok, luasnip = pcall(require, 'luasnip')

if not status_ok then
    print('luasnip not found')
    return
end

-- Package specific keymaps
vim.keymap.set('i', '<C-j>', function() luasnip.jump(1) end)
vim.keymap.set('i', '<C-k>', function() luasnip.jump(-1) end)
