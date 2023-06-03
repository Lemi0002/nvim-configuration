local get_file_names = function()
    local keyword = vim.fn.input('Keyword: ')

    vim.fn.jobstart('rg --files --sort path | rg --fixed-strings "' .. keyword .. '"', {
        stdout_buffered = true,
        on_stdout = function (_, data)
            vim.api.nvim_buf_set_lines(0, 0, -1, false, data)
        end ,
    })
end

local export_current_file_name = function()
    local name = vim.fn.expand('%:t')
    vim.fn.setreg('+', name)
    print('Copied file name to system clipboard')
end

local export_current_file_path = function()
    local path = vim.fn.expand('%')
    vim.fn.setreg('+', path)
    print('Copied file path to system clipboard')
end

local run_current_file = function()
    local extension = 'build.bat'
    local delimiter = '_'
    local path = vim.fn.expand('%:h')
    local name_full = vim.fn.expand('%:t')
    local name_cropped = vim.fn.expand('%:t:r')
    local file = name_cropped .. delimiter .. extension
    local file_run = vim.fn.expand(path .. '/' .. file)
    local file_run_generic = vim.fn.expand(path .. '/' .. extension)

    if vim.fn.filereadable(file_run) == 1 then
        vim.cmd('!"' .. file_run .. '" "' .. name_full .. '"')
    elseif vim.fn.filereadable(file_run_generic) == 1 then
        vim.cmd('!"' .. file_run_generic .. '" "' .. name_full .. '"')
    else
        print(file .. ' and ' .. extension .. ' not found')
    end
end

-- General keymaps
vim.keymap.set('n', '\u{00F6}', '/')
vim.keymap.set('n', '<leader>oe', vim.cmd.Ex, { desc = 'Open Netrw' })
vim.keymap.set('n', '<leader>th', '<cmd>set invhls<CR>', { desc = 'Toggle search highlighting' })
vim.keymap.set('n', '<leader>ts', '<cmd>set invspell<CR>', { desc = 'Toggle spell checking' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })
vim.keymap.set('n', 'G', 'Gzz', { desc = 'Go to bottom and center' })
vim.keymap.set('n', 'n', 'nzz', { desc = 'Go to next result and center' })
vim.keymap.set('n', 'N', 'Nzz', { desc = 'Go to previous result and center' })
vim.keymap.set('n', '<leader>d', '"+d', { desc = 'Delete to system clipboard' })
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<leader>P', '"+P', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<leader>.', '10<C-w>>', { desc = 'Shrink window horizontally' })
vim.keymap.set('n', '<leader>-', '10<C-w><', { desc = 'Expand window horizontally' })
vim.keymap.set('n', '<leader>:', '10<C-w>+', { desc = 'Shrink window vertically' })
vim.keymap.set('n', '<leader>_', '10<C-w>-', { desc = 'Expand window vertically' })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Open diagnostics panel' })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Open next diagnostics panel' })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Open previous diagnostics panel' })
vim.keymap.set('n', '<leader>rb', '<cmd>!build.bat<CR>', { desc = 'Run build script' })
vim.keymap.set('n', '<leader>rB', ':!build.bat', { desc = 'Run build script' })
vim.keymap.set('n', '<leader>rf', run_current_file, { desc = 'Run build script of current file' })
vim.keymap.set('n', '<leader>xn', export_current_file_name, { desc = 'Export file name to system clipboard' })
vim.keymap.set('n', '<leader>xp', export_current_file_path, { desc = 'Export file path to system clipboard' })
vim.keymap.set('v', '<leader>d', '"+d', { desc = 'Delete to system clipboard' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('v', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('v', '<leader>P', '"+P', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<leader>gf', get_file_names, {desc = 'Get files names with keyword'})
