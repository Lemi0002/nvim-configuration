-- Use protected call
local status_ok, telescope = pcall(require, 'telescope')

if not status_ok then
    print('telescope not found')
    return
end

-- Configure settings
telescope.setup()

builtin = require('telescope.builtin')

-- Setup keymaps
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fp', builtin.git_files, {})
vim.keymap.set('n', '<leader>sp', builtin.grep_string, {})
vim.keymap.set('n', '<leader>sg', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
