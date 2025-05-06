local status_ok, lspconfig = pcall(require, 'lspconfig')

if not status_ok then
    print('lspconfig not found')
    return
end

local lspconfig_ui_windows = require('lspconfig.ui.windows')

-- Required dependencies by this package
local settings
local cmp_nvim_lsp
local mason
local mason_lspconfig
local mason_tool_installer

status_ok, settings = pcall(require, 'settings')

if not status_ok then
    print('settings not found')
    return
end

status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')

if not status_ok then
    print('cmp_nvim_lsp not found')
    return
end

status_ok, mason = pcall(require, 'mason')

if not status_ok then
    print('mason not found')
    return
end

status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

if not status_ok then
    print('mason-lspconfig not found')
    return
end

status_ok, mason_tool_installer = pcall(require, 'mason-tool-installer')

if not status_ok then
    print('mason-tool-installer not found')
    return
end

-- Configure mason plugins
mason.setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Lemi0002/mason-registry",
    },
    ui = {
        border = settings.border,
        icons = {
            package_installed = '\u{f00c}',
            package_pending = '\u{f061}',
            package_uninstalled = '\u{f00d}',
        },
    }
})
mason_lspconfig.setup()
mason_tool_installer.setup({
    ensure_installed = {
        'autopep8',
        'bash-language-server',
        'clang-format',
        'clangd',
        'gopls',
        'lua-language-server',
        'pyright',
        'rust_analyzer',
        'texlab',
        'vhdl_ls',
    }
})

-- Configure language servers
local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.bashls.setup {
    capabilities = capabilities,
}
lspconfig.clangd.setup({
    capabilities = capabilities,
})
lspconfig.gopls.setup({
    capabilities = capabilities,
})
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
lspconfig.pyright.setup({
    capabilities = capabilities,
})
lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                allFeatures = true,
            },
        },
    },
})
lspconfig.texlab.setup({
    capabilities = capabilities,
    filetypes = {
        'tex',
        'plaintex',
        'bib'
    },
    single_file_support = true,
})
lspconfig.vhdl_ls.setup({
    capabilities = capabilities,
    cmd = {
        'vhdl_ls',
    },
    filetypes = {
        'vhd',
        'vhdl',
    },
    single_file_support = true,
})

-- Buffer specific keymaps
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = args.buf, desc = 'Go to declaration' })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, desc = 'Go to definition' })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = args.buf, desc = 'Go to implementation' })
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = args.buf, desc = 'Go to type definition' })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = args.buf, desc = 'Show references' })
        vim.keymap.set('n', 'K', 
            function() 
                vim.lsp.buf.hover({
                    border=settings.border,
                })
            end,
            { buffer = args.buf, desc = 'Show hover information' })
        vim.keymap.set('n', '<C-k>',
            function() 
                vim.lsp.buf.signature_help({
                    border=settings.border,
                })
            end,
            { buffer = args.buf, desc = 'Show signature information' })
        vim.keymap.set('n', 'gQ', vim.lsp.buf.format, { buffer = args.buf, desc = 'Go to declaration' })
        vim.keymap.set('n', '<leader>rl', vim.lsp.buf.rename, { buffer = args.buf, desc = 'Rename symbol' })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = args.buf, desc = 'Run code action' })
    end,
})

-- Configure lspconfig
lspconfig_ui_windows.default_options.border = settings.border
