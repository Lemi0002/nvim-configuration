-- Use protected call
local status_ok, lsp_zero = pcall(require, 'lsp-zero')

if not status_ok then
    print('lsp-zero not found')
    return
end

local lsp = lsp_zero.preset({
    name = 'minimal',
    set_lsp_keymaps = { omit = { '<F2>', '[d', ']d' } },
    manage_nvim_cmp = true,
    suggest_lsp_servers = true,
})

-- General keymaps
lsp.on_attach(function(client, bufnr)
    local options = { buffer = bufnr }

    vim.keymap.set('n', '<leader>rl', vim.lsp.buf.rename, options)
    vim.keymap.set('n', 'gQ', vim.lsp.buf.format, options)
    vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, options)
    vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, options)
    vim.keymap.set('n', '<leader>dl', '<cmd>Telescope diagnostics<cr>', options)
end)

lsp.setup()
