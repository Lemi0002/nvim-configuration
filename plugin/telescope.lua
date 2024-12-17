-- Use protected call
local status_ok, telescope = pcall(require, 'telescope')

if not status_ok then
    print('telescope not found')
    return
end

-- Configure settings
telescope.setup({
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
})

telescope.load_extension('fzf')

-- Reconfigure highlights
vim.cmd.highlight('clear TelescopePromptCounter')
vim.cmd.highlight('link TelescopePromptCounter TelescopePromptNormal')

-- Package specific keymaps
local telescope_builtin = require('telescope.builtin')
local telescope_finders = require('telescope.finders')
local telescope_pickers = require('telescope.pickers')
local telescope_make_entry = require('telescope.make_entry')
local telescope_config = require('telescope.config')
local telescope_sorters = require('telescope.sorters')

local live_multigrep = function(opts)
    opts = opts or {}
    opts.cwd = opts.cwd or vim.uv.cwd()

    local finder = telescope_finders.new_async_job({
        command_generator = function(input)
            if not input or input == '' then
                return nil
            end

            local pieces = vim.split(input, '  ')
            local arguments = { 'rg' }

            if pieces[1] then
                table.insert(arguments, '-e')
                table.insert(arguments, pieces[1])
            end

            if pieces[2] then
                table.insert(arguments, '-g')
                table.insert(arguments, pieces[2])
            end

            table.insert(arguments, '--color=never')
            table.insert(arguments, '--no-heading')
            table.insert(arguments, '--with-filename')
            table.insert(arguments, '--line-number')
            table.insert(arguments, '--column')
            table.insert(arguments, '--smart-case')
            return arguments
        end,
        entry_maker = telescope_make_entry.gen_from_vimgrep(opts),
        cwd = opts.cwd,
    })

    telescope_pickers.new(opts, {
        prompt_title = 'Live Multi Grep',
        finder = finder,
        previewer = telescope_config.values.grep_previewer(opts),
        sorter = telescope_sorters.empty(),
    }):find()
end

vim.keymap.set('n', '<leader>ot', telescope_builtin.builtin, { desc = 'Open telescope' })
vim.keymap.set('n', '<leader>dl', telescope_builtin.diagnostics, { desc = 'Open diagnostics' })
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.git_files, { desc = 'Find files in git' })
vim.keymap.set('n', '<leader>fp',
    function()
        local data_path = vim.fn.stdpath('data')
        if type(data_path) == 'table' then
            data_path = data_path[1]
        end
        telescope_builtin.find_files({ cwd = vim.fs.joinpath(data_path, 'site', 'pack', 'packer', 'start') })
    end,
    { desc = 'Find files in packages' }
)
vim.keymap.set('n', '<leader>sh', telescope_builtin.help_tags, { desc = 'Search for word in help' })
vim.keymap.set('n', '<leader>sp', telescope_builtin.grep_string, { desc = 'Search for word under cursor in files' })
vim.keymap.set('n', '<leader>sl', live_multigrep, { desc = 'Search live for word in files' })
vim.keymap.set('n', '<leader>sg',
    function()
        telescope_builtin.grep_string({ search = vim.fn.input("Search: ") });
    end,
    { desc = 'Search for word in files' }
)
