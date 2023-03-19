-- Leader settings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- General settings
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.showcmd = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'

-- Use spaces instead of tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

-- Show invisible characters
vim.opt.listchars = 'tab:<->,space:\u{00B7},multispace:\u{00B7}\u{00B7}\u{00B7}|'
vim.opt.list = true

-- Use system clipboard with y and p
--vim.opt.clipboard = unnamedplus

-- Disable startup screen
vim.opt.shortmess = 'I'

-- Default color scheme
local status_ok = pcall(vim.cmd.colorscheme, 'sonokai')

if not status_ok then
    vim.cmd.colorscheme('slate')
end
