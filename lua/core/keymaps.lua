local status_ok, globals = pcall(require, 'core.globals')

if not status_ok then
    print('globals not found')
    return
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
vim.keymap.set('n', '<leader>sr', ':%s/', { desc = 'Search and replace' })
vim.keymap.set('n', '<leader>.', '10<C-w>>', { desc = 'Shrink window horizontally' })
vim.keymap.set('n', '<leader>-', '10<C-w><', { desc = 'Expand window horizontally' })
vim.keymap.set('n', '<leader>:', '10<C-w>+', { desc = 'Shrink window vertically' })
vim.keymap.set('n', '<leader>_', '10<C-w>-', { desc = 'Expand window vertically' })
vim.keymap.set('n', '<leader>m', '\'', { desc = 'Remap for marks' })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Open diagnostics panel' })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Open next diagnostics panel' })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Open previous diagnostics panel' })
vim.keymap.set('n', '<leader>rb', globals.run_build, { desc = 'Run build script' })
vim.keymap.set('n', '<leader>xn', globals.export_current_file_name, { desc = 'Export file name to system clipboard' })
vim.keymap.set('n', '<leader>xp', globals.export_current_file_path, { desc = 'Export file path to system clipboard' })
vim.keymap.set('v', '<leader>d', '"+d', { desc = 'Delete to system clipboard' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('v', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('v', '<leader>P', '"+P', { desc = 'Paste from system clipboard' })
vim.keymap.set('v', '<leader>sr', ':s/', { desc = 'Search and replace' })
vim.keymap.set('v', 'J', ':move \'>+1<CR>gv=gv', { desc = 'Move visually selected range down' })
vim.keymap.set('v', 'K', ':move \'<-2<CR>gv=gv', { desc = 'Move visually selected range up' })
vim.keymap.set('v', '<leader>m', '\'', { desc = 'Remap for marks' })
