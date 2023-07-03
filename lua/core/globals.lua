local globals = {}

P = function(argument)
    print(vim.inspect(argument))
end

globals.get_file_names = function()
    local keyword = vim.fn.input('Keyword: ')
    local position = vim.api.nvim_win_get_cursor(0)

    vim.fn.jobstart('rg --files --sort path | rg --fixed-strings "' .. keyword .. '"', {
        stdout_buffered = true,
        on_stdout = function(_, data)
            vim.api.nvim_buf_set_lines(0, position[1], position[1], false, data)
        end,
    })
end

globals.export_current_file_name = function()
    local name = vim.fn.expand('%:t')
    vim.fn.setreg('+', name)
    print('Copied file name to system clipboard')
end

globals.export_current_file_path = function()
    local path = vim.fn.expand('%')
    vim.fn.setreg('+', path)
    print('Copied file path to system clipboard')
end

globals.run_current_file = function()
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

globals.run_project = function()
    local file_run_generic = 'build.bat'

    if vim.fn.filereadable(file_run_generic) == 1 then
        vim.cmd('!"' .. file_run_generic .. '"')
    else
        print(file_run_generic .. ' not found')
    end
end

local command_prefix = 'Global'
vim.api.nvim_create_user_command(command_prefix .. 'GetFileNames', globals.get_file_names, {})
return globals
