-- Use protected call
local status_ok, comment = pcall(require, 'Comment')

if not status_ok then
    print('comment not found')
    return
end

-- Configure settings
comment.setup({
    toggler = {
        line = '<leader>clt',
        block = '<leader>cbt'
    },
    opleader = {
        line = '<leader>cl',
        block = '<leader>cb'
    },
    extra = {
        above = '<leader>clO',
        below = '<leader>clo',
        eol = '<leader>clA'
    },
    mappings = {
        extra = true
    }
})
