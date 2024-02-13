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
vim.opt.mouse = nil
vim.opt.cmdwinheight = 20

-- Netrw settings
vim.g.netrw_banner = false

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

-- Spellchecking
vim.opt.spelllang = { 'en_us', 'de_ch' }

-- Default color scheme
local colorscheme = 'sonokai'

vim.api.nvim_create_autocmd('ColorSchemePre', {
    group = vim.api.nvim_create_augroup('SonokaiPre', {}),
    pattern = { 'sonokai' },
    callback = function(args)
        vim.cmd.set('termguicolors')
        vim.g.sonokai_enable_italic = 0
        vim.g.sonokai_disable_italic_comment = 1
        vim.g.sonokai_colors_override = {
            bg0 = { '#1d1f21', '235' },
            bg1 = { '#373737', '236' },
            bg2 = { '#414141', '236' },
            bg3 = { '#464646', '237' },
            bg4 = { '#505050', '237' },
        }
    end,
})

local status_ok = pcall(vim.cmd.colorscheme, colorscheme)

if not status_ok then
    vim.cmd.colorscheme('slate')
end

-- Disable italics
vim.cmd.highlight('Comment cterm=NONE gui=NONE')
vim.cmd.highlight('TSEmphasis cterm=NONE gui=NONE')

-- Reconfigure highlights
vim.cmd.highlight('InfoFloat ctermbg=None guibg=None')
vim.cmd.highlight('HintFloat ctermbg=None guibg=None')
vim.cmd.highlight('WarningFloat ctermbg=None guibg=None')
vim.cmd.highlight('ErrorFloat ctermbg=None guibg=None')
vim.cmd.highlight('clear NormalFloat')
vim.cmd.highlight('clear FloatBorder')
vim.cmd.highlight('clear LspInfoBorder')
vim.cmd.highlight('link NormalFloat Normal')
vim.cmd.highlight('link FloatBorder Normal')
vim.cmd.highlight('link LspInfoBorder Normal')

-- Disable highlights for transparency
vim.cmd.highlight('Normal ctermbg=None guibg=None')
vim.cmd.highlight('NormalNC ctermbg=None guibg=None')
vim.cmd.highlight('NonText ctermbg=None guibg=None')

-- Disable diagnostic virtual text and set border type
settings.border = 'rounded'

vim.diagnostic.config({
    virtual_text = false,
    float = { border = settings.border },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = settings.border
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = settings.border
    }
)

package.preload.settings = function() return { border = settings.border } end
return settings
