local status_ok, lspconfig = pcall(require, 'lspconfig')

if not status_ok then
    print('lspconfig not found')
    return
end

-- Required dependencies by this package
local cmp_nvim_lsp
local mason
local mason_lspconfig

status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')

if not status_ok then
    print('cmp_nvim_lsp not found')
    return
end

status_ok, mason = pcall(require, 'mason')

if not mason then
    print('mason not found')
    return
end

status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

if not mason_lspconfig then
    print('mason-lspconfig not found')
    return
end

-- Configure mason plugins
mason.setup({
    ui = {
        icons = {
            package_installed = '\u{f00c}',
            package_pending = '\u{f061}',
            package_uninstalled = '\u{f00d}'
        }
    }
})
mason_lspconfig.setup()

-- Configure language servers
local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.pyright.setup({
    capabilities = capabilities,
})
lspconfig.clangd.setup({
    capabilities = capabilities,
})
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        runtime = {
            version = 'LuaJIT',
        },
        diagnostics = {
            globals = { 'vim' },
        },
        workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = {
            enable = false,
        },
    },
})

-- Buffer specific keymaps
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', 'gQ', vim.lsp.buf.format, opts)
        vim.keymap.set('n', '<leader>rl', vim.lsp.buf.rename, opts)
        -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        --[[ vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts) ]]
        -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    end,
})
