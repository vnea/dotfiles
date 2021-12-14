return require("packer").startup(function()
    use "wbthomason/packer.nvim"
    use "rstacruz/vim-closer"
    use "nvim-treesitter/nvim-treesitter"
    use {
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } }
    }
end)
