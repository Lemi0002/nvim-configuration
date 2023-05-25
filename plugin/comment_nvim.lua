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
        block = '<leader>ck'
    },
    opleader = {
        line = '<leader>cL',
        block = '<leader>cK'
    },
    mappings = {
        extra = false,
    }
})
