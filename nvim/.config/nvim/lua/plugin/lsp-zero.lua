-- Inspired from configuration: https://lsp-zero.netlify.app/docs/guide/lazy-loading-with-lazy-nvim (section 'Expand: automatic setup of LSP servers')
return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {},
    },

    -- Autocompletion
    {
        "saghen/blink.cmp",
        dependencies = "rafamadriz/friendly-snippets",
        version = "v1.1.1",
        opts = {
            appearance = { nerd_font_variant = "Nerd Font Mono" },
            completion = {
                menu = {
                    -- Don't show completion menu automatically when searching (https://cmp.saghen.dev/recipes.html#don-t-show-completion-menu-automatically-when-searching)
                    auto_show = function(ctx)
                        return ctx.mode ~= "cmdline" or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
                    end,
                },
            },
            keymap = { preset = "default" },
            signature = { enabled = true },
            sources = {
                providers = {
                    path = {
                        opts = {
                            show_hidden_files_by_default = true,
                        },
                    },
                },
            },
        },
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "saghen/blink.cmp" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        init = function()
            vim.opt.signcolumn = "yes"
        end,
        config = function()
            local lsp_defaults = require("lspconfig").util.default_config
            lsp_defaults.capabilities = vim.tbl_deep_extend(
                "force",
                lsp_defaults.capabilities,
                require("blink.cmp").get_lsp_capabilities()
            )

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set("n", "<leader>cD", function()
                        -- Run it twice to focus the floating popup
                        vim.diagnostic.open_float()
                        vim.diagnostic.open_float()
                    end, opts)

                    vim.keymap.set("n", "<leader>cd", function()
                        if not vim.diagnostic.config().virtual_lines then
                            vim.diagnostic.config({ virtual_lines = { current_line = true } })
                        else
                            vim.diagnostic.config({ virtual_lines = false })
                        end
                    end, opts)

                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, opts)
                    vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, opts)
                    vim.keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end, opts)
                    vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, opts)
                    vim.keymap.set("n", "gs", function() Snacks.picker.lsp_symbols() end, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>rv", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set({ "n", "x" }, "<leader>l", function() require("conform").format() end, opts)
                    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("n", "<F2>", function() vim.diagnostic.jump({ count = 1 }) end, opts)
                    vim.keymap.set("n", "<F1>", function() vim.diagnostic.jump({ count = -1 }) end, opts)
                end,
            })

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
            })

            require("mason-lspconfig").setup({
                automatic_installation = false,
                ensure_installed = {
                    "ansiblels",
                    "basedpyright",
                    "bashls",
                    "harper_ls",
                    "lua_ls",
                    "terraformls",
                    "vtsls",
                },
                handlers = {
                    -- Default handler
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,

                    -- Custom handlers
                    -- Settings: https://writewithharper.com/docs/integrations/neovim#Optional-Configuration
                    harper_ls = function()
                        require("lspconfig").harper_ls.setup({
                            settings = {
                                ["harper-ls"] = {
                                    linters = {
                                        SentenceCapitalization = false,
                                        SpellCheck = false,
                                    },
                                }
                            }
                        })
                    end,

                    lua_ls = function()
                        require("lspconfig").lua_ls.setup({
                            settings = {
                                Lua = {
                                    hint = {
                                        enable = true,
                                    }
                                }
                            }
                        })
                    end,
                },
            })
        end
    },
}
