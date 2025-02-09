-- Inspired from configuration: https://lsp-zero.netlify.app/docs/guide/lazy-loading-with-lazy-nvim (section 'Expand: automatic setup of LSP servers')
return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {},
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
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
                require("cmp_nvim_lsp").default_capabilities()
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
                    vim.keymap.set("n", "<Leader><A-Enter>", function() require("telescope.builtin").spell_suggest() end,
                        opts)
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
