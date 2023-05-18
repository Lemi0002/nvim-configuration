-- Use protected call
local status_ok, luasnip = pcall(require, 'luasnip')

if not status_ok then
    print('luasnip not found')
    return
end

-- Package specific keymaps
vim.keymap.set('i', '<C-j>', function() luasnip.jump(1) end)
vim.keymap.set('i', '<C-k>', function() luasnip.jump(-1) end)
vim.keymap.set('i', '<C-h>', function() luasnip.change_choice(1) end)
vim.keymap.set('s', '<C-h>', function() luasnip.change_choice(1) end)

-- Define snippets
local s = luasnip.snippet
local sn = luasnip.snippet_node
local isn = luasnip.indent_snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node
local c = luasnip.choice_node
local d = luasnip.dynamic_node
local r = luasnip.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = luasnip.multi_snippet

luasnip.add_snippets('vhdl', {
    s('entitiy',
        fmt([[
            entity {} is

            end entity {};
        ]], {
            i(1, 'entitiy_name'),
            rep(1),
        })
    ),
    s('architecture',
        fmt([[
            architecture {} of {} is
            begin

            end architecture {};
        ]], {
            i(1, 'architecture_name'),
            i(2, 'entitiy_name'),
            rep(1)
        })
    ),
    s('component',
        fmt([[
            component {}
                port(
                    
                );
            end component;
        ]], {
            i(1, 'entitiy_name'),
        })
    ),
    s('process',
        fmt([[
            {}process{}
            begin

            end process;
        ]], {
            c(1, {
                sn(1, {
                    i(1, 'process_name'),
                    t(' : '),
                }),
                t(''),
            }),
            c(2, {
                sn(1, {
                    t('('),
                    i(1, 'sensitivity_list'),
                    t(')'),
                }),
                t(''),
            }),
        })
    ),
})
