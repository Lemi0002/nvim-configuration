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

vim.keymap.set('n', '<leader>ot', telescope_builtin.builtin)
vim.keymap.set('n', '<leader>dl', telescope_builtin.diagnostics)
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files)
vim.keymap.set('n', '<leader>fp', telescope_builtin.git_files)
vim.keymap.set('n', '<leader>sp', telescope_builtin.grep_string)
vim.keymap.set('n', '<leader>sg', function()
    telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
