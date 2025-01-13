return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-path" },
        { "L3MON4D3/LuaSnip" },
    },
    config = function()
        -- Lsp
        local lsp_zero = require("lsp-zero")

        lsp_zero.on_attach(function(_, bufnr)
            lsp_zero.default_keymaps({ buffer = bufnr })

            -- See :help lsp-zero-keybindings to learn the available actions
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { buffer = bufnr })
            vim.keymap.set({ "n", "v" }, "<Leader>rv", function() vim.lsp.buf.rename() end, { buffer = bufnr })
            vim.keymap.set({ "n", "v" }, "<Leader>l", function() require("conform").format() end, { buffer = bufnr })
            vim.keymap.set("n", "<Leader>ca", function() vim.lsp.buf.code_action() end, { buffer = bufnr })
            vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, { buffer = bufnr })
            vim.keymap.set("n", "<F2>", function() vim.diagnostic.goto_next() end, { buffer = bufnr })
            vim.keymap.set("n", "<S-F2>", function() vim.diagnostic.goto_prev() end, { buffer = bufnr })
        end)

        lsp_zero.set_sign_icons({
            error = "✘",
            warn = "▲",
            hint = "⚑",
            info = "»"
        })

        lsp_zero.format_on_save({
            format_opts = {
                async = false,
                timeout_ms = 10000,
            },
            servers = {
                ["gopls"] = { "go" }
            }
        })

        -- Mason
        require("mason").setup({})

        local lspconfig = require("lspconfig")
        lspconfig.ansiblels.setup({
            filetypes = { "yaml.ansible" },
        })
        lspconfig.bashls.setup({})
        lspconfig.lua_ls.setup({})
        lspconfig.pyright.setup({})
        lspconfig.terraformls.setup({})

        require("mason-lspconfig").setup({
            ensure_installed = {
                "ansiblels",
                "bashls",
                "lua_ls",
                "pyright",
                "terraformls",
            },
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require("lspconfig").lua_ls.setup(lua_opts)
                end,
                gopls = function()
                    require("lspconfig").gopls.setup({
                        cmd_env = {
                            GOFLAGS = "-tags=integration",
                        }
                    })
                end,
                golangci_lint_ls = function()
                    -- In order to fix error "Column value outside range", source: https://github.com/folke/trouble.nvim/issues/224#issuecomment-1495410321
                    local on_publish_diagnostics = vim.lsp.handlers["textDocument/publishDiagnostics"]
                    require("lspconfig").golangci_lint_ls.setup({
                        -- <...>
                        handlers = {
                            -- stops an out-of-range column error when viewing diagnostics with Trouble.nvim
                            ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
                                for idx, diag in ipairs(result.diagnostics) do
                                    for position, value in pairs(diag.range) do
                                        if value.character == -1 then
                                            result.diagnostics[idx].range[position].character = 0
                                        end
                                    end
                                end

                                return on_publish_diagnostics(_, result, ctx, config)
                            end,
                        },
                    })
                end,
            }
        })

        -- Cmp
        local cmp = require("cmp")

        cmp.setup({
            sources = {
                { name = "nvim_lsp" },
                { name = "path" },
            },
            mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<C-Space>"] = cmp.mapping.complete(),
            })
        })
    end,
}
