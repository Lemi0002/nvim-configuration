-- Use protected call
local status_ok, builtin = pcall(require, 'telescope.builtin')

if not status_ok then
    print('telescope not found')
    return
end

-- Setup keymaps
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fp', builtin.git_files, {})
vim.keymap.set('n', '<leader>sp', function()
    builtin.grep_string({search = vim.fn.input("Grep > ")});
end)

