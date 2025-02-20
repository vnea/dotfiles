return {
    "linrongbin16/gitlinker.nvim",
    config = function()
        local git_hosts = require("plugin.ignore_tmp.gitlinker-nvim.git_hosts")

        local git_browse_routes = {}
        for host_pattern, base_url in pairs(git_hosts) do
            git_browse_routes[host_pattern] = base_url
                .. "{_A.ORG}/"
                .. "{_A.REPO}/blob/"
                .. "{_A.REV}/"
                .. "{_A.FILE}"
                .. "?&lines={_A.LSTART}"
                .. "{_A.LEND > _A.LSTART and ('&lines-count=' .. _A.LEND - _A.LSTART + 1) or ''}"
        end

        require("gitlinker").setup({
            router = {
                browse = git_browse_routes
            }
        })
    end,
    cmd = "GitLink",
    opts = {},
    keys = {
        { "<leader>gy", "<cmd>GitLink<cr>",  mode = { "n", "v" }, desc = "Yank git link" },
        { "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
    },
}
