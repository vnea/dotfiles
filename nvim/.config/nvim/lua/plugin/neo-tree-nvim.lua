return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    event = "VeryLazy",
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
        vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
        vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
        vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

        -- Source: https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/370#discussioncomment-8303412
        local copy_path = function(state)
            -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
            -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local filename = node.name
            local modify = vim.fn.fnamemodify

            local results = vim.fn.uniq({
                filepath,
                modify(filepath, ":~"),
                modify(filepath, ":."),
                filename,
            })

            vim.ui.select(results, { prompt = "Choose to copy to clipboard:" }, function(choice)
                if choice then
                    vim.fn.setreg("+", choice)
                    vim.notify("Copied: " .. choice)
                end
            end)
        end

        -- Inspired from: https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#diff-files
        local diff_two_files = function(state, toto)
            local DIFF_ACTION = "diff"

            local current_node = state.tree:get_node()

            if first_selected_node and current_node.id ~= first_selected_node.id then
                vim.cmd("CodeDiff file " .. first_selected_node.id .. " " .. current_node.id)

                first_selected_node = nil
                state.clipboard = {}

                return
            end

            local current_node_clipboard = state.clipboard[current_node.id]
            local current_node_is_marked = current_node_clipboard and current_node_clipboard.action == DIFF_ACTION

            if current_node_is_marked then
                state.clipboard[current_node.id] = nil
                first_selected_node = nil
            else
                state.clipboard[current_node.id] = { action = DIFF_ACTION, node = current_node }
                first_selected_node = state.clipboard[current_node.id].node
            end

            require("neo-tree.ui.renderer").redraw(state)
        end

        require("neo-tree").setup({
            commands = {
                -- Source: https://github.com/MagicDuck/grug-far.nvim?tab=readme-ov-file#add-neo-tree-integration-to-open-search-limited-to-focused-directory-or-file
                grug_far_replace = function(state)
                    local node = state.tree:get_node()
                    local prefills = {
                        paths = node.type == "directory" and
                            vim.fn.fnameescape(vim.fn.fnamemodify(node:get_id(), ":p"))
                            or vim.fn.fnameescape(vim.fn.fnamemodify(node:get_id(), ":h")),
                    }

                    require("grug-far").open({ prefills = prefills })
                end,
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        ".vscode",
                        ".idea",
                    },
                },
                hijack_netrw_behavior = "disabled",
            },
            window = {
                mappings = {
                    ["<Tab>"] = "open",
                    ["e"] = "rename_basename",
                    ["c"] = "copy_to_clipboard",
                    ["<C-v>"] = "open_vsplit",
                    ["y"] = copy_path,
                    ["F"] = "grug_far_replace",
                    ["D"] = diff_two_files,
                },
            },
        })
    end,
}
