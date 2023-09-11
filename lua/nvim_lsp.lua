require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'ep', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'en', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end


-- Setup lspconfig.
--local capabilities = require('cmp_nvim_lsp').default_capabilitie(vim.lsp.protocol.make_client_capabilities())
local capabilities = require('cmp_nvim_lsp').default_capabilities()


require 'lspconfig'.pyright.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

require 'lspconfig'.rome.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

require 'lspconfig'.jdtls.setup {
    use_lombok_agent = true,
    on_attach = on_attach
}

require('lspconfig').sumneko_lua.setup {
    cmd = { '/home/preacher/Documents/Programming/lua-language-server/bin/lua-language-server' },
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
            globals = { 'vim' }
            }
        }
    }
}

require('lspconfig').yamlls.setup {
    cmd = {'/home/preacher/.config/nvim/packages/yaml-language-server/bin/yaml-language-server'},
    on_attach = on_attach,

}
require'lspconfig'.bashls.setup{
    on_attach = on_attach,
}

require'lspconfig'.clangd.setup{
    on_attach = on_attach,
}

require'lspconfig'.prosemd_lsp.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
require'lspconfig'.ccls.setup{
    capabilities = capabilities,
    use_lombok_agent = true,
    on_attach = on_attach,
}

require'lspconfig'.eslint.setup{
    on_attach = on_attach
}

require'lspconfig'.tsserver.setup{
    on_attach = on_attach
}

require'lspconfig'.cmake.setup{
    cmd = {'/home/preacher/.local/bin/cmake-language-server'},
    on_attach = on_attach,
}


vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Setup nvim-cmp.
local cmp = require 'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({ 
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})
require('luasnip.loaders.from_vscode').lazy_load()

-- Allow jsx and tsx to use js snippets
require('luasnip').filetype_extend('javascript', { 'javascriptreact', 'typescriptreact' })
