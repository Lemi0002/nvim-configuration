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
        border = settings.border,
        icons = {
            package_installed = '\u{f00c}',
            package_pending = '\u{f061}',
            package_uninstalled = '\u{f00d}',
        },
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
lspconfig.texlab.setup({
    capabilities = capabilities,
    single_file_support = true,
    filetypes = {
        'tex',
        'plaintex',
        'bib'
    },
})
--[[ lspconfig.hdl_checker.setup({
    default_config = {
        cmd = {
            'hdl_checker',
            '--lsp',
        },
        filetypes = {
            'vhdl',
            'verilog',
            'systemverilog'
        },
        root_dir = function(fname)
            -- will look for the .hdl_checker.config file in parent directory, a
            -- .git directory, or else use the current directory, in that order.
            local util = require 'lspconfig'.util
            return util.root_pattern('.hdl_checker.config')(fname) or util.find_git_ancestor(fname) or
                util.path.dirname(fname)
        end,
        settings = {},
    },
}) ]]

-- Buffer specific keymaps
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(args)
        local opts = { buffer = args.buf }
        local client = vim.lsp.get_client_by_id(args.data.client_id)

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
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    end,
})

-- Configure lspconfig
lspconfig_ui_windows.default_options.border = settings.border