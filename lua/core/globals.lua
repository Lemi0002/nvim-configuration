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

globals.run_build = function(file_mode)
    local configuration = {
        name = 'build',
        extensions = {
            { name = '.py',  command = 'pyhton' },
            { name = '.sh',  command = 'bash' },
            { name = '.bat', command = '' },
        },
        delimiter = '_',
    }

    local file_path = vim.fn.expand('%:h')
    local file_name = vim.fn.expand('%:t')
    local file_name_root = vim.fn.expand('%:t:r')
    local file
    local file_extension
    local file_found = false

    if file_mode == true then
        for _, extension in ipairs(configuration.extensions) do
            file = vim.fn.expand(
                file_path ..
                '/' ..
                file_name_root ..
                configuration.delimiter ..
                configuration.name ..
                extension.name
            )

            if vim.fn.filereadable(file) == 1 then
                file_found = true
                file_extension = extension
                goto file_found
            end
        end

        for _, extension in ipairs(configuration.extensions) do
            file = vim.fn.expand(
                file_path ..
                '/' ..
                configuration.name ..
                extension.name
            )

            if vim.fn.filereadable(file) == 1 then
                file_found = true
                file_extension = extension
                break
            end
        end

        ::file_found::
        if file_found then
            vim.cmd('!' .. file_extension.command .. ' "' .. file .. '" "' .. file_name .. '"')
        else
            print(
                '"' ..
                file_name_root ..
                configuration.delimiter ..
                configuration.name ..
                '" and local "' ..
                configuration.name ..
                '" not found'
            )
        end
    else
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
end

local command_prefix = 'Global'
vim.api.nvim_create_user_command(command_prefix .. 'GetFileNames', globals.get_file_names, {})
return globals
