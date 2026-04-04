return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        "mason-org/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    opts = {
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
    },
}
