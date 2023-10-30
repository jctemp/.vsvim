vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- loads vscode style snippets (e.g. friendly-snipplets)
require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')         -- autocompletes
local luasnip = require('luasnip') -- expands autocompletion

local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp', keyword_length = 1 },
        { name = 'buffer',   keyword_length = 3 },
        { name = 'luasnip',  keyword_length = 2 },
    },
    window = {
        documentation = cmp.config.window.bordered()
    },
    formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'lsp',
                buffer = 'buf',
                path = 'path',
                luasnip = 'snip',
            }

            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- confirm with enter
        ['<C-Space>'] = cmp.mapping.complete(),       -- show completion suggestion
        ['<C-e>'] = cmp.mapping.abort(),              -- close completion window
    },
})
