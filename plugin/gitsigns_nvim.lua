-- Use protected call
local status_ok, gitsigns = pcall(require, 'gitsigns')

if not status_ok then
    print('gitsigns not found')
    return
end

-- Configure settings
gitsigns.setup()

-- Package specific keymaps
vim.keymap.set('n', '<leader>gn', gitsigns.next_hunk, { desc = 'Got to next git hunk' })
vim.keymap.set('n', '<leader>gp', gitsigns.prev_hunk, { desc = 'Got to previous git hunk' })
