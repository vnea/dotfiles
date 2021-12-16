return require("packer").startup(function()
    use "wbthomason/packer.nvim"

    use "rstacruz/vim-closer"

    use "nvim-treesitter/nvim-treesitter"

    use {
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use { "junegunn/fzf", dir = "~/.fzf", run = "./install --all" }
    use { "junegunn/fzf.vim" }

    use { "lambdalisue/fern.vim" }
    use { "antoinemadec/FixCursorHold.nvim" }
end)
