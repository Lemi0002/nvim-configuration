local run_current_file = function()
    local extension = 'build.bat'
    local path = vim.fn.expand('%:h')
    local name = vim.fn.expand('%:t:r')
    local file = name .. '_' .. extension
    local file_run = vim.fn.expand(path .. '/' .. file)
    local file_run_generic = vim.fn.expand(path .. '/' .. extension)

    if vim.fn.filereadable(file_run) == 1 then
        vim.cmd('!"' .. file_run .. '"')
    elseif vim.fn.filereadable(file_run_generic) == 1 then
        vim.cmd('!"' .. file_run_generic .. '"')
    else
        print(file .. ' and ' .. extension .. ' not found')
    end
end

-- General keymaps
vim.keymap.set('n', '\u{00F6}', '/')
vim.keymap.set('n', '<leader>oe', vim.cmd.Ex)
vim.keymap.set('n', '<leader>th', '<cmd>set invhls<CR>')
vim.keymap.set('n', '<leader>ts', '<cmd>set invspell<CR>')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'G', 'Gzz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '<leader>d', '"*d')
vim.keymap.set('n', '<leader>y', '"*y')
vim.keymap.set('n', '<leader>p', '"*p')
vim.keymap.set('n', '<leader>P', '"*P')
vim.keymap.set('n', '<leader>.', '10<C-w>>')
vim.keymap.set('n', '<leader>-', '10<C-w><')
vim.keymap.set('n', '<leader>:', '10<C-w>+')
vim.keymap.set('n', '<leader>_', '10<C-w>-')
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>rb', '<cmd>!build.bat<CR>')
vim.keymap.set('n', '<leader>rB', ':!build.bat')
vim.keymap.set('n', '<leader>rf', run_current_file)
vim.keymap.set('v', '<leader>d', '"*d')
vim.keymap.set('v', '<leader>y', '"*y')
vim.keymap.set('v', '<leader>p', '"*p')
vim.keymap.set('v', '<leader>P', '"*P')
