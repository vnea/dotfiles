local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(_, bufnr)
    -- See :help lsp-zero-keybindings to learn the available actions
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "<S-F6>", function() vim.lsp.buf.rename() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "<C-A-l>", function() vim.lsp.buf.format() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "<F4>", function() vim.lsp.buf.code_action() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "<F2>", function() vim.diagnostic.goto_next() end, { silent = true, remap = false, buffer = bufnr })
    vim.keymap.set("n", "<S-F2>", function() vim.diagnostic.goto_prev() end, { silent = true, remap = false, buffer = bufnr })
end)

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local cmp = require("cmp")

cmp.setup({
    mapping = {
        -- Confirm completion
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        -- Trigger completion menu
        ["<C-Space>"] = cmp.mapping.complete(),
    }
})
