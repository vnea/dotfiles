return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
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
        end,
        keys = {
            {
                "<leader>cd",
                function()
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
                end,
                desc = "Toggle inline diagnostics",
            },
            {
                "<leader>cD",
                function()
                    vim.diagnostic.open_float()
                    vim.diagnostic.open_float()
                end,
                desc = "Open diagnostic float and force focus",
            },
            -- gra = Code action
            { "gri",        function() Snacks.picker.lsp_implementations() end,                                        desc = "Go to implementations" },
            { "grI",        function() Snacks.picker.lsp_declarations() end,                                           desc = "Go to declarations" },
            -- grn = Rename
            { "grr",        function() Snacks.picker.lsp_references() end,                                             desc = "Go to references" },
            { "grt",        function() Snacks.picker.lsp_type_definitions() end,                                       desc = "Go to type definitions" },
            -- grx = Run Code Lens
            { "gO",         function() Snacks.picker.lsp_symbols() end,                                                desc = "LSP symbols" },
            { "grh",        function() vim.lsp.buf.hover() end,                                                        desc = "Hover" },
            { "<F2>",       function() vim.diagnostic.jump({ count = 1 }) end,                                         desc = "Next diagnostic" },
            { "<F1>",       function() vim.diagnostic.jump({ count = -1 }) end,                                        desc = "Previous diagnostic" },
            { "<leader>ih", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 }) end, desc = "Toggle inlay hints" },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
            "b0o/schemastore.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "ansiblels",
                    "basedpyright",
                    "bashls",
                    "harper_ls",
                    "jsonls",
                    "lua_ls",
                    "terraformls",
                    "vtsls",
                    "yamlls",
                },
            })

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
        end,
    },
}
