-- Use protected call
local status_ok, nvim_tree = pcall(require, 'nvim-tree')

if not status_ok then
    print('nvim-tree not found')
    return
end

-- Configure settings
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

nvim_tree.setup()

