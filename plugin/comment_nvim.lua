-- Use protected call
local status_ok, comment = pcall(require, 'Comment')

if not status_ok then
    print('comment not found')
    return
end

-- Configure settings
comment.setup({
    toggler = {
        line = '<leader>cl',
        block = '<leader>cb'
    },
    opleader = {
        line = '<leader>cl',
        block = '<leader>cb'
    },
    mappings = {
        extra = false,
    }
})
