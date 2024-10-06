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

globals.run_build = function()
    local configuration = {
        name = 'build',
        extensions = {
            { name = '.py',  command = 'python' },
            { name = '.sh',  command = 'bash' },
            { name = '.bat', command = '' },
        },
        delimiter = '_',
    }

    local file
    local file_extension
    local file_found = false

    for _, extension in ipairs(configuration.extensions) do
        file = vim.fn.expand(configuration.name .. extension.name)

        if vim.fn.filereadable(file) == 1 then
            file_found = true
            file_extension = extension
            break
        end
    end

    if file_found then
        vim.cmd('!' .. file_extension.command .. ' "' .. file .. '"')
    else
        print('"' .. configuration.name .. '" not found')
    end
end

local command_prefix = 'Global'
vim.api.nvim_create_user_command(command_prefix .. 'GetFileNames', globals.get_file_names, {})
return globals
