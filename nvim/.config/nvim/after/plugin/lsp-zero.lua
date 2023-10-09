local lsp_zero = require("lsp-zero")
lsp_zero.on_attach(function(_, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})

    -- See :help lsp-zero-keybindings to learn the available actions
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "<S-F6>", function() vim.lsp.buf.rename() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "<C-A-l>", function() vim.lsp.buf.format() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "<A-Enter>", function() vim.lsp.buf.code_action() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "<F2>", function() vim.diagnostic.goto_next() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "<S-F2>", function() vim.diagnostic.goto_prev() end, { silent = true, remap = false, buffer = bufnr })
end)

require("mason").setup({})
require("mason-lspconfig").setup({
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
        end,
        gopls = function ()
            require("lspconfig").gopls.setup({
                cmd_env = {GOFLAGS="-tags=integration"}
            })
        end
    }
})

local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({select = false}),
        ["<C-Space>"] = cmp.mapping.complete(),
    })
})
