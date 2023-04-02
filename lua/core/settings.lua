local settings = {}

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
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Use spaces instead of tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

-- Show invisible characters
vim.opt.listchars = 'tab:<->,space:\u{00B7},multispace:\u{00B7}\u{00B7}\u{00B7}|'
vim.opt.list = true

-- Disable startup screen
vim.opt.shortmess = 'I'

-- Completion
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Disable diagnostic virtual text and set border type
local border = 'rounded'
package.preload.settings = function() return {border = border} end
settings.boder = border

vim.diagnostic.config({
    virtual_text = false,
    float = { border = border },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = border
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = border
    }
)

-- Default color scheme
status_ok = pcall(vim.cmd.colorscheme, 'sonokai')

if not status_ok then
    vim.cmd.colorscheme('slate')
end

-- Reset floating window color
vim.api.nvim_set_hl(0, 'FloatBorder', {})
vim.api.nvim_set_hl(0, 'NormalFloat', {})

return settings
