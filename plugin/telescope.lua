-- Use protected call
local status_ok, telescope = pcall(require, 'telescope')

if not status_ok then
    print('telescope not found')
    return
end

-- Configure settings
telescope.setup()

-- Reconfigure highlights
vim.cmd.highlight('clear TelescopePromptCounter')
vim.cmd.highlight('link TelescopePromptCounter TelescopePromptNormal')

-- Package specific keymaps
local telescope_builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ot', telescope_builtin.builtin, { desc = 'Open telescope' })
vim.keymap.set('n', '<leader>dl', telescope_builtin.diagnostics, { desc = 'Open diagnostics' })
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fp', telescope_builtin.git_files, { desc = 'Find files in git' })
vim.keymap.set('n', '<leader>sp', telescope_builtin.grep_string, { desc = 'Search for word under cursor in files' })
vim.keymap.set('n', '<leader>sg', function()
    telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, { desc = 'Search for word in files' })
