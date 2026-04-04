-- ======================
-- === Diagnostic
-- ======================
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
        },
    },
    virtual_lines = false,
    virtual_text = false,
    underline = false,
})

-- ======================
-- === LSP config
-- ======================
-- Configuration: https://writewithharper.com/docs/integrations/neovim#Optional-Configuration
vim.lsp.config("harper-ls", {
    settings = {
        ["harper-ls"] = {
            linters = {
                SentenceCapitalization = false,
                SpellCheck = false,
            },
        }
    }
})

vim.lsp.config("jsonls", {
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
})

vim.lsp.config("yamlls", {
    settings = {
        yaml = {
            schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
        },
    },
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            -- Configuration: https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/docs/format_config_EN.md
            format = {
                defaultConfig = {
                    call_arg_parentheses = "always",
                    indent_style = "space",
                    max_line_length = "200",
                    quote_style = "double",
                },
            },
            hint = { enable = true },
            runtime = { version = "LuaJIT" },
            telemetry = { enable = false },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        },
    },
})

-- ======================
-- === Mapping
-- ======================
vim.keymap.set("n", "<leader>cd", function()
    if not vim.diagnostic.config().virtual_lines then
        vim.diagnostic.config({
            virtual_lines = { current_line = true },
            underline = { current_line = true },
        })
    else
        vim.diagnostic.config({
            virtual_lines = false,
            underline = false,
        })
    end
end, { desc = "Toggle inline diagnostics" })

vim.keymap.set("n", "<leader>cD", function()
    vim.diagnostic.open_float()
    vim.diagnostic.open_float()
end, { desc = "Open diagnostic float and force focus" })

-- gra = Code action
vim.keymap.set("n", "gri", function() Snacks.picker.lsp_implementations() end, { desc = "Go to implementations" })
vim.keymap.set("n", "grI", function() Snacks.picker.lsp_declarations() end, { desc = "Go to declarations" })
-- grn = Rename
vim.keymap.set("n", "grr", function() Snacks.picker.lsp_references() end, { desc = "Go to references" })
vim.keymap.set("n", "grt", function() Snacks.picker.lsp_type_definitions() end, { desc = "Go to type definitions" })
-- grx = Run Code Lens
vim.keymap.set("n", "gO", function() Snacks.picker.lsp_symbols() end, { desc = "LSP symbols" })
vim.keymap.set("n", "grh", function() vim.lsp.buf.hover() end, { desc = "Hover" })
vim.keymap.set("n", "<F2>", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<F1>", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "<leader>ih", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 }) end, { desc = "Toggle inlay hints" })

