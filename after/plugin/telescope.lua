-- Use protected call
local status_ok, telescope = pcall(require, 'telescope')

if not status_ok then
    print('telescope not found')
    return
end

-- Configure settings
telescope.setup()

telescope_builtin = require('telescope.builtin')

-- Setup keymaps
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fp', telescope_builtin.git_files, {})
vim.keymap.set('n', '<leader>sp', telescope_builtin.grep_string, {})
vim.keymap.set('n', '<leader>sg', function()
    telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
