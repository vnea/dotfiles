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
        version = "v0.11.0",
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- See the full "keymap" documentation for information on defining your own keymap.
            keymap = {
                preset = "default",
            },
            appearance = {
                nerd_font_variant = "Nerd Font Mono",
            },
            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
            },
            completion = {
                menu = {
                    -- Don't show completion menu automatically when searching (https://cmp.saghen.dev/recipes.html#don-t-show-completion-menu-automatically-when-searching)
                    auto_show = function(ctx)
                        return ctx.mode ~= "cmdline" or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
                    end,
                },
            },
        },
        opts_extend = { "sources.default" },
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

                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, opts)
                    vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, opts)
                    vim.keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end, opts)
                    vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, opts)
                    vim.keymap.set("n", "gs", function() Snacks.picker.lsp_symbols() end, opts)
                    vim.keymap.set({ "n", "v" }, "<Leader>rv", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set({ "n", "x" }, "<Leader>l", function() require("conform").format() end, opts)
                    vim.keymap.set("n", "<Leader>ca", function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("n", "<F2>", function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set("n", "<S-F2>", function() vim.diagnostic.goto_prev() end, opts)
                    vim.keymap.set("n", "<Leader><F2>", function() require("trouble").open() end, opts)
                    vim.keymap.set("n", "<Leader><A-Enter>", function() require("telescope.builtin").spell_suggest() end, opts)
                end,
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "ansiblels",
                    "bashls",
                    "lua_ls",
                    "pyright",
                    "terraformls",
                },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                },
            })
        end
    },
}
